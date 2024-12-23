import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';

import '../Exam/exam.dart';

class examsScreenNumbers extends StatelessWidget {
  final String name ;
  const examsScreenNumbers({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TestCubit,TestStates>(
      builder: (BuildContext context, state) {
        var cubit = TestCubit.get(context) ;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios)),
            title: Text( name == 'arabic' ?'Technology Exams':'Science Exams',style: TextStyle(fontSize: 20.0),),
          ),
          body: ConditionalBuilder(
              condition: name == 'arabic' ? cubit.arabicExamsNumber.isNotEmpty : cubit.scienceExamsNumber.isNotEmpty ,
              builder: (context) => ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return lessonsItem(index,context) ;
                },
                itemCount: name == 'arabic' ? cubit.arabicExamsNumber.length : cubit.scienceExamsNumber.length,
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
  Widget lessonsItem(index,context) => GestureDetector(
    onTap: (){
      NavigateAndFinish(context, QuizPage(request: name == 'arabic' ? TestCubit.get(context).arabicExamsNumber[index] : TestCubit.get(context).scienceExamsNumber[index], subjectName: name,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                name == 'arabic' ? '${TestCubit.get(context).arabicExamsNumber[index]}' : '${TestCubit.get(context).scienceExamsNumber[index]}',
              style: const TextStyle(
                  color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.0
              ),
            ),
          ],
        ),
      ),
    ),
  ) ;
}
