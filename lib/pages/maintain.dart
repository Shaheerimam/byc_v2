import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> updateUser(String email, double Currentbalance, bool jorimana,
    double fee, double collection) async {
  await FirebaseFirestore.instance
      .collection('list')
      .doc('balance')
      .get()
      .then((DocumentSnapshot snapshot) async {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    double currentTotal = data['Total'] + 0.0;
    await FirebaseFirestore.instance.collection("list").doc("balance").update({
      'Total': currentTotal + (fee + collection),
    });
  });
  jorimana == true
      ? await FirebaseFirestore.instance
          .collection('list')
          .doc('balance2')
          .get()
          .then((DocumentSnapshot snapshot) async {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          double currentTotal = data['Total'] + 0.0;
          FirebaseFirestore.instance.collection("list").doc("balance2").update({
            'Total': currentTotal + 20.0,
          });
        })
      : null;

  var balacne = Currentbalance + (fee + collection);
  return users
      .doc(email)
      .update({'Balance': balacne})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> updateUser1(String email, double Currentbalance, bool jorimana,
    double fee, double collection) async {
  await FirebaseFirestore.instance
      .collection('list')
      .doc('balance')
      .get()
      .then((DocumentSnapshot snapshot) async {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    double currentTotal = data['Total'] + 0.0;
    await FirebaseFirestore.instance.collection("list").doc("balance").update({
      'Total': currentTotal - (fee + collection),
    });
  });
  jorimana == true
      ? await FirebaseFirestore.instance
          .collection('list')
          .doc('balance2')
          .get()
          .then((DocumentSnapshot snapshot) async {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          double currentTotal = data['Total'] + 0.0;
          FirebaseFirestore.instance.collection("list").doc("balance2").update({
            'Total': currentTotal - 20.0,
          });
        })
      : null;

  var balacne = Currentbalance - (fee + collection);
  return users
      .doc(email)
      .update({'Balance': balacne})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

void showErrDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(FocusNode());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Some thing went Wrong"),
        content: Text(err),
        actions: <Widget>[
          FlatButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<User?> signin1(
    String email, String password, BuildContext context) async {
  try {
    // ignore: unused_local_variable
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // ignore: prefer_const_constructors
    // final snackBar = SnackBar(
    //   content: const Text('Sign in Successful'),
    //   duration: const Duration(seconds: 2),
    //   backgroundColor: const Color.fromRGBO(1, 22, 39, 1),
    // );
    Fluttertoast.showToast(
        msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
    // });

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    User? user = FirebaseAuth.instance.currentUser;
    return Future.value(user);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showErrDialog(context, 'No user found for that email.');
      print('No user found for that email.');
      return Future.value(null);
    } else if (e.code == 'wrong-password') {
      showErrDialog(context, 'Wrong Phone number provided for that user.');
      print('Wrong password provided for that user.');
      return Future.value(null);
    }
  }
  return null;
}

  // void getData()async{ //use a Async-await function to get the data
  //   final data =  await FirebaseFirestore.instance.collection("users").doc('sh').get(); //get the data
  //    snapshot = data;
  // }