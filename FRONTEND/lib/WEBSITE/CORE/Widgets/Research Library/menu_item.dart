import 'package:health_ministry_research_library/imports.dart';

class ResearchLibraryMenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const ResearchLibraryMenuItem({super.key, required this.isSelected, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected ? titleColor : inactiveMenuItemColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: isSelected ? titleColor : inactiveMenuItemColor,
        ),
      ),
    );
  }
}