import 'package:firebaseauth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'home.dart';

class signinPage extends StatefulWidget {
  @override
  _signinPageState createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {

  firebase_auth.FirebaseAuth firebaseAuth=firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;

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
              Text("Sign In",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              buttonItem("assets/icons8-google.svg","continue with Google",25),
              SizedBox(height: 15,),
              buttonItem("assets/icons8-phone.svg","continue with Mobile",30),
              SizedBox(height: 15,),

              Text("Or",style: TextStyle(fontSize: 20,color: Colors.white),),
              SizedBox(height: 15,),
              textItem("Email...",_emailController, false),
              SizedBox(height: 15,),
              textItem("Password.....",_pwdController, true),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't have an Account?",style:TextStyle(color:Colors.white,fontSize: 18 )),
                  InkWell(

                      child: Text("Sign-Up",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold)),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (_)=> signUpPage()));

                    },
                       
                  ),

                ],
              ),

              SizedBox(height: 17,),

              Text("Forgot Password",style:TextStyle(color:Colors.white,fontSize: 17,fontWeight:FontWeight.bold)),


            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
         onTap: () async{

           try{
             firebase_auth.UserCredential userCredential =
             await firebaseAuth.signInWithEmailAndPassword(
                 email: _emailController.text, password: _pwdController.text);
             print(userCredential.user!.email);
             setState(() {
               circular = false;
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

        child: Center(child:circular ? CircularProgressIndicator(): Text("Log-In",style: TextStyle(color:Colors.white,fontSize: 20 ),)),
      ),
    );
  }

  Widget buttonItem(String imagepath,String buttonName,double size){
    return  Container(
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

    );
  }

  Widget textItem(String labelText,TextEditingController controller,bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(

            labelText: labelText,
            labelStyle: TextStyle(fontSize: 17,color: Colors.white),
            enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide( //................
                  width: 1,color: Colors.amber,

                )

            ),

        ),
      ),


    );
  }
}

