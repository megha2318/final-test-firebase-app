import 'package:final_test_firestore/globals/global.dart';
import 'package:final_test_firestore/screens/home_screen.dart';
import 'package:final_test_firestore/screens/signin_screen.dart';
import 'package:final_test_firestore/utils/string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MaterialApp(
      initialRoute: "/signUpPage",
      routes: {
        "/signUpPage": (context) => const SignUpPage(),
        "/signInPage": (context) => const SignInPage(),
        "/": (context) => const HomePage(),
      },
    ),
  );
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  String? name;
  String? role;
  String? email;
  String? password;

  String dropDownVal = 'Admin';

  var items = [
    'Admin',
    'Manager',
    'Clerk',
    'Employee',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 350,
              decoration: const BoxDecoration(
                image: const DecorationImage(
                  image: const NetworkImage(
                      "https://expert.vedak.com/static/media/login.d281c5f6.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                "SignUp",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.blue,
                ),
              ),
            ),
            Form(
              key: registerFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                      onSaved: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your username first.......";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "User Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your email first.......";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your password first.......";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: 50,
                width: 370,
                child: ElevatedButton(
                  child: const Text("SignUp"),
                  onPressed: () {
                    validateAndSignUp();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "SignIn",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/signInPage', (route) => false);
                      },
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateAndSignUp() {
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();

      Global.data = {emailKey: email, nameKey: name};
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
        '/signInPage', (route) => false,
        arguments: [name, email, password]);
  }
}
