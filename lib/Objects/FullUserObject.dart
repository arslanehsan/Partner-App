import 'package:image_picker/image_picker.dart';

class FullUserObject {
  String? uid, userName, phoneNumber;

  String? imageLink, firstName, dob;
  String? imageName;
  XFile? imageFile;

  FullUserObject({
    this.uid,
    this.userName,
    this.phoneNumber,
    this.firstName,
    this.dob,
    this.imageLink,
    this.imageName,
    this.imageFile,
  });

  factory FullUserObject.fromJson(Map<dynamic, dynamic> json) {
    print('user DATA GETTING $json');
    return FullUserObject(
      uid: json['uid'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'] ?? '',
      imageLink: json['imageLink'] ?? '',
      dob: json['dob'] ?? '',
      firstName: json['firstName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['phoneNumber'] = phoneNumber;
    data['imageLink'] = imageLink;
    data['dob'] = dob;
    return data;
  }
}
