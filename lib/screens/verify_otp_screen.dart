import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/auth/auth_repository.dart';
import 'home_screen.dart';
import '../providers/home_screen_provider.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty || otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await AuthRepository.verifyOtp(
        phoneNumber: widget.phoneNumber,
        otp: otp,
      );

      setState(() => isLoading = false);

      if (response.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );

        // Set selectedIndexProvider to 0 to navigate to home tab
        ref.read(selectedIndexProvider.notifier).state = 0;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Enter OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Enter OTP', Icons.lock),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

