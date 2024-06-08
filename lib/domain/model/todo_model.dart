class TodoModel {
  String title;
  String desc;
  bool? isCompleted;
  String? creatdAt;

  TodoModel(
      {required this.desc,
      required this.title,
      required this.isCompleted,
      required this.creatdAt});

  factory TodoModel.formDoc(Map<String, dynamic> doc) {
    return TodoModel(
        desc: doc['desc'],
        title: doc['title'],
        isCompleted: doc['isCompleted'],
        creatdAt: doc['createdAt']);
  }

  Map<String, dynamic> toDoc() {
    return {
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'createdAt': creatdAt
    };
  }
}
