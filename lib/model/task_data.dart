class TaskData {
  String taskText;
  bool isCheked;

  TaskData({required this.taskText, this.isCheked = false});

  bool toggle() {
    isCheked = !isCheked;
    return isCheked;
  }

  Map<String, dynamic> toJson() {
    return {
      'taskText': taskText,
      'isChecked': isCheked,
    };
  }
}
