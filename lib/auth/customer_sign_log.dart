import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app2/main_screens/profile.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:multi_store_app2/widgets/my_button.dart';

import 'google_facebook_log.dart';

class Customer_Sign_Log extends StatefulWidget {
  const Customer_Sign_Log({super.key});

  @override
  State<Customer_Sign_Log> createState() => _Customer_Sign_LogState();
}

class _Customer_Sign_LogState extends State<Customer_Sign_Log> {
  bool progressing = false;
  late String _uid;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        leading: const AppBarBackButton(buttonColor: Colors.black),
        title: const Text(
          'Customer Section',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Image.asset('images/inapp/designer1.png', scale: 0.5),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: YellowDivider(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      child: MyButton(
                        label: 'Log In',
                        width: MediaQuery.of(context).size.width * 0.5,
                        onpressed: () {
                          Navigator.pushNamed(context, '/customer_login');
                        },
                        family: 'Acme',
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        radius: 6,
                        hight: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                      child: MyButton(
                        label: 'Sign Up',
                        width: MediaQuery.of(context).size.width * 0.5,
                        onpressed: () {
                          Navigator.pushNamed(context, '/customer_signup');
                        },
                        family: 'Acme',
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        radius: 6,
                        hight: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade300.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GoogleFacebookLogin(
                            onPressed: () {},
                            child: const CircleAvatar(
                              backgroundColor: Colors.black87,
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          GoogleFacebookLogin(
                            onPressed: () {},
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.shade900,
                              child: const Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          if (progressing)
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                          else
                            GoogleFacebookLogin(
                              onPressed: () async {
                                setState(() {
                                  progressing = true;
                                });
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .whenComplete(() async {
                                  _uid = FirebaseAuth.instance.currentUser!.uid;
                                  await anonymous.doc(_uid).set({
                                    'name': '',
                                    'email': '',
                                    'profileimage': '',
                                    'phone': '',
                                    'address': '',
                                    'cid': _uid,
                                  });
                                });

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/Customer_home',
                                  (Route<dynamic> route) => false,
                                );
                              },
                              label: ' Guest',
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  size: 22,
                                  FontAwesomeIcons.shop,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
