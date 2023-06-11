
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pepcorns_app/AuthenticationRepository/a10_authentication_repository.dart';
import 'package:pepcorns_app/Models/a15_user_model.dart';
import 'package:pepcorns_app/UserRepository/a16_user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  /// Call this Function from Design & it will do this rest
  Future<void> registerUser(UserModel user) async{
    await userRepo.createUser(user);
    AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password);
  }

  // Future<void> createUser(UserModel user) async{
  //   await userRepo.createUser(user);
  //   phoneAuthentication(user.phoneNo);
  //   Get.to(()=> const VerifyCodeForPhone());
  // }

  // void phoneAuthentication(String phoneNo){
  //   AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  // }

}