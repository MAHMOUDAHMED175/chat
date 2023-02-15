



class CreateUserModel{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  bool? isEmailVerify;

  CreateUserModel({
    this.email,
    this.uid,
    this.name,
    this.image,
    this.bio,
    this.phone,
    this.password,
    this.isEmailVerify,
  });

  CreateUserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    uid=json['uid'];
    name=json['name'];
    phone=json['phone'];
    image=json['image'];
    bio=json['bio'];
    password=json['password'];
    isEmailVerify=json['isEmailVerify'];
  }

  /* علشان احول الداتا اللى جايالى الى Map*/
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'password':password,
      'email':email,
      'uid':uid,
      'bio':bio,
      'image':image,
      'isEmailVerify':isEmailVerify,
    };

  }
}
