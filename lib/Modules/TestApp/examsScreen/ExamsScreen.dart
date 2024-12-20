import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Modules/TestApp/scienceExamsScreen/ExamScienceScreen.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';
import '../../../Shared/styles/colors.dart';
import '../arabicExamsScreen/ExamArabicScreen.dart';

class examsScreen extends StatelessWidget {
  const examsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Variables> varaibles = [
      Variables('assets/images/physics.jpg', 'Science'),
      Variables('assets/images/technology.jpg', 'Technology'),
    ];
    return  BlocConsumer<TestCubit,TestStates>(
      builder: (BuildContext context, TestStates state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 45.0 , left: 15.0),
            child: Column(
              children: [
                const Text(
                  'Exams',
                  style: TextStyle(
                      color: secondColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      subjectItem(varaibles[0], context),
                      SizedBox(width: 20.0,),
                      subjectItem(varaibles[1], context),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, TestStates state) {  },

    );
  }
  Widget subjectItem(Variables varaiable , context) => InkWell(
    onTap: (){
      if(varaiable.name == 'Technology'){
        TestCubit.get(context).getArabicExamsNumber();
        NavigateTo(context, Examarabicscreen());
      }else{
        TestCubit.get(context).getScienceExamsNumber();
        NavigateTo(context, examScienceScreen());
        print('object');
      }
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0)
          ),
          clipBehavior: Clip.antiAlias,
          child: Image(
              height: 90.0,
              width: 90.0,
              fit: BoxFit.cover,
              image: AssetImage('${varaiable.path}')
          ),
        ),
        SizedBox(height: 5.0,),
        Text(
          '${varaiable.name}',
          style: TextStyle(
              color:secondColor,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    ),
  ) ;
}

class Variables{
  final String path ;
  final String name ;
  Variables(this.path, this.name);
}

