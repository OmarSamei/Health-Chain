import 'package:flutter/material.dart';
import 'package:health_chain/auth/NewPass.dart';
import 'package:health_chain/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  TextEditingController codeController = TextEditingController();
  int secondsRemaining = 32;
  late final _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Stream.periodic(const Duration(seconds: 1), (i) => i).listen((i) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Enter code",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Verify email address
            const Text(
              "Verify email address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),

            // Email text
            const Text(
              "Verification code sent to: hotella@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Pin Code Fields
            PinCodeTextField(
              appContext: context,
              controller: codeController,
              length: 5,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                activeColor: Colors.blue,
                selectedColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              enableActiveFill: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),

            // Timer
            TextButton(
              onPressed: secondsRemaining == 0 ? () {} : null,
              child: Text(
                secondsRemaining > 0
                    ? "00:${secondsRemaining.toString().padLeft(2, '0')}  send code again"
                    : "Resend code",
                style: TextStyle(
                  color: secondsRemaining > 0 ? Colors.blue : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: "Get Code",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPassPage()),
                );
              },
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
