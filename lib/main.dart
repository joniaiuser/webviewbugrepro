import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File imageFile;

  Future<void> uploadFile() async {
    try {
      var imagePicker = ImagePicker();
      final pickedFile = await imagePicker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 800,
      ); //ImageSource.camera
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        return;
      }
      if (imageFile != null) {
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 500,
                child: WebView(
                  initialUrl: 'https://flutter.dev',
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PermissionHandler()
              .requestPermissions([PermissionGroup.camera]);
          var permission = await PermissionHandler()
              .checkPermissionStatus(PermissionGroup.camera);
          var hasPermission = permission == PermissionStatus.granted;
          if (hasPermission) await uploadFile();
        },
        tooltip: 'Take Photo',
        child: Icon(Icons.photo_camera),
      ),
    );
  }
}
