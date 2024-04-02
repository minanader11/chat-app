class MyUser {
  String id;
  String userName;
  String email;

  MyUser({
    required this.email, required this.userName, required this.id
  });

  Map <String, dynamic> toFireStore(MyUser user) {
    return {
      'id': id,
      'email': email,
      'username': userName,
    };
  }

  MyUser.fromFireStore(Map<String, dynamic> user)
      : this(id: user['id'], email: user['email'], userName: user['username']);
}