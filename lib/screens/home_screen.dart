import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_test_firestore/helpers/firestore_helper.dart';
import 'package:final_test_firestore/utils/string.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> insertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController roleUpdateController = TextEditingController();

  String? name;
  String? role;

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      floatingActionButton: (args == "Admin")
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(
                      child: Text("Insert Data"),
                    ),
                    content: Form(
                      key: insertFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                  role = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please Enter your role first.......";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Role",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Insert"),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(),
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.firebaseFirestore
            .collection('users')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Name: ${data[i][nameKey]}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Role: ${data[i][roleKey]}"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        const Spacer(),
                        (args == "Admin")
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  nameUpdateController.text = data[i][nameKey];
                                  roleUpdateController.text = data[i][roleKey];

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Center(
                                        child: const Text("Update Data"),
                                      ),
                                      content: Form(
                                        key: updateFormKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: TextFormField(
                                                controller:
                                                    nameUpdateController,
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
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "User Name",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: TextFormField(
                                                controller:
                                                    roleUpdateController,
                                                onSaved: (val) {
                                                  setState(() {
                                                    role = val;
                                                  });
                                                },
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "Please Enter your role first.......";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Role",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          child: const Text("Update"),
                                          onPressed: () {
                                            Map<String, dynamic> data = {
                                              nameKey: name,
                                              roleKey: role,
                                            };
                                            FireStoreHelper.fireStoreHelper
                                                .updateUsers(
                                                    id: data[i].id, data: data);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container(),
                        (args == "Admin")
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await FireStoreHelper.fireStoreHelper
                                      .deleteUsers(id: data[i].id);
                                },
                              )
                            : Container(),
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
