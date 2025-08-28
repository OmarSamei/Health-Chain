import 'package:flutter/material.dart';
import 'package:health_chain/auth/VerifyCodePage.dart';
import 'package:health_chain/widgets/custom_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🔹 الخلفية بيضاء
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Forget Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 الفريم اللي فيه الصورة
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/frames/Frame4.png", // غيّر المسار حسب مكان الصورة
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 النص
            const Text(
              "Please write your email to receive a confirmation code to set a new password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // 🔹 TextField للإيميل
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined), // أيقونة الإيميل
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),

            // 🔹 الزر
            CustomButton(
              text: "Get Code",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifyCodePage()),
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
