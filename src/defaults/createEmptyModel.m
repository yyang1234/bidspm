% (C) Copyright 2020 CPP BIDS SPM-pipeline developers

function content = createEmptyModel()
  %
  % Creates the content of a basic model.json file for GLM analysis with 
  % some default options like high pass filter cut-off 
  % and the type of autocorrelation correction.
  %
  % USAGE::
  %
  %   content = createEmptytModelBasic()
  %
  % :returns:
  %
  % - :content: structure containing the output that can be saved with
  %             ``spm_jsonwrite()``. See below.
  %
  % EXAMPLE::
  %
  %   jsonOptions.indent = '   ';
  %   content = createEmptytModelBasic()
  %   filename = fullfile(pwd, 'models', 'model-empty_smdl.json')
  %   spm_jsonwrite(filename, content, jsonOptions);
  %

  content.Name = ' ';
  content.Description = ' ';
  content.Input = struct('task', ' ');
  content.Steps = { ...
                   struct( ...
                          'Level', 'subject', ...
                          'Transformations', {returnTransformation()}, ...
                          'Model', returnModel(), ...
                          'AutoContrasts', {{' '}}); ...
                   struct( ...
                          'Level', 'run', ...
                          'Transformations', {returnTransformation()}, ...
                          'Model', returnModel(), ...
                          'AutoContrasts', {{' '}} ...
                         ); ...
                   struct( ...
                          'Level', 'dataset', ...
                          'AutoContrasts', {{' '}} ...
                         ) ...
                  };

end

function transformation = returnTransformation()

  transformation =   {struct( ...
                             'Name', 'Factor', ...
                             'Inputs', {{'trial_type'}} ...
                            ); ...
                      struct( ...
                             'Name', 'Convolve', ...
                             'Model', 'spm', ...
                             'Inputs', {{' '}} ...
                            )};

end

function model = returnModel()
  model = struct( ...
                 'X', {{' '}}, ...
                 'Options', struct('high_pass_filter_cutoff_secs', 128), ...
                 'Software', struct('SPM', struct('whitening', 'FAST')), ...
                 'Mask', {' '});
end
