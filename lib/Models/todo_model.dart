class TodoModel {
  String? title;
  String? description;
  bool? isCompleted;

  TodoModel({this.title, this.description, this.isCompleted});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}
