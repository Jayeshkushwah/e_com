import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get the current user
  User? get currentUser => _auth.currentUser;

  // login
  Future<UserCredential> login(String email, String password) async{
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // signup
  Future<UserCredential> signUp(String email, String password) async{
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // logout
  Future<void> logout() async{
    await _auth.signOut();
  }
}