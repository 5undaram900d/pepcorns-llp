
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pepcorns_app/Models/a15_user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Store user in database
  createUser(UserModel user) async{
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      Get.snackbar(
        'Success',
        'Your account has been created',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    }).catchError((error, stackTrace){
      Get.snackbar(
        'Error',
        'Something went wrong. try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    });
  }

  /// fetch all user or User details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection('users').get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }

}











