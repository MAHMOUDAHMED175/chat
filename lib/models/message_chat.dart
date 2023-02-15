

class MessageModel{
  late String? sender;
  late String? receiver;
  late String? dateTime;
  late String? text;
  MessageModel({
    required this.sender,
    required this.receiver,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String,dynamic>json){
    dateTime=json['dateTime'];
    sender=json['sender'];
    receiver=json['receiver'];
    text=json['text'];
  }

  /* علشان احول الداتا اللى جايالى الى Map*/
  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'sender':sender,
      'dateTime':dateTime,
      'receiver':receiver,
    };

  }
}