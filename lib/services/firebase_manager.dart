import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  var currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference _collectionRefFavorites =
      FirebaseFirestore.instance.collection("users-favorite-news");

  Future addToFavorites(String id) async {
    return _collectionRefFavorites
        .doc(currentUser.email)
        .collection('cid')
        .doc(id)
        .set({
      "content-id": id,
    }).then((value) => print("Added to favorites"));
  }

  Future removeFromFavorites(String id) async {
    return _collectionRefFavorites
        .doc(currentUser.email)
        .collection('cid')
        .doc(id)
        .delete()
        .then((value) => print("Removed from favorites"));
  }

 Future getRecentSearches() async {
    List  recentSearches = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-recent-searches");
    // try {
     await _collectionRef
          .doc(currentUser.email)
          .collection("recent-searches")
          .get()
          .then((value) {
             print(value);
                value.docs.forEach((element) {
                  recentSearches.add(element.data);
                });
     print(recentSearches);
              });

    // } catch (e) {
    //   print(e);
    // }


  }
}
