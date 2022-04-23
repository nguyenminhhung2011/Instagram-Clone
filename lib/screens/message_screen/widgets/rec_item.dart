import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class RecItem extends StatelessWidget {
  final String tittle;
  final String photoUrl;
  final int typeMessage;
  final String linkImage;
  const RecItem({
    Key? key,
    required this.tittle,
    required this.photoUrl,
    required this.typeMessage,
    required this.linkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 18,
            ),
            const SizedBox(width: 5),
            (typeMessage == 0)
                ? Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: mobileSearchColor,
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
          ],
        ),
      ),
    );
  }
}
