import 'package:flutter/material.dart';
import 'package:scaffoldzoid/buyer/buyerHomePage.dart';
import 'package:scaffoldzoid/buyer/buyerlogin.dart';
import 'package:scaffoldzoid/seller/sellerhomepage.dart';
import 'package:scaffoldzoid/seller/sellerlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Scaffoldzoid",
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  SharedPreferences? userlogindata;
  Future<bool> checknewuserornot()async{
    SharedPreferences userlogindata=await SharedPreferences.getInstance();
    bool newuser=userlogindata.getBool("newuser") ?? true;
    return newuser;

  }

  String? sellerid;
  Future<String> checksellerorbuyer()async{
    SharedPreferences userlogindata=await SharedPreferences.getInstance();
    String sellerorbuyer=userlogindata.getString("sellerorbuyer") ?? "";
    String seller=userlogindata.getString("sellerid")??"";
    setState(() {
      sellerid=seller;
    });
    return sellerorbuyer;
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SharedPreferences userlogindata=await SharedPreferences.getInstance();
    checknewuserornot().then((v){
      if(v==false){
       checksellerorbuyer().then((value){
         if(value=="seller"){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHomePage(sellerid)));
         }
         else{
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BuyerHomePage()));
         }
       });
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerOrBuyer()));
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}





class SellerOrBuyer extends StatefulWidget {
  const SellerOrBuyer({Key? key}) : super(key: key);

  @override
  State<SellerOrBuyer> createState() => _SellerOrBuyerState();
}

class _SellerOrBuyerState extends State<SellerOrBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("WELCOME",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("TO",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("SCAFFOLDZOID",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please choose whether You are a")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Buyer OR Seller")
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: Text(
                      "BUYER".toUpperCase(),
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
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BuyerLogin()));

                  },
                ),
              ),

              ElevatedButton(
                child: Text(
                    "SELLER".toUpperCase(),
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
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SellerLogin()));

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
