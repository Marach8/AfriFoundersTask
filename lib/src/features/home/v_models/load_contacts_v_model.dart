import '../../../global_export.dart';

final contactsProvider = StateNotifierProvider<LoadContactsNotifier, AsyncValue<List<Contact>?>>(
  (ref) => LoadContactsNotifier(ref)
);

class LoadContactsNotifier extends StateNotifier<AsyncValue<List<Contact>?>>{
  LoadContactsNotifier(this.ref):
    //We can use another implementation (Maybe HomeRepoImplB) 
    //that uses another service (instead of Hive) by decoupling here and injecting that one.
    homeRepo = HomeRepoImplA(),
    super(const AsyncData(null));

  final Ref ref;
  final HomeRepo homeRepo;

  List<Contact>? _contacts;


  Future<void> loadContacts({int? delay}) async{
    state = const AsyncLoading();
    await Future.delayed(Duration(seconds: delay ?? 2));
    
    try{
      final response = await homeRepo.loadContacts();
      response.when(
        successful: (result){
          _contacts = result.data;
          state = AsyncData(result.data);
        },
        error: (error) => state = AsyncError(
          error.error.exectionMsg, StackTrace.current
        )
      );
    }
    catch (e){
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }


  void filterContacts(String searchKey) async{    
    if(searchKey.isEmpty){
      ref.invalidate(stringProvider(AfriStrings.ENTER_SEARCH_KEY));
      state = AsyncData(_contacts);
      return;
    }

    final filteredContacts = _contacts?.where(
      (user) => (user.name?.toLowerCase().contains(searchKey.toLowerCase()) ?? false)
    ).toList();
    
    ///Writes the searchKey to the Filter Widget that will change the color of the name text of the filtered items.
    AfriHelperFuncs.setAProvider(
      value: searchKey, ref: ref,
      provider: stringProvider(AfriStrings.ENTER_SEARCH_KEY)
    );

    state = AsyncData(filteredContacts);
  }
}