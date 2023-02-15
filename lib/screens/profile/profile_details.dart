import 'package:chat/component/component.dart';
import 'package:chat/layout/Home.dart';
import 'package:chat/layout/chat_cubit.dart';
import 'package:chat/layout/chat_state.dart';
import 'package:chat/screens/pageroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileDetails extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, index) {},
      builder: (context, index) {
        return Scaffold(
          body: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.cyanAccent,
                        Colors.blue,
                        Colors.black,
                        Colors.grey.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0, right: 30.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {

                              ChatCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                                password: passwordController.text,
                                email: emailController.text,
                              );
                              Navigator.pushAndRemoveUntil(context, Scale(page: Chat()),(route)=>false);
                            }
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 16,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 30,
                  left: MediaQuery.of(context).size.width / -30,
                  top: MediaQuery.of(context).size.height / 4.4,
                  bottom: MediaQuery.of(context).size.height / 700,
                  //bottom:0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    //MediaQuery.of(context).size.height/12,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      border: Border.all(
                        width: 10,
                        color: HexColor('#85C5E0'),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      duration: Duration(seconds: 3),
                                      firstChild: Text(
                                        '${ChatCubit.get(context).createUserModel?.name}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      secondChild: defaultFormField(
                                          controller: nameController,
                                          type: TextInputType.text,
                                          validate: (value){
                                            if (value!.isEmpty) {
                                              return 'Value Is Empty';
                                            }
                                            return null;
                                          },
                                          hintText: 'Your Name',
                                          prefix: Icons.person),
                                      firstCurve: Curves.linear,
                                      secondCurve: Curves.linear,
                                      crossFadeState: cubit.changeName ?? true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.compare_arrows,
                                      size: 50.0,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubit.Name();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      duration: Duration(seconds: 3),
                                      firstChild: Text(
                                        '${ChatCubit.get(context).createUserModel?.bio}',
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      secondChild: defaultFormField(
                                          controller: bioController,
                                          type: TextInputType.text,
                                          hintText: 'Your Bio',validate: (value){
                                        if (value!.isEmpty) {
                                          return 'Value Is Empty';
                                        }
                                        return null;
                                      },
                                          prefix: Icons.edit_outlined),
                                      firstCurve: Curves.linear,
                                      secondCurve: Curves.linear,
                                      crossFadeState: cubit.changeBio ?? true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.compare_arrows,
                                      size: 50.0,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubit.Bio();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      duration: Duration(seconds: 3),
                                      firstChild: Text(
                                        '${ChatCubit.get(context).createUserModel?.email}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      secondChild: defaultFormField(
                                          controller: emailController,
                                          type: TextInputType.emailAddress,validate: (value){
                                        if (value!.isEmpty) {
                                          return 'Value Is Empty';
                                        }
                                        return null;
                                      },
                                          hintText: 'Your Email',
                                          prefix: Icons.email_outlined),
                                      firstCurve: Curves.linear,
                                      secondCurve: Curves.linear,
                                      crossFadeState: cubit.changeEmail ?? true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.compare_arrows,
                                      size: 50.0,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubit.Email();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      duration: Duration(seconds: 3),
                                      firstChild: Text(
                                        '${ChatCubit.get(context).createUserModel?.phone}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      secondChild: defaultFormField(
                                          controller: phoneController,
                                          type: TextInputType.phone,validate: (value){
                                        if (value!.isEmpty) {
                                          return 'Value Is Empty';
                                        }
                                        return null;
                                      },
                                          hintText: 'Your Phone',
                                          prefix: Icons.phone),
                                      firstCurve: Curves.linear,
                                      secondCurve: Curves.linear,
                                      crossFadeState: cubit.changePhone ?? true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.compare_arrows,
                                      size: 50.0,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubit.Phone();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      duration: Duration(seconds: 3),
                                      firstChild: Text(
                                        '${ChatCubit.get(context).createUserModel?.password}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      secondChild: defaultFormField(
                                          controller: passwordController,
                                          type: TextInputType.text,
                                          hintText: 'Your Password',validate: (value){
                                        if (value!.isEmpty) {
                                          return 'Value Is Empty';
                                        }
                                        return null;
                                      },
                                          prefix: Icons.password),
                                      firstCurve: Curves.linear,
                                      secondCurve: Curves.linear,
                                      crossFadeState: cubit.changePassword ?? true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.compare_arrows,
                                      size: 50.0,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubit.Password();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text('ملحوظه::عند تغيير احد البيانات يجب تغيير كل البيانات ثانيا  \ \u{1f602} \u{1f602}\ \u{1f602}\u{1f602} \u{1f602} \u{1f602} ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: MediaQuery.of(context).size.width/20,
                                color: Colors.red
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 2.8,
                  left: MediaQuery.of(context).size.width / -20,
                  top: MediaQuery.of(context).size.height / 20,
                  child: Container(
                    width: MediaQuery.of(context).size.height / 3,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 10,
                        color: HexColor('#85C5E0'),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: ChatCubit.get(context).profileImage !=
                              null
                          ? NetworkImage(
                              '${ChatCubit.get(context).createUserModel?.image}')
                          : NetworkImage(
                              'https://img.freepik.com/free-photo/3d-hands-from-mobile-phones-fists-bump_107791-17021.jpg'),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue,
                                Colors.red,
                              ],
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {
                                ChatCubit.get(context).getProfileImage();
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 30.0,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
