import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scaffoldzoid/buyer/buyerHomePage.dart';
import 'package:scaffoldzoid/buyer/buyerlogin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class BuyerRegister extends StatefulWidget {
  const BuyerRegister({Key? key}) : super(key: key);

  @override
  State<BuyerRegister> createState() => _BuyerRegisterState();
}

class _BuyerRegisterState extends State<BuyerRegister> {
  final k1= GlobalKey<FormState>();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController shopname=TextEditingController();
  SharedPreferences? userlogindata;

  var logindata;
  Future registerdatasend()  async{
    var APIURL = "https://shorbazar.shop/shorbazarapp_api/assignment_buyerregistration.php";
    Map mapeddate ={
      'username':username.text,
      'password':password.text,
      'name':shopname.text
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL),body:mapeddate );
    //getting response from php code, here
    var data = jsonDecode(reponse.body.toString());
    print("logindata: ${data}");
    setState(() {
      logindata=data;
    });
    if(data==1){
      Fluttertoast.showToast(
          msg: "Registration successful",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.green,
          fontSize: 12.0
      );
      SharedPreferences userlogindata=await SharedPreferences.getInstance();
      userlogindata.setBool("newuser", false);
      userlogindata.setString("sellerorbuyer","buyer");
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BuyerHomePage()));
      });
    }
    else{
      if(data==0){
        Fluttertoast.showToast(
            msg: "registration Error!",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.red,
            fontSize: 12.0
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "Already Registered",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.red,
            fontSize: 12.0
        );
      }

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: k1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BUYER REGISTRATION",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
                SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0,5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.deepOrange,
                      style: TextStyle(color: Colors.grey,fontSize: 14),
                      //autovalidate: false,
                      validator: (value){
                        if(username.text.length<1){
                          return 'Please put your username';
                        }
                        null;
                      },

                      enableInteractiveSelection: false,
                      controller: username,
                      decoration: InputDecoration(
                        labelText: "Email ID",
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0,5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.deepOrange,
                      style: TextStyle(color: Colors.grey,fontSize: 14),
                      //autovalidate: false,
                      validator: (value){
                        if(password.text.length<1){
                          return 'Please put your password';
                        }
                        null;
                      },

                      enableInteractiveSelection: false,
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0,5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.deepOrange,
                      style: TextStyle(color: Colors.grey,fontSize: 14),
                      //autovalidate: false,
                      validator: (value){
                        // if(username.text.length<1){
                        //   return 'Please put your username';
                        // }
                        // null;
                      },

                      enableInteractiveSelection: false,
                      controller: shopname,
                      decoration: InputDecoration(
                        labelText: "Your Name (optional)",
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                        "Register".toUpperCase(),
                        style: TextStyle(fontSize: 14,color: Colors.white,)
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.black)
                          )
                      ),
                      // shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                      // elevation: MaterialStateProperty.all<double>(10),
                    ),
                    onPressed: (){
                      if(k1.currentState!.validate()){
                        registerdatasend();

                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Fillup mendatory fields",
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade200,
                            textColor: Colors.red,
                            fontSize: 12.0
                        );

                      }

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an Account?",style: TextStyle(color: Colors.grey),),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BuyerLogin()));
                            },
                            child: Text("LogIn",style: TextStyle(color: Colors.deepOrange,fontSize: 14,fontWeight: FontWeight.bold),)
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
