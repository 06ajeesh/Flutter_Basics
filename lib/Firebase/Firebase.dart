import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase service = FirebaseDatabase();

  final _modelService = FirebaseDatabase();

  //register user

  Future createUser(
      {required String name,
      required String email,
      required String password,
      required String age,
      required String address,
      required String mobile}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      final userId = user!.uid;
      log('user id is $userId');
      await _modelService.addToCollection(
          id: userId,
          name: name,
          age: age,
          email: email,
          address: address,
          mobileNum: mobile);

      log('inside create user');

      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //login user

  Future loginUser(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      await saveToken(true);
      log('user id is ${result.user!.uid}');

      // final userId = result.user!.uid;

      //await service.getDocuments(userId);

      return result.user;
    } catch (e) {
      log('inside catch');
      log(e.toString());
    }
  }

  //signout user

  Future signoutUser() async {
    await saveToken(false);
    return await _auth.signOut();
  }

  // Future<void> saveToken(bool check) async {
  //   try {
  //     final sharep = await SharedPreferences.getInstance();
  //     await sharep.setBool('value', check);
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }
}
