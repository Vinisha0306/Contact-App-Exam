import 'package:contact_app_exam/model/databaseModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/databaseController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController contactController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DbController listanble = Provider.of<DbController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Provider.of<DbController>(context).allContactData.isEmpty
            ? Center(child: Text('No Any Contact'))
            : ListView.builder(
                itemCount:
                    Provider.of<DbController>(context).allContactData.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % 18].shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(
                      Provider.of<DbController>(context)
                          .allContactData[index]
                          .name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      Provider.of<DbController>(context)
                          .allContactData[index]
                          .contact,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Uri call = Uri(
                              scheme: 'tel',
                              path: Provider.of<DbController>(context,
                                      listen: false)
                                  .allContactData[index]
                                  .contact,
                            );
                            await launchUrl(call);
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                        ),
                        //sms
                        IconButton(
                          onPressed: () async {
                            Uri sms = Uri(
                              scheme: 'sms',
                              path: Provider.of<DbController>(context,
                                      listen: false)
                                  .allContactData[index]
                                  .contact,
                            );
                            await launchUrl(sms);
                          },
                          icon: const Icon(
                            Icons.sms,
                            color: Colors.blueAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            nameController.text = Provider.of<DbController>(
                                    context,
                                    listen: false)
                                .allContactData[index]
                                .name;
                            contactController.text = Provider.of<DbController>(
                                    context,
                                    listen: false)
                                .allContactData[index]
                                .contact;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Update Contact'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        hintText: 'Enter Name',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: contactController,
                                      decoration: InputDecoration(
                                        labelText: 'Contact',
                                        hintText: 'Enter Contact Number',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<DbController>(context,
                                              listen: false)
                                          .updateData(
                                        contact: Contact(1, nameController.text,
                                            contactController.text),
                                        id: Provider.of<DbController>(context,
                                                listen: false)
                                            .allContactData[index]
                                            .id,
                                      );
                                      nameController.clear();
                                      contactController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Update'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.yellow,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            listanble.deleteData(
                              contact: Contact(1, nameController.text,
                                  contactController.text),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Contact'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                    ),
                  ),
                  TextFormField(
                    controller: contactController,
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      hintText: 'Enter Contact Number',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Provider.of<DbController>(context, listen: false)
                        .insertData(
                      contact: Contact(
                          1, nameController.text, contactController.text),
                    );
                    Navigator.pop(context);
                    nameController.clear();
                    contactController.clear();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Contact'),
      ),
    );
  }
}
