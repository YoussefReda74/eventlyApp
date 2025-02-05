import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  static Future<void> addEvent(TaskModel task) {
    var collection = getTasksCollection();
    var docsRef = collection.doc();
    task.id = docsRef.id;
    return docsRef.set(task);
  }

  static Future<void> addUser (UserModel user) {
    var collection = getUserCollection();
    var docsRef = collection.doc(user.id);
    return docsRef.set(user);
  }

  static Stream<QuerySnapshot<TaskModel>> getEvent() {
    var collection = getTasksCollection();
    return collection.snapshots();
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
      if (e.code == 'user-not-found') {
        onError(e.message);
      }
    }
  }
}
