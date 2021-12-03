import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../libary.dart';

class Button1RestScreen extends StatefulWidget {
  static String id = 'Button1Screen2';
  @override
  _Button1RestScreenState createState() => _Button1RestScreenState();
}

class _Button1RestScreenState extends State<Button1RestScreen> {
  final double containerHeight = 40;
  Quadrant selectedQuadrant;
  Octant selectedOctant;
  String selectedBuildingBlock;
  Audience selectedAudience;
  CorType selectedCorType;

  GestureDetector getFourOptionContainer(BoxConstraints constraints, var option,
      bool isAudience, BorderRadius border) {
    var toCheckOption = isAudience ? selectedAudience : selectedCorType;
    bool selected = toCheckOption == option;
    return GestureDetector(
      onTap: () {
        //logging van acties:
        isAudience
            ? selectedAudience == null
                ? addObservationLog(
                    Log(DateTime.now(), option, LogAction.selectAudience))
                : addObservationLog(
                    Log(DateTime.now(), option, LogAction.changeAudience))
            : selectedCorType == null
                ? addObservationLog(
                    Log(DateTime.now(), option, LogAction.selectCorType))
                : addObservationLog(
                    Log(DateTime.now(), option, LogAction.changeCorType));

        setState(() {
          isAudience ? selectedAudience = option : selectedCorType = option;
        });
      },
      child: Container(
        width: constraints.maxWidth / 2,
        height: containerHeight,
        decoration: BoxDecoration(
          color: selected ? lightBlue : Colors.white,
          borderRadius: border,
        ),
        child: Center(
          child: Text(
            describeEnum(option),
            style: kTextStyleOption(selected),
          ),
        ),
      ),
    );
  }

