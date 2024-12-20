class UserDataModel {
 String? email ;
 String? image ;
 String? uId ;
 String? username ;
 String? bio ;
 String? cover ;
 String? phone ;

 UserDataModel.FromJson(Map<String,dynamic> json){
  email = json['email'];
  image = json['image'];
  uId = json['uId'];
  username = json['username'];
  bio = json['bio'];
  cover = json['cover'];
  phone = json['phone'];
 }

 UserDataModel({
  this.email,
  this.image,
  this.uId,
  this.username,
  this.bio,
  this.cover,
  this.phone,
 });

 Map<String,dynamic> toMap(){
  return{
   'email' : email,
   'image' : image,
   'uId' : uId,
   'username' : username,
   'bio' : bio,
   'cover' : cover,
   'phone' : phone,
  };
 }
}