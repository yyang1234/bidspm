% (C) Copyright 2020 bidspm developers

clear;
clc;

addpath(fullfile(pwd, '..', '..'));
bidspm();

% The directory where the data are located
root_dir = fileparts(mfilename('fullpath'));
bids_dir = fullfile(root_dir, 'inputs', 'ds000001');
output_dir = fullfile(root_dir, 'outputs', 'ds000001', 'derivatives');

%% Preprocessing
bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', {'01', '02'}, ...
       'action', 'preprocess', ...
       'task', {'balloonanalogrisktask'}, ...
       'space', {'IXI549Space'});

%% Stats
preproc_dir = fullfile(root_dir, 'outputs', 'ds000001', 'derivatives', 'bidspm-preproc');

model_file = fullfile(root_dir, 'models', 'model-defaultBalloonanalogrisktask_smdl.json');

%% subject level
opt.results.nodeName = 'subject_level';
opt.results.name = 'cash_demean';

bidspm(bids_dir, output_dir, 'subject', ...
       'action', 'stats', ...
       'participant_label', {'01', '02'}, ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file, ...
       'options', opt);

%% dataset level
opt.results.nodeName = 'dataset_level';

bidspm(bids_dir, output_dir, 'dataset', ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file, ...
       'options', opt);
