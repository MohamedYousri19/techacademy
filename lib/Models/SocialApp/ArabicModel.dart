class ArabicDataModel {
  String? image ;
  String? data ;
  String? lesson ;

  ArabicDataModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    data = json['data'];
    lesson = json['lesson'];
  }

  ArabicDataModel({
    this.lesson,
    this.image,
    this.data,
  });

  Map<String,dynamic> toMap(){
    return{
      'lesson' : lesson,
      'image' : image,
      'data' : data,
    };
  }
}