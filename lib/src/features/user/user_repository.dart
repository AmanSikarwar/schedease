import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedease/src/features/authentication/firebase_auth_repo.dart';

class UserRepository {
  UserRepository(this.auth, this.firestore);

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  getUserFromFirestore(String? uid) async {
    if (uid == null) {
      uid = auth.currentUser!.uid;
      final user = await firestore.collection('users').doc(uid).get();
      if (user.exists) {
        return user;
      } else {
        await firestore.collection('users').doc(uid).set({
          'name': auth.currentUser!.displayName,
          'email': auth.currentUser!.email,
          'photoURL': auth.currentUser!.photoURL,
          'uid': auth.currentUser!.uid,
        });
        final user = await firestore.collection('users').doc(uid).get();
        return user;
      }
    } else {
      final user = await firestore.collection('users').doc(uid).get();
      return user;
    }
  }
}

final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    return UserRepository(
      ref.watch(firebaseAuthProvider),
      ref.watch(firestoreProvider),
    );
  },
);
