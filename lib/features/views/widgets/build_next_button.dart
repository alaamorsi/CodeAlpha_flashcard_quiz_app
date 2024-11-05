import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildNextButton extends StatelessWidget {
  final String nextTitle ;
  final void Function() onPressed;
  const BuildNextButton({super.key, required this.nextTitle,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: mainColor,
          side: const BorderSide(color: mainColor, width: 2),
          fixedSize: Size(0.5.sw, 40.0.h), // Set text color
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nextTitle,
              style: TextStyle(fontSize: 21.0.sp, color: Colors.black),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.black,
              size: 25.0.sp,
            ),
          ],
        ),
      ),
    );
  }
}
