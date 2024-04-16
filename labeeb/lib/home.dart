import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart' as tflh;

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<Home> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "...";

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
    setState(() {
      cameraController!.startImageStream((CameraImage image) {
        cameraImage = image;
        runModel();
      });
    });
  }

  loadModel() async {
    await tfl.Interpreter.fromAsset(
      "assets/model.tflite",
    );
  }

  bool isModelRunning = false;

  runModel() async {
    if (cameraImage != null && !isModelRunning) {
      isModelRunning = true;
      try {
        final interpreter =
            await tfl.Interpreter.fromAsset('your_model.tflite');
        final inputTensor = tflh.TensorImage.fromImage(cameraImage!);
        final outputTensor = tflh.TensorBuffer.createFixedSize(<int>[1, 2],
            dataType: tfl.DataType.UINT8);
        final input = tflh.TensorImage.fromTensor(inputTensor);
        final output = tflh.TensorBuffer.createFixedSize(<int>[1, 2]);

        interpreter.run(input, output);

        final predictions = output.getDoubleList();

        // Process the predictions as needed
        if (predictions != null && predictions.isNotEmpty) {
          final label = predictions.indexOf(predictions.reduce(max));
          final confidenceScore = predictions.reduce(max);

          setState(() {
            output = label.toString();
          });
        }

        interpreter.close();
      } catch (e) {
        print('Error running model: $e');
      }
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Labeeb",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: cameraController == null
                    ? Container()
                    : !cameraController!.value.isInitialized
                        ? Container()
                        : AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(cameraController!),
                          ),
              ),
            ),
            Text(
              output,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
