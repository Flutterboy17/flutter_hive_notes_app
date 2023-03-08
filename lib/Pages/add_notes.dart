// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Components/hive_boxes.dart';
import '../Models/hive_models.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                myFields(context);
              },
              icon: Icon(Icons.done))
        ],
        elevation: 0.5,
        title: Text("Add Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3,
            ),
            "Title".text.fontWeight(FontWeight.bold).minFontSize(30).make(),
            SizedBox(
              height: 3,
            ),
            TextFormField(
                autofocus: true,
                controller: titleController,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (val) {
                  if (val != "") {
                    focusNode.requestFocus();
                  }
                }),
            SizedBox(
              height: 3,
            ),
            "Description"
                .text
                .fontWeight(FontWeight.bold)
                .minFontSize(30)
                .make(),
            Expanded(
              child: TextFormField(
              
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: null,
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> myFields(BuildContext context) async {
    final data = HiveModels(
        title: titleController.text, description: descriptionController.text);

    var box = HiveBoxes.getData();
    box.add(data).then((value) {
      Fluttertoast.showToast(msg: 'Note Added!');
    });

    data.save();

    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }

  Future<dynamic> editFields(
      String title, String description, HiveModels hiveModels) async {
    titleController.text = title;
    descriptionController.text = description;

    hiveModels.title = titleController.text;
    hiveModels.description = descriptionController.text;

    await hiveModels.save();

    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }
}
