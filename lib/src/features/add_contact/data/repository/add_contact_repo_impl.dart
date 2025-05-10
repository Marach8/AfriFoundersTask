import '../../../../global_export.dart';

class AddContactsRepoImplA implements AddContactRepo {

 //Singleton for Single global instance.
  static final AddContactsRepoImplA _instance = AddContactsRepoImplA._internal();
  factory AddContactsRepoImplA() => _instance;
  AddContactsRepoImplA._internal();

  @override
  Future<ApiResponse<bool>> addAContact(Contact contact) async {
    try {
      final contacts = await HiveContactService.getContacts();

      if (contact.name != null) {
        final nameExists = contacts.any((c) => 
            c.name != null && 
            c.name!.toLowerCase() == contact.name!.toLowerCase());
        if (nameExists) {
          throw AfriStrings.NAME_EXISTS;
        }
      }

      if (contact.phoneNumber != null) {
        final numberExists = contacts.any((c) => 
            c.phoneNumber != null && 
            c.phoneNumber == contact.phoneNumber);
        if (numberExists) {
          throw AfriStrings.NUMBER_EXISTS;
        }
      }

      await HiveContactService.addContact(contact);
      return Successful(data: true);
    } on String catch (e) {
      return Error(error: AfriException(e, StackTrace.current));
    } catch (e) {
      return Error(error: AfriException(e.toString(), StackTrace.current));
    }
  }
}