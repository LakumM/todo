class TodoModel {
  String title;
  String desc;

  TodoModel({required this.desc, required this.title});

  factory TodoModel.formDoc(Map<String, dynamic> doc) {
    return TodoModel(desc: doc['desc'], title: doc['title']);
  }

  Map<dynamic, dynamic> toDoc() {
    return {'title': title, 'desc': desc};
  }
}
