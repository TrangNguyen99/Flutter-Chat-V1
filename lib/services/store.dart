import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test1/helper/helpers.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> addUser({String id, String username, String email}) async {
  try {
    await firestore.collection('Users').doc(id).set({
      'id': id,
      'name': username,
      'email': email,
    });

    return null;
  } catch (e) {
    print('Có lỗi:');
    print(e);
    return e.toString();
  }
}

Future<List<Map<String, dynamic>>> getUsersByName({String name}) async {
  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('Users')
        .where('name', isEqualTo: name)
        .get();

    List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    querySnapshot.docs.forEach((DocumentSnapshot element) {
      result.add(element.data());
    });

    return result;
  } catch (e) {
    print('Có lỗi:');
    print(e);
    return [];
  }
}

Future createChat({String fromId, String toId}) async {
  try {
    String chatId = getChatId(fromId: fromId, toId: toId);

    await firestore.collection('Chats').doc(chatId).set({
      'id': chatId,
    });
  } catch (e) {
    print('Có lỗi:');
    print(e);
  }
}

Future addMessage({String fromId, String toId, String content}) async {
  try {
    String chatId = getChatId(fromId: fromId, toId: toId);

    await firestore.collection('Chats').doc(chatId).collection('messages').add({
      'from_id': fromId,
      'to_id': toId,
      'content': content,
      'at': Timestamp.now(),
    });
  } catch (e) {
    print('Có lỗi:');
    print(e);
  }
}
