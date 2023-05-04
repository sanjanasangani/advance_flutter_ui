import 'package:flutter/material.dart';
import 'package:p_converter/controllers/providers/App_Providers.dart';
import 'package:p_converter/components/calls.dart';
import 'package:p_converter/components/settings.dart';
import 'package:p_converter/components/chats.dart';
import 'package:provider/provider.dart';
import '../../components/addcomponents.dart';

class materialApp extends StatefulWidget {
  const materialApp({Key? key}) : super(key: key);

  @override
  State<materialApp> createState() => _materialAppState();
}

class _materialAppState extends State<materialApp> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Platform converter",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Switch(
              value: Provider.of<AppProvider>(context).appModel.switchVal,
              onChanged: (val) {
                Provider.of<AppProvider>(context, listen: false).changeui();
              },
                )
          ],
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 3,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.only(left: 20, right: 20),
            isScrollable: true,
            tabs: [
              Tab(
                child: Icon(Icons.person_add_alt_outlined),
              ),
              Tab(
                child: Text(
                  "CHATS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "CALLS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            addcomponents(),
            chats(),
            calls(),
            settings(),
          ],
        )
      ),
    );
  }
}
