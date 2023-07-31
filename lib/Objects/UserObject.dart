class UserObject {
  String uid, userName, password, phoneNumber;

  UserObject({
    required this.uid,
    required this.userName,
    required this.password,
    required this.phoneNumber,
  });

  factory UserObject.fromJson(Map<dynamic, dynamic> json) {
    print('user DATA GETTING $json');
    // print('user DATA GETTING ${json['uid']}');
    return UserObject(
      uid: json['uid'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['userName'] = userName;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
