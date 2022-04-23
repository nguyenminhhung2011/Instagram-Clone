import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendItem extends StatefulWidget {
  final Map<String, dynamic> snap;
  const SendItem({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<SendItem> createState() => _SendItemState();
}

class _SendItemState extends State<SendItem> {
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
            alignment: Alignment.centerRight,
            child: (widget.snap['typeMessage'] == 0)
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isLoadingDate = !isLoadingDate;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(widget.snap['tittle']),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Image(
                              image: NetworkImage(widget.snap['photoUrl'])),
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
          ),
        ],
      ),
    );
  }
}
