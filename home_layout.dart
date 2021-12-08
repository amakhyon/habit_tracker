import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/edit_habit_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'components.dart';
import 'database.dart';
import 'new_habit.dart';

class HomeLayout extends StatefulWidget {
  String userId = '';
  Database db;
  List userHabits = [];

  setState() {

  }

  HomeLayout(this.userId, this.userHabits, this.db);

  @override
  State<HomeLayout> createState() => _HomeLayout();
}

class _HomeLayout extends State<HomeLayout> {
  @override
  // TextEditingController emailController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController phoneController = new TextEditingController();

  late Database db;
  List habits = [];

  initialise() {
    print(widget.userId);
    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    print('initialized home');
    reloadData();
    setState(() {

    });
  }

  void reloadData() {
    widget.userHabits = [];
    initialise();
    db.getHabits().then((value) {
      setState(() {
        habits = value;
      });
      print(habits);
      for(var i=0; i < habits.length; i++)
      {
        String habitId = habits[i]['user'].toString().trim();
        if (habitId == widget.userId && !widget.userHabits.contains(habits[i])) {
          widget.userHabits.add(habits[i]);
        }
      }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'todoto',
              style: TextStyle(
                color: Colors.white,

              ),

            ),
          )
      ),
      body:
      Padding(
          padding: EdgeInsets.all(15),
          child:
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.userHabits.length,
              itemBuilder: (context, habitIndex) {
                return SingleChildScrollView(
                  child: Column(
                    children: [ Row(

                      children: [
                        new CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 10.0,
                          percent: (widget.userHabits[habitIndex]['count'] /21),
                          center: Icon(Icons.wb_sunny, color:Colors.green, size: 50,),
                          progressColor: Colors.green,
                        ),
                        SizedBox(
                            width:10
                        ),
                          Expanded(
                            child: Text(
                                "${widget.userHabits[habitIndex]['title']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        IconButton(onPressed: (){
                          if(widget.userHabits[habitIndex]['count'] < 21) {
                            widget.userHabits[habitIndex]['count'] ++;
                            db.updateHabitCount(widget
                                .userHabits[habitIndex]['id'],
                                widget.userHabits[habitIndex]['count']).then((
                                value) => reloadData());
                          }
                        },
                            icon: Icon(Icons.done, size: 30, color:Colors.green)),
                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateHabit(widget.userHabits[habitIndex]['id'], widget.userHabits[habitIndex]['title'],widget.userHabits[habitIndex]['count']),
                            ),
                          ).then((value) => reloadData());
                        },
                            icon: Icon(Icons.edit, size: 30) ),
                        IconButton(onPressed: (){
                          db.deleteHabit(widget.userHabits[habitIndex]['id']);
                          reloadData();
                        },
                            icon: Icon(Icons.delete, size:30, color:Colors.red)), //delete

                      ],
                    ),
                      SizedBox(height:30)
                ]
                  ),
                );
              },

            ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewHabit(widget.userId, widget.userHabits),
            ),
          ).then((value) => reloadData());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}