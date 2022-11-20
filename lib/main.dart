import 'dart:math';

import 'package:crud_sqlite_app/model/diary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Diary> diaries = [];
  final types = ['Familia', 'JUdo', 'Escuela', 'Trabajo', 'Personal', 'Juegos'];

  void _addNew() async {
    final rng = Random();
    Diary diary = Diary(
      type: (types..shuffle()).first,
      enterCode: rng.nextInt(100).toString(),
    );

    final id = await diary.save();
    diary.id = id;
    setState(() => diaries.add(diary));
  }

  void _updateDiary() async {
    final rng = Random();
    Diary diary = Diary(
      id: diaries.first.id,
      type: (types..shuffle()).first,
      enterCode: rng.nextInt(100).toString(),
    );

    print("diary $diary");
    final id = await diary.save();
    _getDiaries();
  }

  void _remove() {
    if (diaries.isNotEmpty) {
      Diary diary = Diary(id: diaries.first.id);
      diary.remove();
      _getDiaries();
    }
  }

  void _getDiaries() async {
    List<Diary> diaries = await Diary().getDiaries();
    setState(() => this.diaries = diaries.map((e) => e).toList());
  }

  void _getDiary() async {
    final Diary diary = await (Diary(id: 31, enterCode: "61")).checkEnterCode();
    setState(() => diaries = [diary]);
  }

  @override
  void initState() {
    super.initState();
    _getDiaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: ListView(
          children: diaries.map((e) {
            return Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(e.toString(),
                  style: Theme.of(context).textTheme.headline4),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _remove,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
