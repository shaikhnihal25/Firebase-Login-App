import 'package:flutter/material.dart';
import 'package:test_app/utils/iColors.dart';

class InputTile extends StatefulWidget {
  String title;
  String placeholder;
  Icon icon;
  double top;
  TextEditingController controller;
  TextInputType? type;
  bool secured;
  InputTile(
      {Key? key,
      required this.title,
      required this.placeholder,
      required this.icon,
      required this.top,
      required this.controller,
      this.type,
      required this.secured})
      : super(key: key);

  @override
  State<InputTile> createState() => _InputTileState();
}

class _InputTileState extends State<InputTile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height / widget.top, left: width / 15),
          child: Text(
            widget.title,
            style: TextStyle(
                color: IColors.offWhite,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 20, top: height / 80),
          child: Container(
            height: height / 18,
            width: width / 1.1,
            decoration: BoxDecoration(
                color: IColors.input, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.only(left: width / 30),
              child: TextFormField(
                style: TextStyle(color: IColors.offWhite),
                obscureText: widget.secured,
                keyboardType: widget.type,
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(color: IColors.icon),
                    border: InputBorder.none,
                    suffixIcon: widget.icon),
              ),
            ),
          ),
        )
      ],
    );
  }
}
