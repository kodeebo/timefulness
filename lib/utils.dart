String secondsToTimer<int>(time) {
  var minutes = (time / 60).floor();
  var seconds = (time % 60);
  if (minutes < 10) minutes = '0$minutes';
  if (seconds < 10) seconds = '0$seconds';
  return '$minutes : $seconds';
}
