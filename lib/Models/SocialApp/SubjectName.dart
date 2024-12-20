class SubjectName {
  String? name ;

  SubjectName.FromJson(Map<String,dynamic> json){
    name = json['name'];
  }

  SubjectName({
    this.name,
  });

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
    };
  }
}