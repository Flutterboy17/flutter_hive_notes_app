// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hive_notes_app/Models/hive_models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Components/app_routes.dart';
import '../Components/hive_boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> myColors = [
    Colors.yellow.shade100,
    Colors.brown.shade100,
    Colors.pink.shade100,
    Colors.green.shade100,
    Colors.deepPurple.shade100,
    Colors.grey.shade100,
    Colors.red.shade100,
    Colors.deepOrange.shade100,
  ];

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
          Random random = Random();
          Color bg = myColors[random.nextInt(7)];
          return Padding(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: bg,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          right: 10, left: 10, top: 5, bottom: 5),
                      onLongPress: () {
                        data[index].delete().then((value) {
                          Fluttertoast.showToast(msg: "Note deleted!");
                        });
                      },
                      title: data[index]
                          .title
                          .text
                          .fontWeight(FontWeight.w500)
                          .overflow(TextOverflow.ellipsis)
                          .maxLines(1)
                          .minFontSize(20)
                          .make(),
                      subtitle:
                          data[index].description.text.minFontSize(16).make(),
                      trailing: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.addNotesRoute);
                          },
                          child: Icon(Icons.edit)),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  deleteData(HiveModels hiveModels) {
    hiveModels.delete();
  }
}
