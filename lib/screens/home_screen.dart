import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController noteController = TextEditingController();
TextEditingController noteUpdateController = TextEditingController();
User? userId = FirebaseAuth.instance.currentUser;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.pink,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: ListTile(
                title: Text("Saif"),
              ),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              title: const Text("Signout"),
              trailing: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("uid", isEqualTo: userId!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Error Occured!");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Text("No Data Found!");
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var docId = snapshot.data!.docs[index].id;
                      return Card(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.docs[index]["notes"],
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]["uid"],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    btmSheetToUpdateNote(
                                        context,
                                        "${snapshot.data!.docs[index]["notes"]}",
                                        docId);
                                  },
                                  child: const Icon(Icons.edit)),
                              const SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("notes")
                                      .doc(docId)
                                      .delete()
                                      .then(
                                        (value) => Fluttertoast.showToast(
                                            msg: "Note Deleted Sucessfully"),
                                      );
                                },
                                child: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          btmSheetToAddNewNote(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

btmSheetToAddNewNote(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: ((context) {
        return Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    hintText: "Add Note",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.deepPurple,
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () async {
                    if (noteController.text != "") {
                      try {
                        await FirebaseFirestore.instance
                            .collection("notes")
                            .doc()
                            .set({
                          "createdAt": DateTime.now(),
                          "notes": noteController.text,
                          "uid": userId!.uid,
                        }).then(
                          (value) => Fluttertoast.showToast(
                              msg: "Note Added Sucessfully"),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Error $e");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Please Write Something!");
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
}

btmSheetToUpdateNote(BuildContext context, String text, var docId) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: ((context) {
        return Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: noteUpdateController..text = text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.deepPurple,
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc(docId)
                        .update({
                      "notes": noteUpdateController.text,
                    }).then(
                      (value) => Fluttertoast.showToast(
                          msg: "Note Updated Sucessfully"),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
}
