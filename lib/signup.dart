import 'package:firebaseauth/home.dart';
import 'package:firebaseauth/service/Auth_Service.dart';
import 'package:firebaseauth/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'Phonepage.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  firebase_auth.FirebaseAuth firebaseAuth=firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular=false;
  AuthClass authClass=AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign up",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              buttonItem("assets/icons8-google.svg","continue with Google",25,() async { await authClass.googleSignIn(context);
              }),
              SizedBox(height: 15,),
              buttonItem("assets/icons8-phone.svg","continue with Mobile",30,(){Navigator.push(context,MaterialPageRoute(builder: (_)=>phone()));}),
              SizedBox(height: 15,),

              Text("Or",style: TextStyle(fontSize: 20,color: Colors.white),),
              SizedBox(height: 15,),
              textItem("Email...",_emailController,false),
              SizedBox(height: 15,),
              textItem("Password.....",_pwdController,true),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you already have an Account?",style:TextStyle(color:Colors.white,fontSize: 18 )),
                  InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=> signinPage()));
                      },
                      child: Text("Login",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold))),

                ],
              )


            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: () async{
           setState(() {
             circular=true;
           });
        try {
          firebase_auth.UserCredential userCredential = await firebaseAuth
              .createUserWithEmailAndPassword(
              email: _emailController.text, password: _pwdController.text);
          print(userCredential.user!.email);
          setState(() {
            circular=true;
          });
          
         Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
          
          
        }
        catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });

        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20),
          gradient: LinearGradient(

              colors: [
                Color(0xfffd746c),
                Color(0xffff9068),
                Color(0xfffd746c)
              ],



          )
        ),

        child: Center(child: circular ? CircularProgressIndicator():Text("Sign Up",style: TextStyle(color:Colors.white,fontSize: 20 ),)),
      ),
    );
  }

  Widget buttonItem(String imagepath,String buttonName,double size,Function ontap){
    return  InkWell(
    onTap:() => ontap(), //************** use => for google sigin or else it will show error
      child: Container(

        width: MediaQuery.of(context).size.width-60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,color: Colors.grey,

              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(imagepath,height: size,width: size,),
              SizedBox(width:15 ,),
              Text(buttonName,style: TextStyle(color: Colors.white,fontSize: 17),)
            ],
          ),
        ),

      ),


    );
  }

  Widget textItem(labelText,TextEditingController controller,bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 17,color: Colors.white),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide( //................
                width: 1,color: Colors.grey,

              )

          )
        ),
      ),


       );
  }
}

