import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scaffoldzoid/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class SellerHomePage extends StatefulWidget {
  //const SellerHomePage({Key? key}) : super(key: key);
  String? sellerid;
  SellerHomePage(s){
    this.sellerid=s;
  }

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {

  var sellerdata;
  Future fetchsellerdata()  async{
    var APIURL = "https://shorbazar.shop/shorbazarapp_api/assignment_fetchsellerdata.php";
    Map mapeddate ={
      'sellerid':widget.sellerid,

    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL),body:mapeddate );
    //getting response from php code, here
    var data = jsonDecode(reponse.body.toString());
    print("logindata: ${data}");
    setState(() {
      sellerdata=data;
    });
    // if(data[0]==1){
    //   Fluttertoast.showToast(
    //       msg: "Login successful",
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.grey.shade200,
    //       textColor: Colors.green,
    //       fontSize: 12.0
    //   );
    //   SharedPreferences userlogindata=await SharedPreferences.getInstance();
    //   userlogindata.setBool("newuser", false);
    //   userlogindata.setString("sellerorbuyer", "seller");
    //   userlogindata.setString("sellerid",data[1].toString());
    //   Timer(Duration(seconds: 2), () {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHomePage(data[1].toString())));
    //   });
    // }
    // else{
    //   Fluttertoast.showToast(
    //       msg: "Invalid credential",
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.grey.shade200,
    //       textColor: Colors.red,
    //       fontSize: 12.0
    //   );
    // }
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsellerdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("SCAFFOLDZOID",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: ()async{
              Fluttertoast.showToast(
                  msg: "Logout Successful",
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.shade200,
                  textColor: Colors.green,
                  fontSize: 12.0
              );
              SharedPreferences userlogindata=await SharedPreferences.getInstance();
              userlogindata.setBool("newuser",true);
              userlogindata.setString("sellerorbuyer", "");
              Timer(Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SellerOrBuyer()),ModalRoute.withName('/'));
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: sellerdata!=null?sellerdata!="No Data"?ListView.builder(
          itemCount: sellerdata.length,
          itemBuilder: (BuildContext context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text("${sellerdata[index]["id"]}."),
                title: Text("${sellerdata[index]["type"]}"),
                trailing: Text("Rs. ${sellerdata[index]["price"]}/kg."),
              ),
            );
          },
        ):
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child:Text("No Product")
              ),
            )
            :
        Center(
          child: CircularProgressIndicator(backgroundColor:Colors.cyan,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade200),strokeWidth: 5,),
        )
      ),
    );
  }
}
