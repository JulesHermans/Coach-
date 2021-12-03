import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Data/LoggingData.dart';
import 'Data/ResultData.dart';
import 'libary.dart';

const Color darkBlue = Color(0xFF00407A);
const Color accentDarkBlue = Color(0xFF185D85);
const Color lightBlue = Color(0xFF52BDEC);
const Color greyText = Color(0xFF4d4d4d);
const Color darkGreen = Color(0xFF657153);
const Color darkRed = Color(0xFF92140C);
const Color ownOrange = Color(0XFFCD533B);
const Color ownYellow = Colors.lightGreen;
const double kThicknessCompass = 3;
final double kDiameter = 275;
final Map<Octant, Color> octantColors = {
  autonomySupport.octants[0]: Color(0xFF146094),
  autonomySupport.octants[1]: Color(0xFF1E82CA),
  structure.octants[1]: Color(0xFF257435),
  structure.octants[0]: Color(0xFF3BAD4F),
  control.octants[1]: Color(0xFFA85C23),
  control.octants[0]: Color(0xFFFAB97E),
  chaos.octants[1]: Color(0xFFE96E6A),
  chaos.octants[0]: Color(0xFFA52624),
};
const int passID = 601037;
const Map<String, String> videoUrlID = {
  "vid1": "kk7sPTY2Amk",
  "vid2": "n46mH9CSBO0",
  "vid3": "PMCP7s4fTHI",
};

enum ResultOption {
  Oplossing,
  Observaties,
  Vergelijking,
}

enum VideoOption {
  chronologisch,
  correct,
  incorrect,
  gemist,
  passief,
}
String enumToString(e) {
  if (e == null)
    return null;
  else if (e == Timing.TimeOut)
    return 'Time-Out';
  else if (e == FeedbackOption.deelsCorrect)
    return 'Deels correct';
  else
    return describeEnum(e);
}

String durationToString(Duration d) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
  return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class ButtonBack extends StatelessWidget {
  ButtonBack(this.isObservationScreen);
  bool isObservationScreen;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //logging van actie:
        if (isObservationScreen) {
          addObservationLog(Log(DateTime.now(),
              ModalRoute.of(context).settings.name, LogAction.back));
        } else {
          addFeedbackLog(FBLog(DateTime.now(),
              ModalRoute.of(context).settings.name, LogAction.back));
        }
        Navigator.pop(context);
      },
    );
  }
}

BoxDecoration kVisualButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    color: lightBlue,
    width: kThicknessCompass,
  ),
);

TextStyle kTextStyleOption(bool selected) {
  return TextStyle(
    color: selected ? Colors.white : greyText,
    fontWeight: selected ? FontWeight.w500 : FontWeight.w300,
    fontSize: 14,
  );
}

class BottomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  BottomButton({@required this.onTap, @required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
        decoration: BoxDecoration(
          color: accentDarkBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  SubTitle({@required this.title});
  final String title;
  double symmetricIndent = 115;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: greyText,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Divider(
          color: accentDarkBlue,
          thickness: 2,
          height: 2,
          indent: symmetricIndent,
          endIndent: symmetricIndent,
        ),
        SizedBox(height: 3),
      ],
    );
  }
}

void showDialogWithoutButtons(
    BuildContext context, String title, String message) {
  //logging van de dialog

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          titleTextStyle: _dialogTitleStyle,
          titlePadding:
              EdgeInsets.only(top: 30, left: 30, bottom: 5, right: 30),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: _dialogContentStyle,
          contentPadding:
              EdgeInsets.only(top: 5, left: 10, bottom: 30, right: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: darkBlue, width: kThicknessCompass),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      });
}

void showDialogueWith2Buttons(BuildContext context, String title,
    String message, String textCheckButton, Function onPressedCheck) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          titleTextStyle: _dialogTitleStyle,
          titlePadding:
              EdgeInsets.only(top: 30, left: 30, bottom: 5, right: 30),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: _dialogContentStyle,
          contentPadding:
              EdgeInsets.only(top: 5, left: 10, bottom: 30, right: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: darkBlue, width: kThicknessCompass),
            borderRadius: BorderRadius.circular(10),
          ),
          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          actions: <Widget>[
            FlatButton.icon(
              color: darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel, color: Colors.white),
              label: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            FlatButton.icon(
              color: darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: onPressedCheck,
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              label:
                  Text(textCheckButton, style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      });
}

TextStyle _dialogTitleStyle = TextStyle(
  color: greyText,
  fontSize: 22,
  fontWeight: FontWeight.w800,
);

TextStyle _dialogContentStyle = TextStyle(
  color: greyText,
  fontSize: 18,
  fontWeight: FontWeight.w400,
);

