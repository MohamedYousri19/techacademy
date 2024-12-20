import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Modules/TestApp/RegisterScreen/cubit/Cubit.dart';
import 'package:tech_acadmy/Modules/TestApp/RegisterScreen/cubit/states.dart';
import '../../../Layout/TestAppLayout/TestLayout.dart';
import '../../../Layout/TestAppLayout/cubit/cubit.dart';
import '../../../Shared/Components/Components.dart';
import '../SocialLogin/SocialLoginScreen.dart';

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>() ;
    var emailController = TextEditingController() ;
    var passwordController = TextEditingController() ;
    var nameController = TextEditingController() ;
    var phoneController = TextEditingController() ;
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
          builder: (context,state) {
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
                          Text('REGISTER' , style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),),
                          const SizedBox(height: 15.0,),
                          Text('Register now to communicate with friends' , style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),
                          const SizedBox(height: 20.0,),
                          default_TextField(
                            titleController: nameController,
                            hintText: 'Name',
                            valdate: (String value){
                              if(value.isEmpty){
                                return'Name must not be empty';
                              }
                            },
                            prefixIcon: Icons.person,
                            type: TextInputType.name,
                            isShow: false,
                          ),
                          const SizedBox(height: 20.0,),
                          default_TextField(
                            titleController: emailController,
                            hintText: 'Email Address',
                            valdate: (String value){
                              if(value.isEmpty){
                                return'email must not be empty';
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            isShow: false,
                          ),
                          const SizedBox(height: 20.0,),
                          default_TextField(
                            titleController: passwordController,
                            hintText: 'Password',
                            valdate: (String value){
                              if(value.isEmpty){
                                return'Password is too short';
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            type: TextInputType.visiblePassword,
                            suffixIconIcon: IconButton(
                              onPressed: (){
                               SocialRegisterCubit.get(context).hidden() ;
                              },
                              icon: Icon(SocialRegisterCubit.get(context).iconPassword),
                            ),
                            isShow:SocialRegisterCubit.get(context).isShow,
                          ),
                          const SizedBox(height: 30.0,),
                          default_TextField(
                            titleController: phoneController,
                            hintText: 'Phone',
                            valdate: (String value){
                              if(value.isEmpty){
                                return'Phone must not be empty';
                              }
                            },
                            prefixIcon: Icons.phone,
                            type: TextInputType.phone,
                            isShow: false,
                          ),
                          const SizedBox(height: 20.0,),
                          ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState ,
                              builder: (context) => defaulButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                   SocialRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text ,
                                        phone: phoneController.text
                                    );
                                  }
                                },
                                name: 'REGISTER',
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator(),)
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              const Text('Do You have an account?' ),
                              defaultTextButton(
                                  text: 'LOGIN NOW',
                                  pressed: (){
                                    NavigateTo(context, const SocialLoginScreen()) ;
                                  }
                              )
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
          listener: (context,state) async {
            if(state is SocialCreateUserSuccessState){
              await TestCubit.get(context).getUserData();
              TestCubit.get(context).getHistory();
              TestCubit.get(context).getArabicExamsNumber();
              NavigateAndFinish(context, const TestLayout()) ;

            }
            if(state is SocialRegisterErrorState){
              ShowToast(text: state.error.toString(), backgroundColor: Colors.red) ;
            }
          }
      )
    );
  }
}
