import 'package:google_sign_in/google_sign_in.dart';
import 'package:positive_conversion_reframing/data_class/user.dart';
import 'package:positive_conversion_reframing/models/db/database_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserRepository {
  final DatabaseManager databaseManager;

  UserRepository({required this.databaseManager});

  static User? currentUser;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool> isSignIn() async {
    //サインインしている場合は、現在のUserを返す→現在のUserって何？
    final firebaseUser = _auth.currentUser;
    //TODO FirebaseAuth.instanceのcurrentUserには何が入っているのか確認する
    print("firebaseUser: $firebaseUser / isSignIn");
    if (firebaseUser != null) {
      print("初回ログイン時 / isSignIn");
      currentUser = await databaseManager.getUserInfoDbById(firebaseUser.uid);
      print("currentUser: $currentUser / isSignIn");
      return true;
    }
    print("CurrentUserが存在しないため、ログイン画面へ遷移します / isSignIn");
    return false;
  }

  Future<bool> signIn() async {
    try {
      //グーグルログインのリクエストを行い、認証情報（Authentication）を取得する
      GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();
      if (_googleUser == null) return false;
      GoogleSignInAuthentication? googleAuth = await _googleUser.authentication;

      //取得した認証情報からFirebase認証に必要な信用状(Credential)を取得
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //取得した信用状(Credential)を元にFirebase認証を実行
      final firebaseUser =
          (await auth.FirebaseAuth.instance.signInWithCredential(credential))
              .user;
      print("firebaseUser: $firebaseUser / signIn");
      //hachimitsuboy5564@gmail.comでサインインした場合
      //firebaseUser: User(displayName: はちくん,
      // email: hachimitsuboy5564@gmail.com, emailVerified: true,
      // isAnonymous: false, metadata: UserMetadata(creationTime: 2021-11-03 09:16:07.794,
      // lastSignInTime: 2021-11-03 09:16:07.794), phoneNumber: null,
      // photoURL: https://lh3.googleusercontent.com/a-/AOh14Gj4aObabYik4xMNoGdYkK7lWr9WwrpCBdVk_KP36g=s96-c,
      // providerData, [UserInfo(displayName: はちくん, email: hachimitsuboy5564@gmail.com,
      // phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a-/AOh14Gj4aObabYik4xMNoGdYkK7lWr9WwrpCBdVk_KP36g=s96-c,
      // providerId: google.com, uid: 108909055116155708900)], refreshToken: ,
      // tenantId: null, uid: 3A9HKJCNlcZHuZsnUlbtMK7qipv2) / signIn


      if (firebaseUser == null) return false;

      //DBに登録の前にユーザがいるか確認
      final isUserExistedInDb =
          await databaseManager.searchUserInDb(firebaseUser);
      print("isUserExistedInDb: $isUserExistedInDb / signIn");
      print("!isUserExistedInDb: ${!isUserExistedInDb} / signIn");

      if (!isUserExistedInDb) {
        //DBに登録
        await databaseManager.insertUser(_convertToUserDataClass(firebaseUser));
      }
      currentUser = await databaseManager.getUserInfoDbById(firebaseUser.uid);
      return true;
    } catch (error) {
      print("sign in error : $error");
      return false;
    }
  }

  _convertToUserDataClass(auth.User firebaseUser) {
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? "",
      inputWord: "",
      selectedWord: "",
      isMatched: false,
    );
  }
}
