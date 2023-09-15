
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uas_21312007/app/routes/app_pages.dart';

class AuthController extends GetxController {
FirebaseAuth auth = FirebaseAuth.instance;

Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup(String emailAddress, String password) async{
    try {
  UserCredential myUser = await auth.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  await myUser.user!.sendEmailVerification();
  Get.defaultDialog(
    title: "Verifikasi email",
    middleText: "kami telah mengirimkan verifikasi ke email $emailAddress.",
    onConfirm: (){
      Get.back();
      Get.back();
    },
    textConfirm: "OK");
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  void Login (String emailAddress, String password) async {
    try {
  UserCredential myUser = await auth.signInWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  if (myUser.user!.emailVerified){
    Get.offAndToNamed(Routes.HOME);
  }else{
    Get.defaultDialog(
      title: "Verifikasi email",
      middleText: "harap verifikasi email terlebih dahulu",
    );
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
     Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "tidak dapat melakukan reset password"
      );
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword (String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
 try{
   await auth.sendPasswordResetEmail(email: email);
     Get.defaultDialog(
        title: "Berhasil",
        middleText: "Kami telah mengirimkan reset password ke $email",
        onConfirm : () {
          Get.back();
          Get.back();
        },
        textConfirm: "OK"
        );
 }catch(e){
   Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "tidak dapat melakukan reset password"
      );
 }
    }else{
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email tidak valid"
      );
    }
  }

  void LoginGoogle()async{
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null){
        final GoogleSignInAuthentication? googleAuth = 
        await googleUser?.authentication;

        final Credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(Credential);
        Get.offNamed(Routes.HOME);

      }else{
        throw "Belum Memilih akun google";
      }

    } catch (error) {
      print(error);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "${error.toString()}",
      );
    }
  }
}