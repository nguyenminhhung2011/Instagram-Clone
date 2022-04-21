import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Button_Design extends StatelessWidget {
  final String content;
  final Function() press;
  final bool ishaveIcon;
  final Icon icon;
  final bool isLoading;
  const Button_Design({
    Key? key,
    required this.content,
    required this.press,
    required this.isLoading,
    this.ishaveIcon = false,
    this.icon = const Icon(Icons.facebook),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: press,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: blueColor,
          ),
          child: (isLoading)
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (ishaveIcon) icon,
                    const SizedBox(width: 5),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
