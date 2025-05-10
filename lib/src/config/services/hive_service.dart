import 'dart:developer' show log;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:synchronized/synchronized.dart' show Lock;
import '../../global_export.dart';


class HiveContactService {
  HiveContactService._();

  static bool _isInitialized = false;
  static late final Box<Contact> _contactBox;

  static Future<void> intializeHive() async {
    if (_isInitialized) return;
    
    await Hive.initFlutter();
    Hive.registerAdapter(ContactAdapter());
    _contactBox = await Hive.openBox<Contact>(AfriStrings.ALL_CONTACTS);
    _isInitialized = true;
  }


  static Future<void> addContact(Contact contact) {
    return _contactBox.put(contact.id, contact);
  }

  static Future<List<Contact>> getContacts() {
    return Future.value(
      _contactBox.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt))
    );
  }


  static Future<void> deleteAllContacts() async {
    await _contactBox.clear();
  }


  static final _deleteLock = Lock();
  static final Map<String, bool> _pendingDeletions = {};

  static Future<void> deleteContact(String contactId) async {
    if (_pendingDeletions.containsKey(contactId)) return;

    return await _deleteLock.synchronized(() async {
      try {
        _pendingDeletions[contactId] = true;
        
        await _contactBox.delete(contactId);
      } 
      finally {
        _pendingDeletions.remove(contactId);
      }
    });
  }


  static Future<void> close() async {
    await _contactBox.close();
    _isInitialized = false;
  }
}