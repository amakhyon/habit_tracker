

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  late FirebaseFirestore firestore = FirebaseFirestore.instance;
  initiliase() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String code) async {
    try {
      await firestore.collection("countries").add({
        'name': name,
        'code': code,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> createUser(String email, String password, String name, String phone) async {
    try {
      await firestore.collection("users").add({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'isAdmin': false,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> createHabit(String title, String startDate, double count, userId) async {
    try {
      await firestore.collection("habits").add({
        'title': title,
        'startDate': startDate,
        'count': count,
        'userId': userId,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("countries").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
  Future<void> deleteHabit(String id) async {
    try {
      await firestore.collection("habits").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
  Future<void> deleteUser(String id) async {
    try {
      await firestore.collection("users").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
      await firestore.collection('countries').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "code": doc["code"]};
          docs.add(a);
        }
        return docs;
      }
      return docs;
    } catch (e) {
      print(e);
      return docs;
    }
  }

  Future<void> update(String id, String name, String email) async {
    try {
      await firestore
          .collection("users")
          .doc(id)
          .update({'name': name, 'email': email});
    } catch (e) {
      print(e);
    }
  }
  Future<void> updateHabit(String id, String title, String startDate, double count) async {
    try {
      await firestore.collection("habits").doc(id).update({
        'title': title,
        'startDate': startDate,
        'count': count,
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> updateHabitCount(String id, double count) async {
    try {
      await firestore.collection("habits").doc(id).update({
        'count': count,
      });
    } catch (e) {
      print(e);
    }
  }
  Future<List> getUsers() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
      await firestore.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "email": doc["email"], "phone": doc["phone"], "password": doc["password"], "isAdmin": doc["isAdmin"]};
          docs.add(a);
        }
        return docs;
      }
      return docs;
    } catch (e) {
      print(e);
      return docs;
    }
  }
  Future<List> getHabits() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
      await firestore.collection('habits').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "title": doc['title'], "user": doc["userId"], "count": doc["count"]};
          docs.add(a);
        }
        return docs;
      }
      return docs;
    } catch (e) {
      print(e);
      return docs;
    }
  }




}