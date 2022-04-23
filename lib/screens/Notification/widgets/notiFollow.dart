import 'package:flutter/material.dart';

class notiFollow extends StatelessWidget {
  const notiFollow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'http://t2.gstatic.com/licensed-image?q=tbn:ANd9GcSVbUweKhuzxgjDmAdsya_O4JDJFsVylP6mfsgbpW4l4w7lFmnCULPEvFzZxder',
            ),
            radius: 25,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Yua Mikami',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " "),
                    TextSpan(text: "started following you"),
                  ],
                ),
              ),
              Text('Sex Actor'),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('Follow'),
            ),
          ),
        ],
      ),
    );
  }
}
