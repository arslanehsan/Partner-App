import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
import 'package:partner/Objects/FullUserObject.dart';
import 'package:partner/Objects/UserObject.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Firebase/FirebaseStorageService.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';
import '../Utils/Toast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();

  bool buttonLoading = false;

  XFile? selectedFile;

  UserObject? userData;
  FullUserObject? fullUserData;

  Future<void> getUserData() async {
    await FirebaseDatabaseHelper().getUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = user;
        });
        _userNameController.text = user.userName;
        _phoneNumberController.text = user.phoneNumber;
      }
    });
  }

  Future<void> getFullUserData() async {
    await FirebaseDatabaseHelper().getFullUsers().then((user) {
      if (user != null) {
        setState(() {
          fullUserData = user;
        });
        _userNameController.text = user.userName!;
        _firstNameController.text = user.firstName!;
        _phoneNumberController.text = user.phoneNumber!;
        _dobController.text = user.dob!;
      } else {
        getUserData();
      }
    });
  }

  @override
  void initState() {
    getFullUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: _screenHeight,
          width: _screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: const BoxDecoration(
            color: AppThemeColor.backGroundColor,
          ),
          child: Form(
            key: _userFormKey,
            child: Column(
              children: [
                AppConstents().topBarViewWithBack(context: context),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // pickFile();
                            ImagePicker.platform
                                .getImage(source: ImageSource.gallery)
                                .then((mediaInfo) {
                              setState(() {
                                selectedFile = mediaInfo;
                              });
                            });
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: _screenWidth / 3.5,
                                height: _screenWidth / 3.5,
                                decoration: BoxDecoration(
                                  // color: Colors.purple,
                                  borderRadius:
                                      BorderRadius.circular(_screenWidth / 3.5),
                                  image: selectedFile != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(selectedFile!.path),
                                          ),
                                        )
                                      : fullUserData != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                fullUserData!.imageLink!,
                                              ),
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                'images/profile.png',
                                              ),
                                            ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppThemeColor.pureBlackColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: AppThemeColor.pureWhiteColor,
                                  size: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _userNameController,
                                      decoration: const InputDecoration(
                                          hintText: 'username'),
                                      validator: (value) => value!.length > 1
                                          ? null
                                          : 'User Name!',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.label,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _firstNameController,
                                      decoration: const InputDecoration(
                                          hintText: 'First name'),
                                      validator: (value) => value!.length > 1
                                          ? null
                                          : 'First Name!',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _dobController,
                                      validator: (value) => value!.length > 1
                                          ? null
                                          : 'Date of birth26 Dece',
                                      decoration: const InputDecoration(
                                          hintText: 'Date of birth'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_android,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppThemeColor.pureWhiteColor,
                                      ),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        validator: (value) => value!.length > 1
                                            ? null
                                            : 'Phone number!',
                                        decoration: const InputDecoration(
                                            hintText: '413525565'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () => fullUserData != null
                                    ? updateFullCustomer()
                                    : addNewFullCustomer(),
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppThemeColor.darkBlueColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                      color: AppThemeColor.pureWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buttonLoading
            ? AppConstents().loaderView(
                message: 'Updating Profile!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : const SizedBox()
      ],
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }

  // when user edit first time it will call
  Future<void> addNewFullCustomer() async {
    try {
      if (!buttonLoading) {
        if (_userFormKey.currentState!.validate()) {
          if (selectedFile != null) {
            _userFormKey.currentState!.save();
            setState(() {
              buttonLoading = true;
            });
            FullUserObject userObject = FullUserObject(
              firstName: _firstNameController.text,
              userName: _userNameController.text,
              dob: _dobController.text,
              phoneNumber: _phoneNumberController.text,
            );
            if (selectedFile != null) {
              userObject.imageFile = selectedFile;
            }

            addUserToFirebaseToFirebase(user: userObject);
          } else {
            ShowToast().showNormalToast(msg: 'Please Select Profile Image!');
          }
        }
      } else {
        ShowToast().showNormalToast(msg: 'Please Wait!');
      }
    } on PlatformException catch (e) {
      ShowToast().showNormalToast(msg: e.message!);
    } catch (e) {
      ShowToast().showNormalToast(
          msg:
              'The connection failed because the device is not connected to the internet');
    } finally {
      // setState(() {
      //   buttonLoading = false;
      // });
    }
  }

// when user edit first time it will call
  Future<FullUserObject?> addUserToFirebaseToFirebase(
      {required FullUserObject user}) async {
    DatabaseReference dbf = FirebaseDatabase.instance.ref();
    FullUserObject updatedUser = user;

    try {
      String userId = userData!.uid;
      String userImageName = '$userId.${user.imageFile!.name.split('.').last}';

      Reference ref = FirebaseStorage.instance
          .ref()
          .child('ProfileImages')
          .child(userImageName);
      await FirebaseStorageService()
          .uploadImage(file: user.imageFile!, ref: ref)
          .then((uploadTask) async {
        if (uploadTask != null) {
          await uploadTask.whenComplete(() async {
            await ref.getDownloadURL().then((imageLink) async {
              print('upload done $imageLink');
              updatedUser.uid = userId;
              updatedUser.imageLink = imageLink;
              updatedUser.imageName = userImageName;
              print(uploadTask.snapshot.bytesTransferred);
              await dbf
                  .child('FullUserProfiles')
                  .child(userId)
                  .set(
                    updatedUser.toJson(),
                  )
                  .then((value) {
                setState(() {
                  buttonLoading = false;
                });

                Navigator.pop(context);
              });
            });
          });
        } else {
          return null;
        }
      });
      return updatedUser;
    } catch (e) {
      setState(() {
        buttonLoading = false;
      });
      print("Add New Full User Error");
      print(e);
      return null;
    } finally {
      setState(() {
        buttonLoading = false;
      });
    }
  }

  // when user edit second or more we just update their existing profile
  Future<void> updateFullCustomer() async {
    try {
      if (!buttonLoading) {
        if (_userFormKey.currentState!.validate()) {
          _userFormKey.currentState!.save();
          setState(() {
            buttonLoading = true;
            print('loader $buttonLoading');
          });
          FullUserObject userObject = FullUserObject(
            uid: fullUserData!.uid!,
            firstName: _firstNameController.text,
            userName: _userNameController.text,
            dob: _dobController.text,
            phoneNumber: _phoneNumberController.text,
          );
          if (selectedFile != null) {
            userObject.imageFile = selectedFile;
          } else {
            userObject.imageLink = fullUserData!.imageLink;
          }

          updateUserToFirebaseToFirebase(user: userObject);
        }
      } else {
        ShowToast().showNormalToast(msg: 'Please Wait!');
      }
    } on PlatformException catch (e) {
      ShowToast().showNormalToast(msg: e.message!);
    } catch (e) {
      ShowToast().showNormalToast(
          msg:
              'The connection failed because the device is not connected to the internet');
    } finally {
      // setState(() {
      //   buttonLoading = false;
      // });
    }
  }

// when user edit second or more we just update their existing profile
  Future<FullUserObject?> updateUserToFirebaseToFirebase(
      {required FullUserObject user}) async {
    DatabaseReference dbf = FirebaseDatabase.instance.ref();
    FullUserObject updatedUser = user;

    try {
      String userId = user.uid!;

      if (user.imageFile != null) {
        String userImageName =
            '$userId.${user.imageFile!.name.split('.').last}';
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('ProfileImages')
            .child(userImageName);
        await FirebaseStorageService()
            .uploadImage(file: user.imageFile!, ref: ref)
            .then((uploadTask) async {
          if (uploadTask != null) {
            await uploadTask.whenComplete(() async {
              await ref.getDownloadURL().then((imageLink) async {
                print('upload done $imageLink');
                updatedUser.uid = userId;
                updatedUser.imageLink = imageLink;
                updatedUser.imageName = userImageName;
                print(uploadTask.snapshot.bytesTransferred);
                await dbf
                    .child('FullUserProfiles')
                    .child(userId)
                    .update(
                      updatedUser.toJson(),
                    )
                    .then((value) {
                  setState(() {
                    buttonLoading = false;
                  });

                  Navigator.pop(context);
                });
              });
            });
          } else {
            return null;
          }
        });
      } else {
        await dbf
            .child('FullUserProfiles')
            .child(userId)
            .update(
              updatedUser.toJson(),
            )
            .then((value) {
          setState(() {
            buttonLoading = false;
          });

          Navigator.pop(context);
        });
      }

      return updatedUser;
    } catch (e) {
      setState(() {
        buttonLoading = false;
      });

      print("Update Full User Error");
      print(e);
      return null;
    } finally {
      setState(() {
        buttonLoading = false;
      });
    }
  }
}
