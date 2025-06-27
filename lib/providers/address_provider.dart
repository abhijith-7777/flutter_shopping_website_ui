import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressFormNotifier extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  void disposeControllers() {
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void submitForm(BuildContext context) {
    if (validateForm()) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address saved successfully')),
      );
    }
  }
}

final addressFormProvider = ChangeNotifierProvider<AddressFormNotifier>((ref) {
  final notifier = AddressFormNotifier();
  ref.onDispose(() {
    notifier.disposeControllers();
  });
  return notifier;
});
