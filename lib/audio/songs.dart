const Set<Song> songs = {
  Song('inspiring-motivation-synthwave.mp3', 'song A'),
  Song('mezhdunami-flashes.mp3', 'song B'),
  Song('synthwave-80s-retro.mp3', 'song C'),
};

class Song {
  final String filename;

  final String name;

  const Song(this.filename, this.name);

  @override
  String toString() => 'Song<$filename>';
}
