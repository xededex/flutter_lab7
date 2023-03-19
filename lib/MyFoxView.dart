import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyFoxView extends StatefulWidget {
  final int index;
  const MyFoxView(this.index, {super.key});

  @override
  State<StatefulWidget> createState() => _MyFoxViewState();
}

class _MyFoxViewState extends State<MyFoxView> {

  late int itemId;
  late Uint8List imageData;
  bool canLoad = false;

  // https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
  // невозможно получить изображение с некоторых сайтов, без внесения этих изменений в flutter
  _asyncMethod() async {
    Map<String, String> requestHeaders = {
      'Accept': 'image/*',
    };
    // нет ошибки:
    // has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.
    var url = Uri.parse("https://randomfox.ca/images/$itemId.jpg");

    var response = await get(url, headers: requestHeaders);

    if(mounted){
      setState(() {
        imageData = response.bodyBytes;
        canLoad = true;
      });
    }
  }
  @override
  void initState() {
    itemId = widget.index;
    _asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(canLoad) {
      return Table(
        children: [
          TableRow(children: [
            Text('Лиса $itemId'),
            Image.memory(imageData, width: 100, height: 100)
          ])
        ],
      );
    }else{
      return const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyan,
            strokeWidth: 5)
          ),
        );
    }
  }
}
