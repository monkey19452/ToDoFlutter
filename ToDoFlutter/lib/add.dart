import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class addnote extends StatefulWidget {
  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('todos/$k');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '★ ZADANIA NA DZIŚ\n★ DODAJ NOWE ZADANIE',
          style: TextStyle(

            fontSize: 22,
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..strokeWidth = 2
              ..color = Colors.lightGreen[700]!,


          ),
        ),
        backgroundColor: Colors.lightGreen[200],
      ),

      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            Container(
              decoration: BoxDecoration(),
              child: TextField(
                controller: second,
                decoration: InputDecoration(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  hintText: 'Podaj Tytuł Zadania',
                  prefixIcon: const Icon(Icons.edit),
                  hintStyle: TextStyle(color: Colors.lightGreen),
                  helperText: 'Nazwij to krótko...',



                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(),
              child: TextField(
                controller: third,
                decoration: InputDecoration(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  hintText: 'Tutaj Opisz Swoje Zadanie',
                  hintStyle: TextStyle(color: Colors.lightGreen),
                  helperText: 'Opisz krótko co chcesz zrobić...',
                  prefixIcon: const Icon(Icons.edit),

                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              
              color: Colors.lightGreen[200],
              onPressed: () {
                ref.set({
                  "title": second.text,
                  "subtitle": third.text,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              child: Text(

                " ⥅  Dodaj   ",

                style: TextStyle(

                  fontSize: 33,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 2
                    ..color = Colors.lightGreen[700]!,

                ),
              ),
            ),


            MaterialButton(

              color: Colors.lightGreen[200],
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
              child: Text(
                " ⤵   Wstecz",

                style: TextStyle(

                  fontSize: 33,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 2
                    ..color = Colors.lightGreen[700]!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
