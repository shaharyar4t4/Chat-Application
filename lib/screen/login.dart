import 'package:appdev/constant/colour_screen.dart';
import 'package:appdev/screen/auth_serivces.dart';
import 'package:appdev/screen/home.dart';
import 'package:appdev/screen/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 87),
            child: Center(
              child: Text(
                "Login here",
                style: TextStyle(
                    fontFamily: 'pppinsbold', fontSize: 28, color: boldtxt),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              "Welcome back you’ve been missed!",
              style: TextStyle(fontSize: 18, fontFamily: 'pppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 315,
            child: TextField(
              controller: email,
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
            height: 30,
          ),
          Container(
            width: 315,
            child: TextField(
              controller: pass,
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
          Padding(
            padding: const EdgeInsets.only(left: 158, top: 10),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                      fontFamily: 'pppinsbold', fontSize: 12, color: boldtxt),
                )),
          ),
          SizedBox(
            height: 10,
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
                //     context, MaterialPageRoute(builder: (context) => Home()));

                login(context);
              },
              child: Text(
                "Sign in",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup()));
                },
                child: Text(
                  "Create new account",
                  style: TextStyle(
                      fontFamily: 'pppinsbold',
                      fontSize: 13,
                      color: Color(0xFF4a4a4a)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
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

  void login(BuildContext context) async{
   final authService = AuthService();

   try{
     await authService.signInWithEmailPassword(email.text, pass.text);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
   }catch (e){
     showDialog(context: context, builder: (context)=> AlertDialog(
       title: Text(e.toString()),
     ));
   }

  }



}
