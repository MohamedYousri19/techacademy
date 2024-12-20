  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';

class TestLayout extends StatelessWidget {
  const TestLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = TestCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper), label: 'Exams'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Time_Circle), label: 'History'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile), label: 'Profile'),
              ]),
        );
      },
    );
  }
}
