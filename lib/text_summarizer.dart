import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class TextSummarizerScreen extends StatefulWidget {
  const TextSummarizerScreen({super.key});

  @override
  State<TextSummarizerScreen> createState() => _TextSummarizerScreenState();
}

class _TextSummarizerScreenState extends State<TextSummarizerScreen> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController suggestionTextController =
      TextEditingController();

  final apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCaZ_rbKsh3OM8Y0Ef3myiP9taP97NZoSQ';

  String summary = "";
  bool scanning = false;

  final headers = {
    'Content-Type': 'application/json',
  };

  getdata(myText, howToSummarize) async {
    setState(() {
      scanning = true;
    });
    var data = {
      "contents": [
        {
          "parts": [
            {'text': "$howToSummarize - $myText"}
          ]
        }
      ],
    };
    await http
        .post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(data))
        .then((response) {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);
        setState(() {
          summary = result['candidates'][0]['content']['parts'][0]['text'];
        });
      } else {
        print("Request failed ${response.statusCode}");
      }
    }).catchError((error) {
      print("Error : ${error}");
    });
    setState(() {
      scanning = false;
    });
  }

  void clearAllFields() {
    setState(() {
      inputTextController.clear();
      suggestionTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Summarizer"),
        actions: [
          TextButton(
              onPressed: () {
                clearAllFields();
              },
              child: const Text("Clear Data"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: inputTextController,
                maxLines: 16,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter text to summarize...",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: suggestionTextController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "How to summarize",
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                getdata(
                    inputTextController.text, suggestionTextController.text);
              },
              child: const Text("Summarize Text"),
            ),
            const SizedBox(
              height: 16,
            ),
            scanning
                ? const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: SpinKitPulsingGrid(color: Colors.black, size: 50),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(summary),
                  ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
