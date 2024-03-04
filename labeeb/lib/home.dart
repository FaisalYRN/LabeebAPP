import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:labeeb/main.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({key});

  @override
  // ignore: library_private_types_in_public_api
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<Home> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";

  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Sign language translator"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: !cameraController!.value.isInitialized
                        ? Container()
                        : AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(cameraController!),
                          )),
              ),
              Text(
                output,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          )),
    );
  }
}
