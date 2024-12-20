import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/cubit.dart';
import 'package:tech_acadmy/Modules/TestApp/SocialLogin/cubit/Cubit.dart';
import 'package:tech_acadmy/Modules/TestApp/SocialLogin/cubit/states.dart';
import '../../../Layout/TestAppLayout/TestLayout.dart';
import '../../../Network/Local/Cach_Helper.dart';
import '../../../Shared/Components/Components.dart';
import '../RegisterScreen/SocialRegisterScreen.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (BuildContext context, Object? state) async {
          if (state is SocialLoginErrorState) {
            ShowToast(
                text: state.error.toString(), backgroundColor: Colors.red
            );
          }
          if (state is SocialLoginSuccessState) {
           await CachHelper.saveData(key: 'uId', value: state.uId);
           print(CachHelper.getData(key: 'uId'));
           await TestCubit.get(context).getUserData();
           TestCubit.get(context).getHistory();
           TestCubit.get(context).getArabicExamsNumber();
           NavigateAndFinish(context, const TestLayout()) ;
           ShowToast(
               text: 'LogIn Successfully', backgroundColor: Colors.green
           );
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        default_TextField(
                          titleController: _emailController,
                          hintText: 'Email Address',
                          valdate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          prefixIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          isShow: false,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        default_TextField(
                          titleController: _passwordController,
                          hintText: 'Password',
                          valdate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          prefixIcon: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          suffixIconIcon: IconButton(
                            onPressed: () {
                              SocialLoginCubit.get(context).hidden();
                            },
                            icon: Icon(
                                SocialLoginCubit.get(context).IconPassword),
                          ),
                          submit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          isShow: SocialLoginCubit.get(context).isShow,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaulButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: _emailController.text,
                                          password: _passwordController.text
                                      );
                                    }
                                  },
                                  name: 'LOGIN',
                                ),
                            fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                                text: 'Register Now',
                                pressed: () {
                                  NavigateTo(
                                      context, const SocialRegisterScreen());
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
