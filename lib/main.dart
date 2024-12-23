import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Shared/styles/Themes.dart';
import 'Layout/TestAppLayout/TestLayout.dart';
import 'Layout/TestAppLayout/cubit/cubit.dart';
import 'Layout/TestAppLayout/cubit/states.dart';
import 'Modules/TestApp/SocialLogin/SocialLoginScreen.dart';
import 'Network/Local/Cach_Helper.dart';
import 'Shared/Components/Constants.dart';
import 'Shared/bolck_observer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Widget widget;
  uId = CachHelper.getData(key:'uId');
  if (kDebugMode) {
    print(uId);
  }

  if(uId != null){
    widget = const TestLayout() ;
  }else{
    widget = const SocialLoginScreen() ;
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget ;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestCubit()..getUserData()..getHistory()..getArabicExamsNumber(),
      child: BlocConsumer<TestCubit,TestStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
//hello
