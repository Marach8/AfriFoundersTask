import '../../../global_export.dart';

final deleteContactProvider = StateNotifierProvider<DeleteContactsNotifier, AsyncValue<bool?>>(
  (ref) => DeleteContactsNotifier(ref)
);

class DeleteContactsNotifier extends StateNotifier<AsyncValue<bool?>>{
  DeleteContactsNotifier(this.ref):
    //We can use another implementation (Maybe HomeRepoImplB) 
    //that uses another service (instead of Hive) by decoupling here and injecting that one.
    homeRepo = HomeRepoImplA(),
    super(const AsyncData(null));

  final Ref ref;
  final HomeRepo homeRepo;

  Future<bool> deleteContact(Contact contact) async{
    state = const AsyncLoading();    
    try{
      final response = await homeRepo.deleteContact(contact.id);
      final result = response.when(
        successful: (result){
          state = AsyncData(result.data);
          NotificationService.cancelReminder(contact);
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