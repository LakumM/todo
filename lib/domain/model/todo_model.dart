class TodoModel {
  String title;
  String desc;
  bool? isCompleted;

  TodoModel(
      {required this.desc, required this.title, required this.isCompleted});

  factory TodoModel.formDoc(Map<String, dynamic> doc) {
    return TodoModel(
        desc: doc['desc'],
        title: doc['title'],
        isCompleted: doc['isCompleted']);
  }

  Map<String, dynamic> toDoc() {
    return {'title': title, 'desc': desc, 'isCompleted': isCompleted};
  }
}
