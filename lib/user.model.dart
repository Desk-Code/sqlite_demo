class User {
  int? id;
  String userName;

  User({this.id, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        userName: json['userName'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['userName'] = userName;
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
