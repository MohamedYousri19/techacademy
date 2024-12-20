import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:tech_acadmy/Modules/TestApp/Edit_Info/Edit_Profile.dart';
import 'package:tech_acadmy/Modules/TestApp/HistoryExams/HistoryScreen.dart';
import 'package:tech_acadmy/Modules/TestApp/SocialLogin/SocialLoginScreen.dart';
import 'package:tech_acadmy/Modules/TestApp/examsScreen/ExamsScreen.dart';
import 'package:tech_acadmy/Network/Local/Cach_Helper.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';
import '../../../Layout/TestAppLayout/cubit/cubit.dart';
import '../../../Layout/TestAppLayout/cubit/states.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TestCubit,TestStates>(
      listener: (BuildContext context, TestStates state) {  },
      builder: (BuildContext context, TestStates state) {
        var cubit =TestCubit.get(context) ;
        return  Padding(
          padding: const EdgeInsets.only(top: 70.0 , right: 10.0 , left: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                    radius: 30.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${cubit.userModel!.username}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                            ),
                          ),
                          Text(
                            '${cubit.userModel!.email}',
                            style: TextStyle(
                                fontSize: 15.0,
                              color: Colors.grey[700]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(IconBroken.Profile , size: 30.0,)
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 30.0,start: 5.0 , end: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.indigo[500],
                  ),
                  child: Column(
                    children: [
                      items('Personal Info', IconBroken.Profile,(){
                        NavigateTo(context, const EditProfileScreen());
                      },1),
                      line(),
                      items('History', IconBroken.Time_Circle,(){
                        NavigateTo(context, const historyScreen());
                      },1),
                      line(),
                      items('Exams', IconBroken.Paper,(){
                        NavigateTo(context, const examsScreen());
                      },0),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 10.0),
                child: GestureDetector(
                    onTap: (){
                    FirebaseAuth.instance.signOut();
                    NavigateAndFinish(context, const SocialLoginScreen());
                    CachHelper.removeData(key: 'uId');
                    },
                  child:Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: const Border(
                        top: BorderSide(
                          color: Colors.indigo,
                          width: 2.0
                        ),
                        bottom: BorderSide(
                            color: Colors.indigo,
                            width: 2.0
                        ),
                        right: BorderSide(
                            color: Colors.indigo,
                            width: 2.0
                        ),
                        left: BorderSide(
                            color: Colors.indigo,
                            width: 2.0
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Logout , color: Colors.indigo, size: 25.0,),
                        Text('Log Out' , style: TextStyle(color: Colors.indigo , fontWeight: FontWeight.bold , fontSize: 16.0),)
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        );
      },
    );

  }
  Widget items(text ,icon ,method , idx) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0)
    ),
    clipBehavior: Clip.antiAlias,
    padding: const EdgeInsets.all(5.0),
    child: MaterialButton(
      splashColor: Colors.white,
      onPressed: (){
        method();
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(top: 10.0 , bottom:10.0),
        child: Column(
          children: [
            Row(
                  children:[
                    Icon(icon, size: 30.0 , color: Colors.white,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: Text(
                          text,
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    const Icon( IconBroken.Arrow___Right_2, size: 25.0, color: Colors.white,),
                  ],
                ),
          ],
        ),
      ),
    ),
  );
}
