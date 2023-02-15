import 'package:bloc/bloc.dart';
import 'package:chat/component/Opserver.dart';
import 'package:chat/component/cache_helper.dart';
import 'package:chat/component/constant.dart';
import 'package:chat/layout/Home.dart';
import 'package:chat/layout/chat_cubit.dart';
import 'package:chat/screens/login/login.dart';
import 'package:chat/screens/on_bording/on_bording.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/chat_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.shared();

  uid = CacheHelper.getShared(key: 'uid');

  print('ddddddddddddd m m mm m m m m m m m m  m m m m m m   mmm m m m m mm m m  m m m m m m m m m m m m mm m mm m m m m m dd');
  print(uid.toString());
   onBord = CacheHelper.getShared(key: 'onBoarding');
   print(onBord);
  Widget widget;
  if (onBord != null) {
    if (uid != null) {
      widget = Chat();
    } else {
      widget = MyLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    screen: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget screen;

  MyApp({
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ChatCubit()..getUserData()..listUsers()),
      ],
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'short',
              primarySwatch: Colors.teal,
            ),
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection: TextDirection.rtl,
                child: screen),
          );
        },
      ),
    );
  }
}
