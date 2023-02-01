import 'package:health_ministry_research_library/imports.dart';

extension SizeExtension on num {
  num get sizeExtensionHeight => SizeConfig.height(toDouble());

  num get sizeExtensionWidth => SizeConfig.width(toDouble());

  num get sizeExtensionText => SizeConfig.textSize(toDouble());
}
