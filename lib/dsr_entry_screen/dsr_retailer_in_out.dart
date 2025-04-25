import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class DsrRetailerInOut extends StatefulWidget {
  const DsrRetailerInOut({super.key});

  @override
  State<DsrRetailerInOut> createState() => _DsrRetailerInOutState();
}

class _DsrRetailerInOutState extends State<DsrRetailerInOut> {
  // Dropdown state
  String _puchaserRetailerItem = 'Select';
  final List<String> _puchaserRetailerdropdownItems = [
    'Select',
    'AD',
    'Stokiest/Urban Stokiest',
    'Direct Dealer',
    'Retailer',
    'Rural Stokiest'
  ];

  String _areaCode = 'Select';
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
  ];

  // City coordinates mapping
  final Map<String, Map<String, double>> _cityCoordinates = {
    'Agra': {'latitude': 27.1767, 'longitude': 78.0081},
    'Ahmedabad': {'latitude': 23.0225, 'longitude': 72.5714},
    'Ajmer': {'latitude': 26.4499, 'longitude': 74.6399},
    'Akola': {'latitude': 20.7063, 'longitude': 77.0202},
    'Aligarh': {'latitude': 27.8974, 'longitude': 78.0880},
    // Add more cities here as required
  };

  // Date picker
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // Location controllers
  final TextEditingController _yourLatitudeController = TextEditingController();
  final TextEditingController _yourLongitudeController = TextEditingController();
  final TextEditingController _custLatitudeController = TextEditingController();
  final TextEditingController _custLongitudeController = TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dateController.dispose();
    _yourLatitudeController.dispose();
    _yourLongitudeController.dispose();
    _custLatitudeController.dispose();
    _custLongitudeController.dispose();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw ('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw ('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _captureYourLocation() async {
    try {
      final pos = await _determinePosition();
      setState(() {
        _yourLatitudeController.text = pos.latitude.toString();
        _yourLongitudeController.text = pos.longitude.toString();
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _captureCustomerLocation() async {
    try {
      final pos = await _determinePosition();
      setState(() {
        _custLatitudeController.text = pos.latitude.toString();
        _custLongitudeController.text = pos.longitude.toString();
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

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

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: const Text(
          'DSR Retailer IN OUT',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildLabel('Purchaser / Retailer'),
          const SizedBox(height: 8),
          _dropDownField(
            selected: _puchaserRetailerItem,
            items: _puchaserRetailerdropdownItems,
            onChanged: (val) {
              if (val != null) setState(() => _puchaserRetailerItem = val);
            },
          ),

          const SizedBox(height: 16),
          _buildLabel('Area code *:'),
          const SizedBox(height: 8),
          _searchableDropdownField(
            selected: _areaCode,
            items: _majorCitiesInIndia,
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _areaCode = val;
                  // Set latitude and longitude based on the selected area code
                  if (_cityCoordinates.containsKey(val)) {
                    _custLatitudeController.text = _cityCoordinates[val]!['latitude']!.toString();
                    _custLongitudeController.text = _cityCoordinates[val]!['longitude']!.toString();
                  }
                });
              }
            },
          ),

          const SizedBox(height: 16),
          _buildLabel('Code *:'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: _inputDecoration('Purchaser code'),
                ),
              ),
              const SizedBox(width: 8),
              _iconButton(Icons.search, () {
                // TODO: perform code search
              }),
            ],
          ),

          const SizedBox(height: 16),
          _buildLabel('Customer Name*:'),
          const SizedBox(height: 8),
          TextField(decoration: _inputDecoration('')),

          const SizedBox(height: 16),
          _buildLabel('Report Date*'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _dateController,
            readOnly: true,
            decoration: _inputDecoration('Select Date', suffix: Icons.calendar_today),
            onTap: _pickDate,
            validator: (v) => (v == null || v.isEmpty) ? 'Please select a date' : null,
          ),

          const SizedBox(height: 16),
          _buildLabel('Your Latitude'),
          const SizedBox(height: 8),
          TextField(controller: _yourLatitudeController, decoration: _inputDecoration('')),

          const SizedBox(height: 16),
          _buildLabel('Your Longitude'),
          const SizedBox(height: 8),
          TextField(controller: _yourLongitudeController, decoration: _inputDecoration('')),

          const SizedBox(height: 16),
          _buildLabel('Retailer’s Latitude:'),
          const SizedBox(height: 8),
          TextField(controller: _custLatitudeController, decoration: _inputDecoration('')),

          const SizedBox(height: 16),
          _buildLabel('Retailer’s Longitude:'),
          const SizedBox(height: 8),
          TextField(controller: _custLongitudeController, decoration: _inputDecoration('')),

          const SizedBox(height: 30),
          _buildButton('Capture Your Location', _captureYourLocation),
          const SizedBox(height: 12),
          _buildButton('Capture Customer Location', _captureCustomerLocation),
          const SizedBox(height: 12),
          _buildButton('IN', () {
            // TODO: IN logic
          }),
          const SizedBox(height: 12),
          _buildButton('Exception Entry', () {
            // TODO: exception logic
          }),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );

  Widget _dropDownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: const SizedBox(),
          value: selected,
          onChanged: onChanged,
          items: items
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
        ),
      );

  Widget _searchableDropdownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: DropdownSearch<String>(
          items: items,
          selectedItem: selected,
          onChanged: onChanged,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            itemBuilder: (c, item, sel) => Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: '',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );

  InputDecoration _inputDecoration(String hint, {IconData? suffix}) =>
      InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: _pickDate) : null,
      );

  Widget _iconButton(IconData icon, VoidCallback onPressed) => Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
    child: IconButton(icon: Icon(icon, color: Colors.white), onPressed: onPressed),
  );

  Widget _buildButton(String label, VoidCallback onPressed) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(label, style: const TextStyle(fontSize: 18)),
  );
}
