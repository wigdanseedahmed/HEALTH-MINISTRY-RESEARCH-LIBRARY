import 'package:health_ministry_research_library/imports.dart';

class ReusableRegistrationCard extends StatelessWidget {
  const ReusableRegistrationCard({Key? key, required this.colour, required this.cardChild, required this.onPress}) : super(key: key);

  final Color colour;
  final Widget cardChild;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 2.0,
            color: colour,
          ),
        ),
      ),
    );
  }
}
