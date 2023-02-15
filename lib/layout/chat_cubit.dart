import 'dart:io';

import 'package:chat/layout/chat_state.dart';
import 'package:chat/models/create_users.dart';
import 'package:chat/models/message_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../component/constant.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  CreateUserModel? createUserModel;
  bool? changeName = true;
  bool? changeBio = true;
  bool? changeEmail = true;
  bool? changePassword = true;
  bool? changePhone = true;

  void Name() {
    changeName = !changeName!;
    emit(changeProfileName());
  }

  void Bio() {
    changeBio = !changeBio!;
    emit(changeProfileName());
  }

  void Email() {
    changeEmail = !changeEmail!;
    emit(changeProfileName());
  }

  void Password() {
    changePassword = !changePassword!;
    emit(changeProfileName());
  }

  void Phone() {
    changePhone = !changePhone!;
    emit(changeProfileName());
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      // emit(SocialProfileImageSuccess());
    } else {
      print('No image selected ');
      //emit(SocialProfileImageError());
    }
  }

  Future<void> getUserData() async {
    emit(getDataLoad());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      print(
          'جااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااات'
          'التاتا اتاتاتاا تا ا ت ت ا');
      print(value.data());
      emit(gatDataSuccess());
      createUserModel = CreateUserModel.fromJson(value.data()!);
    }).catchError((error) {
      print(error.toString());
      emit(gatDataError());
    });
  }

  List<CreateUserModel> users = [];

  void listUsers() {
    emit(listUsersLoad());

    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != createUserModel!.uid) {
            users.add(CreateUserModel.fromJson(element.data()));
            emit(listUsersSuccess());
          }
        });
      }).catchError((error) {
        print(error.toString());
        emit(listUsersError());
      });
    }
  }

  void uploadProfileImage({
     String? name,
     String? phone,
     String? bio,
     String? password,
     String? email,
  }) {
    emit(uploadImageProfileLoad());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            password: password,
            email: email,
            image: value);
      }).catchError((error) {
        print(error.toString());

        emit(uploadImageProfileError());
      });
    }).catchError((error) {
      print(error.toString());

      emit(uploadImageProfileError());
    });
  }

  void updateUserData({
     String? name,
     String? phone,
     String? bio,
     String? password,
     String? email,
     String? image,
  }) {
    emit(updateDataLoad());

    CreateUserModel model = CreateUserModel(
      email: email,
      uid: uid,
      name: name,
      phone: phone,
      password: password,
      image: image,
      bio: bio,
      isEmailVerify: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(createUserModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(updateDataError());
    });
  }

  void sendMessage({
    String? receiver,
    String? dateTime,
    String? text,
    String? uid,
  }) {
    MessageModel model = MessageModel(
      text: text,
      sender: createUserModel!.uid!,
      receiver: receiver,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(createUserModel!.uid)
        .collection('chats')
        .doc(receiver)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(sendMessageSuccess());
    }).catchError((error) {
      emit(sendMessageError());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiver)
        .collection('chats')
        .doc(createUserModel!.uid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(sendMessageSuccess());
    }).catchError((error) {
      emit(sendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiver,
  }) {
    //هتصفر الداتا علشان الرسايل متتكررش تانى

    FirebaseFirestore.instance
        .collection('users')
        .doc(createUserModel!.uid) //mahmoud     //   ali
        .collection('chats')
        .doc(receiver) //ali        //mahmoud
        .collection('message')
    // .id
        .orderBy('dateTime')

        //دى يعنى stream او تدفق من الرسايل والبيانات ورى بعض وطابور من البيانات وعامله زى الطابور المفتوح
        .snapshots()
        //دى علشان يسمع لكل حاجه بتحصل كلمه كلمه
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(getMessageSuccess());
    });
  }
  //











}
