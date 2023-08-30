import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() => _instance;

  FirebaseService._();

  // FirebaseDatabase.instance.setPersistenceEnabled(true);

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // DatabaseReference get databaseRef => FirebaseDatabase.instance.ref();
}