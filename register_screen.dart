


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'database.dart';

class RegisterScreen extends StatefulWidget {
  late Database db;

  RegisterScreen() {
    db = Database();
    db.initiliase();
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Register')),
      body: SingleChildScrollView(
        child: Column(
            children: [
              defaultFormField(
                type: TextInputType.text,
                label: 'Email..',
                prefix: Icons.mail,
                controller: emailController,
                validate: (String) {  },

              ), //email
              SizedBox(
                height:30,
              ),
              defaultFormField(
                type: TextInputType.text,
                label: 'password..',
                prefix: Icons.lock,
                controller: passwordController,
                isPassword: true,
                validate: (String) {  },

              ),
              //password
              SizedBox(
                height:30,
              ),
              defaultFormField(
                type: TextInputType.text,
                label: 'confirm password..',
                prefix: Icons.lock,
                controller: passwordController,
                isPassword: true,
                validate: (String) {  },

              ), //confirm password
              SizedBox(
                height:30,
              ),
              defaultFormField(
                type: TextInputType.text,
                label: 'name..',
                prefix: Icons.account_circle,
                controller: nameController,
                validate: (String) {  },

              ), //name
              SizedBox(
                height:30,
              ),
              defaultFormField(
                type: TextInputType.text,
                label: 'phone..',
                prefix: Icons.phone,
                controller: phoneController,
                validate: (String) {  },

              ), //phone

              defaultButton(
                text: 'Register',
                function: () {
                    var email = emailController.text;
                    var password = passwordController.text;
                    var name = nameController.text;
                    var phone = phoneController.text;
                    widget.db.createUser(email,password,name,phone);
                    Navigator.pop(context);
                },
              ),

            ]
        ),
      ),
    );
  }
}