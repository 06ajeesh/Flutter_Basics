import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/minor_screens/visit_store.dart';
import 'package:multi_store_app2/widgets/alert_dialog.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

import '../dashboard_components/edit_buisiness.dart';
import '../dashboard_components/manage_products.dart';
import '../dashboard_components/supplier_balance.dart';
import '../dashboard_components/supplier_orders.dart';
import '../dashboard_components/supplier_statics.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics',
];
List<IconData> icon = [
  Icons.store,
  Icons.shop_2_rounded,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrders(),
  const EditBusiness(),
  const ManageProducts(),
  const BalanceScreen(),
  const Statics(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Dashboard'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialog(
                context: context,
                title: 'warning',
                content: 'you are about log out',
                tapNo: () {
                  Navigator.pop(context);
                },
                tapYes: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                    context,
                    '/Welcome_Screen',
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
            color: Colors.red,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(
              6,
              (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.purpleAccent,
                      elevation: 10,
                      color: Colors.blueGrey.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            icon[index],
                            size: 50,
                            color: Colors.yellow,
                          ),
                          Text(
                            label[index].toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Acme',
                              fontWeight: FontWeight.w600,
                              color: Colors.yellow,
                              letterSpacing: 1.7,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
