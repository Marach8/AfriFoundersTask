import 'dart:ui';
import 'package:contact_alarm/main.dart' show AfriRouteTransiton;
import 'package:contact_alarm/src/global_export.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AfriHomeScreen extends StatefulWidget {
  const AfriHomeScreen({super.key});

  @override
  State<AfriHomeScreen> createState() => _AfriHomeScreenState();
}

class _AfriHomeScreenState extends State<AfriHomeScreen> {

  @override 
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_){
        final ref = context.getRef;
        ref.read(contactsProvider.notifier).loadContacts();
      }
    );
    FlutterNativeSplash.remove();
  }


  @override
  Widget build(BuildContext context) {
    final ref = context.getRef;
    ref.listen(
      contactsProvider,
      (_, next){
        if(next is AsyncError){
          final error = ref.read(contactsProvider).error as String;
          if(context.mounted){
            showAppNotification(
              context: context,
              icon: Icon(Icons.warning_rounded, color: AfriColors.white,),
              text: error,
            );
          }
        }
      }
    );

    return AfriAnnotatedRegion(
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (_, __) => [
              SliverAppBar(
                floating: true,
                title: Text(
                  AfriStrings.ALL_CONTACTS,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
          
              SliverPersistentHeader(
                pinned: true,
                delegate: AfriSliverHeader(
                  maxExt: 70, minExt: 70, rebuild: false,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: AfriContainer(
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Consumer(
                          builder: (_, ref, __) {
                            final asyncContacts = ref.watch(contactsProvider);
                            if(asyncContacts is! AsyncData){
                              return AfriShimmer(height: 40, margin: const EdgeInsets.only(bottom: 20),);
                            }
                            return AfriTextField(
                              prefixIcon: const Icon(CupertinoIcons.search, size: 20),
                              enabled: (asyncContacts is AsyncData && asyncContacts.value != null),
                              hintText: AfriStrings.ENTER_SEARCH_KEY,
                              onChanged: (text) => AfriHelperFuncs.callDebouncer(
                                500,
                                () => ref.read(contactsProvider.notifier).filterContacts(text.trim())
                              )
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],

            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: AfriContactList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).textTheme.headlineMedium?.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () => Navigator.push(
            context,
            AfriRouteTransiton(child: AfriAddContactScreen(),),
          ),
          child: Icon(Icons.add, color: Theme.of(context).scaffoldBackgroundColor,),
        )
      ),
    );
  }
}