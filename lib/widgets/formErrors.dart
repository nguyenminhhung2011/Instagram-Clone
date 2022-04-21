import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormError extends StatelessWidget {
  final String errors;

  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormError(errors: errors);
  }

  Row FormErrorText({required String errorText}) {
    return Row(
      children: [
        SvgPicture.asset('assets/Error.svg', height: 16),
        SizedBox(width: 10),
        Text(
          errorText,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
