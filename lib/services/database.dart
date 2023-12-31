import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:brew_crew/models/brew.dart';

import '../models/users.dart';

class DatabaseService {

   final String uid;
  DatabaseService({ required this.uid });
  //collection reference


  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brew');

      Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
           'name': name,
      'strength': strength,

      'sugars': sugars,
    });
  }
// brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Brew(
        name: doc.get('name') ?? " ",

        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }


  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    
    return UserData(
      uid: uid,
      name: snapshot['name'],

      sugars:  snapshot['sugars'],

      strength: snapshot['strength'],

    );
  }
  // get brews stream
  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }


  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }



}