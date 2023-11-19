import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_flutter_project/Entity/dairy.dart';
import 'package:my_flutter_project/Service/db.dart';

class AddDairy extends StatefulWidget {
  const AddDairy({super.key});

  @override
  State<AddDairy> createState() => _AddDairyState();
}

class _AddDairyState extends State<AddDairy> {
  late String dateStr;
  late QuillController _controller;
  bool init = false;

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    dateStr = '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    _loadData();
    init = true;
    setState(() {});
  }

  void _loadData() {
    _controller = QuillController.basic();
    DiaryEntry? diary = DairyService().getEntry(dateStr);
    if (diary != null) {
      Document data = diary.entry;
      _controller = QuillController(
          document: data,
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      _controller = QuillController.basic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (init)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text('Note Your day on ${dateStr}'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillProvider(
                configurations: QuillConfigurations(
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
                child: Column(
                  children: [
                    const QuillToolbar(),
                    Expanded(
                      child: QuillEditor.basic(
                        configurations: const QuillEditorConfigurations(
                          readOnly: false,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                DairyService()
                    .createEntry(dateStr, _controller.document);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SAVED')),
                );
              },
              child: const Icon(Icons.save),
            ),
          )
        : const CircularProgressIndicator();
  }
}