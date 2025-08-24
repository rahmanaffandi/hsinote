import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cubit/note_cubit.dart';
import 'models/note_model.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  final notesBox = await Hive.openBox<NoteModel>('notes');
  runApp(HsiNoteApp(notesBox: notesBox));
}

class HsiNoteApp extends StatelessWidget {
  final Box<NoteModel> notesBox;
  const HsiNoteApp({super.key, required this.notesBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NoteCubit(notesBox)..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HSI Note',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
