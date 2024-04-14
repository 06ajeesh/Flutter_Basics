import 'package:flutter/material.dart';
import 'package:multi_store_app2/main_screens/profile.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';
import 'package:multi_store_app2/widgets/my_button.dart';

class Seller_Sign_Log extends StatefulWidget {
  const Seller_Sign_Log({super.key});

  @override
  State<Seller_Sign_Log> createState() => _Seller_Sign_LogState();
}

class _Seller_Sign_LogState extends State<Seller_Sign_Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        leading: const AppBarBackButton(buttonColor: Colors.black),
        title: const Text(
          'Supplier Section',
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
                          Navigator.pushNamed(context, '/supplier_login');
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
                          Navigator.pushNamed(context, '/supplier_signup');
                        },
                        family: 'Acme',
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        radius: 6,
                        hight: 40,
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
