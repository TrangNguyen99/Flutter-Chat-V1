String getChatId({String fromId, String toId}) {
  if (fromId.compareTo(toId) < 0) {
    return '$fromId$toId';
  } else {
    return '$toId$fromId';
  }
}
