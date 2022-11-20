import 'package:brew_crew/Models/brew_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collectionreference
  CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

// get all documents (list of brew data)
  //Custom Data
  List<BrewModel> customBrew(QuerySnapshot snapshot) {
    return snapshot.docs.map((each) {
      return BrewModel(
        name: each.get('name') ?? '',
        barista: each.get('barista') ?? false,
        brew: each.get('brew') ?? [],
        // size: each.get('size') ?? 0,
        // cost: each.get('cost') ?? [],
        favorite: each.get('favorite') ?? [],
        total: each.get('total') ?? 0,
      );
    }).toList();
  }

  //Stream data
  Stream<List<BrewModel>> get brewStream {
    return brewCollection.snapshots().map(customBrew);
  }

//---------------------------------------
//get brew data by uid

  //get user doc stream
  Stream<BrewModel> get brewStreamByUid {
    return brewCollection.doc(uid).snapshots().map(_customUserBrew);
  }

  //Custom user data
  BrewModel _customUserBrew(DocumentSnapshot snapshot) {
    return BrewModel(
      name: snapshot.get("name") ?? "New Member",
      barista: snapshot.get("barista") ?? false,
      brew: snapshot.get("brew") ?? [],
      // size: snapshot.get("size") ?? 0,
      // cost: snapshot.get("cost") ?? [],
      favorite: snapshot.get("favorite") ?? [],
      total: snapshot.get("total") ?? 0,
    );
  }

//---------------------------------------

  Future updateUserData(
      String name, bool barista, List brew, List favorite, double total) async {
    try {
      return await brewCollection.doc(uid).set({
        'name': name,
        'barista': barista,
        'brew': brew,
        'favorite': favorite,
        'total': total,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
