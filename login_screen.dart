


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/register_screen.dart';
import 'package:habit_tracker/view_all_habits.dart';

import 'components.dart';
import 'database.dart';
import 'display_all_data.dart';
import 'home_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
        habits = value  ;
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

  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'habit tracker',
              style: TextStyle(
                color: Colors.white,

              ),

            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: (
                        Image.asset('assets/images/man lying down.png')
                    )
                ),
                Container(
                  child: defaultFormField(
                    label:'Email...',

                    prefix: Icons.mail,
                    type:TextInputType.text,
                    controller: emailController,
                    validate: (String ) {  },
                  ),
                ), //username

                SizedBox(
                  height:20,
                ),
                Container(
                  child: defaultFormField(
                    label:'password...',

                    prefix: Icons.account_circle,
                    isPassword: true,
                    type:TextInputType.text,
                    controller: passwordController,
                    validate: (String ) {  },
                  ),
                ),  //password
                SizedBox(
                  height:40,
                ),

                Container(
                  child: defaultButton(
                    background: Colors.blue,
                    text: 'Login',
                    function: (){
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();
                      var userId;
                      for(var i=0; i < users.length; i++){
                        if (users[i]['email'] == email){
                            if (users[i]['password'] == password){
                              userId = users[i]['id'].toString().trim();
                              List userHabits = [];
                              print(habits);
                              for(var i=0; i < habits.length; i++){
                                String habitId = habits[i]['user'].toString().trim();
                                if(habitId == userId){
                                  userHabits.add(habits[i]);
                                }
                              }
                              if(users[i]['isAdmin'] == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>DisplayAllData(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeLayout(userId,userHabits, db),
                                  ),
                                );
                              }
                            } else{
                              print('incorrect password');
                            }
                        }
                      }
                      // if(formKey.currentState!.validate()){
                      //
                      //
                      // }

                    },
                  ) //login button,
                ),
                SizedBox(
                  height:40,
                ),//default button
                Container(
                  child: defaultButton(
                    background: Colors.blue,
                    text: 'Register',
                    function: (){
                      if(formKey.currentState!.validate()){
                        print('correct');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ), //register
                        );
                      }

                    },
                  ),
                ), //default button
              ],
            ),
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}