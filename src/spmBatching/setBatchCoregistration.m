% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function matlabbatch = setBatchCoregistration(matlabbatch, nbSessions)

    matlabbatch{end + 1}.spm.spatial.coreg.estimate.ref(1) = cfg_dep;
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).tname = 'Reference Image';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).tgt_spec{1}(1).name = 'class';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).tgt_spec{1}(1).value = 'cfg_files';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).tgt_spec{1}(2).name = 'strtype';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).tgt_spec{1}(2).value = 'e';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).sname = ...
        'Named File Selector: Structural(1) - Files';
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).src_exbranch = ...
        substruct( ...
                  '.', 'val', '{}', {1}, ...
                  '.', 'val', '{}', {1});
    matlabbatch{end}.spm.spatial.coreg.estimate.ref(1).src_output = ...
        substruct('.', 'files', '{}', {1});

    % SOURCE IMAGE : DEPENDENCY FROM REALIGNEMENT
    % ('Realign: Estimate & Reslice: Mean Image')
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1) = cfg_dep;
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).tname = 'Source Image';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).name = 'filter';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).value = 'image';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).name = 'strtype';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).value = 'e';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).sname = ...
        'Realign: Estimate & Reslice: Mean Image';
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).src_exbranch = ...
        substruct( ...
                  '.', 'val', '{}', {2}, ...
                  '.', 'val', '{}', {1}, ...
                  '.', 'val', '{}', {1}, ...
                  '.', 'val', '{}', {1});
    matlabbatch{end}.spm.spatial.coreg.estimate.source(1).src_output = ...
        substruct('.', 'rmean');

    % OTHER IMAGES : DEPENDENCY FROM REALIGNEMENT ('Realign: Estimate & Reslice:
    % Realigned Images (Sess 1 to N)')
    % files %%
    for iSes = 1:nbSessions
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes) = cfg_dep;
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).tname = 'Other Images';
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).tgt_spec{1}(1).name = ...
            'filter';
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).tgt_spec{1}(1).value = ...
            'image';
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).tgt_spec{1}(2).name = ...
            'strtype';
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).tgt_spec{1}(2).value = ...
            'e';
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).sname = ...
            ['Realign: Estimate & Reslice: Realigned Images (Sess ' (iSes) ')'];
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).src_exbranch = ...
            substruct( ...
                      '.', 'val', '{}', {2}, ...
                      '.', 'val', '{}', {1}, ...
                      '.', 'val', '{}', {1}, ...
                      '.', 'val', '{}', {1});
        matlabbatch{end}.spm.spatial.coreg.estimate.other(iSes).src_output = ...
            substruct( ...
                      '.', 'sess', '()', {iSes}, ...
                      '.', 'cfiles');
    end

    % The following lines are commented out because those parameters
    % can be set in the spm_my_defaults.m
    % matlabbatch{end}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    % matlabbatch{end}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    % matlabbatch{end}.spm.spatial.coreg.estimate.eoptions.tol = ...
    % [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    % matlabbatch{end}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

end
