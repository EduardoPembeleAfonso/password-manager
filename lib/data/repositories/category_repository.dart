import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryRepository {
  //Create new FirebaseStorage Instance
  final FirebaseStorage storage = FirebaseStorage.instance;

// Create a storage reference from our app
  // final _storageRef = FirebaseStorage.instance.ref();

  // final mountainsRef = _storageRef.child('images');

  //Create new FirebaseStorage Instance
//   final FirebaseStorage storage = FirebaseStorage.instance;
// //Creating storage refernce (this will create a images folder in cloud storage)
//   final storageRef = storage.ref().child('images');

//   uploadImage(File file) async {
//     //Create new FirebaseStorage Instance
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     //This will get the filename with file extension
//     String fileName = file.path.split('/').last;
//     //Creating storage refernce (this will create a images folder in cloud storage)
//     //This will save the file as {images/{file.name}}
//     final storageRef = storage.ref().child('images').child(fileName);
//     //Use putFile method to upload the File
//     await storageRef.putFile(file);
//     //Retrieve the url
//     //You can use this url to show or download the saved image
//     final downloadUrl = await storageRef.getDownloadURL();
//   }

  //reference to document
  final _dbRef = FirebaseFirestore.instance
      .collection('category')
      .doc('CustomDocumentName1');

  Future<void> createCategory({
    required String name,
    required image,
  }) async {
    try {
      //This will get the filename with file extension
      String fileName = image.split('/').last;
      //Creating storage refernce (this will create a images folder in cloud storage)
      //This will save the file as {images/{file.name}}
      final storageRef = storage.ref().child('images').child(fileName);
      //Use putFile method to upload the File
      // final file = await storageRef.putFile(image);
      final jsonData = {'name': name, 'image': storageRef};

      final data = await _dbRef.set(jsonData).then((value) {
        name = '';
        image = '';
      });
      print('storageRef');
      print(storageRef);

      return data;
    } catch (e) {
      print('error in catch create category');
      print(e);
      throw Exception(e);
    }
  }

  Future<void> updateCategory(
      {required String newName,
      required String newImage,
      required String categoryId}) async {
    _dbRef.collection('category').doc(categoryId);
    final jsonData = {'name': newName, 'image': newImage, 'id': categoryId};
    await _dbRef.update(jsonData);
  }

  Future<void> deleteCategory({required String categoryId}) async {
    final docData =
        FirebaseFirestore.instance.collection('category').doc(categoryId);
    await docData.delete();
  }
}

  // final DatabaseReference _dbRef = FirebaseService().databaseRef.child('category');
  // final FirebaseFirestore db;

  // // db.settings = const Settings(persistenceEnabled: true);

  // Future<void> createCategory(String name, String image) async {
  //   final newCategoryRef = _dbRef.push();
  //   await newCategoryRef.set({
  //     'name': name,
  //     'image': image,
  //   });
  // }

  // Future<DatabaseEvent> readCategorys() async {
  //   return await _dbRef.once();
  // }

  // Future<void> updateCategory(
  //     String categoryId, String newName, String newImage) async {
  //   final categoryRef = _dbRef.child(categoryId);
  //   await categoryRef.update({
  //     'name': newName,
  //     'image': newImage,
  //   });
  // }

  // Future<void> deleteCategory(String categoryId) async {
  //   final categoryRef = _dbRef.child(categoryId);
  //   await categoryRef.remove();
  // }

  // Future<void> SignUp({required String email, required String password}) async {
  //   try {} catch (e) {
  //     throw Exception(e);
  //   }
  // }
