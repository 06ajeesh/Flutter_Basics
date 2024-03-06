// import 'dart:math';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_store_app2/widgets/yellow_button.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// var textColor = [
//   Colors.blue,
//   Colors.green,
//   Colors.green,
//   Colors.white,
//   Colors.white,
//   Colors.white,
//   Colors.green,
//   Colors.green,
//   Colors.white,
//   Colors.white,
//   Colors.green.shade500,
// ];
// const textStyle = TextStyle(
//   fontWeight: FontWeight.bold,
//   fontFamily: 'Acme',
//   fontSize: 42,
// );
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool progressing = false;
//   CollectionReference customers =
//       FirebaseFirestore.instance.collection('Customers');
//   CollectionReference anonymous =
//       FirebaseFirestore.instance.collection('anonymous');
//   late String _uid;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _controller.repeat();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/inapp/front_background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: ListView(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.95,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 50,
//                     ),
//                     child: AnimatedTextKit(
//                       animatedTexts: [
//                         ColorizeAnimatedText(
//                           'Welcome',
//                           textStyle: textStyle,
//                           colors: textColor,
//                           speed: const Duration(milliseconds: 500),
//                         ),
//                         ColorizeAnimatedText(
//                           'Store',
//                           textStyle: textStyle,
//                           colors: textColor,
//                           speed: const Duration(milliseconds: 500),
//                         ),
//                       ],
//                       isRepeatingAnimation: true,
//                       repeatForever: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 45,
//                     child: DefaultTextStyle(
//                       style: TextStyle(
//                         color: Colors.blue.shade800,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Acme',
//                         fontSize: 38,
//                       ),
//                       child: AnimatedTextKit(
//                         totalRepeatCount: 2,
//                         animatedTexts: [
//                           RotateAnimatedText(
//                             'Buy',
//                           ),
//                           RotateAnimatedText(
//                             'Shop',
//                           ),
//                         ],
//                         repeatForever: true,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             width: 175,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               color: Colors.lightBlueAccent.withOpacity(0.5),
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(30),
//                               ),
//                               // border: Border.all(
//                               //   width: 2,
//                               //   color: Colors.lightBlueAccent.shade700,
//                               // ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 11),
//                               child: Text(
//                                 'Suppliers',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 20,
//                                   color: Colors.black87.withOpacity(0.7),
//                                   fontFamily: 'Acme',
//                                 ),
//                                 textAlign: TextAlign.end,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width * 0.565,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade500,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(30),
//                                 bottomLeft: Radius.circular(30),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 // AnimatedLogo(controller: _controller),
//                                 YellowButton(
//                                   label: 'Login',
//                                   customFont: true,
//                                   width: 0.25,
//                                   onPressed: () {
//                                     Navigator.pushReplacementNamed(
//                                       context,
//                                       '/supplier_login',
//                                     );
//                                   },
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 9),
//                                   child: YellowButton(
//                                     label: 'Sign Up',
//                                     customFont: true,
//                                     width: 0.25,
//                                     onPressed: () {
//                                       Navigator.pushReplacementNamed(
//                                         context,
//                                         '/supplier_signup',
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width * 0.56,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade500,
//                           borderRadius: const BorderRadius.only(
//                             topRight: Radius.circular(50),
//                             bottomRight: Radius.circular(50),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 9),
//                               child: YellowButton(
//                                 label: 'Log In'.toUpperCase(),
//                                 customFont: true,
//                                 width: 0.24,
//                                 onPressed: () {
//                                   Navigator.pushReplacementNamed(
//                                       context, '/customer_login');
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             YellowButton(
//                               label: 'Sign Up'.toUpperCase(),
//                               customFont: true,
//                               width: 0.25,
//                               onPressed: () {
//                                 Navigator.pushReplacementNamed(
//                                     context, '/customer_signup');
//                               },
//                             ),
//                             // AnimatedLogo(controller: _controller),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.white38.withOpacity(0.3),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GoogleFacebookLogin(
//                           onPressed: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.black45,
//                             child: Icon(
//                               FontAwesomeIcons.google,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         GoogleFacebookLogin(
//                           onPressed: () {},
//                           child: CircleAvatar(
//                             backgroundColor: Colors.blue.shade700,
//                             child: const Icon(
//                               FontAwesomeIcons.facebook,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         if (progressing)
//                           const Center(
//                             child: CircularProgressIndicator(),
//                           )
//                         else
//                           GoogleFacebookLogin(
//                             onPressed: () async {
//                               setState(() {
//                                 progressing = true;
//                               });
//                               await FirebaseAuth.instance
//                                   .signInAnonymously()
//                                   .whenComplete(() async {
//                                 _uid = FirebaseAuth.instance.currentUser!.uid;
//                                 await anonymous.doc(_uid).set({
//                                   'name': '',
//                                   'email': '',
//                                   'profileimage': '',
//                                   'phone': '',
//                                   'address': '',
//                                   'cid': _uid,
//                                 });
//                               });
//
//                               Navigator.pushReplacementNamed(
//                                   context, '/Customer_home');
//                             },
//                             label: ' Guest',
//                             child: const CircleAvatar(
//                               backgroundColor: Colors.transparent,
//                               child: Icon(
//                                 size: 22,
//                                 FontAwesomeIcons.shop,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedLogo extends StatelessWidget {
//   const AnimatedLogo({
//     super.key,
//     required AnimationController controller,
//   }) : _controller = controller;
//
//   final AnimationController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller.view,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: _controller.value * 2 * pi,
//           child: child,
//         );
//       },
//       child: const SizedBox(
//         height: 40,
//         child: Image(
//           image: AssetImage('images/inapp/logo.jpg'),
//           fit: BoxFit.fitHeight,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoplayerFuture;

  @override
  void initState() {
    _controller =
        VideoPlayerController.asset('videos/wecome_screen_videos.mp4');
    _initializeVideoplayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Stack(
            children: [
              FutureBuilder(
                future: _initializeVideoplayerFuture,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.145,
                left: MediaQuery.of(context).size.width * 0.29,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/seller_section');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const BeveledRectangleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.43,
                      35,
                    ),
                  ),
                  child: Text(
                    "Start Selling".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.28,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.46,
                      35,
                    ),
                    backgroundColor: Colors.white,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customer_section');
                  },
                  child: const Text(
                    "START SHOPPING",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
