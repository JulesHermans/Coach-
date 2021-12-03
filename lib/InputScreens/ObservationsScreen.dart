import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../libary.dart';

class ObservationScreen extends StatefulWidget {
  static String id = 'ObservationsScreen';

  @override
  _ObservationScreenState createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {
  List<Widget> _getObservationsContainers() {
    List<Widget> result = [];
    for (Observation o in obsSes.observations.reversed) {
      Quadrant q = o.getQuadrant();
      Octant oc = o.getOctant();
      Duration d = o.getTime();
      Container c = Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lightBlue, width: kThicknessCompass),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  durationToString(d),
                  style: TextStyle(color: greyText),
                ),
                SizedBox(width: 30),
                Text(
                  q.name + '-' + oc.name,
                  style: TextStyle(
                    color: greyText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                //logging van actie:
                addObservationLog(
                    Log(DateTime.now(), o, LogAction.DeleteObservation));

                setState(() {
                  obsSes.deleteObservation(o);
                });
              },
              icon: Icon(
                Icons.clear,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      );
      result.add(c);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(true),
        centerTitle: true,
        title: Text('Added Observations'),
      ),
      body: ListView(
        children: _getObservationsContainers(),
      ),
    );
  }
}
