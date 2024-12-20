import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_acadmy/Layout/TestAppLayout/cubit/states.dart';
import '../../../Layout/TestAppLayout/cubit/cubit.dart';
import '../../../Shared/Components/Components.dart';
import '../../../Shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();

        nameController.text = TestCubit.get(context).userModel!.username! ;
        bioController.text = TestCubit.get(context).userModel!.bio! ;
        phoneController.text = TestCubit.get(context).userModel!.phone! ;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  TestCubit.get(context).getUserData();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text('Edit Profile'),
              titleSpacing: 0.5,
              actions: [
                Container(
                  width: 70.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    focusColor: defaultColor,
                    color: defaultColor,
                      onPressed: (){
                      TestCubit.get(context).UpdateData(phone: phoneController.text, name: nameController.text, bio: bioController.text);
                      },
                    child: Text('Edit',style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 20.0,color: Colors.white),),
                  ),
                )
                ,
                const SizedBox(width: 10,)
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if( state is SocialUploadProfileImageLoadingState || state is SocialUploadImageCoverLoadingState || state is SocialUpdateDataLoadingState)
                    const LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    default_TextField(
                        titleController: nameController,
                        valdate: (String value){
                          if(value.isEmpty){
                            return 'Name Must Not be Empty';
                          }
                        },
                        prefixIcon: Icons.person,
                        isShow: false,
                        type: TextInputType.name,
                      hintText: 'Name'
                    ),
                    const SizedBox(height: 10.0,),
                    default_TextField(
                        titleController: phoneController,
                        valdate: (String value){
                          if(value.isEmpty){
                            return 'Phone Must Not be Empty';
                          }
                        },
                        prefixIcon: Icons.call,
                        isShow: false,
                        type: TextInputType.text,
                        hintText: 'Phone'
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
