function matlabbatch = setBatchSelectAnat(matlabbatch, BIDS, opt, subLabel)
  %
  % Creates a batch to set an anatomical image
  %
  % USAGE::
  %
  %   matlabbatch = setBatchSelectAnat(matlabbatch, BIDS, opt, subLabel)
  %
  % :param matlabbatch: list of SPM batches
  % :type  matlabbatch: structure
  %
  % :param BIDS: BIDS layout returned by ``getData``.
  % :type  BIDS: structure
  %
  % :param opt: structure or json filename containing the options.
  %             See ``checkOptions()`` and ``loadAndCheckOptions()``.
  % :type  opt: structure
  %
  % :param subLabel: subject label
  % :type  subLabel: string
  %
  % :returns: :matlabbatch: (structure)
  %
  % matlabbatch = setBatchSelectAnat(matlabbatch, BIDS, opt, subLabel)
  %
  % - image type = opt.bidsFilterFiler.t1w.suffix (default = T1w)
  % - session to select the anat from = opt.bidsFilterFiler.t1w.ses (default = 1)
  %
  % We assume that the first anat of that type is the "correct" one
  %
  % (C) Copyright 2020 CPP_SPM developers

  printBatchName('selecting anatomical image', opt);

  [anatImage, anatDataDir] = getAnatFilename(BIDS, opt, subLabel);

  matlabbatch{end + 1}.cfg_basicio.cfg_named_file.name = 'Anatomical';
  matlabbatch{end}.cfg_basicio.cfg_named_file.files = { {fullfile(anatDataDir, anatImage)} };

end
