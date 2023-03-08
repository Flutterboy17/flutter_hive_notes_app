// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hive_notes_app/Models/hive_models.dart';
import 'package:hive_flutter/adapters.dart';

import '../Components/app_routes.dart';
import '../Components/hive_boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("Recent Notes"),
       
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text("Add Notes"),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.post_add)
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addNotesRoute);

          //  myFields(context);
        },
      ),

      body: ValueListenableBuilder<Box<HiveModels>>(
        valueListenable: HiveBoxes.getData().listenable(),
        builder: (context, value, child) {
          var data = value.values.toList().cast<HiveModels>();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: IconButton(
                  onPressed: () {
                    data[index].delete();
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text(data[index].title),
                subtitle: Text(data[index].description),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    editFields(data[index].title, data[index].description,
                        data[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  deleteData(HiveModels hiveModels) {
    hiveModels.delete();
  }

  Future<dynamic> editFields(
      String title, String description, HiveModels hiveModels) {
    titleController.text = title;
    descriptionController.text = description;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL")),
            TextButton(
                onPressed: () async {
                  hiveModels.title = titleController.text;
                  hiveModels.description = descriptionController.text;

                  await hiveModels.save();

                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text(
                  "EDIT",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Enter title...'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Enter description...'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> myFields(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL")),
            TextButton(
                onPressed: () {
                  final data = HiveModels(
                      title: titleController.text,
                      description: descriptionController.text);

                  var box = HiveBoxes.getData();
                  box.add(data);

                  data.save();

                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Enter title...'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Enter description...'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
