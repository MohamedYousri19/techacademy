class ResultModel {
  String? image ;
  int? result ;
  String? name ;
  String? myName ;
  String? email ;
  String? time ;
  String? examName ;
  String? length ;

  ResultModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    result = json['result'];
    name = json['name'];
    myName = json['myName'];
    email = json['email'];
    time = json['time'];
    examName = json['examName'];
    length = json['length'];
  }

  ResultModel({
    required this.result,
    required this.image,
    required this.name,
    required this.myName,
    required this.email,
    required this.time,
    required this.examName,
    required this.length,
  });

  Map<String,dynamic> toMap(){
    return{
      'result' : result,
      'myName' : myName,
      'email' : email,
      'image' : image,
      'name' : name,
      'time' : time,
      'examName' : examName,
      'length' : length,
    };
  }
}