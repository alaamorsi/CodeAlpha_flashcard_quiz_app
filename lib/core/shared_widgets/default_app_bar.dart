import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressed;

  const DefaultAppBar({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0.sp,bottom: 30.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        Expanded(child: Center(child: Text(title,style: TextStyle(fontSize: 28.0.sp,color: Colors.black),))),
      ],),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
