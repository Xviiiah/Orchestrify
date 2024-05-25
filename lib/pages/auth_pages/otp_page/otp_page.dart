import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';
import 'package:forti_grad/pages/home_page/home_page.dart';

import '../../../widgets/input/custom_text_form_field.dart';
import '../../../widgets/spacers.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key, required this.auth, required this.confirmationResult});
  final ConfirmationResult confirmationResult;
  final FirebaseAuth auth;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final String _phoneNumber = '***********49';
  late TextEditingController _otp;
  final _formKey = GlobalKey<FormState>();
  final RegExp _otpRegExp = RegExp(r'^(\d{6})$');
  String errorMessage = '';
  bool waiting = false;

  @override
  void initState() {
    _otp = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Orchestrify",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "One Time Passcode",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
            const VSpacer10(),
            Text(
              "A one time passcode has been sent to the number:",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            Text(
              _phoneNumber,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const VSpacer10(),
            errorMessage.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                      const VSpacer10(),
                    ],
                  )
                : const SizedBox(),
            Form(
              key: _formKey,
              child: CustomTextFormField(
                textEditingController: _otp,
                size: size,
                width: 0.2,
                hint: "XXX XXX",
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "This field is mandatory";
                  } else if (input.length != 6 || !_otpRegExp.hasMatch(input)) {
                    return "invalid OTP";
                  }
                  return null;
                },
              ),
            ),
            const VSpacer10(),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: verify,
              child: !waiting
                  ? const Text("Verify")
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> verify() async {
    if (_formKey.currentState!.validate() && !waiting) {
      setState(() {
        waiting = true;
      });
      try {
        /// OTP Confirmation, if successful open HomePage(),
        /// Else, throw and error.
        await widget.confirmationResult.confirm(_otp.value.text);
        errorMessage = '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        setState(() {
          waiting = false;
        });
      } catch (e) {
        /// If OTP is not Correct, show a message
        setState(() {
          errorMessage = 'Enter correct passcode';

          waiting = false;
        });
      }
      setState(() {
        waiting = false;
      });
    }
  }
}
