# ArcticPRIZE

**Code for processing Arctic PRIZE moorings 2017-2108 and 2018-2019**

## Step 1

***m_scripts/Stage1_read_data.m***
- Reads instrument data from each mooring
- Output to Matlab structure and individual CSV files
- Plots stacked data

## Step 2

***Stage_2_grid_interpolate.m***
- reads .mat file produced by stage 1
- Uses ***prize_grid_linear_interp*** to de-spike, grid, and filter data
- Outputs to Matlab stucture
