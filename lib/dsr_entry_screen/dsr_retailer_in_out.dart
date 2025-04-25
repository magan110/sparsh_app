import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

// Import necessary DSR screens for navigation (assuming they are in the same directory)
// Please verify these import paths match your project structure.
import 'Meeting_with_new_purchaser.dart';
import 'Meetings_With_Contractor.dart';
import 'any_other_activity.dart';
import 'btl_activites.dart';
import 'check_sampling_at_site.dart';
import 'dsr_entry.dart'; // Assuming DsrEntry is the main entry point
import 'dsr_retailer_in_out.dart'; // This is the current file, keep it
import 'internal_team_meeting.dart';
import 'office_work.dart';
import 'on_leave.dart';
import 'phone_call_with_builder.dart';
import 'phone_call_with_unregisterd_purchaser.dart';
import 'work_from_home.dart';
import 'package:learning2/screens/Home_screen.dart'; // Assuming HomeScreen is in this path


class DsrRetailerInOut extends StatefulWidget {
  const DsrRetailerInOut({super.key});

  @override
  State<DsrRetailerInOut> createState() => _DsrRetailerInOutState();
}

class _DsrRetailerInOutState extends State<DsrRetailerInOut> {
  // State variables for dropdowns and date pickers
  String? _puchaserRetailerItem = 'Select';
  final List<String> _puchaserRetailerdropdownItems = [
    'Select',
    'AD',
    'Stokiest/Urban Stokiest',
    'Direct Dealer',
    'Retailer',
    'Rural Stokiest'
  ];

  String? _areaCode = 'Select';
  final List<String> _majorCitiesInIndia = [
    'Select',
    'Agra', 'Ahmedabad', 'Ajmer', 'Akola', 'Aligarh',
    'Allahabad', 'Alwar', 'Ambala', 'Amravati', 'Amritsar',
    'Anand', 'Anantapur', 'Aurangabad', 'Asansol', 'Bareilly',
    'Bengaluru', 'Belgaum', 'Bhagalpur', 'Bhavnagar', 'Bhilai',
    'Bhiwandi', 'Bhopal', 'Bhubaneswar', 'Bikaner', 'Bilaspur',
    'Bokaro Steel City', 'Chandigarh', 'Chennai', 'Coimbatore', 'Cuttack',
    'Dehradun', 'Delhi', 'Dhanbad', 'Durgapur', 'Erode',
    'Faridabad', 'Firozabad', 'Gandhinagar', 'Ghaziabad', 'Gorakhpur',
    'Guntur', 'Gurgaon', 'Guwahati', 'Gwalior', 'Haldwani',
    'Haridwar', 'Hubli-Dharwad', 'Hyderabad', 'Imphal', 'Indore',
    'Itanagar', 'Jabalpur', 'Jaipur', 'Jalandhar', 'Jammu',
    'Jamshedpur', 'Jhansi', 'Jodhpur', 'Junagadh', 'Kakinada',
    'Kalyan-Dombivli', 'Kanpur', 'Kochi', 'Kolhapur', 'Kolkata',
    'Kollam', 'Kota', 'Kozhikode', 'Kurnool', 'Lucknow',
    'Ludhiana', 'Madurai', 'Malappuram', 'Mangalore', 'Meerut',
    'Mira-Bhayandar', 'Moradabad', 'Mumbai', 'Mysuru', 'Nagpur',
    'Nanded', 'Nashik', 'Navi Mumbai', 'Nellore', 'Noida',
    'Patna', 'Pimpri-Chinchwad', 'Prayagraj', 'Pune', 'Raipur',
    'Rajkot', 'Rajahmundry', 'Ranchi', 'Rohtak', 'Rourkela',
    'Saharanpur', 'Salem', 'Sangli-Miraj & Kupwad', 'Shillong', 'Shimla',
    'Siliguri', 'Solapur', 'Srinagar', 'Surat', 'Thane',
    'Thiruvananthapuram', 'Thrissur', 'Tiruchirappalli', 'Tirunelveli', 'Tiruppur',
    'Udaipur', 'Ujjain', 'Ulhasnagar', 'Vadodara', 'Varanasi',
    'Vasai-Virar', 'Vijayawada', 'Visakhapatnam', 'Warangal', 'Yamunanagar',
    // Add more cities here as required
  ];

