import 'dart:io';

import 'package:flutter/material.dart';

import 'MyFoxView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endless ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Endless ListView Page'),
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
  List<MyFoxView> myFoxes = [];

  // в flitter web не испозльзуется dart:io для работы с файлами
  /*_asyncMethod() async {
    var url = Uri.parse("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY207PXnzNorp6OUr9hkeVF29vT6Ca2PhPvQ&usqp=CAU");
    var response = await get(url);
    print(url);
    print(response.body);
    var documentDirectory = ".";
    var firstPath = "$documentDirectory/images";
    var filePathAndName = '$documentDirectory/images/pic.jpg';

    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    print(file);
    file.writeAsBytesSync(response.bodyBytes);
    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: 123*2,
            itemBuilder: (context, i) {
              if (i.isOdd) return const Divider();
              final int index = i ~/ 2;
              if (index >= myFoxes.length) {
                myFoxes.addAll([
                  MyFoxView(index + 1),
                  MyFoxView(index + 2),
                  MyFoxView(index + 3)
                ]);
              }
              print('просят индекс $i отдаем индекс $index длина массива ${myFoxes.length}');
              return ListTile(
                title: myFoxes[index],
              );
            }));
  }
}
