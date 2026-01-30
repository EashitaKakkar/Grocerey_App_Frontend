import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(), 
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  //WIDGET MOTION 
  @override
  State<MyApp> createState() => _MyAppState();
}

  
 
  class _MyAppState extends State<MyApp> {
  bool isExpanded= false;
  String selectedCategory = 'Popular'; //Current state
  String activeNav= "Home"; //current state

  // --- COLORS ---
  static const Color mainBackground = Color(0xFFF5F5F5);
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textA= Color(0xFF384042);
  static const Color buttonGray = Color(0xFF424242);

  // --- TEXT-STYLE ---
  static const TextStyle popularHeading = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      body: SafeArea(
  
        child: Stack( 
          children: [
            // 1. SCROLLABLE CONTENT (The main body)
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // --- HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('2464 Royal Ln. Mesa', 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Your address', 
                            style: TextStyle(color: textSecondary, fontSize: 12)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(20)),
                        child: const Row(
                          children: [
                            Icon(Icons.shopping_basket_outlined, color: Colors.white, size: 18),
                            SizedBox(width: 5),
                            Text('02', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),

                  // --- SEARCH BAR ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: textSecondary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- CATEGORIES ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      GestureDetector(
                         onTap: () {
                          setState(() {
                            isExpanded = !isExpanded; // Flips true to false and vice versa
                            });
                            },
                            child: Text(
                              isExpanded ? 'Show Less' : 'View All', 
                              style: const TextStyle(color: textSecondary),
                            ),
                        ),
                      ],
                    ),

                  AnimatedCrossFade(firstChild: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _categoryItem('assets/images/snacks.png'),
                      _categoryItem('assets/images/breakfast.png'),
                      _categoryItem('assets/images/canned.png'),
                      _categoryItem('assets/images/sauce2.png'),
                    ],
                  ), secondChild: GridView.count (
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 30,
                    childAspectRatio: 0.85,
                    children: [
                      _categoryItem('assets/images/snacks.png'),
                      _categoryItem('assets/images/breakfast.png'),
                      _categoryItem('assets/images/drinks.png'),
                      _categoryItem('assets/images/coffee.png'),
                      _categoryItem('assets/images/canned.png'),
                      _categoryItem('assets/images/fruits.png'),
                      _categoryItem('assets/images/vegetables.png'),
                      _categoryItem('assets/images/fish.png'),
                      _categoryItem('assets/images/meat.png'),
                    ],
                  ), 
                crossFadeState: isExpanded? CrossFadeState.showSecond: CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 2),
                  // --- POPULAR SECTION (Tabs) ---
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTab(context, 'Flash Sale'),
                        const SizedBox(width: 20),
                        _buildTab(context, 'Popular'),
                        const SizedBox(width: 20),
                        _buildTab(context, 'New Arrivals'),
                        const SizedBox(width: 20),
                        _buildTab(context, 'Snacks'),
                        const SizedBox(width: 20),
                        _buildTab(context, 'Breakfast'), 
                        const SizedBox(width: 20),
                        _buildTab(context, 'Canned'), 
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- PRODUCT GRID ---
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    children: _getFilteredProducts(),
                  ),
                  const SizedBox(height: 25), // Space so Nav Bar doesn't cover products
                ],
              ),
            ),

            // 2. FLOATING NAVIGATION BAR
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navItem(Icons.home, "Home"),
                    _navItem(Icons.grid_view, "Categories"),
                    _navItem(Icons.folder_open, "Orders"),
                    _navItem(Icons.person_outline, "Profile"),
                  ],
                ),
              ),
            ),
          ], // End of Stack children
        ),
      ),
    );
  }
  List<Widget> _getFilteredProducts() {
    if (selectedCategory == 'Snacks') {
      return [
        _productCard('Lays Chips', '50g', '\$2.00', 'assets/images/lays.png'),
        _productCard('Oreo', '100g', '\$3.50', 'assets/images/oreo.png'),
      ];
    } else if (selectedCategory == 'Popular') {
      return [
        _productCard('Mushroom Sauce', '24oz', '\$8.92', 'assets/images/sauce.png'),
        _productCard('Ghetto Gastro', '1 Kg', '\$20.72', 'assets/images/gastro.png'),
      ];
    } else if(selectedCategory == 'New Arrivals') {
      return [
        _productCard('Cake', '500g', '\$15', 'assets/images/cake'),
        _productCard('Onions', '500g', '\$13', 'assets/images/onion'),
      ];
    }else if(selectedCategory == 'Breakfast') {
      return [
        _productCard('Cake', '500g', '\$15', 'assets/images/cake'),
        _productCard('Onions', '500g', '\$13', 'assets/images/onion'),
      ];
    }else if(selectedCategory == 'Canned') {
      return [
        _productCard('Tuna', '500g', '\$15', 'assets/images/cake'),
        _productCard('Pickle', '500g', '\$13', 'assets/images/onion'),
      ];
    } else if(selectedCategory == 'Flash Sale') {
      return [
        _productCard('Tuna', '500g', '\$15', 'assets/images/cake'),
        _productCard('Onions', '500g', '\$13', 'assets/images/onion'),
      ];
    }else {
      return [
        const Center(child: Text("More items coming soon!")),
      ];
    }
  }
  Widget _buildTab(BuildContext context, String label) {
  bool isCurrentlySelected= selectedCategory==label;
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedCategory=label;
      });
    },
    child: Text(
      label,
      style: TextStyle(
        color: isCurrentlySelected? textA : textSecondary,
        fontSize: isCurrentlySelected ? 35 : 25, // "Popular" is larger in your UI
        fontWeight: FontWeight.bold ,
        fontFamily: 'FrancisOne-Regular',
      ),
    ),
  );
}

  Widget _categoryItem(String imgPath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80, height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.contain,
          ), 
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _productCard(String title, String weight, String price, String img) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 12, child: Center(child:Image.asset(img,fit: BoxFit.contain,errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, size: 50, color: Colors.red);
      },
      ),
    ),
  ),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'FrancisOne-Regular')),
          Text(weight, style: const TextStyle(color: textSecondary, fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: buttonGray, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              )
            ],
          )
        ],
      ),
    );
  }


  Widget _navItem(IconData icon, String label) {
    bool isActive= (activeNav==label);
    return GestureDetector(
      onTap: () {
        setState(() {
          activeNav= label;
        });
      },
      child: Container (
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isActive ? BoxDecoration(color: primaryGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(20)): null, 
        child: Row(
          children: [
            Icon(icon, color: isActive? primaryGreen: Colors.black54),
            if(isActive) const SizedBox(width: 8),
            if(isActive) Text(label, style: const TextStyle (color: primaryGreen, fontWeight: FontWeight.bold)),
          ],
        )
      )
      
      
    
    );
  }
}