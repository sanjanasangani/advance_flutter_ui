import 'dart:io';

import 'package:flutter/material.dart';

class variable {
  static TextEditingController name = TextEditingController();
  static TextEditingController phone = TextEditingController();
  static TextEditingController chat = TextEditingController();
}

class ChatModel {
  File? img;
  DateTime? initialDate;
  DateTime? pickDate;
  TimeOfDay? initialtime;
  TimeOfDay? pickTime;

  List<String> fullName;
  List<String> phoneNumber;
  List<String> chatConversation;
  List<String> image;
  List<String> date;
  List<String> time;


  ChatModel({

    this.img,
    this.initialDate,
    this.pickDate,
    this.initialtime,
    this.pickTime,

    required this.fullName,
    required this.phoneNumber,
    required this.chatConversation,
    required this.image,
    required this.date,
    required this.time,

  });

}
