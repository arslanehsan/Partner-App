import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:partner/Objects/Evaluation.dart';
import 'package:partner/Objects/FullUserObject.dart';

import '../Objects/PaypalKeyObject.dart';
import '../Objects/UserObject.dart';

class FirebaseDatabaseHelper {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<UserObject?> getUsers() async {
    UserObject? candidateObject;

    final topUserPostsRef = FirebaseDatabase.instance
        .ref('Users')
        .child(FirebaseAuth.instance.currentUser!.uid);
    try {
      await topUserPostsRef.once().then((snapshot) {
        Map<dynamic, dynamic>? value =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;
        if (value != null) {
          candidateObject = UserObject.fromJson(value);
        }
      });

      return candidateObject;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserObject?> getUsersByPhoneNumber(
      {required String phoneNumber}) async {
    UserObject? candidateObject;

    final topUserPostsRef = FirebaseDatabase.instance
        .ref('Users')
        .orderByChild('phoneNumber')
        .equalTo(
          phoneNumber,
        );
    // try {
    await topUserPostsRef.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        value.forEach((key, userValue) {
          candidateObject = UserObject.fromJson(userValue);
        });
      } else {
        return null;
      }
    });
    return candidateObject;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  Future<FullUserObject?> getFullUsers() async {
    FullUserObject? candidateObject;

    final topUserPostsRef = FirebaseDatabase.instance
        .ref('FullUserProfiles')
        .child(FirebaseAuth.instance.currentUser!.uid);
    try {
      await topUserPostsRef.once().then((snapshot) {
        Map<dynamic, dynamic>? value =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;
        if (value != null) {
          candidateObject = FullUserObject.fromJson(value);
        }
      });

      return candidateObject;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PaypalKeyObject?> getPaypalKeys() async {
    PaypalKeyObject? candidateObject;

    final topUserPostsRef = FirebaseDatabase.instance.ref('AppSettings');
    try {
      await topUserPostsRef.once().then((snapshot) {
        Map<String, dynamic>? value =
            snapshot.snapshot.value as Map<String, dynamic>?;
        if (value != null) {
          candidateObject = PaypalKeyObject.fromJson(value);
        }
      });

      return candidateObject;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Evaluation?> getUserEvaluation({required String id}) async {
    Evaluation? evaluationObject;

    final topUserPostsRef =
        FirebaseDatabase.instance.ref('Evaluations').orderByChild('id').equalTo(
              id,
            );
    try {
    await topUserPostsRef.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        value.forEach((key, userValue) {
          evaluationObject = Evaluation.fromJson(userValue);
        });
      } else {
        return null;
      }
    });
    return evaluationObject;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
