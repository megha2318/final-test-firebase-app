import 'package:final_test_firestore/globals/global.dart';
import 'package:final_test_firestore/helpers/firestore_helper.dart';
import 'package:final_test_firestore/utils/string.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  String? signInEmail;
  String? signInPassword;
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
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    name = args[0];
    // role = args[1];
    email = args[1];
    password = args[2];

    return Scaffold(
      body: (args[0] == null || args[1] == null || args[2] == null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.gpslink.co.uk/static/assets/img/login.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "SignIn",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: TextFormField(
                          onSaved: (val) {
                            setState(() {
                              signInEmail = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter your email first.......";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
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
                              signInPassword = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter your password first.......";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
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
                      child: Text("SignIn"),
                      onPressed: () {
                        validateAndSignIn();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: "No any account? ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "SignUp",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/signUpPage', (route) => false);
                          },
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://www.gpslink.co.uk/static/assets/img/login.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Form(
                    key: signInFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                signInEmail = val;
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter your email first.......";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                                signInPassword = val;
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter your password first.......";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
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
                        child: Text("SignIn"),
                        onPressed: () {
                          validateAndSignIn();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "No any account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "SignUp",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/signUpPage', (route) => false);
                            },
                          style: TextStyle(
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

  validateAndSignIn() {
    if (signInFormKey.currentState!.validate()) {
      signInFormKey.currentState!.save();

      if (signInEmail == email && signInPassword == password) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text("Select your Role")),
            content: StatefulBuilder(
              builder: (context, setState) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton(
                    // Initial Value
                    value: dropDownVal,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? val) {
                      setState(() {
                        dropDownVal = val!;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      roleKey: dropDownVal,
                    };
                    Global.data!.addAll(data);
                    FireStoreHelper.fireStoreHelper
                        .insertUsers(data: Global.data!);
                    // FireStoreHelper.fireStoreHelper.firebaseFirestore
                    //     .collection('users')
                    //     .doc(Global.id)
                    //     .set(data);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (route) => false,
                        arguments: dropDownVal);
                  },
                  child: Text("Select"),
                ),
              ),
            ],
          ),
        );

        // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    }
  }
}
