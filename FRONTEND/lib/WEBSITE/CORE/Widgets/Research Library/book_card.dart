import 'package:health_ministry_research_library/imports.dart';

class BookCard extends StatelessWidget {
  final BookModel? bookData;

  const BookCard({super.key, this.bookData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BookDetails(
                        bookData: bookData,
                      )),
            ),
        child: Column(
          children: [
            Hero(
              tag: bookData!.name!,
              child: Stack(children: [
                Container(
                  height: 250,
                  width: 200,
                  margin: const EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    color: bookData!.bgColor!,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 40,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        bookData!.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: 50,
                  child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: bookData!.bgColor!,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: titleColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            bookData!.rating!,
                            style: GoogleFonts.poppins(
                              color: titleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      )),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 80,
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ]),
              child: Text(
                bookData!.name!,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: subtitleColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ));
  }
}
