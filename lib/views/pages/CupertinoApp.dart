import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_converter/components/calls.dart';
import 'package:p_converter/components/chats.dart';
import 'package:p_converter/controllers/providers/App_Providers.dart';
import 'package:provider/provider.dart';

import '../../components/addcomponents.dart';
import '../../components/settings.dart';

class cupertinoapp extends StatefulWidget {
  const cupertinoapp({Key? key}) : super(key: key);

  @override
  State<cupertinoapp> createState() => _cupertinoappState();
}

class _cupertinoappState extends State<cupertinoapp> {
  int initialIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: index,
          onTap: (val) {
            setState(() {
              index = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_add),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: "CHATS"
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: "CALLS",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: "SETTINGS",
            ),
          ],
        ), 
        tabBuilder: (context,index){
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text("Platform Convertor"),
                  trailing:
                  CupertinoSwitch(
                    value: Provider.of<AppProvider>(context).appModel.switchVal,
                    onChanged: (val) {
                      Provider.of<AppProvider>(context, listen: false).changeui();
                    },),
                ),
                child: Center(
                  child: IndexedStack(
                    index: index,
                    children: [
                      addcomponents(),
                      chats(),
                      calls(),
                      settings(),
                    ],
                  ),
                ),
              );
            },
          );
        },
    );
  }
}


