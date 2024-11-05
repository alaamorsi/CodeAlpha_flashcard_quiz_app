import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildHomeButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  const BuildHomeButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Set your desired border radius
          ),
          foregroundColor: Colors.deepPurple,
          side: const BorderSide(color: Colors.deepPurple, width: 3),
          fixedSize: Size(0.5.sw, 40.0.h), // Set text color
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(fontSize: 21.0.sp, color: Colors.black,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
