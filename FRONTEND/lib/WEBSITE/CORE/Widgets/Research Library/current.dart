import 'package:health_ministry_research_library/imports.dart';

class Current extends StatelessWidget {
  const Current({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Book Listening",
          style: GoogleFonts.poppins(
            color: inactiveMenuItemColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 100,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(10, 10),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]),
          child: ListTile(
            leading: Image.network(
              "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1475462006l/29868604._SY475_.jpg",
              height: 100,
              width: 40,
            ),
            title: Text(
              "Monkey Grip",
              style: GoogleFonts.poppins(
                color: titleColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              "Helen Warner",
              style: GoogleFonts.poppins(
                color: subtitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.play_arrow,
              color: titleColor,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}