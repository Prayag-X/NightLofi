import 'package:cloud_firestore/cloud_firestore.dart';
import 'song.dart';

class Playlist {

  String? name;
  Stream<Song>? songs;

  Playlist({this.name, this.songs});
}