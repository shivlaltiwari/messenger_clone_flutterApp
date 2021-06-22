import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUserInfoDatabase(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("user")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future addMessage(
      String ChatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(ChatRoomId)
        .collection("Chats")
        .doc(messageId)
        .set(messageInfoMap.cast());
  }

  updateLastMessageSent(String chatRoomId, Map lastMessageInfo) {
    return FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatRoomId)
        .update(lastMessageInfo.cast());
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .get();
    if (snapShot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("ChatRoom")
          .doc(chatRoomId)
          .set(chatRoomInfoMap.cast());
    }
  }
}
