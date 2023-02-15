import 'package:chat/component/component.dart';
import 'package:chat/layout/chat_cubit.dart';
import 'package:chat/layout/chat_state.dart';
import 'package:chat/models/create_users.dart';
import 'package:chat/screens/pageroute.dart';
import 'package:chat/screens/profile/profile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../models/message_chat.dart';
import '../screens/chart.dart';
import '../screens/chat_details/chat_details.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatCubit()
        ..getUserData()
        ..listUsers(),
      child:Builder(
        builder: (BuildContext context) {


      return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var users = ChatCubit.get(context).users;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[900],
              elevation: 0.0,
              titleSpacing: 30.0,
              title: GradientText(
                'Users',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15.0,
                ),
                colors: [Colors.white, Colors.lightBlueAccent],
              ),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, Alignmentaion(page: MyHomePage()));
                },
                    icon: Icon(Icons.rotate_90_degrees_cw_outlined)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, Fadetion(page: Profile()));
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.lightBlueAccent,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: users.length > 0,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/r.png'),
                      fit: BoxFit.cover),
                ),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    return itemChatBuilder(users[index], context);
                  },
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: users.length,
                ),
              ),
              fallback: (context) => Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[800],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\u{1f601} تحقق من اتصالك بالانترنت  \u{1f601}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height / 36),
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
          );
        },
      );
        })
    );
  }

  Widget itemChatBuilder(CreateUserModel users, context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, Alignmentaion(page: ChatDetails(
          userDataModel: users,
        )));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: users.image != null
                  ? NetworkImage('${users.image}')
                  : NetworkImage(
                      'https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg'),
            ),
            SizedBox(
              width: 18.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " ${users.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'short',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "I Will Enjoy Talking With You",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.4, fontSize: MediaQuery.of(context).size.height/50, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
