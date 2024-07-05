import 'dart:math';

import 'package:SPay/Screens/Animate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmountProccess extends StatefulWidget {
  final String upiId;
  final String bankName;
  final String amount;
  AmountProccess(
      {super.key,
      required this.upiId,
      required this.bankName,
      required this.amount});

  @override
  State<AmountProccess> createState() => _AmountProccessState();
}

class _AmountProccessState extends State<AmountProccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: 220,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose a account to pay"),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 50,
                          width: 80,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1.0,
                                ),
                              ],
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/SBI Logo and symbol, meaning, history, PNG, brand.jpeg"),
                                fit: BoxFit.contain,
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State Bank of India ····00033",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Paying using",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimateScreen(
                                upiId: widget.upiId,
                                bankName: widget.bankName,
                                amount: widget.amount),
                          ),
                        );
                      },
                      child: Text(
                        "Pay \u{20B9}" + widget.amount,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 58, 129, 241),
                          fixedSize: Size(350, 29)),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 38,
                      width: 200,
                      child: FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          child: Image.asset(
                            'assets/images/powerdlogo.png',
                          )),
                    ),
                  )
                ],
              ),
            )),
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.report)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: CircleAvatar(
                radius: 38, // Image radius
                backgroundColor: Color.fromARGB(255, 103, 85, 25),
                child: Text(
                  "${widget.bankName.substring(0, 1)}",
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Paying ${widget.bankName}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user,
                  color: Color.fromARGB(255, 59, 106, 6),
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Banking name: ${widget.bankName}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("+91 ${randomnum()}")],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\u{20B9}',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  widget.amount,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration.collapsed(
                          hintText: 'Add a note',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ),
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 216, 216),
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String randomnum() {
    Random random = Random();
    var result = '';
    for (var i = 0; i < 10; i++) {
      result += random.nextInt(10).toString();
      
    }
     return result;
  }
 
}
