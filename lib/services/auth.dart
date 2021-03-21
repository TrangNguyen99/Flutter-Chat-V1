import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<String> signInWithEmailAndPassword(
    {String email, String password}) async {
  try {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return null;
  } catch (e) {
    print('Có lỗi:');
    print(e);
    return e.toString();
  }
}

Future<String> signUpWithEmailAndPassword(
    {String email, String password}) async {
  try {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return null;
  } catch (e) {
    print('Có lỗi:');
    print(e);
    return e.toString();
  }
}

Future<String> signOut() async {
  try {
    await auth.signOut();

    return null;
  } catch (e) {
    print('Có lỗi:');
    print(e);
    return e.toString();
  }
}
