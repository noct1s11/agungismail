import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  // google sign Login
  SignInWithGoogle() async{
    //begin interactive sign in
   final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();


    // obitain auth detail
 final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    //create a new user
 final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken);

    // finish  lets sign in
  await FirebaseAuth.instance.signInWithCredential(credential);
  }

}