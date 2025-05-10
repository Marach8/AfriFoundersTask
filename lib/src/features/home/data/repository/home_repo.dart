import '../../../../global_export.dart';

abstract class HomeRepo {
  Future<ApiResponse<List<Contact>>> loadContacts();

  Future<ApiResponse<bool>> deleteContact(String contactId);

  Future<ApiResponse<bool>> clearContacts();
}