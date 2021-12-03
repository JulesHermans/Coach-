import 'package:coachthecoach/Data/sessionData.dart';
import 'package:coachthecoach/FlowScreens/SelectSessionScreen.dart';
import 'package:coachthecoach/InputScreens/QuadrantScreen.dart';
import 'package:coachthecoach/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class StartScreen extends StatefulWidget {
  static String id = 'StartScreen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int inputID;
  int checkID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Coach the Coach'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
            child: Image.asset('images/KUL logo.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
                child: TextField(
                  onChanged: (String newValue) {
                    inputID = num.tryParse(newValue);
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Enter ID',
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: lightBlue),
                    ),
                  ),
                ),
              ),
              BottomButton(
                text: 'Start sessie',
                onTap: () async {
                  if (inputID == null) {
                    showDialogWithoutButtons(context, 'Incorrect ID',
                        'Please enter an ID before starting a session.');
                    /*} else if (!await checkID(inputID.toString())) {
                    showDialogWithoutButtons(context, 'Incorrect ID',
                        'The ID you entered is incorrect.\n Please try again.');*/
                  } else {
                    initSession(inputID);
                    Navigator.pushNamed(context, QuadrantScreen.id);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
