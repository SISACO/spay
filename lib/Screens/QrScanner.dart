import 'package:SPay/Screens/Animate.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:intl/intl.dart';

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  void parseUPICode(String qrData) {
    Uri uri = Uri.parse(qrData);
    String upiId = uri.queryParameters['pa'] ?? 'N/A';
    String bankName = uri.queryParameters['pn'] ?? 'N/A';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmountAdd(bankName: bankName, upiId: upiId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UPI QR Scanner')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: (barcodeCapture) {
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  final String? code = barcode.rawValue;
                  if (code != null) {
                    parseUPICode(code);
                    break; // Stop after processing the first barcode
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Scan a QR code to get UPI data.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QrRedirect extends StatelessWidget {
  final String upiId;
  final String bankName;
  final String amount;

  QrRedirect(
      {required this.upiId, required this.bankName, required this.amount});

  @override
  Widget build(BuildContext context) {
    // Format amount with commas for thousands separator
    final NumberFormat formatter = NumberFormat('#,###.##', 'en_US');
    String formattedAmount = formatter.format(double.parse(amount));
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
              topLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose an account to pay"),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/SBI Logo and symbol, meaning, history, PNG, brand.jpeg",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "State Bank of India ····00033",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Paying using"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimateScreen(
                            upiId: upiId,
                            bankName: bankName,
                            amount: formattedAmount),
                      ),
                    );
                  },
                  child: Text(
                    "Pay \u{20B9}$formattedAmount",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 129, 241),
                    fixedSize: Size(350, 29),
                  ),
                ),
                Center(
                  child: Container(
                    height: 38,
                    width: 200,
                    child: FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      child: Image.asset('assets/images/powerdlogo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.report)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: Color.fromARGB(255, 103, 85, 25),
              child: Text(
                "${bankName.substring(0, 1)}",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Paying $bankName",
              style: TextStyle(fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user,
                  color: Color.fromARGB(255, 59, 106, 6),
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Banking name: $bankName",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 14),
            Text(upiId),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\u{20B9}',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  formattedAmount,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class AmountAdd extends StatefulWidget {
  final String upiId;
  final String bankName;

  AmountAdd({super.key, required this.bankName, required this.upiId});

  @override
  State<AmountAdd> createState() => _AmountAddState();
}

class _AmountAddState extends State<AmountAdd> {
  final TextEditingController _amountController = TextEditingController();

  void _navigateToQrRedirect(BuildContext context) {
    final String amount = _amountController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrRedirect(
          upiId: widget.upiId,
          bankName: widget.bankName,
          amount: amount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _keyForm = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Enter Amount')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter a amount";
                    }
                    return null;
                  },
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _navigateToQrRedirect(context);
                    }
                  },
                  child: Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
