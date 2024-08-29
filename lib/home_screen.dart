import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_flutter/text_summarizer.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? pickedImage;
  String myText = "";
  bool scanning = false;
  bool isLoading = false;

  final ImagePicker imagePicker = ImagePicker();

  getImage(ImageSource ourSource) async {
    setState(() {
      isLoading = true;
    });
    XFile? result = await imagePicker.pickImage(source: ourSource);
    if (result != null) {
      setState(() {
        pickedImage = result;
      });
      await performTextRecognition();
    }
    setState(() {
      isLoading = false;
    });
  }

  performTextRecognition() async {
    setState(() {
      scanning = true;
    });
    try {
      final inputImage = InputImage.fromFilePath(pickedImage!.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);
      setState(() {
        myText = recognizedText.text;
        scanning = false;
      });
    } catch (e) {
      print("Error during text recognition is $e");
      setState(() {
        scanning = false;
      });
    }
  }

  void clearImage() {
    setState(() {
      pickedImage = null;
      myText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Recognition"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TextSummarizerScreen()));
              },
              child: const Text("Text Summarizer"))
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        isLoading
            ? const Center(
                child: SpinKitThreeBounce(color: Colors.black, size: 30),
              )
            : pickedImage == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      height: 250,
                      child:
                          const Center(child: Text("No Image Selected......")),
                    ))
                : Stack(children: [
                    Center(
                        child: Image.file(
                      File(pickedImage!.path),
                      height: 250,
                    )),
                    Positioned(
                        right: 58,
                        top: 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15,
                          child: IconButton(
                              onPressed: () {
                                clearImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.white,
                              )),
                        ))
                  ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: const Text("Gallery"),
              icon: const Icon(Icons.photo),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: const Text("Camera"),
              icon: const Icon(Icons.camera_alt),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "𝕽𝖊𝖈𝖔𝖌𝖓𝖎𝖟𝖊𝖉 𝕿𝖊𝖝𝖙✍",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        scanning
            ? const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: SpinKitThreeBounce(color: Colors.black, size: 20),
                ),
              )
            : Center(
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      myText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ]),
    );
  }
}
