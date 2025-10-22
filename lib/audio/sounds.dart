List<String> soundTypeToFilename(SfxType type) => switch (type) {
  SfxType.buttonClick => const ['button-click-1.wav', 'button-click-2.wav'],
  SfxType.cardPlaced => const ['card-placed-1.wav', 'card-placed-2.wav'],
  SfxType.cardNotPlaced => const [
    'card-unaccepted-1.wav',
    'card-unaccepted-2.wav',
  ],
  SfxType.transition => const ['transition-1.wav', 'transition-2.wav'],
  SfxType.meterFull => const ['meter-full.wav'],
  SfxType.utilPlaced => const ['util-placed.wav'],
};

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.transition:
      return 0.5;
    case SfxType.cardPlaced:
    case SfxType.cardNotPlaced:
    case SfxType.buttonClick:
    case SfxType.meterFull:
    case SfxType.utilPlaced:
      return 1.0;
  }
}

enum SfxType {
  buttonClick,
  cardPlaced,
  cardNotPlaced,
  transition,
  meterFull,
  utilPlaced,
  // TODO: Add win/lose sounds
}
