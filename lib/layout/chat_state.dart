


abstract class ChatState {}

class ChatInitial extends ChatState {}


// profile details
class changeProfileName extends ChatState {}
class changeProfileBio extends ChatState {}
class changeProfileEmail extends ChatState {}
class changeProfilePassword extends ChatState {}
class changeProfilePhone extends ChatState {}



class uploadImageProfileLoad extends ChatState {}
class uploadImageProfileError extends ChatState {}



class chatImageLoad extends ChatState {}
class chatImageError extends ChatState {}



class updateDataLoad extends ChatState {}
class updateDataError extends ChatState {}




class getDataLoad extends ChatState {}
class gatDataSuccess extends ChatState {}
class gatDataError extends ChatState {}




class listUsersLoad extends ChatState {}
class listUsersSuccess extends ChatState {}
class listUsersError extends ChatState {}







class load extends ChatState {}
class sendMessageSuccess extends ChatState {}
class getMessageSuccess extends ChatState {}
class sendMessageError extends ChatState {}




class removeMessageSuccess extends ChatState {}
class removeMessageError extends ChatState {}





















