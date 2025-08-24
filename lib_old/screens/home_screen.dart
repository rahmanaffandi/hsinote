import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/note_cubit.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      //body: const Center(child: Text('No notes yet')),

      body: BlocBuilder<NoteCubit, List<Note>>(
        builder: (context, notes) {
          if (notes.isEmpty) {
            return const Center(child: Text("No notes yet"));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(
                  note.title,
                  style: TextStyle(
                    decoration:
                    note.isFinished ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(note.content),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'finish') {
                      context.read<NoteCubit>().toggleFinished(index);
                    } else if (value == 'delete') {
                      context.read<NoteCubit>().deleteNote(index);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'finish', child: Text("Mark as Finished")),
                    const PopupMenuItem(
                        value: 'delete', child: Text("Delete")),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
