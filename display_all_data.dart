import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/home_layout.dart';
import 'package:habit_tracker/register_screen.dart';
import 'package:habit_tracker/update_user_screen.dart';
import 'package:habit_tracker/view_all_habits.dart';

import 'database.dart';
import 'view_all_users.dart';





class DisplayAllData extends StatefulWidget {
  const DisplayAllData({ Key? key }) : super(key: key);

  @override
  State<DisplayAllData> createState() => _DisplayAllData();


}

class _DisplayAllData extends State<DisplayAllData> {
  late Database db;
  List users = [];
  List habits = [];
  initialise() {
    db = Database();
    db.initiliase();
    db.getUsers().then((value) => {
      setState(() {
        users = value;
      })
    });
    db.getHabits().then((value) => {
      setState(() {
        habits = value;
      })
    });
  }

  @override
  void  initState() {
    super.initState();
    initialise();
    setState(() {

    });
  }
  void reloadData() {
    users = [];
    initialise();
    db.getUsers().then((value) {
      setState(() {
        users = value;
      });
    });
  }

  List getUserHabits(userId){
    List userHabits = [];
    print(habits);
    for(var i=0; i < habits.length; i++){
      String habitId = habits[i]['user'].toString().trim();
      if(habitId == userId){
        userHabits.add(habits[i]);
      }
    }
    return userHabits;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'Users',
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
          itemCount: users.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                  children: [ Row(

                    children: [
                      SizedBox(
                          width:10
                      ),
                      Expanded(
                        child: Text(
                          "${users[index]['name']}",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeLayout(users[index]['id'], getUserHabits(users[index]['id']), db),
                    ),
                  ).then((value) => reloadData());
                },
                    icon: Icon(Icons.check, size: 30) ), //see user habits
                      IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateUser(),
                          ),
                        ).then((value) => reloadData());
                      },
                          icon: Icon(Icons.edit, size: 30) ), //update
                      IconButton(onPressed: (){
                        db.deleteUser(users[index]['id']);
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
              builder: (context) => RegisterScreen()
            ),
          ).then((value) => reloadData());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}