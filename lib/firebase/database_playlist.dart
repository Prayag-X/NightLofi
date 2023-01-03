import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/playlist.dart';
import '../models/song.dart';

class DatabasePlaylist {
  DatabasePlaylist({required this.uid});

  final String uid;
  final firebaseDb = FirebaseFirestore.instance;
  final collectionUsers = FirebaseFirestore.instance.collection('Users');
  final collectionPlaylistLofi =
      FirebaseFirestore.instance.collection('Playlist-Lofi');
  final collectionPlaylistNight =
      FirebaseFirestore.instance.collection('Playlist-Night');

  List<String> _playlistIdsSnap(DocumentSnapshot snapshot) => List<String>.from(
      snapshot.get('playlist_lofi').map((id) => id).toList());

  Stream<List<String>> readPlaylistIdsLofi() => collectionUsers
      .doc(uid)
      .snapshots(includeMetadataChanges: true)
      .map(_playlistIdsSnap);

  Song _songSnap(DocumentSnapshot snapshot) => Song(
        name: snapshot.get('name'),
        tracker: snapshot.get('tracker'),
      );

  Playlist _playlistSnap(DocumentSnapshot snapshot) => Playlist(
        name: snapshot.get('name'),
      );

  Stream<Playlist> readPlaylistLofi(String playlistId) => collectionPlaylistLofi
      .doc(playlistId)
      .snapshots(includeMetadataChanges: true)
      .map(_playlistSnap);

  // Stream<Song> readSong(String playlistId) {
  //   DocumentReference dataCollection = FirebaseFirestore.instance
  //       .collection('Rooms')
  //       .doc(roomID)
  //       .collection('Quiz')
  //       .doc('recent leaderboard');
  //   return dataCollection
  //       .snapshots(includeMetadataChanges: true)
  //       .map(_songSnap);
  // }
}
