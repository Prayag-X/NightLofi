import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../firebase/database_playlist.dart';
import '../models/playlist.dart';
import 'user_provider.dart';

StateProvider<DatabasePlaylist> databasePlaylistProvider =
    StateProvider((ref) => DatabasePlaylist(uid: ref.watch(userId)));

final playlistIdProvider = StreamProvider.autoDispose<List<String>>((ref) {
  final databasePlaylist = ref.watch(databasePlaylistProvider);
  return databasePlaylist.readPlaylistIdsLofi();
});
