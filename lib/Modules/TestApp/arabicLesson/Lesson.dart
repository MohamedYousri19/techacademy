import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';


class lesson extends StatelessWidget {
  final String name ;
  const lesson({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit,TestStates>(
      builder: (BuildContext context, state) {
        var cubit = TestCubit.get(context) ;
        return  ConditionalBuilder(
            condition: name == 'arabic' ? cubit.arabicLessons.isNotEmpty : cubit.scienceLessons.isNotEmpty,
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo,
                leading:  IconButton(onPressed: (){
                  cubit.getArabicLessonsNumber();
                  cubit.listIndex == 0 ;
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios , color: Colors.white,)),
                title: Text( name == 'arabic' ? '${cubit.arabicLessons[cubit.listIndex].lesson}' : '${cubit.scienceLessons[cubit.listIndex].lesson}' , style: TextStyle(color: Colors.white , fontSize: 25.0),),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.teal], // الألوان
                    begin: Alignment.topLeft, // بداية التدرج
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(25.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height *0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[200]
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: CachedNetworkImage(imageUrl: name == 'arabic' ? '${cubit.arabicLessons[cubit.listIndex].image}' : '${cubit.scienceLessons[cubit.listIndex].image}',),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                              ),
                              SizedBox(height: 20.0,),
                              Column(
                                children: [
                                  Text(
                                    name == 'arabic' ? '${cubit.arabicLessons[cubit.listIndex].data}' : '${cubit.scienceLessons[cubit.listIndex].data}' ,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20.0),
                                    maxLines: 14,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if(name == 'arabic'){
                                        if(cubit.listIndex < cubit.arabicLessons.length - 1 || cubit.listIndex == cubit.arabicLessons.length - 1 ){
                                          if(cubit.listIndex == 0){
                                            print('finish');
                                          }else{
                                            cubit.changeIndex1();
                                          }
                                        }else{
                                          print('finished');
                                        }
                                      }else{
                                        if(cubit.listIndex < cubit.scienceLessons.length - 1 || cubit.listIndex == cubit.scienceLessons.length - 1 ){
                                          if(cubit.listIndex == 0){
                                            print('finish');
                                          }else{
                                            cubit.changeIndex1();
                                          }
                                        }else{
                                          print('finished');
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.indigo,
                                      ),
                                      padding: EdgeInsetsDirectional.symmetric(vertical: 15.0 , horizontal: 20.0),
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        'Previous',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if(name == 'arabic'){
                                        if(cubit.listIndex <  cubit.arabicLessons.length - 1 ){
                                          cubit.changeIndex();
                                        }else{
                                          print('finished');
                                        }
                                      }else{
                                        if(cubit.listIndex <  cubit.scienceLessons.length - 1 ){
                                          cubit.changeIndex();
                                        }else{
                                          print('finished');
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.indigo,
                                      ),
                                      padding: EdgeInsetsDirectional.symmetric(vertical: 15.0 , horizontal: 20.0),
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
