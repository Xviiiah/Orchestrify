import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../widgets/input/custom_text_form_field.dart';
import '../../../widgets/spacers.dart';
import '../otp_page/otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late String errorMessage;
  final _formKey = GlobalKey<FormState>();
  bool waiting = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    errorMessage = '';
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white),
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
                  child: Column(
                    children: [
                      CustomTextFormField(
                        textEditingController: _usernameController,
                        size: size,
                        width: 0.2,
                        label: "Username",
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                      ),
                      const VSpacer10(),
                      CustomTextFormField(
                        textEditingController: _passwordController,
                        size: size,
                        width: 0.2,
                        label: "Password",
                        obscure: true,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const VSpacer10(),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: login,
                  child: !waiting
                      ? const Text("Login")
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    /// validate input correctness
    if (_formKey.currentState!.validate() && !waiting) {
      /// Validate username and password
      if (validateCredentials().isEmpty) {
        setState(() {
          waiting = true;
        });
        try {
          /// Ask Firebase to send OTP to the phone number below,
          /// Correct Number, Send OTP. Else, throw Error
          FirebaseAuth auth = FirebaseAuth.instance;
          ConfirmationResult confirmationResult =
              await auth.signInWithPhoneNumber('+966535707249');
          setState(() {
            errorMessage = '';
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(
                    confirmationResult: confirmationResult, auth: auth)),
          );
        } catch (e) {
          ///If Phone number is incorrect, show error Message
          setState(() {
            errorMessage = 'Something went wrong';
            waiting = false;
          });
        }
        setState(() {
          waiting = false;
        });
      }
    }
  }

  String validateCredentials() {
    String appUsername = 'admin';
    String appPassword = 'password';

    if (appUsername != _usernameController.value.text ||
        appPassword != _passwordController.value.text) {
      setState(() {
        errorMessage = "Username or Password is Wrong";
      });
      return errorMessage;
    }
    setState(() {
      errorMessage = "";
    });
    return '';
  }
}
