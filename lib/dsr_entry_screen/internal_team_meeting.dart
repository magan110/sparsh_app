import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart'; // Keep if needed elsewhere, but not used in this styled version
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

// Ensure these imports are correct based on your project structure
import 'Meeting_with_new_purchaser.dart';
import 'Meetings_With_Contractor.dart';
import 'any_other_activity.dart';
import 'btl_activites.dart';
import 'check_sampling_at_site.dart';
import 'dsr_entry.dart'; // Assuming DsrEntry is the main entry point
import 'dsr_retailer_in_out.dart';
import 'internal_team_meeting.dart'; // This is the current file, keep it
import 'office_work.dart';
import 'on_leave.dart';
import 'phone_call_with_builder.dart';
import 'phone_call_with_unregisterd_purchaser.dart';
import 'work_from_home.dart';
// Assuming HomeScreen is not directly navigated to from here, but keep if needed
// import 'package:learning2/screens/Home_screen.dart';


class InternalTeamMeeting extends StatefulWidget {
  const InternalTeamMeeting({super.key});

  @override
  State<InternalTeamMeeting> createState() => _InternalTeamMeetingState();
}

class _InternalTeamMeetingState extends State<InternalTeamMeeting> {
  // State variables for dropdowns and date pickers
  String? _processItem = 'Select';
  final List<String> _processdropdownItems = [
    'Select',
    'Add',
    'Update',
  ];

  String? _activityItem = 'Internal Team Meetings / Review Meetings'; // Default to this activity
  final List<String> _activityDropDownItems = [
    'Select',
    'Personal Visit',
    'Phone Call with Builder/Stockist',
    'Meetings With Contractor / Stockist',
    'Visit to Get / Check Sampling at Site',
    'Meeting with New Purchaser(Trade Purchaser)/Retailer',
    'BTL Activities',
    'Internal Team Meetings / Review Meetings',
    'Office Work',
    'On Leave / Holiday / Off Day',
    'Work From Home',
    'Any Other Activity',
    'Phone call with Unregistered Purchasers',
  ];

  // Controllers for date text fields
  final TextEditingController _submissionDateController = TextEditingController(); // Renamed for clarity
  final TextEditingController _reportDateController = TextEditingController();

  // State variables to hold selected dates
  DateTime? _selectedSubmissionDate; // Renamed for clarity
  DateTime? _selectedReportDate;

  // Lists for image uploads
  List<int> _uploadRows = [0]; // Tracks the number of image upload rows
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker
  // List to hold selected image paths for each row (multiple images per row)
  List<List<String>> _selectedImagePaths = [[]]; // Initialize with an empty list for the first row

