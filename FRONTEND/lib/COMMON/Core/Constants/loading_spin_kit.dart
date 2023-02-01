import 'package:health_ministry_research_library/imports.dart';

const rotatingCircleSpinKit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);

final fadingCircleSpinKit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);

final fadingFourSpinKit = SpinKitFadingFour(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);