  GestureDetector getOctantContainer(
      BoxConstraints constraints, Octant octant) {
    bool selected = selectedOctant == octant;
    String octantName = octant.name;
    return GestureDetector(
      onTap: () {
        //logging van acties:
        selectedOctant == null
            ? addObservationLog(
                Log(DateTime.now(), octant, LogAction.selectOctant))
            : addObservationLog(
                Log(DateTime.now(), octant, LogAction.changeOctant));

        setState(() {
          selectedBuildingBlock = null;
          selectedOctant = octant;
        });
      },
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 15),
        width: constraints.maxWidth / 2,
        height: containerHeight,
        decoration: BoxDecoration(
          color: selected ? lightBlue : Colors.white,
          borderRadius: selectedQuadrant.octants[0] == octant
              ? BorderRadius.only(
                  topLeft: Radius.circular(17), bottomLeft: Radius.circular(17))
              : BorderRadius.only(
                  topRight: Radius.circular(17),
                  bottomRight: Radius.circular(17)),
        ),
        child: Center(
          child: Text(
            '$octantName',
            style: kTextStyleOption(selected),
          ),
        ),
      ),
    );
  }

  List<GestureDetector> getBuildingBlockContainers(
      List<String> buildingBlocks) {
    List<GestureDetector> result = [];
    int length = buildingBlocks.length;
    for (int i = 0; i < length; i++) {
      bool selected = selectedBuildingBlock == buildingBlocks[i];
      GestureDetector bb = GestureDetector(
        onTap: () {
          //logging van acties:
          selectedBuildingBlock == null
              ? addObservationLog(Log(DateTime.now(), buildingBlocks[i],
                  LogAction.selectBuildingBlock))
              : addObservationLog(Log(DateTime.now(), buildingBlocks[i],
                  LogAction.changeBuildingBlock));

          setState(() {
            selectedBuildingBlock = buildingBlocks[i];
          });
        },
        child: Container(
          //padding: EdgeInsets.symmetric(vertical: 10),
          height: containerHeight,
          //height: constraints.maxHeight / length,
          decoration: BoxDecoration(
            color: selected ? lightBlue : Colors.white,
            borderRadius: i == 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(17), topRight: Radius.circular(17))
                : i == length - 1
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17))
                    : BorderRadius.circular(0),
          ),
          child: Center(
            child: Text(
              buildingBlocks[i],
              textAlign: TextAlign.center,
              style: kTextStyleOption(selected),
            ),
          ),
        ),
      );
      result.add(bb);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    selectedQuadrant = obsSes.newObservation.getQuadrant();
    String quadrantName = selectedQuadrant.name;
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(true),
        centerTitle: true,
        title: Text(
          'Kwadrant: $quadrantName',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child:
                    SizedBox()), //deze weghalen indien terug naar vorige versie
            Column(
              children: <Widget>[
                SubTitle(title: 'Octant'),
                Container(
                  decoration: kVisualButtonDecoration,
                  margin: EdgeInsets.only(bottom: 20),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        children: <Widget>[
                          getOctantContainer(
                              constraints, selectedQuadrant.octants[0]),
                          getOctantContainer(
                              constraints, selectedQuadrant.octants[1]),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SubTitle(title: 'Bouwsteen'),
                selectedOctant == null
                    ? Container(
                        decoration: kVisualButtonDecoration,
                        height: containerHeight * 2,
                      )
                    : Container(
                        decoration: kVisualButtonDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: getBuildingBlockContainers(
                              selectedOctant.buildingBlocks),
                        ),
                      ),
              ],
            ),
            Expanded(
                child:
                    SizedBox()), //deze weghalen indien terug naar vorige versie

            Column(
              children: <Widget>[
                SubTitle(title: 'Audience'),
                Container(
                  decoration: kVisualButtonDecoration,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              getFourOptionContainer(
                                  constraints,
                                  Audience.Individu,
                                  true,
                                  BorderRadius.only(
                                      topLeft: Radius.circular(17))),
                              getFourOptionContainer(
                                  constraints,
                                  Audience.Team,
                                  true,
                                  BorderRadius.only(
                                      bottomLeft: Radius.circular(17))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              getFourOptionContainer(
                                  constraints,
                                  Audience.Groep,
                                  true,
                                  BorderRadius.only(
                                      topRight: Radius.circular(17))),
                              getFourOptionContainer(
                                  constraints,
                                  Audience.Andere,
                                  true,
                                  BorderRadius.only(
                                      bottomRight: Radius.circular(17))),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SubTitle(title: 'Correction type'),
                Container(
                  decoration: kVisualButtonDecoration,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              getFourOptionContainer(
                                  constraints,
                                  CorType.Techniek,
                                  false,
                                  BorderRadius.only(
                                      topLeft: Radius.circular(17))),
                              getFourOptionContainer(
                                  constraints,
                                  CorType.Attitude,
                                  false,
                                  BorderRadius.only(
                                      bottomLeft: Radius.circular(17))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              getFourOptionContainer(
                                  constraints,
                                  CorType.Tactiek,
                                  false,
                                  BorderRadius.only(
                                      topRight: Radius.circular(17))),
                              getFourOptionContainer(
                                  constraints,
                                  CorType.Andere,
                                  false,
                                  BorderRadius.only(
                                      bottomRight: Radius.circular(17))),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            BottomButton(
              onTap: () {
                if (selectedOctant == null || selectedBuildingBlock == null) {
                  showDialogWithoutButtons(context, 'Incorrecte observatie',
                      'Er is geen octant en/of bouwsteen geselecteerd. Gelieve eerst een octant en bouwsteen te selecteren.');
                } else {
                  obsSes.newObservation.setOctant(selectedOctant);
                  obsSes.newObservation.setBuildingBlock(selectedBuildingBlock);
                  obsSes.newObservation.setAudience(selectedAudience);
                  obsSes.newObservation.setCorType(selectedCorType);

                  //logging van actie:
                  addObservationLog(Log(
                    DateTime.now(),
                    obsSes.newObservation,
                    LogAction.addBehaviour,
                  ));

                  Navigator.pop(context);
                  obsSes.addNewObservation();
                }
              },
              text: 'Observatie toevoegen',
            ),
          ],
        ),
      ),
    );
  }
}
