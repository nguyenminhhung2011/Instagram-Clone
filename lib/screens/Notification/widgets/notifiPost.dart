import 'package:flutter/material.dart';

class NotifiPost extends StatelessWidget {
  const NotifiPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS00-D7islafjZV9CKVFG5tCMVEVKzyo4O_RwRnhlvNN5jHyqfvo7f0u-FfZMNTczopzbI&usqp=CAU',
            ),
            radius: 25,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Secret class',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " "),
                    TextSpan(text: "is like your post"),
                  ],
                ),
              ),
              Text('Dae ho'),
            ],
          ),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://st.nettruyenhot.com/poster/19010/secret-class-19010.jpg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
