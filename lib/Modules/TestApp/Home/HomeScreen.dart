import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:tech_acadmy/Modules/TestApp/HistoryExams/HistoryScreen.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';
import 'package:tech_acadmy/Shared/styles/colors.dart';
import '../../../Layout/TestAppLayout/cubit/cubit.dart';
import '../../../Layout/TestAppLayout/cubit/states.dart';
import '../../../Models/SocialApp/ResultModel.dart';
import '../ExamsScreenNumber/ExamArabicScreen.dart';
import '../arabicLessonsScreen/ArabicScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestStates>(
      listener: (BuildContext context, TestStates state) {},
      builder: (BuildContext context, TestStates state) {
        var cubit = TestCubit.get(context);
        List<Variables> varaibles = [
          Variables('assets/images/physics.jpg','Science'),
          Variables('assets/images/technology.jpg','Technology'),
        ];
        void methods()async{
          await
          cubit.getUserData();
          cubit.getHistory();
          cubit.getArabicExamsNumber();
        }
        Future<void> onRefresh()async{
          return methods() ;
        }
        return  ConditionalBuilder(
            condition: cubit.userModel != null ,
            builder: (context) => RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: () {
                return onRefresh();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0 , left: 15.0 , right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Container(
                            //   height: 40.0,
                            //   width: 40.0,
                            //   child: Image(
                            //       image: AssetImage('assets/images/logo.jpg'),
                            //     fit: BoxFit.cover,
                            //     height: 40.0,
                            //     width: 40.0,
                            //   ),
                            // ),
                            const Spacer(),
                            Image(
                                height: 40.0,
                                width: 40.0,
                                image: NetworkImage('${cubit.userModel?.image}')
                            )
                          ],
                        ),
                        Text(
                          'Hello, ${cubit.userModel!.username}',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 40.0,),
                        const Text(
                          'Subjects',
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        SizedBox(
                          height: 130.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index) => subjectItem(varaibles[index] , context),
                                    separatorBuilder: (context,index) => const SizedBox(width: 5.0,),
                                    itemCount: varaibles.length
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          children: [
                            const Text(
                              'Take Exam',
                              style: TextStyle(
                                  color: secondColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                NavigateTo(context, const examsScreenNumbers(name: 'arabic',));
                              },
                              child: Container(
                                padding: const EdgeInsetsDirectional.all(7.0),
                                decoration: BoxDecoration(
                                    color: Colors.indigo[100],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                      color: thirdColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index) => examItem(cubit.arabicExamsNumber[index], context),
                                    separatorBuilder: (context,index) => const SizedBox(width: 5.0,),
                                    itemCount: cubit.arabicExamsNumber.length
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          children: [
                            const Text(
                              'Exam History',
                              style: TextStyle(
                                  color: secondColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                NavigateTo(context, const historyScreen());
                              },
                              child: Container(
                                padding: const EdgeInsetsDirectional.all(7.0),
                                decoration: BoxDecoration(
                                    color: Colors.indigo[100],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                      color: thirdColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index) => historyItem(cubit.historyExams[index]),
                            separatorBuilder: (context,index) => const SizedBox(height: 5.0,),
                            itemCount: cubit.historyExams.length
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
  Widget subjectItem(Variables varaiable , context) => InkWell(
    onTap: (){
      if(varaiable.name == 'Technology'){
        TestCubit.get(context).getArabicLessonsNumber();
        NavigateTo(context, const LessonsScreen(name: 'arabic',));
        print('arabic');
      }else{
        TestCubit.get(context).getScienceLessonsNumber();
        NavigateTo(context, const LessonsScreen(name: 'science',));
        print('science');
      }
    },
    child: Container(
      padding: const EdgeInsetsDirectional.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(10.0)
      ),
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
                image: AssetImage(varaiable.path)
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(
              varaiable.name,
            style: const TextStyle(
              color:secondColor,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    ),
  ) ;
  Widget examItem(String name , context) => InkWell(
    onTap: (){
      NavigateTo(context, const examsScreenNumbers(name: 'arabic',));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.indigo,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           '${ name.toUpperCase()}',
            style: const TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.w500,
              fontSize: 15.0
            ),
          ),
          const SizedBox(height: 10.0,),
          const Row(
            children: [
              Text('Take Exam' , style: TextStyle(color: Colors.white , fontSize: 15, fontWeight: FontWeight.w500),),
              SizedBox(width: 10.0,),
              Icon(IconBroken.Arrow___Right,color: Colors.white, size: 17,)
            ],
          )
        ],
      ),
    ),
  ) ;
  Widget historyItem(ResultModel model) => SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsetsDirectional.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white60,
            ),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Image(image: AssetImage('${model.image}') ,height: 100.0 , width: 100.0, fit: BoxFit.cover,)
            )
        ),
        const SizedBox(width: 10.0,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(model.name!.toUpperCase() ,
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 12.0, overflow: TextOverflow.ellipsis ,),
              maxLines: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('${model.result}/${model.length}' , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 14.0 , color: Colors.black),),
            )
          ],
        )
      ],
    ),
  );
}
class Variables{
  final String path ;
  final String name ;
  Variables(this.path,this.name);
}