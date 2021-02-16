

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:input_firebase/splash.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'history.dart';

main()
{
  
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
   runApp(
     MaterialApp(
       theme: ThemeData.dark(),
       routes:{
         "splash":(context)=>MySplash(),
        "/":(context)=>Myapp(),
        "/history":(context)=>MyHistory(),

       },
       debugShowCheckedModeBanner: false,
       initialRoute:"splash",
       ));
       }
String x;
var str;
var op;
var bdy;
var fsconnect=FirebaseFirestore.instance;
 class Myapp extends StatefulWidget {
   @override
   _MyappState createState() => _MyappState();
 }
 
 class _MyappState extends State<Myapp> {
   final _scaffoldKey = GlobalKey<ScaffoldState>();
   @override
   Widget build(BuildContext context) {


  
 _launchURL() async {
  const url = 'https://access.redhat.com/articles/1189123';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 put(comd,body)
{
  fsconnect.collection("history").add({
     "command":comd,
     "output":body,
  });
}
web(cmd) async
{
var url='http://192.168.0.104/cgi-bin/web.py?x=$cmd';
var response=await http.get(url);

setState(() {
     bdy=response.body;
}
);
}

mic() async
{
var url="http://192.168.0.104/cgi-bin/voicecontrol.py";
var response= await http.get(url);
var bdy=response.body;
print(bdy);

            
}


    return  Scaffold(
      key: _scaffoldKey, 
        appBar: AppBar(
          title:Text('RHEL-Mobile',style: TextStyle(color: Colors.white),
        ),
          backgroundColor: Colors.black,
          
          actions: <Widget>[
            IconButton(icon: Icon(Icons.mic), onPressed: (){ 
              final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
            _scaffoldKey.currentState.showSnackBar(snackBar);
            }),
            IconButton(icon: Icon(Icons.help), onPressed: _launchURL),

          ],
          ),
          drawer: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                
                child: DrawerHeader(
                  
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Card(child: FlatButton(onPressed: (){Navigator.pushNamed(context, "/history");}, child: Text("History"),),),
                  ],
                ),
                
                ),
              ),
            ],
          ),
        body: SingleChildScrollView(
                  child: Center(
          child: Column(
                  
                  children: <Widget>[
                    Container(
                     
                     
                      
                      width: double.infinity,
                     height: MediaQuery.of(context).size.height *.2955,
                     // height: 200,
                      color: Colors.grey,
                    //  alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/redhat-docker.png',fit: BoxFit.fill,),
                    ),
                   Container(
                    width: double.infinity,
                    height:400,
                  child: SingleChildScrollView(
                    child: Column(
                      
                      children: <Widget>[
                         Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                           width: MediaQuery.of(context).size.width,
                           decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                           ),
                           child: TextField(onChanged:(str)=>x=str,decoration: InputDecoration(hintText: ' Enter the command',enabled: true,icon: Icon(Icons.computer) , border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),cursorColor: Colors.white,textAlign: TextAlign.center,),
                         ),
                       RaisedButton(onPressed: ()async{await web(x);put(x, bdy);} , color: Colors.blue,splashColor: Colors.grey,child: Text('Submit',style: TextStyle(color:Colors.white,),)),
                        
                          
                             Container(
                          
                            //padding: EdgeInsets.all(20),
                           
                           width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                            
                            child: Column(
                                
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    
                                    // margin: EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.only(right: 20,left:5),
                                        width:MediaQuery.of(context).size.width ,
                                        height:MediaQuery.of(context).size.height *.04,
                                        
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          
                                          children: <Widget>[
                                          
                                          Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
                                           Center(child: Text(' Terminal',style: TextStyle(color:Colors.white,),textAlign: TextAlign.center,)),
                                          ],
                                        ),
                                      ),
                                  
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      
                                      Text('[root@localhost rhel8]# ',style: TextStyle(color:Colors.white),),
                                      Text(x??" ",style: TextStyle(color:Colors.white),),
                                       ],
                                  ),
                                      
                                          
                                          
                                          Text(bdy ?? " ",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                                      
                                   
                                  
                                ],
                              ),
                          
                            decoration: BoxDecoration(
                               color: Colors.black,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(
                                width:2,
                                color:Colors.grey,
                              ),
                            ),
                              ),
                          
                        
                      ],
                    ),
                  ),
                   ),
                  
                  ], 
      
      
             ),
          ),
        ),
         
      //floatingActionButton: FloatingActionButton.extended(onPressed: null, label: null),  
        backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
    );
    
  }
   
 }