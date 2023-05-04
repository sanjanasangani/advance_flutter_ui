import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_converter/Models/chat_Models.dart';
import 'package:p_converter/Models/chat_Models.dart';
import 'package:p_converter/controllers/providers/chat_Providers.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../controllers/providers/App_Providers.dart';

class addcomponents extends StatefulWidget {
  const addcomponents({Key? key}) : super(key: key);

  @override
  State<addcomponents> createState() => _addcomponentsState();
}

class _addcomponentsState extends State<addcomponents> {
  int initialIndex = 0;
  TimeOfDay picktime = TimeOfDay.now();
  File? image;
  DateTime initialDate = DateTime.now();
  DateTime? pickedDate;
  DateTime initialTime = DateTime.now();

  // Future<void> Camera() async {
  //   ImagePicker pick = ImagePicker();
  //   XFile? img = await pick.pickImage(source: ImageSource.camera);
  //   if (img != null) {
  //     setState(() {
  //       image = File(img.path);
  //     });
  //   }
  // }
  //
  // Future<void> gallery() async {
  //   ImagePicker pick = ImagePicker();
  //   XFile? img = await pick.pickImage(source: ImageSource.gallery);
  //   if (img != null) {
  //     setState(() {
  //       image = File(img.path);
  //     });
  //   }
  // }
  GlobalKey<FormState> add_contact_key = GlobalKey<FormState>();
  //
  // GlobalKey<FormState> Name = GlobalKey<FormState>();
  // GlobalKey<FormState> Phone = GlobalKey<FormState>();
  // GlobalKey<FormState> conversation = GlobalKey<FormState>();
  // GlobalKey<FormState> pick_time = GlobalKey<FormState>();
  // GlobalKey<FormState> pick_date = GlobalKey<FormState>();
  //
  //
  // final TextEditingController first_name_controller = TextEditingController();
  // final TextEditingController phone_num_controller = TextEditingController();
  // final TextEditingController Conversation_controller = TextEditingController();
  //
  // String? firstName;
  // String? phoneNumber;
  // String? coversation;
  // String? pickedtime;
  // String? pickdate;

