class MyUser {
  final String userId;
  final String email;
  MyUser({this.email, this.userId});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'email': email};
  }

  MyUser.fromFirestore(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        email = firestore['email'];
}