  // City coordinates mapping (more cities added for demonstration)
  final Map<String, Map<String, double>> _cityCoordinates = {
    'Agra': {'latitude': 27.1767, 'longitude': 78.0081},
    'Ahmedabad': {'latitude': 23.0225, 'longitude': 72.5714},
    'Ajmer': {'latitude': 26.4499, 'longitude': 74.6399},
    'Akola': {'latitude': 20.7063, 'longitude': 77.0202},
    'Aligarh': {'latitude': 27.8974, 'longitude': 78.0880},
    'Allahabad': {'latitude': 25.4358, 'longitude': 81.8463},
    'Alwar': {'latitude': 27.5663, 'longitude': 76.6345},
    'Ambala': {'latitude': 30.3782, 'longitude': 76.7767},
    'Amravati': {'latitude': 20.9374, 'longitude': 77.7797},
    'Amritsar': {'latitude': 31.6340, 'longitude': 74.8737},
    'Anand': {'latitude': 22.5645, 'longitude': 72.9288},
    'Anantapur': {'latitude': 14.6819, 'longitude': 77.6006},
    'Aurangabad': {'latitude': 19.8762, 'longitude': 75.3433},
    'Asansol': {'latitude': 23.6853, 'longitude': 86.9510},
    'Bareilly': {'latitude': 28.3670, 'longitude': 79.4304},
    'Bengaluru': {'latitude': 12.9716, 'longitude': 77.5946},
    'Belgaum': {'latitude': 15.8500, 'longitude': 74.5000},
    'Bhagalpur': {'latitude': 25.2423, 'longitude': 86.9857},
    'Bhavnagar': {'latitude': 21.7652, 'longitude': 72.1519},
    'Bhilai': {'latitude': 21.2167, 'longitude': 81.3833},
    'Bhiwandi': {'latitude': 19.2808, 'longitude': 73.0658},
    'Bhopal': {'latitude': 23.2599, 'longitude': 77.4126},
    'Bhubaneswar': {'latitude': 20.2961, 'longitude': 85.8245},
    'Bikaner': {'latitude': 28.0229, 'longitude': 73.3119},
    'Bilaspur': {'latitude': 22.0929, 'longitude': 82.1407},
    'Bokaro Steel City': {'latitude': 23.6610, 'longitude': 85.9790},
    'Chandigarh': {'latitude': 30.7333, 'longitude': 76.7794},
    'Chennai': {'latitude': 13.0827, 'longitude': 80.2707},
    'Coimbatore': {'latitude': 11.0168, 'longitude': 76.9558},
    'Cuttack': {'latitude': 20.4625, 'longitude': 85.8830},
    'Dehradun': {'latitude': 30.0668, 'longitude': 78.3427},
    'Delhi': {'latitude': 28.7041, 'longitude': 77.1025},
    'Dhanbad': {'latitude': 23.7957, 'longitude': 86.4304},
    'Durgapur': {'latitude': 23.5204, 'longitude': 87.3119},
    'Erode': {'latitude': 11.3410, 'longitude': 77.7172},
    'Faridabad': {'latitude': 28.4089, 'longitude': 77.3178},
    'Firozabad': {'latitude': 27.1500, 'longitude': 78.4200},
    'Gandhinagar': {'latitude': 23.2156, 'longitude': 72.6369},
    'Ghaziabad': {'latitude': 28.6692, 'longitude': 77.4538},
    'Gorakhpur': {'latitude': 26.7606, 'longitude': 83.3731},
    'Guntur': {'latitude': 16.3067, 'longitude': 80.4428},
    'Gurgaon': {'latitude': 28.4595, 'longitude': 77.0266},
    'Guwahati': {'latitude': 26.1445, 'longitude': 91.7362},
    'Gwalior': {'latitude': 26.2183, 'longitude': 78.1741},
    'Haldwani': {'latitude': 29.2167, 'longitude': 79.5167},
    'Haridwar': {'latitude': 29.9457, 'longitude': 78.1642},
    'Hubli-Dharwad': {'latitude': 15.3647, 'longitude': 75.1240},
    'Hyderabad': {'latitude': 17.3850, 'longitude': 78.4867},
    'Imphal': {'latitude': 24.8170, 'longitude': 93.9368},
    'Indore': {'latitude': 22.7196, 'longitude': 75.8577},
    'Itanagar': {'latitude': 27.1000, 'longitude': 93.6200},
    'Jabalpur': {'latitude': 23.1815, 'longitude': 79.9215},
    'Jaipur': {'latitude': 26.9124, 'longitude': 75.7873},
    'Jalandhar': {'latitude': 31.3260, 'longitude': 75.5762},
    'Jammu': {'latitude': 32.7333, 'longitude': 74.8500},
    'Jamshedpur': {'latitude': 22.8045, 'longitude': 86.2029},
    'Jhansi': {'latitude': 25.4484, 'longitude': 78.5685},
    'Jodhpur': {'latitude': 26.2389, 'longitude': 73.0243},
    'Junagadh': {'latitude': 21.5200, 'longitude': 70.5500},
    'Kakinada': {'latitude': 16.9900, 'longitude': 82.2000},
    'Kalyan-Dombivli': {'latitude': 19.2167, 'longitude': 73.1333},
    'Kanpur': {'latitude': 26.4499, 'longitude': 80.3319},
    'Kochi': {'latitude': 9.9312, 'longitude': 76.2673},
    'Kolhapur': {'latitude': 16.7050, 'longitude': 74.2433},
    'Kolkata': {'latitude': 22.5726, 'longitude': 88.3639},
    'Kollam': {'latitude': 8.8932, 'longitude': 76.6141},
    'Kota': {'latitude': 25.2138, 'longitude': 75.8648},
    'Kozhikode': {'latitude': 11.2588, 'longitude': 75.7804},
    'Kurnool': {'latitude': 15.8281, 'longitude': 78.0369},
    'Lucknow': {'latitude': 26.8467, 'longitude': 80.9462},
    'Ludhiana': {'latitude': 30.9010, 'longitude': 75.8573},
    'Madurai': {'latitude': 9.9252, 'longitude': 78.1149},
    'Malappuram': {'latitude': 11.0590, 'longitude': 76.0730},
    'Mangalore': {'latitude': 12.9141, 'longitude': 74.8560},
    'Meerut': {'latitude': 28.9845, 'longitude': 77.7064},
    'Mira-Bhayandar': {'latitude': 19.2900, 'longitude': 72.8500},
    'Moradabad': {'latitude': 28.8380, 'longitude': 78.7680},
    'Mumbai': {'latitude': 19.0760, 'longitude': 72.8777},
    'Mysuru': {'latitude': 12.2958, 'longitude': 76.6394},
    'Nagpur': {'latitude': 21.1458, 'longitude': 79.0882},
    'Nanded': {'latitude': 19.1387, 'longitude': 77.3224},
    'Nashik': {'latitude': 19.9975, 'longitude': 73.7898},
    'Navi Mumbai': {'latitude': 19.0330, 'longitude': 73.0297},
    'Nellore': {'latitude': 14.4426, 'longitude': 79.9865},
    'Noida': {'latitude': 28.5355, 'longitude': 77.3910},
    'Patna': {'latitude': 25.5941, 'longitude': 85.1376},
    'Pimpri-Chinchwad': {'latitude': 18.6278, 'longitude': 73.8008},
    'Prayagraj': {'latitude': 25.4358, 'longitude': 81.8463},
    'Pune': {'latitude': 18.5204, 'longitude': 73.8567},
    'Raipur': {'latitude': 21.2514, 'longitude': 81.6296},
    'Rajkot': {'latitude': 22.2959, 'longitude': 70.7984},
    'Rajahmundry': {'latitude': 17.0000, 'longitude': 81.8000},
    'Ranchi': {'latitude': 23.3441, 'longitude': 85.3096},
    'Rohtak': {'latitude': 28.8955, 'longitude': 76.6066},
    'Rourkela': {'latitude': 22.2608, 'longitude': 84.8522},
    'Saharanpur': {'latitude': 29.9649, 'longitude': 77.5468},
    'Salem': {'latitude': 11.6643, 'longitude': 78.1460},
    'Sangli-Miraj & Kupwad': {'latitude': 16.8667, 'longitude': 74.5667},
    'Shillong': {'latitude': 25.5788, 'longitude': 91.8933},
    'Shimla': {'latitude': 31.1048, 'longitude': 77.1734},
    'Siliguri': {'latitude': 26.7271, 'longitude': 88.3953},
    'Solapur': {'latitude': 17.6599, 'longitude': 75.9064},
    'Srinagar': {'latitude': 34.0836, 'longitude': 74.7973},
    'Surat': {'latitude': 21.1702, 'longitude': 72.8311},
    'Thane': {'latitude': 19.2183, 'longitude': 73.0741},
    'Thiruvananthapuram': {'latitude': 8.5241, 'longitude': 76.9361},
    'Thrissur': {'latitude': 10.5276, 'longitude': 76.2144},
    'Tiruchirappalli': {'latitude': 10.8150, 'longitude': 78.6970},
    'Tirunelveli': {'latitude': 8.7139, 'longitude': 77.7567},
    'Tiruppur': {'latitude': 11.1085, 'longitude': 77.3411},
    'Udaipur': {'latitude': 24.5854, 'longitude': 73.7125},
    'Ujjain': {'latitude': 23.1794, 'longitude': 75.7885},
    'Ulhasnagar': {'latitude': 19.2167, 'longitude': 73.1667},
    'Vadodara': {'latitude': 22.3072, 'longitude': 73.1812},
    'Varanasi': {'latitude': 25.3176, 'longitude': 82.9739},
    'Vasai-Virar': {'latitude': 19.4200, 'longitude': 72.8200},
    'Vijayawada': {'latitude': 16.5062, 'longitude': 80.6480},
    'Visakhapatnam': {'latitude': 17.6868, 'longitude': 83.2185},
    'Warangal': {'latitude': 17.9689, 'longitude': 79.5941},
    'Yamunanagar': {'latitude': 30.1381, 'longitude': 77.2677},
  };

