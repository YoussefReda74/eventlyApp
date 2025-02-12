class TaskModel {
  String id;
  String userId;
  String title;
  int date;
  String description;
  String category;
  bool isDone;


  TaskModel({
    this.id='',
    required this.title,
    required this.userId,
    required this.date,
    required this.description,
    required this.category,
     this.isDone=false,

  });
  TaskModel.fromJson(Map<String,dynamic>json)
      :this(
    id:json['id'],
    title:json['title'],
    userId:json['userId'],
    date:json['date'],
    description:json['description'],
    category:json['category'],
    isDone:json['isDone'],
  );

  Map<String,dynamic> toJson(){
    return
    {
      'id':id,
      'title':title,
      'userId':userId,
      'date':date,
      'description':description,
      'category':category,
      'isDone':isDone,
  };

}}
