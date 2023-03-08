import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.done))],
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
            TextFormField(
                autofocus: true,
                controller: titleController,
                style: TextStyle(fontSize: 22),
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
              height: 10,
            ),
            "Description"
                .text
                .fontWeight(FontWeight.bold)
                .minFontSize(30)
                .make(),
            Expanded(
              child: TextFormField(
                //focusNode:focusNode,
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
}
