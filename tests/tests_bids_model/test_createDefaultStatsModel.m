% (C) Copyright 2020 CPP_SPM developers

function test_suite = test_createDefaultStatsModel %#ok<*STOUT>
  try % assignment of 'localfunctions' is necessary in Matlab >= 2016
    test_functions = localfunctions(); %#ok<*NASGU>
  catch % no problem; early Matlab versions can use initTestSuite fine
  end
  initTestSuite;
end

function test_createDefaultStatsModel_basic()

  useRaw = true;
  opt = setOptions('vislocalizer', '', useRaw);

  [BIDS, opt] = getData(opt, opt.dir.preproc);

  createDefaultStatsModel(BIDS, opt);

  % make sure the file was created where expected
  expectedFilename = fullfile(pwd, 'models', 'model-defaultVislocalizer_smdl.json');
  assertEqual(exist(expectedFilename, 'file'), 2);

  % check it has the right content
  content = spm_jsonread(expectedFilename);

  expectedContent = spm_jsonread(fullfile(getDummyDataDir(), 'models', 'model-default_smdl.json'));

  assertEqual(content, expectedContent);

  cleanUp(fullfile(pwd, 'models'));

end
