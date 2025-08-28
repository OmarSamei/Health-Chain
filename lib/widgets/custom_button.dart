import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // نص الزر
  final VoidCallback onPressed; // الدالة اللي هتنفذ عند الضغط
  final bool isPrimary; // true => زر ملون, false => زر مفرغ

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // 🔹 حواف ناعمة مش حادة
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: Colors.blueAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9), // 🔹 نفس الحواف هنا
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.blueAccent)),
          );
  }
}
