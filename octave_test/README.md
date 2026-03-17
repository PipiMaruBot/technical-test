### Project Files
- **`Data_package_Input.json`**: This file contains the input parameters for the problem, such as constants and orbital elements.
- **`Data_package_Output.json`**: This one has some output samples (latitude and longitude) to validate that the code is working correctly.

### Data Meaning
- Using the inputs from `Data_package_Input.json`, the algorithm calculates two things for different times:
  - **`lat_deg`**: The latitude of the sub-satellite (in degrees).
  - **`lon_deg`**: The longitude of the sub-satellite (in degrees).
- In `Data_package_Output.json` I only included a few samples to make the comparison easier for the user and to check if the implementation is correct.

### How to use
- Read `Data_package_Input.json` to get all the constants and orbital data.
- Run your implementation of the algorithm.
- Calculate `lat_deg` and `lon_deg` for the exact same timestamps provided in `Data_package_Output.json`.
-Compare your results with the ones in the output JSON to check for any errors.
