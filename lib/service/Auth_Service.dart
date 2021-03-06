import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../home.dart';

//FOR GOOGLE SIGN_IN
class AuthClass{

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final FirebaseAuth auth=FirebaseAuth.instance;
  final _storage = FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try{
      //it will pop of GMAIL screen
      GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

        AuthCredential credential=GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try{
          UserCredential userCredential=await auth.signInWithCredential(credential);
          storeTokenAndData(userCredential);
          Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
        }
        catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }

      else{
        final snackbar = SnackBar(content: Text("Not Able to sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
    catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

  }

  Future<void> storeTokenAndData(UserCredential userCredential)async
  {
    await _storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await _storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  Future<void> verifyphoneNumber(String phoneNumber,BuildContext context,Function setData) async{
    PhoneVerificationCompleted verificationCompleted=(PhoneAuthCredential phoneAuthCredential) async{
    showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed=(FirebaseAuthException exception){
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent=(
        String verificationID,
        [ int? forceResnedingtoken]){

      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);

    } ;

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {

          showSnackBar(context, "Time out");

    };

    try{
    await auth.verifyPhoneNumber(

        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );
    }
    catch(e){
      showSnackBar(context, e.toString());

    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
      await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await _storage.delete(key: "token");
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void showSnackBar(BuildContext context,String text ){
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}