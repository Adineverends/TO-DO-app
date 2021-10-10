import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauth/AddTodo.dart';
import 'package:firebaseauth/TodoCard.dart';
import 'package:firebaseauth/service/Auth_Service.dart';
import 'package:firebaseauth/signup.dart';
import 'package:flutter/material.dart';
import './main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream=FirebaseFirestore.instance.collection("todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.black87,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text("Today's Schedule",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.white),),
            actions: [
              /* IconButton(
                  onPressed: () async{
                await authClass.signOut;
                Navigator.push(context,MaterialPageRoute(builder: (_)=> signUpPage()));
                },
                  icon: Icon(Icons.logout) ) */
              CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpeg"),
              ),
              SizedBox(
                width: 25,
              )
            ],
            bottom: PreferredSize(
              preferredSize:Size.fromHeight(35),
                child:Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text("Monday 21",
                        style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent)
                    ),
                  ),
                ),
            ),
          ),
      bottomNavigationBar: BottomNavigationBar(
           backgroundColor: Colors.black87,
           items: [
             
             BottomNavigationBarItem(icon:Icon(Icons.home,size: 32,color: Colors.white,),title: Text("")),
             BottomNavigationBarItem(

                 icon:InkWell(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder:(_)=> AddTodoPage()));
                   },
                   child: Container(
                     height: 52,
                       width: 52,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         gradient: LinearGradient(
                             colors: [
                               Colors.indigoAccent,
                               Colors.purple

                             ]

                         )
                       ),

                       child: Icon(
                         Icons.add,
                         size: 32,
                         color: Colors.white,
                       )),
                 ),
                     title: Text("")


             ),

             BottomNavigationBarItem(icon:Icon(Icons.settings,size: 32,color: Colors.white,),title: Text("")),

             
             
             
           ],
           
         ),
      body:  StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }




          return ListView.builder(
         //   itemCount:snapshot.data.docs.length ,
              itemBuilder: (context,index){

               return TodoCard(
                    key: Key("first"),
                    title: "Wake up Bro",
                    iconData: Icons.alarm,
                    iconColor: Colors.black,
                    time: "10 AM",
                    check: true,
                    iconBgColor: Colors.white
                );
              }


          );
        }
      ),

    );
  }
}
