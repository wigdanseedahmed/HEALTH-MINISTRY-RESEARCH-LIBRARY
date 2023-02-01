import 'package:health_ministry_research_library/imports.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ResearchLibraryMenuItem(
          title: 'Explore',
          isSelected: true,
        ),
        ResearchLibraryMenuItem(
          title: 'Categories',
          isSelected: false,
        ),
        ResearchLibraryMenuItem(
          title: 'Saved',
          isSelected: false,
        ),
        ResearchLibraryMenuItem(
          title: 'Book Plans',
          isSelected: false,
        ),
        ResearchLibraryMenuItem(
          title: 'Preference',
          isSelected: false,
        ),
      ],
    );
  }
}