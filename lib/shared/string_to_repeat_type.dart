import 'package:countdown/database/repeat_type.dart';

extension ToRepeatType on String {
  RepeatType toRepeatType() {
    switch (this.toLowerCase()) {
      case 'weekly':
        return RepeatType.weekly;
      case 'monthly':
        return RepeatType.monthly;
      case 'yearly':
        return RepeatType.yearly;
      default:
        return RepeatType.none;
    }
  }
}
