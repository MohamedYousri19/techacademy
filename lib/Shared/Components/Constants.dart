import 'package:flutter/material.dart';
import 'package:tech_acadmy/Modules/TestApp/SocialLogin/SocialLoginScreen.dart';
import '../../Network/Local/Cach_Helper.dart';

void SignOut(context){
  CachHelper.removeData(key: 'token').then((value) => {
    if(value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context)=>SocialLoginScreen())
          ,(route) => false)
    }
  });
}
void printFullText(String text){
  final pattern = RegExp('.{1,800}') ;
  pattern.allMatches(text).forEach((match) {print(match.group(0));});
}
String? token ;
String? uId ;