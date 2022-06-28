import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>>? usersCollection;
  CollectionReference<Map<String, dynamic>>? authenticationCollection;

  void initUsers() {
    usersCollection = firebaseFirestore.collection('users');
  }
  // void signInUsers() {
  //   authenticationCollection = firebaseFirestore.collection('users');
  // }
// String? n;
//
//   Map<String,dynamic> data = {
//     nameKey : n,
//   };

  Future<DocumentReference<Map<String, dynamic>>> insertUsers(
      {required Map<String, dynamic> data}) async {
    initUsers();
    return await usersCollection!.add(data);
  }

  Future<void> deleteUsers({required String id}) async {
    initUsers();
    await usersCollection!.doc(id).delete();
  }

  Future<void> updateUsers(
      {required String id, required Map<String, dynamic> data}) async {
    initUsers();
    await usersCollection!.doc(id).update(data);
  }
}
