import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[200],
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('todos');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[400],
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        child: Icon(

          Icons.add_circle_outline,

          color: Colors.black26,
          size: 52.0,




        ),
      ),




      appBar: AppBar(
        title: Text(
          '☆ ZADANIA NA DZIŚ\n☆ PRZEGLĄD ZADAŃ',
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
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
          snapshot.value.toString();

          g = v.replaceAll(
              RegExp("{|}|subtitle: |title: "), "");
          g.trim();

          l = g.split(',');

          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: second,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.edit),
                        hintText: 'Edytuj Tytuł',
                      ),
                    ),
                  ),
                  content: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: third,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(),

                        prefixIcon: const Icon(Icons.edit),

                        hintText: 'Edytuj Treść',
                      ),

                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.red[200],

                      child: Text(
                        " ✗ ",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.red,



                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await upd();
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.lightGreen[200],

                      child: Text(
                        " ✓ ",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container( //wyswietlanie
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.amber,

                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  tileColor: Colors.lightGreen[200],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black12,
                      size: 40
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Text(


                    "✓ "+l[1] ,
                    // 'dd',
                    style: TextStyle(
                      fontSize: 22,

                      foreground: Paint()
                        ..style = PaintingStyle.fill

                        ..color = Colors.lightGreen[700]!,
                    ),
                  ),
                  subtitle: Text(
                    "       "+l[0],
                    // 'dd',

                    style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()
                        ..style = PaintingStyle.fill

                        ..color = Colors.lightGreen[800]!,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/$k");


    await ref1.update({
      "title": second.text,
      "subtitle": third.text,
    });
    second.clear();
    third.clear();
  }
}
