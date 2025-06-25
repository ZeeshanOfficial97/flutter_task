import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/providers/note_provider.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Notes',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a note...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0,),
            CustomButton(
                onPressed: () {
                  notesProvider.addNote(_controller.text);
                  _controller.clear();
                },
                size: size,
                label: 'Save'
              ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: notesProvider.notesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"));
                  }
                  
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final note = docs[index];
                      return Card(
                        child: ListTile(
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          tileColor: Colors.deepPurple.shade100,
                          title: Text(note['content'] ?? ''),
                          onLongPress: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Note'),
                                content: const Text('Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (shouldDelete == true) {
                              notesProvider.deleteNote(note.id);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Note deleted')),
                                );
                              }
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
