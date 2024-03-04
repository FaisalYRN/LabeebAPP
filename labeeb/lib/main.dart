import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:labeeb/home.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
