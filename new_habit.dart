


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/home_layout.dart';
import 'package:intl/intl.dart';
import 'components.dart';
import 'database.dart';


class NewHabit extends StatefulWidget {



  late Database db;
  String userId;
  List userHabits;
  NewHabit(this.userId, this.userHabits) {
    db = Database();
    db.initiliase();
  }

  @override
  State<NewHabit> createState() => _NewHabit();
}

class _NewHabit extends State<NewHabit> {
  @override
  TextEditingController titleController = new TextEditingController();
  TextEditingController DateController = new TextEditingController();



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("add new habit")),
      body: Column(
          children: [
            SizedBox(
              height:30
            ),
            defaultFormField(
              type: TextInputType.text,
              label: 'Title..',
              prefix: Icons.mail,
              controller: titleController,
              validate: (String) {  },

            ), //email
            SizedBox(
              height:30,
            ),
            defaultFormField(
              type: TextInputType.text,
              label: 'date..',
              prefix: Icons.lock,
              controller: DateController,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse('2022-12-03'),
                ).then((value) {
                  DateController.text = DateFormat.yMMMd().format(value!);
                });
              },
              validate: (String) {  },

            ),
            //password
            SizedBox(
              height:30,
            ),



            defaultButton(
              text: 'Add',
              function: () {
                var title = titleController.text;
                var startDate = DateController.text;
                double count =0;
                var userId = widget.userId;
                widget.db.createHabit(title,startDate,count,userId);
                // HomeLayout.setState();
                Navigator.pop(context,"stuff");
              },
            ),

          ]
      ),
    );
  }
}