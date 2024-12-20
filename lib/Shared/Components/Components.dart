import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';
Widget default_TextField({
  TextEditingController? titleController ,
  String? hintText ,
  String? labelText ,
  required Function valdate,
  IconData? prefixIcon ,
  IconButton? suffixIconIcon ,
  Function? submit ,
  Function? pressedIcon ,
  required bool isShow ,
  required TextInputType type,
}) =>  TextFormField(
  validator: (s){
    return valdate(s);
    },
  onFieldSubmitted: (value){
    submit!(value);
  },
  controller: titleController,
  keyboardType: type,
  obscureText: isShow,
  decoration: InputDecoration(
    hintText: hintText,
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.0),
      borderSide: BorderSide(color: Colors.grey),
       ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.0),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
    ),
    prefixIcon: Icon(prefixIcon),
    suffixIcon: suffixIconIcon,
  ),

);

Widget build_list_news(article,context) => Padding(
  padding:  EdgeInsets.all(20.0),
  child: InkWell(
    onTap: (){} ,
    child: Row(
      children: [
        Container(
          height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image(
                image: article['urlToImage'] == null ? NetworkImage('https://static.vecteezy.com/system/resources/previews/008/255/803/non_2x/page-not-found-error-404-system-updates-uploading-computing-operation-installation-programs-system-maintenance-a-hand-drawn-layout-template-of-a-broken-robot-illustration-vector.jpg') :
                NetworkImage(
                    '${article['urlToImage']}'
                ), fit: BoxFit.cover,
            )
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5.0,),
                Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget line() => Padding(
  padding: EdgeInsets.only(left: 20.0 , right: 20.0),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.white,
  )
);

void NavigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
);
void NavigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
    builder: (context) => widget
), (route) => false) ;

Widget defaulButton({
  required Function function,
  required String name,
  double width = double.infinity,
  double raduis = 13.0,
  Color backgroundColor = defaultColor ,
  EdgeInsets? padding ,
}) => Container(
  width: width,
  clipBehavior:Clip.antiAlias ,
  padding: padding,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(raduis),
    color: backgroundColor,
  ),
  child: MaterialButton(
    height: 50.0,
      onPressed: (){
        function() ;
      },
    child: Text(name , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16.0),),
  ),
);

  Widget defaultTextButton({
    required String text,
    required Function pressed,
    Color? color ,
  }) => TextButton(
      onPressed: (){pressed();}
      , child: Text(text,style: TextStyle(color: color , fontWeight: FontWeight.bold),),
  );

void ShowToast({
  required String text,
  required Color backgroundColor,
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

