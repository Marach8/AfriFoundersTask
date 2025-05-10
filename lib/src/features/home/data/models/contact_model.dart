import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;
  
  @HiveField(2)
  final String? phoneNumber;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  bool hasReminder;

  Contact({this.name, this.phoneNumber, this.hasReminder = false})
    : id = const Uuid().v4(), createdAt = DateTime.now();
}