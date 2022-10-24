// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:tankdrum_learning/models/instruments/instrument.dart';
import 'package:tankdrum_learning/models/song_lib.dart';
import 'package:tankdrum_learning/models/sound_note.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});
}

testFindSoundSet() {
  final instrument = Instrument.getInstrument(Instrument.tankDrum);
  traceSoundSet(Set<int> idxSet) {
    print('source: $idxSet, length: ${idxSet.length}');
    final result =
        SoundNote.findProperSoundSet(instrument.deltaCycleIdx, idxSet, 15);
    print('length: ${result.length}, result: $result');
  }

  // traceSoundSet({5, 6, 7, 4, 7, 2, 21, 4});
  // traceSoundSet({33, 45, 32, 45, 67, 44, 22, 46, 48, 65});
  // traceSoundSet({33, 45, 32, 45, 44, 22, 46, 48});
  // traceSoundSet({27, 29, 31, 32, 34, 36, 38, 39, 41, 43, 44, 46});
  // traceSoundSet(SongLib.happyBirthDay.map((e) => e.soundIdx).toSet());
  // traceSoundSet(SongLib.castleInTheSky.map((e) => e.soundIdx).toSet());
  // traceSoundSet(SongLib.endlessLove.map((e) => e.soundIdx).toSet());
  // traceSoundSet(SongLib.proudOfYou.map((e) => e.soundIdx).toSet());
}

testFillDelta1() {
  final cycle = [2, 2, 1, 2, 2, 2, 1];
  final result = <int>[0];
  for (int i = 1; i < 21; i++) {
    final time = i ~/ cycle.length;

    int add = cycle[(i - 1) % cycle.length];
    result.add(result[i - 1] + add);

    print('i: $i, time: $time, add: $add, result: ${result[i]}');
  }
  print(result);
}

fillTank() {
  final test = [2, 2, 1, 2, 2, 2];
  int first = SoundNote.getNoteIdx('G#3');
  int count = 0;
  final result = [first];
  for (int i = 1; i < 21; i++) {
    if (count == test.length) {
      count = 0;
      result.add(result[i - 1] + 1);
    } else {
      result.add(result[i - 1] + test[count]);
      count++;
    }
  }
  const tank15 = 'F#3,A3,C#5,C#4,E5,E4,F#5,F#4,D5,D4,B4,B3,G4,G3,A4';
  const tank9 = 'A3,C4,C5,D4,E5,G4,D5,E4,A4';
  const kalimba21 =
      'G#3,A#3,C4,C#4,D#4,F4,G4,G#4,A#4,C5,C#5,D#5,F5,G5,G#5,A#5,C6,C#6,D#6,F6,G6';
  int edit = SoundNote.getNoteIdx('G#3') - SoundNote.getNoteIdx('C3');
  final list =
      kalimba21.split(',').map((s) => SoundNote.getNoteIdx(s)).toList();
  list.sort();
  print(list.length);
  final tuning = <String>[];
  for (int i = 0; i < list.length; i++) {
    tuning.add(SoundNote.getNoteName(list[i] - edit));
    if (i > 0) {
      list[i] -= list[0];
    }

    print('$i: ${list[i]},');
  }
  print(tuning);
}
