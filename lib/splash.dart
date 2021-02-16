import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:input_firebase/home.dart';
import 'package:input_firebase/main.dart';
import 'package:page_transition/page_transition.dart';
class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
          duration: 2000 ,
         //splash: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRlY5_rThZszHxk4T6tAvEfRXBSUz0sFiJq0w&usqp=CAU'),
          splash:Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            color: Colors.black,
            child: Center(child: Text("sudo",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 50),)),
          ),
          nextScreen: Myapp(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.downToUp,
          backgroundColor: Colors.grey.shade300,
          splashIconSize: 150.0,
        );
  }
}