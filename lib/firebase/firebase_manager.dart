import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static Future<void> updateTask(TaskModel task) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
    debugPrint("Task updated successfully");
  }

  static Future<void> toggleFavorite(TaskModel task) async {
    final docRef = FirebaseFirestore.instance.collection('tasks').doc(task.id);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final currentData = snapshot.data() as Map<String, dynamic>;
      final isFavorite = currentData['isFavorite'] ?? false;

      await docRef.update({
        'isFavorite': !isFavorite,
      });
    }
  }
  static Future<void> deleteTask(String taskId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
  }

  static Future<void> addEvent(TaskModel task) {
    var collection = getTasksCollection();
    var docsRef = collection.doc();
    task.id = docsRef.id;
    return docsRef.set(task);
  }

  static Future<void> addFav(TaskModel task) {
    var collection = getTasksCollection();
    var docsRef = collection.doc(task.id);
    return docsRef.update(task.toJson());
  }

  static Future<UserModel?> readUser() async {
    var collection = getUserCollection();
    DocumentSnapshot<UserModel> docRef =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    var docsRef = collection.doc(user.id);
    return docsRef.set(user);
  }

  static Stream<QuerySnapshot<TaskModel>> getEvent(String categoryName) {
    var collection = getTasksCollection();
    if (categoryName == 'All') {
      return collection
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('date', descending: false)
          .snapshots();
    } else {
      return collection
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('category', isEqualTo: categoryName)
          .orderBy('date', descending: false)
          .snapshots();
    }
  }

  static Future<void> createAccount(
    String name,
    String emailAddress,
    String password,
    Function onLoading,
    Function onSuccess,
    Function onError,
  ) async {
    try {
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: emailAddress,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError('something wrong');
      print(e);
    }
  }

  static Future<void> login(
    String emailAddress,
    String password,
    Function onLoading,
    Function onSuccess,
    Function onError,
  ) async {
    onLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (credential.user!.emailVerified) {
        onSuccess();
      } else {
        onError('please verify your mail');
      }
    } on FirebaseAuthException catch (e) {
      onError('wrong email or password');
    }
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
