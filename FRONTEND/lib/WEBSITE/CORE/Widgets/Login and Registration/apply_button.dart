import 'package:health_ministry_research_library/imports.dart';

Widget applyButton(BuildContext context, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 50, vertical: MediaQuery.of(context).size.width / 180),
    decoration: BoxDecoration(
      color: isSelected == false ? Colors.white: kViolet,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          spreadRadius: 10,
          blurRadius: 12,
        ),
      ],
    ),
    child: const Text(
      'Apply',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    ),
  );
}