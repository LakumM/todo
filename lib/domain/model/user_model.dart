class UserModel {
  String name;
  String email;
  String mobile;
  String city;

  UserModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.city});

  factory UserModel.fromDoc(Map<String, dynamic> doc) {
    return UserModel(
        name: doc['name'],
        email: doc['email'],
        mobile: doc['mobile'],
        city: doc['city']);
  }

  Map<String, dynamic> todoc() {
    return {'name': name, 'email': email, 'mobile': mobile, 'city': city};
  }
}
