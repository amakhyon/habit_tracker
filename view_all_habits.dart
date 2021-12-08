import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

// class ViewHabit extends StatefulWidget {
//   var user;
//   Map habits;
//   Database db;
//   ViewHabit({Key? key, required this.user,required this.habits, required this.db}) : super(key: key);
//
//   @override
//   _ViewHabitState createState() => _ViewHabitState();
// }

class ViewHabits extends StatelessWidget {
  TextEditingController titleController = new TextEditingController();
  TextEditingController countCountroller = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  List habits = [];
  String userId = '';
  List UserHabits = [];

  ViewHabits(List habits, String userId){
    this.habits = habits;
    this.userId = userId;
    List UserHabits = [];
    for( var i=0; i < habits.length; i++){
      if (habits[i]['user'] == userId) {
        UserHabits.add(habits[i]);
      }
    }
  }

  @override
  // void initState() {
  //   super.initState();
  //   print(widget.habits);
  //   titleController.text = widget.habits['title'];
  //   countCountroller.text = widget.habits['count'];
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('hi'),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}