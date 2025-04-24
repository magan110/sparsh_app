import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class DsrRetailerInOut extends StatefulWidget {
  const DsrRetailerInOut({super.key});

  @override
  State<DsrRetailerInOut> createState() => _DsrRetailerInOutState();
}

class _DsrRetailerInOutState extends State<DsrRetailerInOut> {
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
    'Agra',
    'Ahmedabad',
    'Ajmer',
    'Akola',
    'Aligarh',
    'Allahabad',
    'Alwar',
    'Ambala',
    'Amravati',
    'Amritsar',
    'Anand',
    'Anantapur',
    'Aurangabad',
    'Asansol',
    'Bareilly',
    'Bengaluru',
    'Belgaum',
    'Bhagalpur',
    'Bhavnagar',
    'Bhilai',
    'Bhiwandi',
    'Bhopal',
    'Bhubaneswar',
    'Bikaner',
    'Bilaspur',
    'Bokaro Steel City',
    'Chandigarh',
    'Chennai',
    'Coimbatore',
    'Cuttack',
    'Dehradun',
    'Delhi',
    'Dhanbad',
    'Durgapur',
    'Erode',
    'Faridabad',
    'Firozabad',
    'Gandhinagar',
    'Ghaziabad',
    'Gorakhpur',
    'Guntur',
    'Gurgaon',
    'Guwahati',
    'Gwalior',
    'Haldwani',
    'Haridwar',
    'Hubli-Dharwad',
    'Hyderabad',
    'Imphal',
    'Indore',
    'Itanagar',
    'Jabalpur',
    'Jaipur',
    'Jalandhar',
    'Jammu',
    'Jamshedpur',
    'Jhansi',
    'Jodhpur',
    'Junagadh',
    'Kakinada',
    'Kalyan-Dombivli',
    'Kanpur',
    'Kochi',
    'Kolhapur',
    'Kolkata',
    'Kollam',
    'Kota',
    'Kozhikode',
    'Kurnool',
    'Lucknow',
    'Ludhiana',
    'Madurai',
    'Malappuram',
    'Mangalore',
    'Meerut',
    'Mira-Bhayandar',
    'Moradabad',
    'Mumbai',
    'Mysuru',
    'Nagpur',
    'Nanded',
    'Nashik',
    'Navi Mumbai',
    'Nellore',
    'Noida',
    'Patna',
    'Pimpri-Chinchwad',
    'Prayagraj',
    'Pune',
    'Raipur',
    'Rajkot',
    'Rajahmundry',
    'Ranchi',
    'Rohtak',
    'Rourkela',
    'Saharanpur',
    'Salem',
    'Sangli-Miraj & Kupwad',
    'Shillong',
    'Shimla',
    'Siliguri',
    'Solapur',
    'Srinagar',
    'Surat',
    'Thane',
    'Thiruvananthapuram',
    'Thrissur',
    'Tiruchirappalli',
    'Tirunelveli',
    'Tiruppur',
    'Udaipur',
    'Ujjain',
    'Ulhasnagar',
    'Vadodara',
    'Varanasi',
    'Vasai-Virar',
    'Vijayawada',
    'Visakhapatnam',
    'Warangal',
    'Yamunanagar',
  ];

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Manages dynamic upload rows
  List<int> _uploadRows = [0];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const Text(
            'DSR Retailer IN OUT',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildLabel(context, 'Purchaser / Retailer'),
          const SizedBox(height: 20),
          _dropDownField(
            selected: _puchaserRetailerItem,
            items: _puchaserRetailerdropdownItems,
            onChanged: (val) {
              if (val != null) setState(() => _puchaserRetailerItem = val);
            },
          ),
          const SizedBox(height: 20),
          _buildLabel(context, 'Area code *:'),
          const SizedBox(height: 20),
          _searchableDropdownField(
            selected: _areaCode,
            items: _majorCitiesInIndia,
            onChanged: (val) {
              if (val != null) setState(() => _areaCode = val);
            },
          ),
          const SizedBox(height: 20),
          _buildLabel(context, 'Code *:'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    hintText: 'Purchaser code',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // TODO: perform search
                  },
                ),
              ),

            ],
          ),
          const SizedBox(height: 20),
          _buildLabel(context, 'Customer Name*:'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _buildLabel(context, 'Report Date*'),
          const SizedBox(height: 20),
          TextFormField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select Date',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _pickDate,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onTap: _pickDate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          _buildLabel(context, 'Your Latitude'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),


          const SizedBox(height: 20),
          _buildLabel(context, 'Your Longitude'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _buildLabel(context, 'Retailers Latitude:'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _buildLabel(context, 'Retailers Longitude:'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _buildLabel(context, 'Distance:'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: '',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),


          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // implement upload logic for row i
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: const Text('Capture Your Location'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // implement upload logic for row i
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: const Text('Capture Customer Location'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // implement upload logic for row i
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: const Text('IN'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // implement upload logic for row i
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: const Text('Exception Entry'),
              ),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _dropDownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(),
        value: selected,
        onChanged: onChanged,
        items: items
            .map((value) => DropdownMenuItem(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ))
            .toList(),
      ),
    );
  }

  Widget _searchableDropdownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        color: Colors.white,
      ),
      child: DropdownSearch<String>(
        items: items,
        selectedItem: selected,
        onChanged: onChanged,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 16),
          dropdownSearchDecoration: InputDecoration.collapsed(hintText: ''),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          itemBuilder: _popupItemBuilder,
          fit: FlexFit.loose,
        ),
      ),
    );
  }

  Widget _popupItemBuilder(
      BuildContext context, String item, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(item, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

