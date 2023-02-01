import 'package:health_ministry_research_library/imports.dart';

class UserCard extends StatelessWidget {
  final String title;
  final String plan;

  const UserCard({super.key, required this.title, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageurl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Text(
                plan,
                style: GoogleFonts.poppins(
                  color: subtitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
