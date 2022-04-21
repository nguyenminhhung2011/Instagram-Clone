import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.all(20),
      color: mobileBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: mobileBackgroundColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 10,
                              height: MediaQuery.of(context).size.height - 80,
                            ),
                          );
                        });
                  },
                  child: Text('Back'),
                ),
                const SizedBox(width: 10),
                Text(
                  'Messenger',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mobileSearchColor,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.search),
                  const SizedBox(width: 10),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        border: InputBorder.none,
                      ),
                      onFieldSubmitted: (String _) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
