import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';
import 'package:password_manager/data/repositories/auth_repository.dart';
import 'package:password_manager/pages/SignIn/sign_in.dart';
import 'package:password_manager/services/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context)),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SignIn(),
          ),
        ));
  }
}
