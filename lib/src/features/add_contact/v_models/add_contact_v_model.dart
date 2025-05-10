import 'package:contact_alarm/src/global_export.dart';

final addContactProvider = StateNotifierProvider<AddContactNotifier, AsyncValue<bool?>>(
  (ref) => AddContactNotifier(ref)
);

class AddContactNotifier extends StateNotifier<AsyncValue<bool?>>{
  AddContactNotifier(this.ref):
    //We can use another implementation (Maybe HomeRepoImplB) 
    //that uses another service (instead of Hive) by decoupling here and injecting that one.
    addContactRepo = AddContactsRepoImplA(),
    super(const AsyncData(null));

  final Ref ref;
  final AddContactRepo addContactRepo;


  Future<bool> addAContact({
    required String name,
    required String phoneNumber
  }) async{
    state = const AsyncLoading();
    try{
      //Simulate an API call
      await Future.delayed(const Duration(seconds: 1));
      
      final contact = Contact(name: name, phoneNumber: phoneNumber);

      final response = await addContactRepo.addAContact(contact);
      final result = response.when(
        successful: (result){
          //Refresh contacts on the UI
          ref.read(contactsProvider.notifier).loadContacts();
          state = AsyncData(result.data);
          return true;
        },
        error: (error){
          state = AsyncError(error.error.exectionMsg, StackTrace.current);
          return false;
        }
      );
      return result;
    }
    catch (e){
      state = AsyncError(e.toString(), StackTrace.current);
      return false;
    }
  }
}