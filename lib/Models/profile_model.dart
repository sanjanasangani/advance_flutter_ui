import 'package:flutter/material.dart';

class ProfileModel {
  bool profileSwitch;

  TextEditingController Name;
  TextEditingController Bio;
  TextEditingController Image;

  ProfileModel({
    required this.profileSwitch,
    required this.Name,
    required this.Bio,
    required this.Image,
  });
}

