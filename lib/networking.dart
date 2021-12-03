import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

const String serverUrl = 'http://picasso.experiments.cs.kuleuven.be:3980';
const String hasseltUrl = 'http://192.168.0.114:3980';
const String ZutendaalUrl = 'http://192.168.0.127:3980';
const String LeuvenUrl = 'http://192.168.0.113:3980';
const String url = hasseltUrl;

Future<bool> checkID(String inputID) async {
  try {
    var response = await http.get(
      url + '/checkUserID?ID=' + inputID,
    );
    if (response.body == inputID) return true;
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<int> sendFeedbackLogs(List<Map<String, dynamic>> logs) async {
  try {
    var response = await http.post(
      url + '/feedbackLogs',
      body: {
        'feedbackLogs': jsonEncode(logs),
      },
    );
    return response.statusCode;
  } catch (e) {
    print(e);
    return 500;
  }
}

Future<int> sendLogs(
  List<Map<String, dynamic>> logs,
  List<Map<String, dynamic>> obs,
  BuildContext context,
) async {
  try {
    var response = await http.post(
      url + '/logs',
      body: {
        'logs': jsonEncode(logs),
        'observations': jsonEncode(obs),
      },
    );
    return response.statusCode;
  } catch (e) {
    print(e);
    return 500;
  }
}
/*
Future<String> getObs() async {
  var response = await http.get(url + '/testObs');
  return response.body;
}*/

Future<String> getSol(String vid) async {
  var response = await http.get(url + '/solution' + vid);
  return response.body;
}

String getVideoUrl() {
  return "https://youtu.be/gPn-UdIyysQ";
}
