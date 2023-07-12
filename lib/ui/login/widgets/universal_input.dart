import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversalInput extends StatefulWidget {
  UniversalInput(
      {Key? key,
      required this.label,
      required this.hint,
      this.isSecure,
      this.maxLine = 1,
      this.keyboardType = TextInputType.name,
      required this.controller})
      : super(key: key);
  String label;
  String hint;
  bool? isSecure;
  TextEditingController controller;
  int? maxLine;
  TextInputType keyboardType;

  @override
  State<UniversalInput> createState() => _UniversalInputState();
}

class _UniversalInputState extends State<UniversalInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF5A5A5D)),
        ),
        SizedBox(height: 12),
        TextField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          maxLines: widget.maxLine,
          obscureText: widget.isSecure ?? false,
          style: GoogleFonts.poppins(
              color: Color(0xFF5A5A5D),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            suffixIcon: widget.isSecure == null
                ? null
                : IconButton(
                    onPressed: () {
                      widget.isSecure = !widget.isSecure!;
                    },
                    icon: widget.isSecure!
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
            hintStyle: GoogleFonts.poppins(
                color: Color(0xFFBEBEBF),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: widget.hint,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFBEBEBF))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFE0EFFE), width: 3)),
          ),
        )
      ],
    );
  }
}
