import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:SPay/Screens/AmountProccess.dart';

class ManualScreen extends StatefulWidget {
  ManualScreen({super.key});

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _navigateToAmountProcess(BuildContext context) {
    final String amount = _amountController.text;
    final String bankName = _bankNameController.text;
    final String upiId = _upiIdController.text;
    final NumberFormat formatter = NumberFormat('#,###.##', 'en_US');
    String formattedAmount = formatter.format(double.parse(amount));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmountProccess(
          upiId: upiId,
          bankName: bankName,
          amount: formattedAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Manual amount Prank')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
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
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the receiver name';
                    }
                    return null;
                  },
                  controller: _bankNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Receiver Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the UPI ID';
                    }
                    return null;
                  },
                  controller: _upiIdController,
                  decoration: InputDecoration(
                    labelText: 'Enter UPI ID',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 58, 129, 241),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _navigateToAmountProcess(context);
                    }
                  },
                  child: Text('Proceed'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 58, 129, 241),
                    minimumSize: Size(200, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
