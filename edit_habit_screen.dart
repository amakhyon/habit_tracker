


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/home_layout.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'components.dart';
import 'database.dart';


class UpdateHabit extends StatefulWidget {



  late Database db;

  String habitId;
  String title;
  double count;
  UpdateHabit(this.habitId, this.title, this.count) {
    db = Database();
    db.initiliase();
  }

  @override
  State<UpdateHabit> createState() => _UpdateHabit();
}

class _UpdateHabit extends State<UpdateHabit> {
  @override
  TextEditingController titleController = new TextEditingController();
  TextEditingController DateController = new TextEditingController();
  TextEditingController countController = new TextEditingController();

  int habitCount = 0;

  Widget build(BuildContext context) {
    titleController.text = widget.title;
    countController.text = habitCount.toString();
    return Scaffold(
      appBar: AppBar(title:Text("edit habit")),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height:30),
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
              SizedBox(
                height:30,
              ),
              Text('Count', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: habitCount,
          minValue: 0,
          maxValue: 21,
          step: 1,
          haptics: true,
          onChanged: (value) => setState(() => habitCount = value ),
        ),
              //password
              SizedBox(
                height:30,
              ),



              defaultButton(
                text: 'Edit',
                function: () {
                  var title = titleController.text;
                  var startDate = DateController.text;
                  double count = double.parse(countController.text) ;
                  String habitId = widget.habitId;
                  widget.db.updateHabit(habitId,title,startDate,habitCount.toDouble());
                  // HomeLayout.setState();
                  Navigator.pop(context,"stuff");
                },
              ),

            ]
        ),
      ),
    );
  }
}