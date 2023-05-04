import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_converter/Models/chat_Models.dart';
import 'package:p_converter/controllers/providers/App_Providers.dart';
import 'package:p_converter/controllers/providers/chat_Providers.dart';
import 'package:p_converter/views/pages/CupertinoApp.dart';
import 'package:p_converter/views/pages/MaterialApp.dart';
import 'package:p_converter/components/calls.dart';
import 'package:p_converter/components/settings.dart';
import 'package:p_converter/components/chats.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p_converter/Models/Theme_Modals.dart';
import 'package:p_converter/controllers/providers/Theme_Providers.dart';
import 'package:p_converter/utils/app_themes.dart';
import 'Models/App_Models.dart';
import 'Models/profile_model.dart';
import 'controllers/providers/profile_provider.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isDarkTheme = prefs.getBool('isDark')??false;

  bool profileSwitch = prefs.getBool('profileSwitch') ?? false;

  String Image = prefs.getString('Image') ?? '';
  String Name = prefs.getString('Name') ?? '';
  String Bio = prefs.getString('Bio') ?? '';

  bool Switch = prefs.getBool('Switch') ?? false;

  List<String> fullName = prefs.getStringList('fullName') ?? [];
  List<String> phoneNumber = prefs.getStringList('phoneNumber') ?? [];
  List<String> chatConversation = prefs.getStringList('chatConversation') ?? [];
  List<String> image = prefs.getStringList('image') ?? [];
  List<String> date = prefs.getStringList('date') ?? [];
  List<String> time = prefs.getStringList('time') ?? [];

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider(themeModel: ThemeModel(isDark: isDarkTheme))),
          ChangeNotifierProvider(create: (context) => AppProvider(appModel: AppModel(switchVal: Switch),),),
          ChangeNotifierProvider(create: (context) => ChatProvider(chatModel: ChatModel(fullName: fullName, phoneNumber: phoneNumber, chatConversation: chatConversation, image: image, date: date, time: time,),),),
          ChangeNotifierProvider(create: (context) => ProfileProvider(profileModel: ProfileModel(profileSwitch: profileSwitch,Name: TextEditingController(text: Name), Bio: TextEditingController(text: Bio),Image: TextEditingController(text: Image),),),),
        ],
        builder: (context,_) {
          return (Provider.of<AppProvider>(context).appModel.switchVal == false)
              ? MaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode:
            (Provider.of<ThemeProvider>(context).themeModel.isDark == false)
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            routes:  {
              '/' : (context) => materialApp(),
              'calls': (context) =>calls(),
              'settings': (context) =>settings(),
              'chats': (context) =>chats(),
            },
          )
              : CupertinoApp(
            theme: CupertinoThemeData(
                brightness: (Provider.of<ThemeProvider>(context).themeModel.isDark == false)
                    ? Brightness.light
                    : Brightness.dark
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/' : (context) => cupertinoapp(),
              'calls': (context) =>calls(),
              'settings': (context) =>settings(),
              'chats': (context) =>chats(),


            },
          );
        },
      )
  );
}