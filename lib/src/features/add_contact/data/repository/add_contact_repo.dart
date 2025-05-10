import '../../../../global_export.dart';

abstract class AddContactRepo {
  Future<ApiResponse<bool>> addAContact(Contact contact);
}