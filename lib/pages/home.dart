import 'dart:convert';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/rendering.dart';
import 'package:jokee/constants.dart';
import 'package:jokee/model/model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool jokeArrived = false;
  late JokeModel joke;

  fetchRandomJoke() async {
    var res = await get(Uri.parse(url));
    var decoded = jsonDecode(res.body);
    JokeModel data = JokeModel.fromJson(decoded);
    joke = data;
    jokeArrived = true;
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 1700));
    TextToSpeech tts = TextToSpeech();
    // tts.setLanguage("en-us");
    tts.speak("${joke.setup ?? ''} ${joke.delivery ?? ""}");

    // tts.speak(joke.delivery ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      bottomNavigationBar: Container(
        height: 70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: defaultAnimationDuration,
            child: InkWell(
              onTap: fetchRandomJoke,
              child: Container(
                  height: 55,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white24,
                  ),
                  child: const Center(
                      child: Text(
                    "Generate a Random joke",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1),
                  ))),
            ),
          ),
        ]),
      ),
      body: Center(
        child: FadeInLeftBig(
          delay: const Duration(milliseconds: 1000),
          child: !jokeArrived
              ? Container(
                  height: 55,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Command me for a joke...",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInLeftBig(
                      child: Container(
                          // height: 55,
                          width: 300,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              joke.setup ?? "",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                    ),
                    SizedBox(height: 20),
                    FadeInRightBig(
                      child: Container(
                          // height: 55,
                          width: 300,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              joke.delivery ?? "",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
