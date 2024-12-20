import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/TestLayout.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import 'package:tech_acadmy/Shared/Components/Components.dart';

class ResultScreen extends StatelessWidget {
  final int result ;
  final int length ;
  const ResultScreen({super.key, required this.result, required this.length});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TestCubit,TestStates>(
        builder: (BuildContext context, state) {
          return  Scaffold(
            appBar: AppBar(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Result'),
                ],
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      child: const Image(image: AssetImage('assets/images/congratulate.jpg'))
                  ),
                  const Text('Congratulations' , style: TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20.0,),
                  Text('You have got ${result/length * 100}% Points' , style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 100.0,),
                  Container(
                    padding: const EdgeInsets.all(60.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: result > length/2 ? Colors.green : Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(200.0)
                    ),
                    child: Text('$result/$length' , style: const TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await TestCubit.get(context).getHistory();
                  NavigateAndFinish(context, const TestLayout());
                },
              child: const Icon(IconBroken.Arrow___Right_2, color: Colors.white,),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {  },
    );
  }
}
