import 'package:appdev/screen/auth_serivces.dart';
import 'package:appdev/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appdev/constant/colour_screen.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

TextEditingController emailsig = TextEditingController();
TextEditingController passsig = TextEditingController();
TextEditingController cpass = TextEditingController();

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 85),
            child: Center(
              child: Text(
                "Create Account",
                style: TextStyle(
                    fontFamily: 'pppinsbold', fontSize: 28, color: boldtxt),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Text(
              "Create an account so you can explore all the existing jobs",
              style: TextStyle(fontSize: 14, fontFamily: 'pppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 315,
            child: TextField(
              controller: emailsig,
              decoration: InputDecoration(
                hintText: " Email",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: btn, // Border color when focused
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 315,
            child: TextField(
              controller: passsig,
              obscureText: true,
              decoration: InputDecoration(
                hintText: " Password",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: btn, // Border color when focused
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 315,
            child: TextField(
              controller: cpass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: " Confirm Password",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: btn, // Border color when focused
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Button color
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFd6deff),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Login()));

                resigter(context);
              },
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: btn,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Already have an account",
                  style: TextStyle(
                      fontFamily: 'pppinsbold',
                      fontSize: 13,
                      color: Color(0xFF4a4a4a)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Or continue with",
                  style: TextStyle(
                      fontFamily: 'pppinsbold', fontSize: 13, color: boldtxt),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 35,
                  ),
                  onPressed: () {
                    // Facebook login logic
                  },
                ),
              ),
              SizedBox(width: 20),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.asset(
                    'assets/images/google.png',
                    width: 50,
                    height: 50,
                  )),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.apple,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    // Apple login logic
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  void resigter(BuildContext context) async {
    final auth = AuthService();
    if (passsig.text == cpass.text) {
      try {auth.signUpWithEmailPassword(
          emailsig.text,
          passsig.text
      );} catch (e){
        showDialog(context: context, builder: (context)=> AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }else{
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text("Password Does Not Matched"),
      ));
    }
  }
}