class XButtons extends StatelessWidget {
  XButtons(
      {@required this.text,
      @required this.onTap,
      @required this.isCompassParameter});
  final String text;
  final bool isCompassParameter;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: isCompassParameter ? 80 : 60,
          decoration: BoxDecoration(
              color: accentDarkBlue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: lightBlue,
                width: 2,
              )),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class QuadrantField extends StatelessWidget {
  QuadrantField(
      {@required this.quadrant,
      @required this.radius,
      @required this.startAngle,
      @required this.textAlignment,
      @required this.color});
  final Quadrant quadrant;
  final double radius;
  final int startAngle;
  final Alignment textAlignment;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      child: Stack(
        children: <Widget>[
          PaintContainer(
              radius: radius,
              color: color,
              startAngle: startAngle,
              isQuadrant: true),
          Align(
            alignment: textAlignment,
            child: Text(
              quadrant.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: greyText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaintContainer extends StatelessWidget {
  const PaintContainer({
    Key key,
    @required this.radius,
    @required this.color,
    @required this.startAngle,
    @required this.isQuadrant,
    this.isFilled,
    this.isUserObs,
  }) : super(key: key);

  final double radius;
  final Color color;
  final int startAngle;
  final bool isQuadrant;
  final bool isFilled;
  final bool isUserObs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDiameter / 2,
      width: kDiameter / 2,
      child: CustomPaint(
        painter: isQuadrant
            ? QuadrantPainter(
                color: color,
                startAngle: startAngle,
                radius: radius,
              )
            : OctantPainter(
                radius: radius,
                startAngle: startAngle,
                color: color,
                isFilled: isFilled,
                isUserObs: isUserObs,
              ),
      ),
    );
  }
}

class QuadrantPainter extends CustomPainter {
  QuadrantPainter({
    @required this.startAngle,
    @required this.radius,
    @required this.color,
  });
  final double strokeWidth = kThicknessCompass;
  final double radius;
  final int startAngle;
  final Color color;

  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;

    var quadrantPath = Path();
    Rect arcRect;
    if (startAngle == 0) {
      arcRect = Rect.fromCircle(center: Offset(0, 0), radius: radius);
      quadrantPath.moveTo(0, size.height);
      quadrantPath.lineTo(0, 0);
      quadrantPath.lineTo(size.width, 0);
    }
    if (startAngle == 90) {
      arcRect = Rect.fromCircle(center: Offset(size.width, 0), radius: radius);
      quadrantPath.lineTo(size.width, 0);
      quadrantPath.lineTo(size.width, size.height);
    }
    if (startAngle == 180) {
      arcRect = Rect.fromCircle(
          center: Offset(size.width, size.height), radius: radius);
      quadrantPath.moveTo(size.width, 0);
      quadrantPath.lineTo(size.width, size.height);
      quadrantPath.lineTo(0, size.height);
    }
    if (startAngle == 270) {
      arcRect = Rect.fromCircle(center: Offset(0, size.height), radius: radius);
      quadrantPath.moveTo(size.width, size.height);
      quadrantPath.lineTo(0, size.height);
      quadrantPath.lineTo(0, 0);
    }
    quadrantPath.arcTo(arcRect, degToRad(startAngle), degToRad(90), true);
    canvas.drawPath(quadrantPath, paint);
  }

  @override
  bool shouldRepaint(QuadrantPainter t) => false;
}

class OctantPainter extends CustomPainter {
  OctantPainter({
    @required this.radius,
    @required this.startAngle,
    @required this.color,
    @required this.isFilled,
    @required this.isUserObs,
  });

  final double radius;
  final int startAngle;
  final Color color;
  final bool isFilled;
  final bool isUserObs;

  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = isUserObs ? kThicknessCompass + 3 : kThicknessCompass;
    double circlePointWidth = cos(degToRad(45)) * radius;
    double circlePointHeight = sin(degToRad(45)) * radius;
    var paint = Paint();
    paint.color = color;
    paint.style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;

    var octantPath = Path();
    Rect arcRect;

    if (startAngle == 0) {
      arcRect = Rect.fromCircle(center: Offset(0, 0), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(circlePointWidth, circlePointHeight);
        octantPath.lineTo(0, 0);
        octantPath.lineTo(radius, 0);
      }
    }
    if (startAngle == 45) {
      arcRect = Rect.fromCircle(center: Offset(0, 0), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(0, radius);
        octantPath.lineTo(0, 0);
        octantPath.lineTo(circlePointWidth, circlePointHeight);
      }
    }
    if (startAngle == 90) {
      arcRect = Rect.fromCircle(center: Offset(size.width, 0), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(size.width - circlePointWidth, circlePointHeight);
        octantPath.lineTo(size.width, 0);
        octantPath.lineTo(size.width, radius);
      }
    }
    if (startAngle == 135) {
      arcRect = Rect.fromCircle(center: Offset(size.width, 0), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(size.width - radius, 0);
        octantPath.lineTo(size.width, 0);
        octantPath.lineTo(size.width - circlePointWidth, circlePointHeight);
      }
    }
    if (startAngle == 180) {
      arcRect = Rect.fromCircle(
          center: Offset(size.width, size.height), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(
            size.width - circlePointWidth, size.height - circlePointHeight);
        octantPath.lineTo(size.width, size.height);
        octantPath.lineTo(size.width - radius, size.height);
      }
    }
    if (startAngle == 225) {
      arcRect = Rect.fromCircle(
          center: Offset(size.width, size.height), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(size.width, size.height - radius);
        octantPath.lineTo(size.width, size.height);
        octantPath.lineTo(
            size.width - circlePointWidth, size.height - circlePointHeight);
      }
    }
    if (startAngle == 270) {
      arcRect = Rect.fromCircle(center: Offset(0, size.height), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(circlePointWidth, size.height - circlePointHeight);
        octantPath.lineTo(0, size.height);
        octantPath.lineTo(0, size.height - radius);
      }
    }
    if (startAngle == 315) {
      arcRect = Rect.fromCircle(center: Offset(0, size.height), radius: radius);
      if (!isUserObs) {
        octantPath.moveTo(radius, size.height);
        octantPath.lineTo(0, size.height);
        octantPath.lineTo(circlePointWidth, size.height - circlePointHeight);
      }
    }

    octantPath.arcTo(arcRect, degToRad(startAngle), degToRad(45), true);
    canvas.drawPath(octantPath, paint);
  }

  @override
  bool shouldRepaint(OctantPainter t) => false;
}
