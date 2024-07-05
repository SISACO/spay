import 'package:SPay/Screens/ManualScreen.dart';
import 'package:SPay/Screens/QrScanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blueAccent,
        ),
        title: Text(
          "SPay",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRViewExample(),
                      ),
                    );
                  },
                  icon: Icon(Icons.qr_code_scanner),
                  iconSize: 40,
                ),
                Text("Prank using QR"),
              ],
            ),
            SizedBox(
              width: 40,
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManualScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.draw_outlined),
                  iconSize: 40,
                ),
                Text("Manual Pay Prank"),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
