import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../controllers/providers/Theme_Providers.dart';
import '../controllers/providers/App_Providers.dart';
import '../controllers/providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  File? image;

  Future<void> Camera() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        image = File(img.path);
      });
    }
  }

  Future<void> gallery() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = File(img.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return (Provider.of<AppProvider>(context).appModel.switchVal == false)
    ? Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                title: Text("Profile",
                ),
               subtitle: Text("Update Profile Data",
                  ),
               onChanged: (val){
                 Provider.of<ProfileProvider>(context, listen: false).changeProfileSwitchValue();
               },
               value: Provider.of<ProfileProvider>(context).profileModel.profileSwitch,
              ),
            ),
            (Provider.of<ProfileProvider>(context, listen: false).profileModel.profileSwitch)
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                      CircleAvatar(
                    radius: 60,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Your Image",
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        Camera();
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text("Camera"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        gallery();
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.photo),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text("Gallery"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: Provider.of<ProfileProvider>(context).profileModel.Name,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your name..."),
                  ),
                  TextFormField(
                    controller: Provider.of<ProfileProvider>(context).profileModel.Bio,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your bio..."),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       TextButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false).save();
                        },
                        child: const Text("SAVE"),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false).clear();
                        },
                        child: const Text("CLEAR"),
                      )
                      ],
                  ),
                    ],
                  ),
            )
                : Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwitchListTile(
                title: Text("Theme",
                  // style: TextStyle(
                  //   fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  // ),
                ),
                subtitle: Text("Change Theme",
                  // style: TextStyle(
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                onChanged: (val) {
                  Provider.of<ThemeProvider>(context, listen: false).ChangeTheme();
                },
                value: Provider.of<ThemeProvider>(context).themeModel.isDark,
              ),
            ),
              ],
            )
      )
    : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoListTile(
                title: Text("Profile",
                ),
                subtitle: Text("Update Profile Data",
                ),
                trailing: CupertinoSwitch(
                  onChanged: (val){
                    Provider.of<ProfileProvider>(context, listen: false).changeProfileSwitchValue();
                  },
                  value: Provider.of<ProfileProvider>(context).profileModel.profileSwitch,
                ),
              ),
            ),
            (Provider.of<ProfileProvider>(context, listen: false).profileModel.profileSwitch)
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 60,
                    child: CupertinoButton(
                        onPressed: (){
                          showCupertinoDialog(
                              context: context,
                              builder: (context){
                                return CupertinoAlertDialog(
                                  title: Center(
                                    child: Text("Picked Image"),
                                  ),
                                  content: Text("your choice image"),
                                  actions: [
                                    CupertinoDialogAction(child: Text("Camera"),
                                      onPressed: (){
                                        setState(() {
                                          Camera();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    CupertinoDialogAction(child: Text("Gallery"),
                                      onPressed: (){
                                        setState(() {
                                          gallery();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(child: Text("Cancle"),
                                      onPressed: (){
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: Icon(CupertinoIcons.camera,
                          color: CupertinoColors.white,)
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextFormFieldRow(
                    controller: Provider.of<ProfileProvider>(context).profileModel.Name,
                    placeholder: "Enter your name...",
                    textAlign: TextAlign.center,

                  ),
                  CupertinoTextFormFieldRow(
                    controller: Provider.of<ProfileProvider>(context).profileModel.Bio,
                    placeholder: "Enter your bio...",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false).save();
                        },
                        child: const Text("SAVE"),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false).clear();
                        },
                        child: const Text("CLEAR"),
                      )
                    ],
                  ),
                ],
              ),
            )
                : Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoListTile(
                title: Text("Theme",

                ),
                subtitle: Text("Change Theme",
                ),
                trailing: CupertinoSwitch(
                  onChanged: (val) {
                    Provider.of<ThemeProvider>(context, listen: false).ChangeTheme();
                  },
                  value: Provider.of<ThemeProvider>(context).themeModel.isDark,
                ),

              ),
            ),
          ],
        )
    );
  }
}
