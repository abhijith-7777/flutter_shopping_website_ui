import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/address_provider.dart';

class AddressScreen extends ConsumerWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressForm = ref.watch(addressFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addressForm.formKey,
          child: ListView(
            children: [
       
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: addressForm.address1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address 1',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter Address 1' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: addressForm.address2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address 2',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

         
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: addressForm.cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter City' : null,
                ),
              ),

         
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: addressForm.stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter State' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: addressForm.zipController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter Zip Code' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextFormField(
                  controller: addressForm.countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter Country' : null,
                ),
              ),

            
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => addressForm.submitForm(context),
                  child: const Text('Save Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

