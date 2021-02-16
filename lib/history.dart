import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHistory extends StatefulWidget {
  @override
  _MyHistoryState createState() => _MyHistoryState();
}


 List<String> cmd = List<String>();                   //List for command
 List<String> output = List<String>();                //List for output


var fsc=FirebaseFirestore.instance;                   //Firestore Instance





class _MyHistoryState extends State<MyHistory> {





void deactivate() async
{
  var a=await fsc.collection("history").get();
 for (var d in  a.docs )
  {
    cmd.remove(d.data()["command"]);
    output.remove(d.data()["output"]);
  }
  super.deactivate();

}




  @override
Widget build(BuildContext context)  {
  
      
    return GestureDetector(
      onTap: ()
      {
          FocusScope.of(context).requestFocus(new FocusNode());
      },
      
        child: Scaffold(
        appBar: AppBar(
            title: Text("Command History"),
        ),
        body: StreamBuilder<QuerySnapshot>(builder: (context,snapshot) 
                    {
                    
                        var history= snapshot.data.docs;
                         try{
                          if (!snapshot.hasData || snapshot.data.docs.isEmpty) return Text("loading");
                          else if(snapshot.hasError) return Text("Error");
                        else{
                        for (var d in history)
                        {
                          var c=d.data()["command"];
                          var o=d.data()["output"];
                           cmd.add(c);
                           output.add(o);
                           print(d.data());
                        }
                        }
                         
                        
                       return  ListView.builder( itemCount: cmd.length,itemBuilder: (BuildContext context,int index) 
                        {
                             var c=cmd[index];
                             var o=output[index];
                                
                                  
                              return Card(
                                            elevation: 5,
                                        child: GestureDetector(
                                                            child: ListTile(
                                                            title: Text( c?? "Not "),
                                                            subtitle: Text(o??" "),
                                                                            ),
                                                            onLongPress: (){final act = CupertinoActionSheet(
                                                                     title: Text('Select Option'),
                                                                      message: Text('Which option?'),
                                                                      actions: <Widget>[
                                                                                CupertinoActionSheetAction(
                                                                                      child: Text('Copy'),
                                                                                      onPressed: () {
                                                                                            ClipboardManager.copyToClipBoard(c).then((result) {
                                                                                                      final snackBar = SnackBar(
                                                                                                      content: Text('Copied to Clipboard'),
                                                                                                      action: SnackBarAction(
                                                                                                            label: 'Undo',
                                                                                                            onPressed: () {},
                                                                                                                            ),
                                                                                                                        );
                                                                                                       Scaffold.of(context).showSnackBar(snackBar);
                                                                                                  });
                                                                                              Navigator.pop(context);
                                                                                              },
                                                                                      ),
                                                                                CupertinoActionSheetAction(
                                                                  child: Text('Delete'),
                                                                  onPressed: () {
                                                                  Navigator.pop(context);
                                                                  },
                                                                ),
                                                              ],
                                                              cancelButton: CupertinoActionSheetAction(
                                                                child: Text('Cancel'),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              ));
                                                          showCupertinoModalPopup(
                                                              context: context,
                                                              builder: (BuildContext context) => act);
                                                        },
                                      
                                                ),
                                   
                                    );
                                  }
                         
                         );
                         }
                          catch(e)
                         {
                           print(e);
                         }
                    },
                   
                   
                    
                
                
                    stream: fsc.collection("history").snapshots(),
                    ),
          ),

                    
                    
                  
        );
      
    
  }
}