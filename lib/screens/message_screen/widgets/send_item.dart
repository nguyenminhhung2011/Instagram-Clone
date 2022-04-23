import 'package:flutter/material.dart';

class SendItem extends StatelessWidget {
  final String tittle;
  final int typeMessage;
  final String linkImage;
  const SendItem({
    Key? key,
    required this.tittle,
    required this.typeMessage,
    required this.linkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Align(
        alignment: Alignment.centerRight,
        child: (typeMessage == 0)
            ? Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(tittle),
              )
            : Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2 - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(linkImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}
