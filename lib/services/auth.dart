import "package:firebase_auth/firebase_auth.dart";
import 'package:brew_crew/models/users.dart' ;

import 'database.dart';


class AuthService{

final   FirebaseAuth _auth = FirebaseAuth.instance;


// create user object based on firebase user
Users? _userFromFirebaseUser(User    user){
  return user != null ?  Users(uid: user.uid) : null;
}


// auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
      .map((User? user) => _userFromFirebaseUser(user!) as Users);
  }
  //sign in anon

Future SignInAnon() async {
try{

UserCredential result = await _auth.signInAnonymously();
User ? user = result.user;
return _userFromFirebaseUser(user!);
//User? user = result.user;
//return _userFromFirebaseUser(user!);
  }catch(e) {
print(e.toString());
return null;
  }

}





  //email and pass

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
  //register email and pass
   Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;

            await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
  //sign out
Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  
}