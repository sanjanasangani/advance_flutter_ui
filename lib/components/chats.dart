import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_converter/controllers/providers/App_Providers.dart';
import 'package:p_converter/controllers/providers/chat_Providers.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class chats extends StatefulWidget {
  const chats({Key? key}) : super(key: key);

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Provider.of<AppProvider>(context).appModel.switchVal == false)
      ? (Provider.of<ChatProvider>(context)
          .chatModel
          .fullName
          .isEmpty)
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No any chats yet...",
            )
          ],
        ),
      )
          : ListView.builder(
        itemBuilder: (Context, i) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(
                File(
                  Provider.of<ChatProvider>(context)
                      .chatModel
                      .image[i],
                ),
              ),
            ),
            title: Text(
              Provider.of<ChatProvider>(context)
                  .chatModel
                  .fullName[i],),
            subtitle: Text(Provider.of<ChatProvider>(context)
                .chatModel
                .chatConversation[i],),
            trailing: Text(
                "${Provider.of<ChatProvider>(context, listen: false).chatModel.date[i]}, ${Provider.of<ChatProvider>(context, listen: false).chatModel.time[i]}",
            ),
            );
        },
        itemCount: Provider.of<ChatProvider>(context).chatModel.fullName.length,
      )
      : (Provider.of<ChatProvider>(context)
          .chatModel
          .fullName
          .isEmpty)
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No any chats yet...",
            )
          ],
        ),
      )
          : CupertinoListSection(
    children: List.generate(
    Provider.of<ChatProvider>(context)
        .chatModel
        .fullName
        .length,
    (i) => CupertinoListTile(
      leading: CircleAvatar(
        radius: 70,
        foregroundImage: FileImage(
          File(
            Provider.of<ChatProvider>(context)
                .chatModel
                .image[i],
          ),
        ),
      ),
      title: Text(Provider.of<ChatProvider>(context).chatModel.fullName[i],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        Provider.of<ChatProvider>(context)
            .chatModel
            .chatConversation[i],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        "${Provider.of<ChatProvider>(context, listen: false).chatModel.date[i]}, ${Provider.of<ChatProvider>(context, listen: false).chatModel.time[i]}",
      ),
    ),
    ),
    ),
    );
  }
}
