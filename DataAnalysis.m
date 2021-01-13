%% Load the .3ds data

% INPUTS
% 1: Data file to load, including file type ('QPI.3ds' for example)
% 2: Smoothing sigma for current data

% OUTPUTS
% header: Variable containing all experimental parameters
% I: Current data, smoothed by sigma
% dIdV: Numerically differentiated current data
% voltage: Vector of voltages for current
% midV: Vector of voltages for dIdV/QPI (midpoint of voltage vector)
% QPI: Fourier transformed dIdV data

% Modified function load3dsall from supplied matlab code from Nanonis
[header, I, dIdV, voltage, midV, QPI] = load3dsall('QPImap012.3ds', 3);

% Remove zero offset in dIdV
% for i = 1:size(dIdV,3)
%     dIdV(:,:,i) = dIdV(:,:,i) - mean(mean(dIdV(:,:,i)));
% end

%% Removes streaks in the dIdV

% INPUTS
% 1: dIdV after masking of defects

% OUTPUTS
% dIdV_nostreaks: dIdV with streak removal algorithm applied
% QPI_nostreaks: Fourier transformed dIdV_nostreaks

[dIdV_nostreaks, QPI_nostreaks] = RemoveStreaks(dIdV);

%% Mask any defects present in the material

% [y1, y2] = masking(x1, x2, x3)

% INPUTS
% 1: dIdV 3x3 matrix

% 2: Voltage vector to index match the chosen image voltage
% 3: Voltage to display dIdV to mask data

% OUTPUTS
% dIdV_masked: dIdV with Gaussian masking over chosen defects
% QPI_masked: Fourier transformed dIdV_masked

[dIdV_masked, QPI_masked] = masking(dIdV_nostreaks,midV,600);

%% Crop the dIdV data to remove new line drift

% INPUTS
% dIdV_nostreaks: dIdV matrix after streak removal algorithm

% OUTPUTS
% dIdV_cropped: dIdV with no edge drift
% QPI_cropped: Fourier transformed dIdV_cropped

[dIdV_cropped, QPI_cropped] = CropData(dIdV_nostreaks);

%% Symmetrize the data

% INPUTS
% QPI_cropped: QPI data after removing new line drift

% OUTPUTS
% QPI_symm: Symmetrized QPI with Bragg peaks off axis
% QPI_symm_45: Symmetrized QPI rotated 45 deg w.r.t. QPI_symm

[QPI_symm] = Symmetrizing2(QPI_cropped);

%% Crop the symmetrized data

% INPUTS
% QPI_symm_45: Symmetrized QPI data

% OUTPUTS
% QPI_symm_45_crop: QPI_symm_45 but cropped to the Bragg peaks

[QPI_symm_crop_45] = Crop_Symm_QPI_45(QPI_symm);

%% Crop the symmetrized data

% INPUTS
% QPI_symm_45: Symmetrized QPI data

% OUTPUTS
% QPI_symm_45_crop: QPI_symm_45 but cropped to the Bragg peaks

[QPI_symm_crop] = Crop_Symm_QPI(QPI_symm);
