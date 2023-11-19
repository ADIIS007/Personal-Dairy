// Import necessary packages
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_project/Entity/dairy.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DairyAdapter extends TypeAdapter<DiaryEntry> {
  @override
  DiaryEntry create(BinaryReader reader) {
    return DiaryEntry(reader.readString(),
        Document.fromJson(jsonDecode(reader.readString())));
  }

  @override
  void write(BinaryWriter writer, DiaryEntry diaryEntry) {
    writer.writeString(diaryEntry.date);
    writer.writeString(jsonEncode(diaryEntry.entry.toDelta().toJson()));
  }

  @override
  DiaryEntry read(BinaryReader reader) {
    return DiaryEntry(reader.readString(),
        Document.fromJson(jsonDecode(reader.readString())));
  }

  @override
  int get typeId => 1;
}

class DairyService {
  final Box<DiaryEntry> _diaryBox = Hive.box('diary_entries');

  // Create a new diary entry
  Future<void> createEntry(String date, Document entry) async {
    final newEntry = DiaryEntry(date, entry);
    await _diaryBox.put(date, newEntry);
  }

  // Update an existing diary entry
  Future<void> updateEntry(String date, Document newEntry) async {
    final existingEntry = _diaryBox.get(date);
    if (existingEntry != null) {
      existingEntry.entry = newEntry;
      await _diaryBox.put(date, existingEntry);
    }
  }

  // Fetch a specific diary entry
  DiaryEntry? getEntry(String date) {
    return _diaryBox.get(date);
  }

  // List all diary entries
  List<DiaryEntry> getAllEntries() {
    return _diaryBox.values.toList();
  }
}
