import 'package:health_ministry_research_library/imports.dart';

class ExclusiveCard extends StatelessWidget {
  final BookModel? bookData;

  const ExclusiveCard({super.key, this.bookData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => BookDetails(
                          bookData: bookData,
                        ),
                ),
              ),
          child: Container(
              width: 450,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                  color: exclusiveCardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      bookData!.imageUrl!,
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          bookData!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: titleColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        "By ${bookData!.author}",
                        style: GoogleFonts.poppins(
                          color: subtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                color: bookData!.bgColor,
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
                          const SizedBox(width: 30),
                          Text(
                            "${bookData!.reviewCount} Reviews",
                            style: GoogleFonts.poppins(
                              color: subtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 250,
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: ListView.builder(
                          itemCount: bookData!.genres!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                  right: 20,
                                  bottom: 5,
                                  top: 5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(5, 5),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  bookData!.genres![i],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: subtitleColor,
                                  ),
                                ));
                          },
                        ),
                      )
                    ],
                  )
                ],
              )),
      ),
    );
  }
}
