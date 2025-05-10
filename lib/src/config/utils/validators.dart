import 'package:contact_alarm/src/config/utils/strings.dart';

mixin AfriValidators{

  String? validateName(String? text){
    if(text == null || text.isEmpty){
      return AfriStrings.EMPTY_FIELD;
    }
    return null;
  }


  String? validatePhone(String? phoneNo){
    if(phoneNo == null || phoneNo.isEmpty){
      return AfriStrings.EMPTY_FIELD;
    }

    final phoneRegex = RegExp(r'^(\+?\d{1,3}[- ]?)?\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}$');
    if(!phoneRegex.hasMatch(phoneNo)){
      return AfriStrings.INVALID_PHONE_NO;
    }
    return null;
  }
}
