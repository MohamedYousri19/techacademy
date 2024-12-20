import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Modules/TestApp/scienceLesson/Lesson.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TestCubit,TestStates>(
      builder: (BuildContext context, state) {
        var cubit = TestCubit.get(context) ;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios)),
            title: const Text('Science',style: TextStyle(fontSize: 20.0),),
          ),
          body: ConditionalBuilder(
              condition: cubit.scienceLessonsNumber.isNotEmpty,
              builder: (context) => ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return lessonsItem(index,context) ;
                },
                itemCount: cubit.scienceLessonsNumber.length,
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
      TestCubit.get(context).getScienceLessons(TestCubit.get(context).scienceLessonsNumber[index]);
      NavigateTo(context, const scienceLesson());
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
                '${TestCubit.get(context).scienceLessonsNumber[index]}',
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
