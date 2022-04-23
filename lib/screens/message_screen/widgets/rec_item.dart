import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';

class RecItem extends StatefulWidget {
  final String photoUrl;
  final Map<String, dynamic> snap;
  const RecItem({
    Key? key,
    required this.photoUrl,
    required this.snap,
  }) : super(key: key);

  @override
  State<RecItem> createState() => _RecItemState();
}

class _RecItemState extends State<RecItem> {
  bool isLoadingDate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          (isLoadingDate)
              ? Text(
                  DateFormat.yMMMd().format(widget.snap['date'].toDate()),
                  //['Date'].toString(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                )
              : Container(),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                setState(() {
                  isLoadingDate = !isLoadingDate;
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.photoUrl),
                    radius: 18,
                  ),
                  const SizedBox(width: 5),
                  (widget.snap['typeMessage'] == 0)
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: mobileSearchColor,
                          ),
                          child: Text(widget.snap['tittle']),
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Image(
                                    image:
                                        NetworkImage(widget.snap['photoUrl'])),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2 - 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(widget.snap['photoUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
