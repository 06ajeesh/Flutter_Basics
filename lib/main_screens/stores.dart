import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

import '../minor_screens/visit_store.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(
            title: 'Stores',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Suppliers')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VisitStore(
                                  suppId: snapshot.data!.docs[index]['cid'],
                                ),
                              ));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Image(
                                      image:
                                          AssetImage('images/inapp/store.jpg')),
                                ),
                                Positioned(
                                  bottom: 28,
                                  left: 15,
                                  child: SizedBox(
                                    height: 46,
                                    width: 91,
                                    child: Image.network(
                                      snapshot.data!.docs[index]['storeLogo'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data!.docs[index]['storeName']
                                  .toLowerCase(),
                              style: const TextStyle(
                                fontFamily: 'Akaya',
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Stores'),
                  );
                }
              }),
        ),
      ),
    );
  }
}
