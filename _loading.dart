import 'package:flutter/material.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white38,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to the calculator app",
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed:(){
                  Navigator.pushNamed(context, '/home');
                },
                child: Text("Go",style: TextStyle(fontSize: 18),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black45,
                foregroundColor: Colors.white,
              )
            )
          ],
        ),
      ),
    );
  }

}
