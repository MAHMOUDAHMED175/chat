import 'package:chat/layout/chat_state.dart';
import 'package:chat/models/create_users.dart';
import 'package:chat/models/message_chat.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../layout/chat_cubit.dart';

class ChatDetails extends StatelessWidget {
  CreateUserModel userDataModel;

  ChatDetails({
    required this.userDataModel,
  });

  var messageController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
      ChatCubit.get(context).getMessage(
        receiver: userDataModel.uid!,
      );
      return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo[500],
                elevation: 0.0,
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userDataModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: GradientText(
                        '${userDataModel.name}',
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width / 15.0,
                            fontWeight: FontWeight.bold),
                        colors: [Colors.white, Colors.red],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background.png',
                        ),
                        fit: BoxFit.cover)),
                child: ConditionalBuilder(
                  condition: ChatCubit
                      .get(context)
                      .messages
                      .length >= 0,
                  builder: (context) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {

                                  var message=ChatCubit.get(context).messages[index];

                                  if(ChatCubit.get(context).createUserModel!.uid == message.sender)
                                  {
                                    return
                                        Dismissible(
                                            key: Key(''),
                                            child: buildMyMessage(message,context)) ;
                                  }


                                  return buildMessage(message,context);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                itemCount: ChatCubit.get(context).messages.length,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 5),
                                      child: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          validator: (value){
                                            if (value!.isEmpty) {
                                              return '';
                                            }
                                          },
                                          controller: messageController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Type With Your Image...',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),


                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                     if (formKey.currentState!.validate()) {
                                       ChatCubit.get(context).sendMessage(
                                           receiver: userDataModel.uid!,
                                           text: messageController.text,
                                           dateTime: DateFormat.yMd().add_jm().add_Hms().format(DateTime.now())
                                       );
                                     }
                                      messageController.text='';
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius: BorderRadius.circular(
                                              5)),
                                      child: Icon(
                                        Icons.send,
                                        size: 40.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) =>
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.grey[800],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\u{1f601}تحقق من اتصالك بالانترنت \u{1f601}',
                                style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 60.0,
                              ),
                              Stack(children: [
                                CircleAvatar(
                                  radius: 170,
                                  backgroundColor: Colors.yellow,
                                  child: CircleAvatar(
                                    radius: 150,
                                    backgroundColor: Colors.redAccent,
                                    child: CircleAvatar(
                                      radius: 130,
                                      backgroundColor: Colors.orangeAccent,
                                      child: CircleAvatar(
                                        radius: 110,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 90,
                                          backgroundColor: Colors.blueAccent,
                                          child: CircleAvatar(
                                            radius: 70,
                                            backgroundColor: Colors.greenAccent,
                                            child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor: Colors.black,
                                                child: CupertinoActivityIndicator(
                                                  radius: 50.0,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                ),
              ));
        },
      );
    });
  }

  Widget buildMessage(MessageModel model, context) =>
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 60.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(
                  20.0,
                ),
                topStart: Radius.circular(
                  20.0,
                ),
                topEnd: Radius.circular(
                  20.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 8.0,
            ),
            child: Column(
              children: [
                Text(
                  ' ${model.text}',
                  style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 45,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Text(

                  ' ${model.dateTime}',
                  style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 45,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),

              ],
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model, context) =>
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 60.0, top: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(
                  30.0,
                ),
                topStart: Radius.circular(
                  30.0,
                ),
                topEnd: Radius.circular(
                  30.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 8.0,
            ),
            child: Column(
              children: [
                Text(
                  '${model.text}',
                  style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 45,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  '${model.dateTime}',
                  style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 45,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),


              ],
            ),
          ),
        ),
      );




























/*






                                   */

}
