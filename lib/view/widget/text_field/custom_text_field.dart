import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
        this.icon,
        this.hint,
        this.validator,
        this.controller,
        this.keyboardType = TextInputType.text,
        this.isPassword = false,
        this.minLines = 1,
        this.maxLines = 1,
      });

  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final String? hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final int maxLines;
  final int minLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.icon != null?Icon(widget.icon): null,
          suffixIcon: widget.isPassword ? GestureDetector(
              onTap: toggle,
              child: Padding(
                padding:const EdgeInsetsDirectional.symmetric(horizontal: 16,vertical: 14),
                child: obscureText ?
                const Icon( Icons.visibility_off_outlined) :
                const Icon( Icons.visibility_outlined),
              )
          ) : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
