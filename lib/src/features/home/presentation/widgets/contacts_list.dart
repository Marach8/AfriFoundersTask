import 'package:flutter/cupertino.dart';
import '../../../../global_export.dart';

class AfriContactList extends ConsumerWidget {
  const AfriContactList({super.key});

  @override
  Widget build(context, ref) {
    final brightness = context.getBrightness;
    final inDarkMode = brightness == Brightness.dark;

    List<Contact>? contacts;
    final asyncContacts = ref.watch(contactsProvider);
    final hasData = asyncContacts is AsyncData;
    final hasError = asyncContacts is AsyncError;
    final inFilterMode = ref.read(stringProvider(AfriStrings.ENTER_SEARCH_KEY)).isNotEmpty;

    if(hasData){
      contacts = asyncContacts.value;
    }

    if(contacts != null && contacts.isEmpty){
      return Center(
        child: Text(
          inFilterMode ? AfriStrings.NO_SEARCH_RESULTS : AfriStrings.NO_CONTACTS,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );
    }

    return RefreshIndicator(
      color: Theme.of(context).textTheme.headlineMedium?.color,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onRefresh: (){
        return (hasData || hasError) ? ref.read(contactsProvider.notifier).loadContacts()
          : Future<void>.value();
      },
      child: LayoutBuilder(
        builder: (_, constraints) {
          return ListView.builder(
            itemCount: contacts?.length ?? (constraints.maxHeight ~/ 50),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, listIndex){
              final contact = contacts?.elementAtOrNull(listIndex);
              
              return AfriContainer(
                color: inDarkMode ? AfriColors.black : AfriColors.white, 
                radius: 8,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                border: Border.all(
                  width: 0.2,
                  color: inDarkMode ? AfriColors.white : AfriColors.hex1B1B1B
                ),
                child: Row(
                  children: [
                    !hasData ? AfriShimmer(
                      height: 30, width: 30, radius: 15,
                    ) : Icon(CupertinoIcons.person_circle, size: 30,),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !hasData ? AfriShimmer(
                            height: 15, radius: 5,
                            width: AfriHelperFuncs.getRandomNumber(constraints.maxWidth).toDouble(),
                          ) : AfriFilterWidget(
                            title: contact?.name ?? '',
                            providerId: AfriStrings.ENTER_SEARCH_KEY,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          !hasData ? AfriShimmer(height: 10, width: 120, radius: 3,)
                            : Text(
                            contact?.phoneNumber ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    !hasData ? AfriShimmer(
                      height: 30, width: 30, radius: 15,
                    ) : StatefulBuilder(
                      builder: (_, setter) {
                        return InkWell(
                          onTap: (){
                            if(contact!.hasReminder){
                              NotificationService.cancelReminder(
                                contact, onCancel: () => setter(() => contact.hasReminder = false),
                              );
                            }
                            else{
                              NotificationService.scheduleReminder(
                                contact, onExecute: () => setter(() => contact.hasReminder = false),
                              );
                              setter(() => contact.hasReminder = true);
                            }
                          },
                          splashColor: Theme.of(context).textTheme.headlineMedium?.color?.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(
                            CupertinoIcons.bell,
                            color: (contact?.hasReminder ?? false) ? AfriColors.successColor : null,
                          )
                        );
                      }
                    ),
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}