import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/profile_model.dart';


class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel;
  ProfileProvider({required this.profileModel});

  changeProfileSwitchValue() async {
    profileModel.profileSwitch = !profileModel.profileSwitch;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('profileSwitch', profileModel.profileSwitch);
    notifyListeners();
  }
  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Image', profileModel.Image.text);
    prefs.setString('Name', profileModel.Name.text);
    prefs.setString('Bio', profileModel.Bio.text);

    notifyListeners();
  }

  clear() async {
    profileModel.Name.clear();
    profileModel.Bio.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Image', profileModel.Image.text);
    prefs.setString('Name', profileModel.Name.text);
    prefs.setString('Bio', profileModel.Bio.text);


    notifyListeners();
  }
}
