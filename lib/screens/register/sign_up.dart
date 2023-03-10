import 'package:chat/component/component.dart';
import 'package:chat/layout/Home.dart';
import 'package:chat/screens/pageroute.dart';
import 'package:chat/screens/register/cubit/cubit.dart';
import 'package:chat/screens/register/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, MyLogin());
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/register.png'),
                  fit: BoxFit.cover),),
            child: Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent,
                elevation: 0,),
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                Container(
                  padding: const EdgeInsets.only(left: 35, top: 40),
                  child: const Text(
                    "Create\nAccount",
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 35,
                        left: 35,
                        top: MediaQuery.of(context).size.height * 0.27),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        defaultFormField(
                            controller: nameController,
                            hintText: 'Name',
                            labelText: 'Name',
                            type: TextInputType.text,
                            prefix: Icons.person,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'phone must not be empty';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          hintText: 'Email',
                          labelText: 'Email',
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,

                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'email must not be empty';
                            }

                            return null;
                          },),
                        const SizedBox(
                          height: 30,
                        ),defaultFormField(
                          controller: phoneController,
                          hintText: 'Phone',
                          labelText: 'Phone',
                          type: TextInputType.phone,
                          prefix: Icons.phone,

                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'phone must not be empty';
                            }

                            return null;
                          },),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            hintText: 'Password',
                            labelText: 'Password',
                            type: TextInputType.visiblePassword,
                            prefix: Icons.password,
                            submit: (s){
                              if (formKey.currentState!.validate()) {
                                
                              }  
                            },
                            validate: (String? value)
                            {if(value!.isEmpty)
                              {return 'phone must not be empty';}
                              return null;},
                            isPassword:
                                ChatRegisterCubit.get(context).isPassword,
                            suffixIcon:
                                ChatRegisterCubit.get(context).sufixIcon,
                            suffixPressd: () {
                              ChatRegisterCubit.get(context)
                                  .changePasswordVisibility();}),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ChatRegisterCubit.get(context)
                                            .userRegister(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        Navigator.push(context, Fadetion(page: MyLogin()));
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ]),
                        const SizedBox(
                          height: 0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                   Navigator.push(context, Rotation(page: MyLogin()));
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Spacer(),
                            ]),
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
