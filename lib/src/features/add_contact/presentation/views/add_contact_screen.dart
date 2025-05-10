import 'package:flutter/cupertino.dart' show CupertinoIcons;
import '../../../../global_export.dart';

class AfriAddContactScreen extends StatefulWidget {
  const AfriAddContactScreen({super.key});

  @override
  State<AfriAddContactScreen> createState() => _AfriAddContactScreenState();
}

class _AfriAddContactScreenState extends State<AfriAddContactScreen> with AfriValidators {
  late final TextEditingController _nameCntrl, _phoneCntrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override 
  void initState(){
    super.initState();
    _nameCntrl = TextEditingController();
    _phoneCntrl = TextEditingController();
  }

  @override 
  void dispose(){
    _nameCntrl.dispose();
    _phoneCntrl.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AfriAnnotatedRegion(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(13, kToolbarHeight*0.9, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    splashColor: Theme.of(context).textTheme.headlineMedium?.color?.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(CupertinoIcons.back)
                  ),
                  Text(
                    AfriStrings.ADD_CONTACT,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(width: 30,)
                ],
              ),
            ),
        
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AfriStrings.NAME,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 5,),
                      AfriTextField(
                        hintText: AfriStrings.ENTER_CONTACT_NAME,
                        controller: _nameCntrl,
                        validator: validateName,
                      ),
                      const SizedBox(height: 20,),
                  
                      Text(
                        AfriStrings.NUMBER,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 5,),
                      AfriTextField(
                        controller: _phoneCntrl,
                        hintText: AfriStrings.ENTER_CONTACT_NUMBER,
                        keyboardType: TextInputType.number,
                        validator: validatePhone,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
          child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 1000)),
            builder: (_, snapshot) {
              final shouldShow = snapshot.connectionState == ConnectionState.done;
              return Consumer(
                builder: (_, ref, __) {
                  final isLoading = ref.watch(addContactProvider) is AsyncLoading;
                  return AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    //curve: Curves.bounceOut,
                    offset: shouldShow ? const Offset(0, 0) : const Offset(0, 1.5),
                    child: AfriElevatedBtn(
                      showLoading: isLoading,
                      onPressed: ()async{
                        if(_formKey.currentState?.validate() ?? false){
                          final result = await ref.read(addContactProvider.notifier).addAContact(
                            name: _nameCntrl.text.trim(),
                            phoneNumber: _phoneCntrl.text.trim()
                          );
                    
                          if(context.mounted){
                            if(result){
                              showAppNotification(
                                context: context,
                                icon: Icon(Icons.check_circle, color: AfriColors.white,),
                                text: '${_nameCntrl.text.trim()} ${AfriStrings.ADDED_SUCCESSFULY}',
                                bgColor: AfriColors.successColor
                              );
                              _nameCntrl.clear(); _phoneCntrl.clear();
                            }
                            else{
                              final error = ref.read(addContactProvider).error as String;
                              if(context.mounted){
                                showAppNotification(
                                  context: context,
                                  icon: Icon(Icons.warning_rounded, color: AfriColors.white,),
                                  text: error,
                                );
                              }
                            }
                          }
                        }
                      },
                      btnTitle: AfriStrings.SAVE_CONTACT,
                    ),
                  );
                }
              );
            }
          ),
        )
      ),
    );
  }
}