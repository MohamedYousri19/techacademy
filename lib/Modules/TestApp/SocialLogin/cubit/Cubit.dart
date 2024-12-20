

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Modules/TestApp/SocialLogin/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  String? error1 ;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          print(value.user!.email),
          print('value.user!.uid'),
          print(value.user!.uid),
      emit(SocialLoginSuccessState(value.user!.uid)) ,
    }).catchError((error) {
      error1 == error.toString() ;
      print(error1);
      emit(SocialLoginErrorState(error));
    });
  }


  var isShow = true;

  IconData IconPassword = Icons.visibility;

  void hidden() {
    isShow = !isShow;
    if (isShow == true) {
      IconPassword = Icons.visibility;
    } else {
      IconPassword = Icons.visibility_off;
    }
    emit(SocialLoginChangeState());
  }
}
