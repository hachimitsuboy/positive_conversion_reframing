import 'package:positive_conversion_reframing/models/db/database_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserRepository {
  final DatabaseManager databaseManager;

  UserRepository({required this.databaseManager});

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool> isSignIn() async {
    //サインインしている場合は、現在のUserを返す→現在のUserって何？
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      //TODO FirebaseAuth.instanceのcurrentUserには何が入っているのか確認する
      print("firebaseUser: $firebaseUser");
      return true;
    }
    print("CurrentUserが存在しないため、ログイン画面へ遷移します");
    return false;
  }
}
