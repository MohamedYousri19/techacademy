import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Models/SocialApp/ResultModel.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';

class historyScreen extends StatelessWidget {
  const historyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit,TestStates>(
      builder: (BuildContext context, state) {
        var cubit = TestCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('History Exams'),
          ),
          body: ConditionalBuilder(
              condition: cubit.historyExams.isNotEmpty,
              builder: (context) => Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView.separated(
                    itemBuilder: (context,index) => historyItem(cubit.historyExams[index]),
                    separatorBuilder: (context,index) => line(),
                    itemCount: cubit.historyExams.length
                ),
              ),
              fallback: (context) => cubit.historyExams.isEmpty ? Center(child: Image(image: AssetImage('assets/images/empty.png') , height: 200.0 , width: 200.0,)) :  const Center(child: CircularProgressIndicator())
          )
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
  
  Widget historyItem(ResultModel model) => Container(
    width: double.infinity,
    child: Row(
      children: [
        Container(
            padding: EdgeInsetsDirectional.all(10.0),
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
        const SizedBox(width: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(model.name!.toUpperCase() ,
                style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 12.0, overflow: TextOverflow.ellipsis ,),
                maxLines: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('${model.result}/${model.length}'),
            )
          ],
        )
      ],
    ),
  );
}
