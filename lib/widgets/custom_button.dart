import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Size size;
  final String label;
  const CustomButton({super.key,
    required this.onPressed,
    required this.size,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        backgroundColor: Colors.indigo,
        fixedSize: Size(size.width, 40),
      ),
      child: Text(label,style: TextStyle(color: Colors.white),),
    );
  }
}
