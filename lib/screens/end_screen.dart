import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app3/constants.dart';

class EndPage extends StatefulWidget {
  const EndPage({super.key});

  @override
  State<EndPage> createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IMAEGIS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Colors.grey[850],
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/img1.png'),
                height: 500,
                width: 500,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Text(
                  'Your file was Encrypted/Decrypted successfully',
                  style: kButtonStyle,
                  textAlign: TextAlign.center,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text(
                "Please check the 'MyEncFolder' in your Internal Storage",
                style: kButtonStyle,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
