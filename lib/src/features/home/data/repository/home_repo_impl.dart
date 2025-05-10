import '../../../../global_export.dart';

class HomeRepoImplA implements HomeRepo {

  //Singleton for Single global instance.
  static final HomeRepoImplA _instance = HomeRepoImplA._internal();
  factory HomeRepoImplA() => _instance;
  HomeRepoImplA._internal();


  @override
  Future<ApiResponse<List<Contact>>> loadContacts() async {
    try {
      final contacts = await HiveContactService.getContacts();
      return Successful(data: contacts);
    } catch (e) {
      return Error(error: AfriException(e.toString(), StackTrace.current));
    }
  }
}