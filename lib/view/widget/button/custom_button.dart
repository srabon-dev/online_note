import 'package:flutter/material.dart';
import 'package:online_note/constant/app_colors.dart';
import 'package:online_note/view/widget/dot/jumping_dot.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.bgColor,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor ?? const Color(0xFFEF6A27),
        ),
        child: isLoading?Center(
          child: JumpingDots(
            color: Colors.white,
            radius: 10,
            numberOfDots: 3,
          ),
        ):Center(child: Text(text,style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.whiteColor,
        ))),
      ),
    );
  }
}