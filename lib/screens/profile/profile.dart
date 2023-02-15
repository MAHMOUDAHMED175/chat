import 'package:chat/component/component.dart';
import 'package:chat/layout/chat_cubit.dart';
import 'package:chat/layout/chat_state.dart';
import 'package:chat/screens/chat_details/chat_details.dart';
import 'package:chat/screens/pageroute.dart';
import 'package:chat/screens/profile/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ChatCubit()..getUserData(),
      child: BlocConsumer<ChatCubit, ChatState>(
          builder: (context, state) {
            var cubitModel=ChatCubit.get(context).createUserModel;
            return Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile.png',
                  ),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/10,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:cubitModel?.image!=null? NetworkImage(
                              '${cubitModel?.image}'):NetworkImage(
                                'https://img.freepik.com/free-photo/3d-hands-from-mobile-phones-fists-bump_107791-17021.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        '${cubitModel?.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width/13,
                          color: Colors.white,),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(50.0, 100.0),
                            bottomRight: Radius.elliptical(50.0, 100.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '${ChatCubit.get(context).createUserModel?.bio}',
                            maxLines: 3,

                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height/40,
                              color: Colors.grey[300],

                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                        width: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                      ),
                      child: MaterialButton(
                          color: HexColor('#BEEBFF'),
                          onPressed: (){
                           Navigator.push(context, Rotation(page: ProfileDetails()));
                          }, child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Text('Update Profile'),
                          ),

                          SizedBox(width: 20.0,),
                          Icon(Icons.arrow_circle_right_outlined,size: 25,)

                        ],
                      )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
