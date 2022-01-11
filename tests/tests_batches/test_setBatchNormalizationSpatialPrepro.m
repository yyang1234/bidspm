% (C) Copyright 2020 CPP_SPM developers

function test_suite = test_setBatchNormalizationSpatialPrepro %#ok<*STOUT>
  try % assignment of 'localfunctions' is necessary in Matlab >= 2016
    test_functions = localfunctions(); %#ok<*NASGU>
  catch % no problem; early Matlab versions can use initTestSuite fine
  end
  initTestSuite;
end

function test_setBatchNormalizationSpatialPrepro_anat_only()

  % necessarry to deal with SPM module dependencies
  spm_jobman('initcfg');

  opt = setOptions('vismotion');
  opt.anatOnly = true;
  opt.orderBatches.coregister = 999; % dummy value
  opt.orderBatches.segment = 2;
  opt.orderBatches.skullStripping = 3;

  matlabbatch = {};
  voxDim = [];

  [BIDS, opt] = getData(opt, opt.dir.input);

  matlabbatch = setBatchNormalizationSpatialPrepro(matlabbatch, BIDS, opt, voxDim);

  expectedBatch = returnExpectedBatch(opt, voxDim);
  expectedBatch(1) = [];

  for i = 1:numel(expectedBatch)
    assertEqual(matlabbatch{i}.spm.spatial.normalise.write, ...
                expectedBatch{i}.spm.spatial.normalise.write);
  end

end

function test_setBatchNormalizationSpatialPrepro_reuse_segment_output()

  % necessarry to deal with SPM module dependencies
  spm_jobman('initcfg');

  opt = setOptions('vismotion');

  opt.orderBatches.coregister = 3;
  opt.orderBatches.segment = 5;
  opt.orderBatches.skullStripping = 6;

  matlabbatch = {};
  voxDim = [3 3 3];

  [BIDS, opt] = getData(opt, opt.dir.input);

  matlabbatch = setBatchNormalizationSpatialPrepro(matlabbatch, BIDS, opt, voxDim);

  expectedBatch = returnExpectedBatch(opt, voxDim);

  %   for i = 1:numel(expectedBatch)
  %
  %     assertEqual(matlabbatch{i}.spm.spatial.normalise.write.subj.def, ...
  %                 expectedBatch{i}.spm.spatial.normalise.write.subj.def);
  %     assertEqual(matlabbatch{i}.spm.spatial.normalise.write.subj.resample, ...
  %                 expectedBatch{i}.spm.spatial.normalise.write.subj.resample);
  %
  %     assertEqual(matlabbatch{i}.spm.spatial.normalise.write.woptions, ...
  %                 expectedBatch{i}.spm.spatial.normalise.write.woptions);
  %
  %   end
end

function test_setBatchNormalizationSpatialPrepro_force_segment()

  % necessarry to deal with SPM module dependencies
  spm_jobman('initcfg');

  opt = setOptions('vismotion');

  opt.orderBatches.coregister = 3;
  opt.orderBatches.segment = 5;
  opt.orderBatches.skullStripping = 6;

  opt.segment.force = true;

  matlabbatch = {};
  voxDim = [3 3 3];

  [BIDS, opt] = getData(opt, opt.dir.input);

  matlabbatch = setBatchNormalizationSpatialPrepro(matlabbatch, BIDS, opt, voxDim);

  expectedBatch = returnExpectedBatch(opt, voxDim);

  for i = 1:numel(expectedBatch)

    assertEqual(matlabbatch{i}.spm.spatial.normalise.write.subj.def, ...
                expectedBatch{i}.spm.spatial.normalise.write.subj.def);
    assertEqual(matlabbatch{i}.spm.spatial.normalise.write.subj.resample, ...
                expectedBatch{i}.spm.spatial.normalise.write.subj.resample);

    assertEqual(matlabbatch{i}.spm.spatial.normalise.write.woptions, ...
                expectedBatch{i}.spm.spatial.normalise.write.woptions);

  end

end

function expectedBatch = returnExpectedBatch(opt, voxDim)

  expectedBatch = {};

  jobsToAdd = numel(expectedBatch) + 1;

  for iJob = jobsToAdd:(jobsToAdd + 5)
    expectedBatch{iJob}.spm.spatial.normalise.write.subj.def(1) = ...
        cfg_dep('Segment: Forward Deformations', ...
                substruct( ...
                          '.', 'val', '{}', {opt.orderBatches.segment}, ...
                          '.', 'val', '{}', {1}, ...
                          '.', 'val', '{}', {1}), ...
                substruct('.', 'fordef', '()', {':'})); %#ok<*AGROW>

  end

  expectedBatch{jobsToAdd}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Coregister: Estimate: Coregistered Images', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.coregister}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct('.', 'cfiles'));
  if ~isempty(voxDim)
    expectedBatch{jobsToAdd}.spm.spatial.normalise.write.woptions.vox = voxDim;
  end

  expectedBatch{jobsToAdd + 1}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Segment: bias corrected image', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.segment}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct( ...
                        '.', 'channel', '()', {1}, ...
                        '.', 'biascorr', '()', {':'}));
  expectedBatch{jobsToAdd + 1}.spm.spatial.normalise.write.woptions.vox = [1 1 1];

  expectedBatch{jobsToAdd + 2}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Segment: grey matter image', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.segment}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct( ...
                        '.', 'tiss', '()', {1}, ...
                        '.', 'c', '()', {':'}));
  if ~isempty(voxDim)
    expectedBatch{jobsToAdd + 2}.spm.spatial.normalise.write.woptions.vox = voxDim;
  end

  expectedBatch{jobsToAdd + 3}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Segment: white matter image', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.segment}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct( ...
                        '.', 'tiss', '()', {2}, ...
                        '.', 'c', '()', {':'}));
  if ~isempty(voxDim)
    expectedBatch{jobsToAdd + 3}.spm.spatial.normalise.write.woptions.vox = voxDim;
  end

  expectedBatch{jobsToAdd + 4}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Segment: csf matter image', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.segment}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct( ...
                        '.', 'tiss', '()', {3}, ...
                        '.', 'c', '()', {':'}));
  if ~isempty(voxDim)
    expectedBatch{jobsToAdd + 4}.spm.spatial.normalise.write.woptions.vox = voxDim;
  end

  expectedBatch{jobsToAdd + 5}.spm.spatial.normalise.write.subj.resample(1) = ...
      cfg_dep('Image Calculator: skullstripped anatomical', ...
              substruct( ...
                        '.', 'val', '{}', {opt.orderBatches.skullStripping}, ...
                        '.', 'val', '{}', {1}, ...
                        '.', 'val', '{}', {1}), ...
              substruct('.', 'files'));
  expectedBatch{jobsToAdd + 5}.spm.spatial.normalise.write.woptions.vox = [1 1 1];

end
