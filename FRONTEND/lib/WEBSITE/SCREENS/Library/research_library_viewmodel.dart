import 'package:health_ministry_research_library/imports.dart';

class ResearchLibraryViewModel extends BaseViewModel {
  final String _title = "Home View";
  int _selectedFirstIndex = 1;
  int _selectedSecondIndex = 1;

  String get title => _title;
  int get firstIndex => _selectedFirstIndex;
  int get secondIndex => _selectedSecondIndex;

  changeFirstIndex(int index) {
    _selectedFirstIndex = index;

    notifyListeners();
  }

  changeSecondIndex(int index) {
    _selectedSecondIndex = index;

    notifyListeners();
  }
}
