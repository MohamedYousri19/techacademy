import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Models/SocialApp/ArabicModel.dart';
import 'package:tech_acadmy/Models/SocialApp/ResultModel.dart';
import 'package:tech_acadmy/Models/SocialApp/ScienceModel.dart';
import 'package:tech_acadmy/Models/SocialApp/Social_User_Model.dart';
import 'package:tech_acadmy/Modules/TestApp/HistoryExams/HistoryScreen.dart';
import 'package:tech_acadmy/Modules/TestApp/Settings/SettingsScreen.dart';
import '../../../Modules/TestApp/Home/HomeScreen.dart';
import '../../../Modules/TestApp/examsScreen/ExamsScreen.dart';
import '../../../Network/Local/Cach_Helper.dart';
import '../../../Shared/Components/Components.dart';

class TestCubit extends Cubit<TestStates> {
  TestCubit() : super(TestInitialState());

  UserDataModel? userModel ;

  static TestCubit get(context) => BlocProvider.of(context);
  Future<void> getUserData() async {
    emit(SocialGetUserLoadingState());
    print('uId');
    print(CachHelper.getData(key: 'uId'));
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uId'))
        .get()
        .then((value) =>
    {
      userModel = UserDataModel.FromJson(value.data()!),
      print(value.data()),
      emit(SocialGetUserSuccessState()),
    })
        .catchError((error){
      if (kDebugMode) {
        print(error.toString());
        print("error.toString()");
      }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    const HomeScreen(),
    const examsScreen(),
    const historyScreen(),
    const SettingsScreen(),
  ];
  int currentIndex = 0 ;
  void changeCurrentIndex(index){
    currentIndex = index ;
    emit(TestChangeBottomNav());
  }
  List arabiclessonsNumber = [];

  void getArabicLessonsNumber(){
    arabiclessonsNumber = [] ;
    emit(GetArabicLessonsLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('arabic')
        .collection('lessons')
        .get()
        .then((value){
          print(value);
          value.docs.forEach((element){
            arabiclessonsNumber.add(element.id);
            print(arabiclessonsNumber[0]);
          });
          // print(value.data());
          // arabicLessons.add(ArabicDataModel.FromJson(value.data()!));
          emit(GetArabicLessonsSuccessState());
    })
        .catchError((error){
          emit(GetArabicLessonsErrorState());
    });
  }

  List scienceLessonsNumber = [];
  void getScienceLessonsNumber(){
    scienceLessonsNumber = [] ;
    emit(GetScienceLessonsLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('science')
        .collection('lessons')
        .get()
        .then((value){
      print(value);
      value.docs.forEach((element){
        scienceLessonsNumber.add(element.id);
        print('scienceLessonsNumber[0]');
        print(scienceLessonsNumber[0]);
      });
      // print(value.data());
      // arabicLessons.add(ArabicDataModel.FromJson(value.data()!));
      emit(GetScienceLessonsSuccessState());
    })
        .catchError((error){
      emit(GetScienceLessonsErrorState());
    });
  }

  List<ArabicDataModel> arabicLessons = [];

  void getArabicLessons(id){
    arabicLessons = [] ;
    emit(GetArabicLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('arabic')
        .collection('lessons')
        .doc(id)
        .collection('explain')
        .get()
        .then((value){
          value.docs.forEach((element){
            arabicLessons.add(ArabicDataModel.FromJson(element.data()));
            emit(GetArabicSuccessState());
          });
          emit(GetArabicSuccessState());
          // print(value);
          // print(value.data());
          // arabicLessons.add(ArabicDataModel.FromJson(value.data()!));
          // arabicDataModel = ArabicDataModel.FromJson(value.data()!);
          // print(arabicDataModel!.lesson);
    })
        .catchError((error){
          emit(GetArabicErrorState());
    });
  }

  List<ScienceDataModel> scienceLessons = [];


  void getScienceLessons(id){
    scienceLessons = [] ;
    emit(GetScienceLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('science')
        .collection('lessons')
        .doc(id)
        .collection('explain')
        .get()
        .then((value){
      value.docs.forEach((element){
        scienceLessons.add(ScienceDataModel.FromJson(element.data()));
        print('scienceLessons.length');
        print(scienceLessons.length);
        print('scienceLessons[0].image');
        emit(GetScienceSuccessState());
      });
      emit(GetScienceSuccessState());
      // print(value);
      // print(value.data());
      // arabicLessons.add(ArabicDataModel.FromJson(value.data()!));
      // arabicDataModel = ArabicDataModel.FromJson(value.data()!);
      // print(arabicDataModel!.lesson);
    })
        .catchError((error){
      emit(GetScienceErrorState());
    });
  }

  List arabicExamsNumber = [];

  Future<void> getArabicExamsNumber() async{
    arabicExamsNumber = [] ;
    emit(GetArabicExamLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('arabic')
        .collection('exams')
        .get()
        .then((value){
      value.docs.forEach((element){
        arabicExamsNumber.add(element.id);
        print('arabiclessonsNumber[0]');
        print(arabicExamsNumber[0]);
      });
      emit(GetArabicExamSuccessState());
    })
        .catchError((error){
          print('error.toString()');
          print(error.toString());
      emit(GetArabicExamErrorState());
    });
  }


  List scienceExamsNumber = [];

  void getScienceExamsNumber(){
    scienceExamsNumber = [] ;
    emit(GetScienceExamLoadingState());
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('science')
        .collection('exams')
        .get()
        .then((value){
      print(value);
      value.docs.forEach((element){
        scienceExamsNumber.add(element.id);
        print('scienceExamsNumber[0]');
        print(scienceExamsNumber[0]);
      });
      // print(value.data());
      // arabicLessons.add(ArabicDataModel.FromJson(value.data()!));
      emit(GetScienceExamSuccessState());
    })
        .catchError((error){
      emit(GetScienceExamErrorState());
    });
  }

  ResultModel? resultModel ;
  List<ResultModel> historyExams = [] ;
  Future<void> getHistory() async{
    emit(GetResultLoadingState());
    historyExams = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uId'))
        .collection('results')
        .get()
        .then((value){
          value.docs.forEach((element){
            historyExams.add(ResultModel.FromJson(element.data())) ;
            print('historyExams[0]');
            print(historyExams[0].result);
            emit(GetResultSuccessState());
          });
    })
        .catchError((error){
      emit(GetResultErrorState());
    });
  }

  void UpdateData({
    required String phone,
    required String name,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateDataLoadingState());
    UserDataModel model1 = UserDataModel(
      uId: userModel!.uId,
      username: name,
      email: userModel!.email,
      image: image ?? userModel!.image,
      bio: bio,
      phone: phone,
      cover: cover ?? userModel!.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model1.toMap()).then((value) =>
    {
      getUserData(),
      ShowToast(text: 'Data edited Successfully', backgroundColor: Colors.green)
    }).catchError((error){
      print(error.toString());
      ShowToast(
          text: 'Data Not edited Successfully', backgroundColor: Colors.red);
      emit(SocialUpdateDataErrorState());
    });
  }

  var listIndex = 0 ;
  void changeIndex(){
    listIndex++ ;
    print(listIndex);
    emit(ChangeListIndex());
  }

  void changeIndex1(){
    listIndex-- ;
    print(listIndex);
    emit(ChangeListIndex());
  }
}
