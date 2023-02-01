import 'package:health_ministry_research_library/imports.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key,
    required this.onTap,
    required this.buttonTitle,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kBottomContainerColour,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        width: double.infinity,
        height: 80.0,
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
