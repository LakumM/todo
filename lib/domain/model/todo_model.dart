class TodoModel {
  String title;
  String desc;
  bool? isCompleted;
  String? creatdAt;
  String? isCompletedAt;

  TodoModel(
      {required this.desc,
      required this.title,
      required this.isCompleted,
      required this.creatdAt,
      required this.isCompletedAt});

  factory TodoModel.formDoc(Map<String, dynamic> doc) {
    return TodoModel(
        desc: doc['desc'],
        title: doc['title'],
        isCompleted: doc['isCompleted'],
        isCompletedAt: doc['isCompletedAt'],
        creatdAt: doc['createdAt']);
  }

  Map<String, dynamic> toDoc() {
    return {
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'createdAt': creatdAt,
      'isCompletedAt': isCompletedAt
    };
  }
}
