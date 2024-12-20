import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Modules/TestApp/RegisterScreen/cubit/states.dart';
import '../../../../Models/SocialApp/Social_User_Model.dart';
import '../../../../Network/Local/Cach_Helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CachHelper.saveData(key: 'uId', value: value.user!.uid);
      userCreate(email: email, phone: phone, name: name, uId: value.user!.uid);
      emit(SocialRegisterSuccessState()) ;
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    UserDataModel model = UserDataModel(
        uId: uId,
        username: name,
        email: email ,
        image:'https://cdn-icons-png.flaticon.com/512/149/149071.png' ,
        bio: 'Write Your bio...',
        phone: phone,
        cover:'https://www.creditaccessgrameen.in/wp-content/themes/creditaccessgrameen/assets/images/landing-pages-default-thumb-image.png'
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) => {
              emit(SocialCreateUserSuccessState()),
            })
        .catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialCreateUserErrorState(error));
    });
  }

  var isShow = true;

  IconData iconPassword = Icons.visibility;

  void hidden() {
    isShow = !isShow;
    if (isShow == true) {
      iconPassword = Icons.visibility;
    } else {
      iconPassword = Icons.visibility_off;
    }
    emit(SocialRegisterChangeState());
  }
}
