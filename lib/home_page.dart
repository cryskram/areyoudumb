import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List alignmentList = <Alignment>[
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight
  ];

  Alignment _alignment = Alignment.centerLeft;

  // only for method 3
  int _lastSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedf2f4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you Dumb?",
              style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff2b2d42)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _handleYes,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xff2b2d42),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: Text(
                            "Yes",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Align(
                      alignment: _alignment,
                      child: GestureDetector(
                        onTap: _handleNo,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff2b2d42),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: Text(
                              "No",
                              style: GoogleFonts.bebasNeue(
                                color: const Color(0xff2b2d42),
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _handleNo() {
    setState(() {
      // method 1
      // _alignment = alignmentList[Random().nextInt(alignmentList.length)];

      // method 2
      // alignmentList.shuffle();
      // _alignment = alignmentList.first;

      // both those methods have a chance of repeating positions rarely
      // method 3
      setState(() {
        int index;

        do {
          index = Random().nextInt(alignmentList.length);
        } while (index == _lastSelectedIndex);

        _lastSelectedIndex = index;
        _alignment = alignmentList[index];
      });
    });
  }

  void _handleYes() async {
    await _audioPlayer.setVolume(0.4);
    await _audioPlayer.play(AssetSource("audio/laughAudio.mp3"));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/images/laugh.png"),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "I knew it!!",
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                )
              ],
            ),
          ),
        );
      },
    ).then((value) async {
      await _audioPlayer.stop();
    });
  }
}
