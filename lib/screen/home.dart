import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Hello, Shaharyar", style: TextStyle(fontSize: 20, fontFamily: 'pppins'),))
        ],
      ),
    );
  }
}
