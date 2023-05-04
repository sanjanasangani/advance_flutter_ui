import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p_converter/Models/chat_Models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  ChatModel chatModel;

  ChatProvider({required this.chatModel});

  Camera() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.camera);

    chatModel.img = File(img!.path);
    notifyListeners();
  }

  Gallery() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.gallery);

    chatModel.img = File(img!.path);
    notifyListeners();
  }

  pickDate() async {
    if (chatModel.initialDate != null && chatModel.initialDate != chatModel.pickDate) {chatModel.pickDate = chatModel.initialDate;
    }
    notifyListeners();
  }

  pickTime() async {
    if (chatModel.initialtime != null &&
        chatModel.initialtime != chatModel.pickTime) {
      chatModel.pickTime = chatModel.initialtime;
    }
    notifyListeners();
  }

  saveChat() async {

    chatModel.fullName.add(variable.name.text);
    chatModel.phoneNumber.add(variable.phone.text);
    chatModel.chatConversation.add(variable.chat.text);
    chatModel.image.add(chatModel.img!.path);
    chatModel.date.add("${chatModel.pickDate?.day}/${chatModel.pickDate?.month}/${chatModel.pickDate?.year}");
    chatModel.time.add("${chatModel.pickTime?.hour}:${chatModel.pickTime?.minute}");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    chatModel.img = null;
    variable.name.clear();
    variable.phone.clear();
    variable.chat.clear();
    chatModel.pickDate = null;
    chatModel.pickTime = null;

    prefs.setStringList('fullName', chatModel.fullName);
    prefs.setStringList('phoneNumber', chatModel.phoneNumber);
    prefs.setStringList('chatConversation', chatModel.chatConversation);
    prefs.setStringList('image', chatModel.image);
    prefs.setStringList('date', chatModel.date);
    prefs.setStringList('time', chatModel.time);

    notifyListeners();
  }
}
