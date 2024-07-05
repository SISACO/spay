import 'dart:async';
import 'dart:math';
import 'package:SPay/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:just_audio/just_audio.dart';


class AnimateScreen extends StatefulWidget {
  final String upiId;
  final String bankName;
  final String amount;

  AnimateScreen({
    Key? key,
    required this.upiId,
    required this.bankName,
    required this.amount,
  }) : super(key: key);

  @override
  State<AnimateScreen> createState() => _AnimateScreenState();
}

class _AnimateScreenState extends State<AnimateScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio();
    _redirect(); 
  }

  // Function to play audio
  Future<void> _playAudio() async {
    await _audioPlayer.setAsset('assets/audio/gpay.mp3');
    await _audioPlayer.play();
  }

  // Function to redirect to AnotherScreen after delay
  void _redirect() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnotherScreen(
            upiId: widget.upiId,
            bankName: widget.bankName,
            amount: widget.amount,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: Lottie.asset(
                'assets/animation/PayDone.json',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose audio player when the screen is disposed
    super.dispose();
  }
}



class AnotherScreen extends StatelessWidget {
  final String upiId;
  final String bankName;
  final String amount;

  AnotherScreen({
    required this.upiId,
    required this.bankName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Colors.blue[900],
            ),
            label: Text(
              "Share screenshot",
              style: TextStyle(color: Colors.blue[900]),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(190, 20),
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.black),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(                   context,                   MaterialPageRoute(builder: (context) => HomeScreen()),                   (Route<dynamic> route) => false);
            },
            child: Text("Done", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(100, 20),
              backgroundColor: Color.fromARGB(255, 6, 117, 208),
            ),
          ),
          SizedBox(height: 90),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 150),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 80,
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          Text(
            '\u{20B9}$amount', // Display the amount passed from AnimateScreen
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text(
            'Paid to '+ bankName,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            upiId,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 40),
          Text(
            formattedDateTime(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            "UPI transaction ID: ${generateRandomNumber()}",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

String generateRandomNumber() {
  Random random = Random();
  String result = '';
  
  for (int i = 0; i < 12; i++) {
    result += random.nextInt(10).toString(); 
  }
  
  return result;
}

var MONTHS = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

String formattedDateTime() {
  DateTime now = DateTime.now();
  String time = "${now.hour >= 12 ? " PM" : " AM"}";
  return MONTHS[now.month - 1] +
      " " +
      now.day.toString() +
      ", " +
      now.year.toString() +
      " " +
      now.hour.toString() +
      ":" +
      now.minute.toString() +
      time;
}
