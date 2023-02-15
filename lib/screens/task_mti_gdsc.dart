// const SizedBox(
// height: 30,
// ),
// defaultFormField(
// controller: forgetController,
// hintText: 'Email',
// labelText: 'Email',
// type: TextInputType.emailAddress,
// prefix: Icons.email_outlined,
// validate: (String? value) {
// if (value!.isEmpty) {
// return 'Email must not be empty && like mohamed@gmail.com';
// }

import 'package:chat/screens/login/cubit/cubit.dart';
import 'package:chat/screens/login/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                Container(
                  padding: const EdgeInsets.only(right: 35, top: 80),
                  child: const Text(
                    "Forget\nPassword",
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 35,
                        left: 35,
                        top: MediaQuery.of(context).size.height * 0.5),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        Text(
                          'Please enter your email address to Password recovery',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 35),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            hintText: 'Email',
                            labelText: 'Email',
                            type: TextInputType.text,
                            prefix: Icons.email_outlined,
                            submit: (s) {
                              if (formKey.currentState!.validate()) {}
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email not empty &&mohamed@gmail.com';
                              }
                              return null;
                            },
                        ),

                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.4),
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                  width: 3

                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 3
                              ),
                            ),


                          ),
                          child: InkWell(
                            onTap: (){

                              if (formKey.currentState!.validate()) {
                                // navigateAndFinish(context, const Chat());
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[ Text(
                                'SEND',
                                style: TextStyle(
                                  color: Colors.blue.withOpacity(0.8),
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Icon(Icons.send,size: 50.0,color: Colors.lightBlueAccent,),
                              ]
                            ),
                          ),
                        ),

                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'I don\'t have any \naccount  😔 =>',
                        //         style: TextStyle(
                        //             fontSize:
                        //             MediaQuery
                        //                 .of(context)
                        //                 .size
                        //                 .width / 23,
                        //             color: Colors.grey,
                        //             fontWeight: FontWeight.bold
                        //         ),
                        //       ),
                        //       TextButton(
                        //         style: TextButton.styleFrom(
                        //           backgroundColor: Colors.grey[200],
                        //         ),
                        //
                        //         onPressed: () {
                        //           navigateTo(context, const MyRegister());
                        //         },
                        //         child: Text(
                        //           'Sign Up',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize:
                        //             MediaQuery
                        //                 .of(context)
                        //                 .size
                        //                 .width / 18,
                        //             color: Colors.blue,
                        //           ),
                        //         ),
                        //       ),
                        //     ]),
                      ]),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