  // Global key for the form for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Ensure _selectedImagePaths has an empty list for the initial row
    if (_selectedImagePaths.isEmpty) {
      _selectedImagePaths = [[]];
    }
  }


  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _submissionDateController.dispose();
    _reportDateController.dispose();
    super.dispose();
  }

  // Function to pick the submission date
  Future<void> _pickSubmissionDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedSubmissionDate ?? now,
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
        _selectedSubmissionDate = picked;
        _submissionDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Function to pick the report date
  Future<void> _pickReportDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedReportDate ?? now,
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
        _selectedReportDate = picked;
        _reportDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Function to add a new image upload row
  void _addRow() {
    setState(() {
      _uploadRows.add(_uploadRows.length); // Add a new index
      _selectedImagePaths.add([]); // Add a new empty list for the new row's images
    });
  }

  // Function to remove the last image upload row
  void _removeRow() {
    if (_uploadRows.length <= 1) return; // Prevent removing the last row
    setState(() {
      _uploadRows.removeLast(); // Remove the last index
      _selectedImagePaths.removeLast(); // Remove the last image path list
    });
  }

  // Function to pick multiple images for a specific row
  Future<void> _pickImages(int rowIndex) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        // Replace the existing images for this row with the newly picked ones
        _selectedImagePaths[rowIndex] = pickedFiles.map((e) => e.path).toList();
      });
    } else {
      // User canceled the image selection.
      print('No images selected for row $rowIndex.');
    }
  }

  // Function to show a dialog with the selected images for a specific row
  void _showImagesDialog(int rowIndex) {
    if (_selectedImagePaths[rowIndex].isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No images selected for this row to view.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // Use a Dialog widget for a modal popup
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make column size to fit content
              children: [
                const Text(
                  'Selected Images',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent), // Styled title
                ),
                const SizedBox(height: 16), // Increased spacing
                // Use a SizedBox with constrained height and width for the image list
                SizedBox(
                  height: 200, // Limit the height of the image list
                  width: double.maxFinite, // Make it wide
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Horizontal list
                    itemCount: _selectedImagePaths[rowIndex].length,
                    itemBuilder: (context, index) {
                      final imagePath = _selectedImagePaths[rowIndex][index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0), // Spacing between images
                        child: Image.file(
                          File(imagePath),
                          height: 180, // Adjust as needed
                          width: 180, // Adjust as needed
                          fit: BoxFit.cover, // Use cover to fill the space nicely
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16), // Increased spacing
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // Close the dialog
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.blueAccent), // Styled button
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              // Navigate back to the DsrEntry screen
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
            'DSR Entry',
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
                // Instructions Section
                const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 24, // Adjusted font size
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Match AppBar color
                  ),
                ),
                const SizedBox(height: 24), // Increased spacing

                // Process Type Dropdown
                _buildLabel('Process type'),
                const SizedBox(height: 8), // Reduced spacing below label
                _buildDropdownField(
                  value: _processItem,
                  items: _processdropdownItems,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _processItem = newValue);
                    }
                  },
                ),
                const SizedBox(height: 24), // Increased spacing

                // Activity Type Dropdown (for navigation)
                _buildLabel('Activity Type'),
                const SizedBox(height: 8), // Reduced spacing below label
                _buildDropdownField(
                  value: _activityItem,
                  items: _activityDropDownItems,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _activityItem = newValue);

                      // Navigation logic based on selected activity
                      if (newValue == 'Personal Visit') {
                        _navigateTo(const DsrRetailerInOut());
                      } else if (newValue == 'Phone Call with Builder/Stockist') {
                        _navigateTo(const PhoneCallWithBuilder());
                      } else if (newValue == 'Meetings With Contractor / Stockist') {
                        _navigateTo(const MeetingsWithContractor());
                      } else if (newValue == 'Visit to Get / Check Sampling at Site') {
                        _navigateTo(const CheckSamplingAtSite());
                      } else if (newValue == 'Meeting with New Purchaser(Trade Purchaser)/Retailer') {
                        _navigateTo(const MeetingWithNewPurchaser());
                      } else if (newValue == 'BTL Activities') {
                        _navigateTo(const BtlActivites());
                      } else if (newValue == 'Internal Team Meetings / Review Meetings') {
                        // This is the current page, no navigation needed
                      } else if (newValue == 'Office Work') {
                        _navigateTo(const OfficeWork());
                      } else if (newValue == 'On Leave / Holiday / Off Day') {
                        _navigateTo(const OnLeave());
                      } else if (newValue == 'Work From Home') {
                        _navigateTo(const WorkFromHome());
                      } else if (newValue == 'Any Other Activity') {
                        _navigateTo(const AnyOtherActivity());
                      } else if (newValue == 'Phone call with Unregistered Purchasers') {
                        _navigateTo(const PhoneCallWithUnregisterdPurchaser());
                      }
                    }
                  },
                ),
                const SizedBox(height: 24), // Increased spacing

                // Submission Date Field
                _buildLabel('Submission Date'),
                const SizedBox(height: 8), // Reduced spacing below label
                _buildDateField(_submissionDateController, _pickSubmissionDate, 'Select Date'),
                const SizedBox(height: 24), // Increased spacing

                // Report Date Field
                _buildLabel('Report Date'),
                const SizedBox(height: 8), // Reduced spacing below label
                _buildDateField(_reportDateController, _pickReportDate, 'Select Date'),
                const SizedBox(height: 24), // Increased spacing

                // Meeting Done With Field
                _buildLabel('Meeting Done With'),
                const SizedBox(height: 8),
                _buildTextField('Enter Participants', maxLines: 1), // Single line input likely sufficient
                const SizedBox(height: 24),

                // Topics Discussed Meeting Field
                _buildLabel('Topics Discussed meeting'),
                const SizedBox(height: 8),
                _buildTextField('Enter Topics Discussed', maxLines: 3), // Multi-line input
                const SizedBox(height: 24),

                // Image Upload Section
                _buildLabel('Upload Supporting'),
                const SizedBox(height: 8),

                Column(
                  children: _uploadRows.map((rowIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute buttons
                        children: [
                          Expanded( // Allow buttons to take available space
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImages(rowIndex), // Call _pickImages with the index
                              icon: const Icon(Icons.upload_file, size: 18), // Added icon
                              label: const Text('Upload'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blueAccent, // Match AppBar color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Adjusted padding
                                textStyle: const TextStyle(fontSize: 14), // Adjusted text size
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Spacing between buttons
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showImagesDialog(rowIndex), // Call _showImagesDialog with the index
                              icon: const Icon(Icons.visibility, size: 18), // Added icon
                              label: const Text('View'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green, // Green for view
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Add/Remove Row Buttons - Made smaller and icon-only
                          SizedBox(
                            width: 40, // Fixed width for icon buttons
                            height: 40, // Fixed height
                            child: ElevatedButton(
                              onPressed: _addRow,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orangeAccent, // Orange for add
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero, // No internal padding
                              ),
                              child: const Icon(Icons.add, size: 20), // Plus icon
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 40, // Fixed width
                            height: 40, // Fixed height
                            child: ElevatedButton(
                              onPressed: _removeRow,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.redAccent, // Red for remove
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero, // No internal padding
                              ),
                              child: const Icon(Icons.remove, size: 20), // Minus icon
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30), // Increased spacing before buttons

                // Submit Buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons to full width
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: implement submit and new logic
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid. Submit and New.');
                          // Add your submission logic here
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent, // Match theme color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14), // Increased vertical padding
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Larger, bold text
                        elevation: 3.0, // Add slight elevation
                      ),
                      child: const Text('Submit & New'),
                    ),
                    const SizedBox(height: 16), // Spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        // TODO: implement submit and exit logic
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid. Submit and Exit.');
                          // Add your submission logic here and then navigate back
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent, // Match theme color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        elevation: 3.0,
                      ),
                      child: const Text('Submit & Exit'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: implement view submitted data logic
                        print('View Submitted Data button pressed');
                        // Add logic to view submitted data
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blueAccent, // Blue text
                        backgroundColor: Colors.white, // White background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.blueAccent), // Blue border
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        elevation: 1.0, // Less elevation
                      ),
                      child: const Text('Click to see Submitted Data'),
                    ),
                  ],
                ),
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

  // Helper to build a searchable dropdown field (using dropdown_search) - Not used in this screen but kept for reference
  // Widget _buildSearchableDropdownField({
  //   required String selected,
  //   required List<String> items,
  //   required ValueChanged<String?> onChanged,
  // }) =>
  //     DropdownSearch<String>(
  //       items: items,
  //       selectedItem: selected,
  //       onChanged: onChanged,
  //       popupProps: PopupProps.menu(
  //         showSearchBox: true,
  //         searchFieldProps: const TextFieldProps(
  //           decoration: InputDecoration(
  //             hintText: 'Search...',
  //             hintStyle: TextStyle(color: Colors.black54), // Darker hint text
  //             fillColor: Colors.white,
  //             filled: true,
  //             border: OutlineInputBorder(
  //                borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
  //               borderSide: BorderSide(color: Colors.blueAccent), // Blue border
  //             ),
  //             isDense: true,
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //           ),
  //         ),
  //         itemBuilder: (context, item, isSelected) => Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Text(item, style: const TextStyle(color: Colors.black87)), // Darker text color
  //         ),
  //       ),
  //       dropdownDecoratorProps: DropDownDecoratorProps(
  //         dropdownSearchDecoration: InputDecoration(
  //           hintText: 'Select',
  //           filled: true,
  //           fillColor: Colors.white,
  //           isDense: true,
  //           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Adjusted padding
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10), // Rounded corners
  //             borderSide: BorderSide(color: Colors.grey.shade300), // Lighter border
  //           ),
  //         ),
  //       ),
  //     );


  // Helper to build an icon button (e.g., search icon) - Not used in this screen but kept for reference
  // Widget _buildIconButton(IconData icon, VoidCallback onPressed) => Container(
  //   height: 50, // Match height of text fields/dropdowns
  //   width: 50, // Fixed width
  //   decoration: BoxDecoration(
  //       color: Colors.blueAccent, // Match theme color
  //       borderRadius: BorderRadius.circular(10)), // Rounded corners
  //   child: IconButton(icon: Icon(icon, color: Colors.white), onPressed: onPressed),
  // );

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
