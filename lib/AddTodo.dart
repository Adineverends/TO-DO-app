import 'package:firebaseauth/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

TextEditingController titlecontroller=TextEditingController();
TextEditingController descriptioncontroller=TextEditingController();
String type="";
String category="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff1d1e26),
            Color(0xff252041),

          ]
        )
       ),
       child: SingleChildScrollView(
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
               SizedBox(height: 30,),
             IconButton(
                 onPressed: (){
                   Navigator.push(context,MaterialPageRoute(builder: (_)=>HomePage()));
                 },
                 icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 28,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Text("Create",style: TextStyle(fontSize: 33,color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 4),),
                 SizedBox(height: 8,),
                  Text("New Todo",style: TextStyle(fontSize: 33,color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 2),),
                   SizedBox(height: 8,),
                    Text("Task Title",style: TextStyle(fontSize: 16.5,color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                    SizedBox(height: 25,),
                    label("Task title"),
                    SizedBox(height: 12,),
                    title(),
                    SizedBox(height: 30,),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelect("Important",0xff2664fa),
                        SizedBox(width:20 ,),
                        taskSelect("Planned",0xfff3bc89),

                      ],
                    ),
                    SizedBox(height: 25,),
                    label("Descreption"),
                    SizedBox(height: 12,),
                    description(),
                    SizedBox(height: 25,),
                    label("Category"),
                    SizedBox(height: 12,),
                    Wrap(
                      children: [
                        categorySelet("Food",0xffff6d6e),
                        SizedBox(width:20 ,),
                        categorySelet("WorkOut",0xff269732),
                        SizedBox(width:20 ,),
                        categorySelet("Work",0xff6597ff),
                        SizedBox(width:20 ,),
                        categorySelet("Design",0xfff9557ff),
                        SizedBox(width:20 ,),
                        categorySelet("Run",0xff6557ff),
                        SizedBox(width: 90,),



                      ],
                    ),

                    SizedBox(height: 50,),
                    button(),
                    SizedBox(height: 30,)

                  ],
                ),
              )
           ],
         ),
       ),
     ),


    );
  }

  Widget button(){
   return InkWell(
     onTap:(){
                  /*todo is name of collection made in firestore firebase */
       FirebaseFirestore.instance.collection("todo").add({
         "title":titlecontroller.text,
         "task":type,
         "category":category,
         "Description":descriptioncontroller.text

       });

        Navigator.pop(context);

     },


     child: Container(
      height: 56,
       width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(

         borderRadius: BorderRadius.circular(20),
         gradient:LinearGradient(
           colors: [
             Color(0xff8a32f1),
             Color(0xffad32f9),
           ]
         )

       ),
         child: Center(
           child: Text("Add Todo",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
         ),
     ),
   );
  }

  Widget description(){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d),
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        controller: descriptioncontroller,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17
        ),
        maxLines: null,
        decoration: InputDecoration(
            hintText: "Description",
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,

            ),


            contentPadding: EdgeInsets.only(
                left:20,
                right: 20
            )
        ),
      ),
    );
  }


  Widget taskSelect(String label,int color){
    return InkWell(
      onTap: (){
        setState(() {
          type=label;
        });
      },
      child: Chip(
        backgroundColor:type==label?Colors.white: Color(color),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(label,style: TextStyle(color: type==label?Colors.black: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),



      ),
    );
  }


Widget categorySelet(String label,int color){
  return InkWell(
    onTap: (){
      setState(() {
        category=label;
      });
    },
    child: Chip(
      backgroundColor: category==label?Colors.white: Color(color),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(label,style: TextStyle(color: category==label?Colors.yellowAccent: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
      labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),



    ),
  );
}


  Widget title(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
         borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        controller: titlecontroller,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 17
        ),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Task Title",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,

          ),

          contentPadding: EdgeInsets.only(
            left:20,
            right: 20
          )
        ),
      ),
    );
  }

  Widget label(String label){
   return Text(label,style: TextStyle(fontSize: 16.5,color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.2),);
  }

}
