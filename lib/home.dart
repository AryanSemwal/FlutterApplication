import 'package:flutter/material.dart';
import 'package:input_firebase/main.dart';
import 'package:http/http.dart' as http;
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHome> {
  var a;
  var b;
  static String ip;
   String pass;
  @override
  Widget build(BuildContext context) {
     web(pass) async
                  {
                      var url='http://$ip/cgi-bin/auth.py?password=$pass';
                      var response=await http.get(url);
                      bdy=response.body;
                     if(bdy=="1")
                     {
                       Navigator.pushNamed(context, "/");
                     }
                     else
                     {
                       print("INCORRECT");
                     }
                  }
    return Scaffold(

      backgroundColor: Colors.redAccent[700],
      body: SingleChildScrollView(
        
              child: Container(
          
                    child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:  SingleChildScrollView(
                              child: Column(
                    children: <Widget>[
                      //SizedBox(height: MediaQuery.of(context).size.height*.4,),
                      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*.4,child: Image.network('https://mcdn.wallpapersafari.com/medium/41/40/gQKmxa.jpg',fit: BoxFit.fill,),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),),
                     SizedBox(height: 30,),
                      Container(
                        child: TextField(
                          onChanged: (a){ip=a;},
                          keyboardType: TextInputType.number,
                          
                          decoration: InputDecoration(
                            hintText: "Enter IP",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3,color:Colors.red),
                              borderRadius: BorderRadius.circular(30),
                              ),
                             
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 4,
                                  color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
                                 // filled: true,fillColor: Colors.grey
                                 )
                                
                                 ),
                                    width: MediaQuery.of(context).size.width*.87,
                                    // decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),),
                      ),
                      SizedBox(height: 20,),

                       Container(
                         child: TextField(
                           onChanged: (b){pass=b;},
                           decoration: InputDecoration(
                             hintText: "Enter Password",
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color:Colors.red,width: 3),
                               borderRadius: BorderRadius.circular(30)
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color:Colors.white,
                                 width: 4
                               ),
                               borderRadius: BorderRadius.circular(30)   
                             )
                             ),
                             ),
                      width: MediaQuery.of(context).size.width*.87,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(20)),),
                      SizedBox(height: 30,),
                     
                     Padding(padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.15),child:  MaterialButton(onPressed: (){
               if(ip==null &&  pass==null)
               {
                   print("NULL");
               }
               else
               {
                 try{
                  web(pass);
                 }
                 catch(e)
                 {
                   print(e);
                 }
               }
                       },
                       child: Text('Connect',style: TextStyle(fontSize: 17),),height: 40,elevation: 5,color: Colors.black,minWidth: MediaQuery.of(context).size.width*.5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),)
                    ],
                  ),
              ),
                
              ),
          ),
      ),
      
      
      
    );
  }
}