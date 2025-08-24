import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/note_cubit.dart';
import '../models/note_model.dart';
import 'note_form_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocBuilder<NoteCubit, List<NoteModel>>(
        builder: (context, notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              final note = notes[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: TextStyle(
                      decoration:
                          note.isFinished ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'finish') {
                        context.read<NoteCubit>().toggleFinished(note.id);
                      } else if (value == 'delete') {
                        context.read<NoteCubit>().deleteNote(note.id);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'finish', child: Text('Mark as finished')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
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
            MaterialPageRoute(builder: (_) => const NoteFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
