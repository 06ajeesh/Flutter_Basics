import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:multi_store_app2/widgets/yellow_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../providers/cart_provider.dart';

class PayementScreen extends StatefulWidget {
  const PayementScreen({super.key});

  @override
  State<PayementScreen> createState() => _PayementScreenState();
}

class _PayementScreenState extends State<PayementScreen> {
  late String orderId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('Customers');
  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(msg: 'Please wait..', progressBgColor: Colors.red, max: 100);
  }

  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    final totalPrice = Provider.of<Cart>(context).totalPrice;
    final totalPaid = Provider.of<Cart>(context).totalPrice +
        10; // 10 is the temporary shipping cost

    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something Went Wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document Doesn't Exists");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Material(
            color: Colors.grey.shade200,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  leading: const AppBarBackButton(
                    buttonColor: Colors.black,
                  ),
                  title: const Text(
                    'Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  Text(
                                    '${totalPaid.toStringAsFixed(2)} INR',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Order',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  Text(
                                    totalPrice.toStringAsFixed(2),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Cost',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  Text(
                                    "10.00",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                title: const Text("Cash on delivery"),
                                subtitle: const Text("pay cash after delivery"),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                title: const Text("Pay via visa / Master Card"),
                                subtitle: const Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Icon(
                                        FontAwesomeIcons.ccMastercard,
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccVisa,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                title: const Text("Pay via Paypal"),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.paypal,
                                      color: Colors.blue.shade600,
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      FontAwesomeIcons.ccPaypal,
                                      color: Colors.blue.shade800,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: YellowButton(
                      fontweigh: FontWeight.w500,
                      label: 'Confirm ${totalPaid.toStringAsFixed(2)} \$',
                      width: 0.9,
                      onPressed: () {
                        if (selectedValue == 1) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 80),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Pay at home ${totalPaid.toStringAsFixed(2)} \$",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    YellowButton(
                                      colour: Colors.green.shade400,
                                      fontweigh: FontWeight.w400,
                                      label:
                                          'Confirm ${totalPaid.toStringAsFixed(2)} \$',
                                      width: 0.8,
                                      onPressed: () async {
                                        showProgress();
                                        for (var item in Provider.of<Cart>(
                                          context,
                                          listen: true,
                                        ).getItems) {
                                          orderId = const Uuid().v4();
                                          CollectionReference orderRef =
                                              FirebaseFirestore.instance
                                                  .collection('orders');
                                          await orderRef.doc(orderId).set({
                                            'cid': data['cid'],
                                            'custName': data['name'],
                                            'email': data['email'],
                                            'address': data['address'],
                                            'phone': data['phone'],
                                            'profileImage':
                                                data['profileimage'],
                                            'sid': item.suppId,
                                            'proid': item.documentId,
                                            'orderId': orderId,
                                            'orderName': item.name,
                                            'orderImage': item.imagesUrl.first,
                                            'orderqty': item.qty,
                                            'orderPrice': item.qty * item.price,
                                            'deliveryStatus': 'preparing',
                                            'deliveryDate': ' 20/03/2024',
                                            'orderDate': DateTime.now(),
                                            'payementStatus':
                                                'cash on delivery',
                                            'orederReview': false,
                                          }).whenComplete(() async {
                                            await FirebaseFirestore.instance
                                                .runTransaction(
                                                    (transaction) async {
                                              DocumentReference
                                                  documentReference =
                                                  FirebaseFirestore.instance
                                                      .collection('products')
                                                      .doc(item.documentId);
                                              DocumentSnapshot snapshot2 =
                                                  await transaction
                                                      .get(documentReference);
                                              transaction.update(
                                                  documentReference, {
                                                'instock':
                                                    snapshot2['instock'] -
                                                        item.qty
                                              });
                                            });
                                          });
                                        }
                                        Provider.of<Cart>(context).clearCart();
                                        Navigator.popUntil(
                                          context,
                                          ModalRoute.withName('/Customer_home'),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (selectedValue == 2) {
                        } else if (selectedValue == 3) {}
                      },
                      colour: Colors.lightGreen,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
