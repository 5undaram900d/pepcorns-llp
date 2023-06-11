
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  UserModel({this.id, required this.fullName, required this.email, required this.phoneNo, required this.password});

  /// this function work for a model to store in fireStore database
  toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'password': password
    };
  }

  /// this function work for a model to fetch data from the database
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullName: data['fullName'],
        email: data['email'],
        phoneNo: data['phoneNo'],
        password: data['password']
    );
  }

}