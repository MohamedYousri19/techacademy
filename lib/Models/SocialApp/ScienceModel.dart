class ScienceDataModel {
  String? image ;
  String? data ;
  String? lesson ;

  ScienceDataModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    data = json['data'];
    lesson = json['lesson'];
  }

  ScienceDataModel({
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