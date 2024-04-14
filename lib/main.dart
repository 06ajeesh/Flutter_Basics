import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/auth/customer_login.dart';
import 'package:multi_store_app2/auth/supplier_login.dart';
import 'package:multi_store_app2/auth/supplier_signup.dart';
import 'package:multi_store_app2/firebase_options.dart';
import 'package:multi_store_app2/providers/stripe_id.dart';
import 'package:multi_store_app2/providers/wish_provider.dart';
import 'package:provider/provider.dart';
import 'auth/customer_sign_log.dart';
import 'auth/customer_signup.dart';
import 'auth/seller_sign_log.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/welcome_screen.dart';
import 'package:multi_store_app2/providers/cart_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Cart(),
      ),
      ChangeNotifierProvider(
        create: (_) => Wish(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/Welcome_Screen': (context) => const WelcomeScreen(),
        '/Customer_home': (context) => const CustomerHomeScreen(),
        '/Supplier_home': (context) => const SupplierHomeScreen(),
        '/customer_signup': (context) => const CustomerRegester(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_login': (context) => const SupplierLogin(),
        '/supplier_signup': (context) => const SupplierRegester(),
        '/customer_section': (context) => const Customer_Sign_Log(),
        '/seller_section': (context) => const Seller_Sign_Log(),
      },
      initialRoute: '/Welcome_Screen',
    );
  }
}
