
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pepcorns_app/Utils/a04_utils_toast_message.dart';
import 'package:pepcorns_app/Views/ApiScreen/a06_api_screen.dart';
import 'package:pepcorns_app/Views/Auth/a01_login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// setting Initial Screen onLoad
  _setInitialScreen(User? user){
    user == null ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const ApiScreen());
  }


  Future<void> createUserWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const ApiScreen()) :  Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch(e) {
      Utils().toastMessage(e.toString());
    } catch (_){}
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      Utils().toastMessage(e.toString());
    } catch (_){}
  }

  Future<void> logout() async => await _auth.signOut();

}