  @override
  Widget build(BuildContext context) {
    return (Provider.of<AppProvider>(context).appModel.switchVal == false)
        ? SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 40),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  foregroundImage:
                  (Provider.of<ChatProvider>(context).chatModel.img != null)
                      ? FileImage(Provider.of<ChatProvider>(context).chatModel.img!)
                      : FileImage(File('')),
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
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
                                  Provider.of<ChatProvider>(context, listen: false).Camera();
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
                                  Provider.of<ChatProvider>(context, listen: false).Gallery();
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
                  child: Icon(Icons.add),
                  mini: true,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: add_contact_key,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your first name first";
                        }
                        return null;
                      },
                      controller: variable.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        labelText: "Full Name",
                        hintText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your phone number first...";
                        }
                        else if(val.length != 10){
                          return "Invalid length";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: variable.phone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone Number",
                        hintText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your conversation first...";
                        }
                        return null;
                      },
                      controller: variable.chat,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.message_outlined),
                        labelText: "Chat Conversation",
                        hintText: "Chat Conversation",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                Provider.of<ChatProvider>(context, listen: false)
                                    .chatModel
                                    .initialDate = await  showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2025),
                                  cancelText: 'Dismiss',
                                  confirmText: 'Confirm',
                                  helpText: 'Select form date',
                                );
                                Provider.of<ChatProvider>(context, listen: false).pickDate();
                              },

                              icon: Icon(
                                Icons.date_range_outlined,
                                size: 30,
                              )),
                          SizedBox(width: 10),
                          (Provider.of<ChatProvider>(context, listen: false)
                              .chatModel
                              .pickDate !=
                              null)
                              ? Text(
                            "${Provider.of<ChatProvider>(context).chatModel.pickDate?.day} / ${Provider.of<ChatProvider>(context).chatModel.pickDate?.month} / ${Provider.of<ChatProvider>(context).chatModel.pickDate?.year}",
                          )
                              : const Text("Pick Date"),
                ],
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [

                          IconButton(
                              onPressed: () async {
                                Provider.of<ChatProvider>(context, listen: false)
                                    .chatModel
                                    .initialtime = await showTimePicker(
                                    context: context, initialTime: picktime);
                                Provider.of<ChatProvider>(context, listen: false)
                                    .pickTime();
                              },
                              icon: Icon(
                                Icons.access_time_rounded,
                                size: 30,
                              )),
                          SizedBox(width: 10),
                          (Provider.of<ChatProvider>(context, listen: false)
                              .chatModel
                              .pickTime !=
                              null)
                              ? Text(
                            "${Provider.of<ChatProvider>(context).chatModel.pickTime?.hour} : ${Provider.of<ChatProvider>(context).chatModel.pickTime?.minute}",
                          )
                              : const Text("Pick Time"),
                        ],
                      ),
                    ),
                    OutlinedButton(onPressed: () {
                      if (add_contact_key.currentState!.validate() &&
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatModel
                              .img != null &&
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatModel
                              .pickDate != null &&
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatModel
                              .pickTime != null) {
                        Provider.of<ChatProvider>(context, listen: false).saveChat();
                      }
                    }, child: Text("SAVE")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
      : SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
          ),
          CircleAvatar(
            radius: 70,
            foregroundImage:(Provider.of<ChatProvider>(context).chatModel.img != null)
                ? FileImage(Provider.of<ChatProvider>(context).chatModel.img!)
                : FileImage(File('')),
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
                                Provider.of<ChatProvider>(context, listen: false).Camera();
                              },
                            ),
                            CupertinoDialogAction(child: Text("Gallery"),
                              onPressed: (){
                                Provider.of<ChatProvider>(context, listen: false).Gallery();
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(child: Text("Cancle"),
                              onPressed: (){
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
                child: Icon(CupertinoIcons.photo_camera,
                  color: CupertinoColors.white,)
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            key: add_contact_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoTextFormFieldRow(
                    validator: (val){
                      if(val!.isEmpty){
                        return "Enter your first name first";
                      }
                      return null;
                    },
                    controller: variable.name,
                    placeholder: "Full Name",
                    prefix: Icon(CupertinoIcons.person),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.inactiveGray,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
                CupertinoTextFormFieldRow(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter your phone number first...";
                      }
                      else if(val.length != 10){
                        return "Invalid length";
                      }
                      return null;
                    },
                    controller: variable.phone,
                    placeholder: "Phone Number",
                    keyboardType: TextInputType.number,
                    prefix: Icon(CupertinoIcons.phone),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.inactiveGray,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
                CupertinoTextFormFieldRow(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter your conversation first...";
                      }
                      return null;
                    },
                    controller: variable.chat,
                    placeholder: "Chat Conversation",
                    prefix:  Icon(CupertinoIcons.chat_bubble_text),


                    decoration: BoxDecoration(

                      border: Border.all(
                        color: CupertinoColors.inactiveGray,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CupertinoButton(child: Icon(CupertinoIcons.calendar),
                      onPressed: (){
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            height: 300,
                            color: Colors.white,
                            child:  CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              minimumYear: 2023,
                              maximumYear: 2040,
                              onDateTimeChanged: (val) {
                                Provider.of<ChatProvider>(context,
                                    listen: false).chatModel.pickDate = val;

                                Provider.of<ChatProvider>(context, listen: false).pickDate();

                              },
                              initialDateTime: initialDate,
                            ),
                          )
                      );
                      },
                    ),
                    (Provider.of<ChatProvider>(context, listen: false).chatModel.pickDate != null)
                        ? Text(
                      "${Provider.of<ChatProvider>(context).chatModel.pickDate?.day} / ${Provider.of<ChatProvider>(context).chatModel.pickDate?.month} / ${Provider.of<ChatProvider>(context).chatModel.pickDate?.year}",
                    )
                        : const Text("Pick Date"),
                  ],
                ),
                Row(
                  children: [
                    CupertinoButton(child: Icon(CupertinoIcons.time),
                      onPressed: (){
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Container(
                              height: 300,
                              color: Colors.white,
                              child:  CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                minimumYear: 2023,
                                maximumYear: 2040,
                                onDateTimeChanged: (val) {
                                  Provider.of<ChatProvider>(context, listen: false).chatModel.pickTime = TimeOfDay.fromDateTime(val);

                                  Provider.of<ChatProvider>(context, listen: false).pickTime();
                                  },
                                initialDateTime: initialTime,
                                use24hFormat: false,
                              ),
                            )
                        );
                      },
                    ),
                    (Provider.of<ChatProvider>(context, listen: false)
                        .chatModel
                        .pickTime !=
                        null)
                        ? Text(
                      "${Provider.of<ChatProvider>(context).chatModel.pickTime?.hour} : ${Provider.of<ChatProvider>(context).chatModel.pickTime?.minute}",
                    )
                        : const Text("Pick Time"),
                  ],
                ),
                CupertinoButton.filled(
                  child: Text("SAVE"),
                  onPressed: (){
                    if (add_contact_key.currentState!.validate() &&
                        Provider.of<ChatProvider>(context, listen: false)
                            .chatModel
                            .img != null &&
                        Provider.of<ChatProvider>(context, listen: false)
                            .chatModel
                            .pickDate != null &&
                        Provider.of<ChatProvider>(context, listen: false)
                            .chatModel
                            .pickTime != null) {
                      Provider.of<ChatProvider>(context, listen: false)
                          .saveChat();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
