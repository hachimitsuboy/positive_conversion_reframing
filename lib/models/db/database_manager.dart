import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:positive_conversion_reframing/data_class/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection("users")
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();

    if (query.docs.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoDbById(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();

    print("query: ${query.docs[0].data()}");
    final getUser = User.fromMap(query.docs[0].data());
    print("getUser: $getUser");
    return User.fromMap(query.docs[0].data());
  }
}
