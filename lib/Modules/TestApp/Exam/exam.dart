import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:tech_acadmy/Models/SocialApp/ResultModel.dart';
import 'package:tech_acadmy/Models/SocialApp/Social_User_Model.dart';
import 'package:tech_acadmy/Models/SocialApp/SubjectName.dart';
import 'package:tech_acadmy/Modules/TestApp/ResultsScreen/ResulsScreen.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';
import 'package:tech_acadmy/Shared/Components/Constants.dart';
import '../../../Models/SocialApp/QuestionModel.dart';
import '../../../Network/Local/Cach_Helper.dart';

class QuizPage extends StatefulWidget {
  final String request ;
  const QuizPage({super.key, required this.request});
  @override
  _QuizPageState createState() => _QuizPageState(request);
}

class _QuizPageState extends State<QuizPage> {
  final String request ;
  List<Question> questions = [];
  int currentIndex = 0;
  int? index ;
  int idx1 = 0 ;
  bool isLoading = true;
  int result = 0 ;
  String name = '' ;
  static const int totalTimeInSeconds = 10 * 60; // 10 minutes in seconds
  late int _remainingTime; // Remaining time in seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadQuestions();
    loadQuestionsName();
    getUserData();
    _remainingTime = totalTimeInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          _onTimerEnd(); // Call the function when timer ends
        }
      });
    });
  }

  void _onTimerEnd() {
    // This function is called when the timer ends
    print('Timer finished!');
    // Add your logic here, e.g., navigate, show a dialog, etc.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Time is up!' , style: TextStyle(color: Colors.black , fontSize: 20.0 , fontWeight: FontWeight.bold),),
        content: Text('The 10-minute timer has finished.' , style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: (){
              ResultModel model = ResultModel(
                result: result,
                image: modelname!.name == 'arabic' ? 'assets/images/technology.jpg' : 'assets/images/physics.jpg',
                name: request,
                myName: userModel!.username,
                email: userModel!.email,
                time: DateTime.now().toString(),
                examName: request,
                length: questions.length.toString(),
              );
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uId)
                  .collection('results')
                  .add(model.toMap())
                  .then((onValue){
                setState(() {
                  print('success');
                });
                NavigateAndFinish(context, ResultScreen(result: result, length: questions.length,));
              })
                  .catchError((onError){
                print(onError.toString());
                print('error');
              });
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }


  Question? model;
  List<Question> questions1 = [] ;

  _QuizPageState(this.request);

  Future<void> loadQuestions() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('subjects')
        .doc('arabic')
        .collection('exams')
        .doc(request)
        .collection('questions')
        .get();
    setState(() {
      questions = snapshot.docs.map((doc) {
        return Question.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
      snapshot.docs.map((element){
        questions1.add(Question.fromFirestore(element.data() as Map<String,dynamic>));
      });
      print('questions[0].correctAnswer');
      print(questions[0].correctAnswer);
      print(questions1);
      isLoading = false;
    });
  }
  SubjectName? modelname ;

  Future<void> loadQuestionsName() async {
    FirebaseFirestore.instance
        .collection('subjects')
        .doc('arabic')
        .collection('exams')
        .doc(request)
        .get()
        .then((onValue){
          modelname = SubjectName.FromJson(onValue.data()!);
          print(modelname!.name);
    })
        .catchError((onError){});
  }
  UserDataModel? userModel;

  Future<void> getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uId'))
        .get()
        .then((value) =>
    {
      setState(() {
    userModel = UserDataModel.FromJson(value.data()!);
      print(value.data());
      })
    })
        .catchError((error) {});
  }


  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var question = questions[currentIndex];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.purple], // الألوان
            begin: Alignment.topLeft, // بداية التدرج
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      '$minutes:$seconds',
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold , color:  Colors.white),
                    ),
                    const SizedBox(width: 25.0,),
                    Text('Question ${currentIndex + 1} of ${questions.length}' , style: TextStyle(color: Colors.white),),
                    const Spacer(),
                    const Icon(IconBroken.Paper , color: Colors.white,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 50.0),
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height *0.72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(question.questionText, style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ...question.options.asMap().entries.map((entry) {
                        int idx = entry.key;
                        String option = entry.value;
                        return GestureDetector(
                          onTap: () {
                            print('idx1');
                            print(idx);
                            setState(() {
                              index = idx + 1 ;
                              idx1 = idx ;
                            });

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsetsDirectional.only(start: 30.0 , top: 15.0 , bottom: 15.0 ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: index == idx + 1 ? Colors.indigo : Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option,style: TextStyle(
                                      color: index == idx + 1 ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (idx1 == question.correctAnswer) {
                            setState(() {
                              result ++ ;
                              print('result');
                              print(result);
                            });
                          }
                          if (currentIndex < questions.length - 1) {
                            setState(() {
                              currentIndex++;
                            });
                          }else{
                            if(currentIndex == questions.length - 1){
                              ResultModel model = ResultModel(
                                result: result,
                                image: modelname!.name == 'arabic' ? 'assets/images/technology.jpg' : 'assets/images/physics.jpg',
                                name: request,
                                myName: userModel!.username,
                                email: userModel!.email,
                                time: DateTime.now().toString(),
                                examName: request,
                                length: questions.length.toString(),
                              );
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uId)
                                  .collection('results')
                                  .add(model.toMap())
                                  .then((onValue){
                                setState(() {
                                  print('success');
                                });
                                NavigateAndFinish(context, ResultScreen(result: result, length: questions.length,));
                              })
                                  .catchError((onError){
                                print(onError.toString());
                                print('error');
                              });
                            }
                          }
                          print(result) ;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.indigo,
                          ),
                          padding: EdgeInsets.all(20.0),
                          alignment: AlignmentDirectional.center,
                          width: double.infinity,
                          child: Text(
                              currentIndex == questions.length - 1 ? 'Finish' : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}