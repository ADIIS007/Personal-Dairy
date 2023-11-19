import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_flutter_project/Entity/dairy.dart';
import 'package:my_flutter_project/Service/db.dart';

class ReadDairy extends StatefulWidget {
  final String dateStr;
  const ReadDairy({Key? key, required this.dateStr}): super(key:key);

  @override
  State<ReadDairy> createState() => _ReadDairy(dateStr);
}

class _ReadDairy extends State<ReadDairy> {
  late String dateStr;
  late QuillController _controller;
  bool init = false;

  _ReadDairy(String date){
    dateStr=date;
  }

  @override
  void initState() {
    super.initState();
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
        title: Text('Noted on ${dateStr}'),
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
                    readOnly: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )
        : const CircularProgressIndicator();
  }
}