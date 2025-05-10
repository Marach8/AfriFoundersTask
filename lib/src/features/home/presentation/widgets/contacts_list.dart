import 'package:flutter/cupertino.dart';
import '../../../../global_export.dart';

class AfriContactList extends ConsumerWidget {
  const AfriContactList({super.key});

  @override
  Widget build(context, ref) {
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
              
              return Dismissible(
                key: Key(contact?.id ?? ''),
                background: AfriContainer(
                  color: AfriColors.red, radius: 8,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.filled(2, Icon(CupertinoIcons.delete)),
                  ),
                ),
                confirmDismiss: !hasData ? null : (_) => confirmActionDialog(
                  context: context,
                  title: '${AfriStrings.DELETE} ${contact?.name}?',
                  content: AfriStrings.CONFIRM_DELETION,
                  yesString: AfriStrings.DELETE, noString: AfriStrings.CANCEL
                ),
                onDismissed: !hasData ? null : (_)async{
                  final isDeleted = await ref.read(deleteContactProvider.notifier).deleteContact(contact!);
                  //Refresh UI
                  ref.read(contactsProvider.notifier).loadContacts(delay: 0);

                  if(context.mounted){
                    showAppNotification(
                      context: context,
                      icon: Icon(
                        isDeleted ? Icons.check_circle : Icons.warning_rounded,
                        color: AfriColors.white
                      ),
                      bgColor: isDeleted ? AfriColors.successColor : null,
                      text: isDeleted ? '${contact.name ?? ''} ${AfriStrings.HAS_BEEN_DELETED}'
                        :'${AfriStrings.COULD_NOT_DELETE} ${contact.name ?? ''}',
                    );
                  }
                },
                child: AfriContainer(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  radius: 8,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  border: Border.all(
                    width: 0.2,
                    color: Theme.of(context).textTheme.headlineMedium?.color ?? AfriColors.hex1B1B1B
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
                      ) : NotificationIcon(contact: contact ?? Contact()),
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