  // Controller for the Report Date text field
  final TextEditingController _dateController = TextEditingController();
  // State variable to hold the selected Report Date
  DateTime? _selectedDate;

  // Location controllers
  final TextEditingController _yourLatitudeController = TextEditingController();
  final TextEditingController _yourLongitudeController = TextEditingController();
  final TextEditingController _custLatitudeController = TextEditingController();
  final TextEditingController _custLongitudeController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _dateController.dispose();
    _yourLatitudeController.dispose();
    _yourLongitudeController.dispose();
    _custLatitudeController.dispose();
    _custLongitudeController.dispose();
    super.dispose();
  }

  // Function to determine the current position using Geolocator
  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, show an error
      throw ('Location services are disabled. Please enable them.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permissions are denied, request them
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are still denied, show an error
        throw ('Location permissions are denied. Please grant permissions in settings.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, show an error
      throw ('Location permissions are permanently denied. Please enable them in app settings.');
    }
    // Permissions are granted, get the current position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // Function to capture and display your current location
  Future<void> _captureYourLocation() async {
    try {
      final pos = await _determinePosition();
      setState(() {
        _yourLatitudeController.text = pos.latitude.toString();
        _yourLongitudeController.text = pos.longitude.toString();
      });
    } catch (e) {
      // Show error message if location cannot be captured
      _showError(e.toString());
    }
  }

  // Function to capture and display the customer's location
  Future<void> _captureCustomerLocation() async {
    try {
      final pos = await _determinePosition();
      setState(() {
        _custLatitudeController.text = pos.latitude.toString();
        _custLongitudeController.text = pos.longitude.toString();
      });
    } catch (e) {
      // Show error message if location cannot be captured
      _showError(e.toString());
    }
  }

  // Function to show an error dialog
  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  // Function to pick the report date
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          // Apply a custom theme for the date picker
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black87, // Body text color
            ),
            dialogBackgroundColor: Colors.white, // Dialog background
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Helper for navigation (similar to other DSR screens)
  void _navigateTo(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Light grey background for the body
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // Navigate back to the DsrEntry screen or HomeScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DsrEntry()), // Navigate back to DsrEntry
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white, // White back arrow icon
            ),
          ),
          title: const Text(
            'DSR Retailer IN OUT',
            style: TextStyle(
              color: Colors.white, // White title text
              fontSize: 24, // Slightly smaller font size for a cleaner look
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueAccent, // A slightly brighter blue for AppBar
          elevation: 4.0, // Add shadow to AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Reduced padding slightly
          child: Form(
            key: _formKey, // Assign the form key
            child: ListView(
              children: [
                // Instructions Section (Optional for this screen, keeping for consistency)
                const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 24, // Adjusted font size
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Match AppBar color
                  ),
                ),
                const SizedBox(height: 24), // Increased spacing


                // Purchaser / Retailer Dropdown
                _buildLabel('Purchaser / Retailer'),
                const SizedBox(height: 8), // Reduced spacing below label
                _buildDropdownField(
                  value: _puchaserRetailerItem,
                  items: _puchaserRetailerdropdownItems,
                  onChanged: (val) {
                    if (val != null) setState(() => _puchaserRetailerItem = val);
                  },
                ),

                const SizedBox(height: 24), // Increased spacing

                // Area code Dropdown (Searchable)
                _buildLabel('Area code *:'),
                const SizedBox(height: 8),
                _buildSearchableDropdownField( // Using the styled searchable dropdown
                  selected: _areaCode!, // Use non-nullable as it's initialized
                  items: _majorCitiesInIndia,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _areaCode = val;
                        // Set latitude and longitude based on the selected area code
                        if (_cityCoordinates.containsKey(val)) {
                          _custLatitudeController.text = _cityCoordinates[val]!['latitude']!.toString();
                          _custLongitudeController.text = _cityCoordinates[val]!['longitude']!.toString();
                        } else {
                          // Clear coordinates if city not found in map
                          _custLatitudeController.clear();
                          _custLongitudeController.clear();
                        }
                      });
                    }
                  },
                ),

                const SizedBox(height: 24), // Increased spacing

                // Code Field with Search Button
                _buildLabel('Code *:'),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
                  children: [
                    Expanded(
                      child: _buildTextField('Purchaser code'), // Using styled text field helper
                    ),
                    const SizedBox(width: 8), // Spacing between text field and button
                    _buildIconButton(Icons.search, () { // Using styled icon button helper
                      // TODO: perform code search
                    }),
                  ],
                ),

                const SizedBox(height: 24), // Increased spacing

                // Customer Name Field
                _buildLabel('Customer Name*:'),
                const SizedBox(height: 8),
                _buildTextField('Enter Customer Name'), // Using styled text field helper

                const SizedBox(height: 24), // Increased spacing

                // Report Date Field
                _buildLabel('Report Date*'),
                const SizedBox(height: 8),
                _buildDateField(_dateController, _pickDate, 'Select Date'), // Using styled date field helper

                const SizedBox(height: 24), // Increased spacing

                // Your Latitude Field
                _buildLabel('Your Latitude'),
                const SizedBox(height: 8),
                _buildTextField('Your Latitude', controller: _yourLatitudeController, readOnly: true), // Styled and read-only

                const SizedBox(height: 16), // Consistent spacing

                // Your Longitude Field
                _buildLabel('Your Longitude'),
                const SizedBox(height: 8),
                _buildTextField('Your Longitude', controller: _yourLongitudeController, readOnly: true), // Styled and read-only

                const SizedBox(height: 24), // Increased spacing

                // Retailer’s Latitude Field
                _buildLabel('Retailer’s Latitude:'),
                const SizedBox(height: 8),
                _buildTextField('Retailer’s Latitude', controller: _custLatitudeController, readOnly: true), // Styled and read-only

                const SizedBox(height: 16), // Consistent spacing

                // Retailer’s Longitude Field
                _buildLabel('Retailer’s Longitude:'),
                const SizedBox(height: 8),
                _buildTextField('Retailer’s Longitude', controller: _custLongitudeController, readOnly: true), // Styled and read-only

                const SizedBox(height: 30), // Increased spacing before buttons

                // Action Buttons
                _buildButton('Capture Your Location', _captureYourLocation),
                const SizedBox(height: 16), // Consistent spacing between buttons
                _buildButton('Capture Customer Location', _captureCustomerLocation),
                const SizedBox(height: 16),
                _buildButton('IN', () {
                  // TODO: IN logic
                  if (_formKey.currentState!.validate()) {
                    // Process form data
                    print('Form is valid. Performing IN logic.');
                    // Add your IN logic here
                  }
                }),
                const SizedBox(height: 16),
                _buildButton('Exception Entry', () {
                  // TODO: exception logic
                  if (_formKey.currentState!.validate()) {
                    // Process form data
                    print('Form is valid. Performing Exception Entry logic.');
                    // Add your exception logic here
                  }
                }),
                const SizedBox(height: 20), // Spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Methods for Building Widgets (Copied from previous screens) ---

  // Helper to build a standard text field
  Widget _buildTextField(
      String hintText, {
        TextEditingController? controller,
        TextInputType? keyboardType,
        int maxLines = 1, // Default to single line
        String? Function(String?)? validator,
        bool readOnly = false, // Added readOnly parameter
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly, // Apply readOnly property
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500], // Slightly darker grey hint text
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          borderSide: BorderSide.none, // No visible border line
        ),
        filled: true, // Add a background fill
        fillColor: Colors.white, // White background for text fields
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Adjusted padding
      ),
      validator: validator, // Assign the validator function
    );
  }

  // Helper to build a date input field
  Widget _buildDateField(TextEditingController controller, VoidCallback onTap, String hintText) {
    return TextFormField(
      controller: controller,
      readOnly: true, // Make the text field read-only
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 16,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.blueAccent), // Blue calendar icon
          onPressed: onTap, // Call the provided onTap function
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // No visible border line
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      onTap: onTap, // Allow tapping the field itself to open date picker
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
    );
  }

  // Helper to build a standard text label
  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 16, // Slightly smaller label font size
      fontWeight: FontWeight.w600, // Slightly bolder
      color: Colors.black87, // Darker text color
    ),
  );

  // Helper to build a standard dropdown field (not searchable)
  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 50, // Fixed height for consistency
      padding: const EdgeInsets.symmetric(horizontal: 12), // Adjusted padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(color: Colors.grey.shade300, width: 1), // Lighter border
        color: Colors.white, // White background
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true, // Expand to fill the container
        underline: Container(), // Remove the default underline
        value: value,
        onChanged: onChanged,
        items: items
            .map(
              (item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 16, color: Colors.black87), // Darker text color
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  // Helper to build a searchable dropdown field (using dropdown_search)
  Widget _buildSearchableDropdownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      DropdownSearch<String>(
        items: items,
        selectedItem: selected,
        onChanged: onChanged,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.black54), // Darker hint text
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
                borderSide: BorderSide(color: Colors.blueAccent), // Blue border
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          itemBuilder: (context, item, isSelected) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(item, style: const TextStyle(color: Colors.black87)), // Darker text color
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: 'Select',
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Adjusted padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              borderSide: BorderSide(color: Colors.grey.shade300), // Lighter border
            ),
          ),
        ),
      );


  // Helper to build an icon button (e.g., search icon)
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) => Container(
    height: 50, // Match height of text fields/dropdowns
    width: 50, // Fixed width
    decoration: BoxDecoration(
        color: Colors.blueAccent, // Match theme color
        borderRadius: BorderRadius.circular(10)), // Rounded corners
    child: IconButton(icon: Icon(icon, color: Colors.white), onPressed: onPressed),
  );

  // Helper to build a standard elevated button
  Widget _buildButton(String label, VoidCallback onPressed) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueAccent, // Match theme color
      padding: const EdgeInsets.symmetric(vertical: 14), // Adjusted padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Larger, bold text
      elevation: 3.0, // Add slight elevation
    ),
    child: Text(label),
  );

}
