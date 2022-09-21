import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> googleLoginMain() async{
  GoogleSignIn _googleSignIn = await GoogleSignIn();

  final googleUser = await _googleSignIn.signIn();
  if (googleUser == null){
    return false;
  }

  final googleAuth = await googleUser.authentication;

  final credential = await GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );



  var result = await FirebaseAuth.instance.signInWithCredential(credential);

  var sharedPreferences = await SharedPreferences.getInstance();

  sharedPreferences.setString("email", result.user!.email ?? "");
  sharedPreferences.setString("token", result.user!.uid);
  sharedPreferences.setString("photo", result.user!.photoURL ?? "");
  return true;
}