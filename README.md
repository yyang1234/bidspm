<!-- needed to ignore badges when building doc -->
<!-- .. only:: not latex -->

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/cpp-lln-lab/bidspm/main.svg)](https://results.pre-commit.ci/latest/github/cpp-lln-lab/bidspm/main)
[![miss hit](https://img.shields.io/badge/code%20style-miss_hit-000000.svg)](https://misshit.org/)
[![Documentation Status: main](https://readthedocs.org/projects/bidspm/badge/?version=stable)](https://bidspm.readthedocs.io/en/stable/?badge=stable)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/cpp-lln-lab/bidspm/dev)
[![tests with matlab](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_tests_matlab.yml/badge.svg)](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_tests_matlab.yml)
[![tests with octave](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_tests_octave.yml/badge.svg)](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_tests_octave.yml)
[![system tests with matlab](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_system_tests_matlab.yml/badge.svg)](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_system_tests_matlab.yml)
[![system tests with octave](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_system_tests_octave.yml/badge.svg)](https://github.com/cpp-lln-lab/bidspm/actions/workflows/run_system_tests_octave.yml)
[![codecov](https://codecov.io/gh/cpp-lln-lab/bidspm/branch/main/graph/badge.svg?token=PMQYH0DIPX)](https://codecov.io/gh/cpp-lln-lab/bidspm)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3554331.svg)](https://doi.org/10.5281/zenodo.3554331)
[![All Contributors](https://img.shields.io/badge/all_contributors-14-orange.svg?style=flat-square)](https://github.com/cpp-lln-lab/bidspm#contributors)

# bidspm

This is a Matlab / Octave toolbox to perform MRI data analysis on a
[BIDS data set](https://bids.neuroimaging.io/) using SPM12.

## Installation and set up

```bash
git clone \
    --recurse-submodules \
    https://github.com/cpp-lln-lab/bidspm.git
```

To get the latest version that is on the `dev` branch.

```bash
git clone \
    --recurse-submodules \
    --branch dev \
    https://github.com/cpp-lln-lab/bidspm.git
```

To start using bidspm, you just need to initialize it for this MATLAB / Octave
session with::

```matlab
bidspm()
```

Please see our
[documentation](https://bidspm.readthedocs.io/en/latest/general_information.html)
for more info.

## Usage

For some of its functionality bidspm has a BIDS app like API.

See
[this page for more information](https://bidspm.readthedocs.io/en/latest/usage_notes.html).

### Preprocessing

```matlab
bids_dir = path_to_raw_bids_dataset;
output_dir = path_to_where_the_output_should_go;

subject_label = '01';

bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'preprocess', ...
        'task', {'yourTask'})
```

### GLM

```matlab
bids_dir = path_to_raw_bids_dataset;
preproc_dir = path_to_preprocessed_dataset;
output_dir = path_to_where_the_output_should_go;
model_file = path_to_bids_stats_model_json_file;

subject_label = '01';

bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'stats', ...
        'preproc_dir', preproc_dir, ...
        'model_file', model_file)
```

Please see our
[documentation](https://bidspm.readthedocs.io/en/latest/usage_notes.html) for
more info.

## Features

### Preprocessing

If your data is fairly "typical" (for example whole brain coverage functional
data with one associated anatomical scan for each subject), you might be better
off running [fmriprep](https://fmriprep.org/en/stable/) on your data.

If you have more exotic data that cannot be handled well by fmriprep then bidspm
has some automated workflows to perform amongst other things:

-   remove dummies

-   slice timing correction

-   spatial preprocessing:

    -   realignment OR realignm and unwarp
    -   coregistration `func` to `anat`,
    -   `anat` segmentation and skull stripping
    -   (optional) normalization to SPM's MNI space

-   smoothing

-   fieldmaps processing and voxel displacement map creation (work in progress)

All (well almost all) preprocessed outputs are saved as BIDS derivatives with
BIDS compliant filenames.

### Statistics

The model specification are set up using the
[BIDS stats model](https://bids-standard.github.io/stats-models/) and can be
used to perform:

-   whole GLM at the subject level
-   whole brain GLM at the group level à la SPM (meaning using a summary
    statistics approach).
-   ROI based GLM (using marsbar)
-   model selection (with the MACS toolbox)

### Quality control:

-   anatomical data (work in progress)
-   functional data (work in progress)
-   GLM auto-correlation check

Please see our
[documentation](https://bidspm.readthedocs.io/en/latest/index.html) for more
info.

## Citation

```bibtex
@software{bidspm,
  author = {Gau, Rémi and Barilari, Marco and Battal, Ceren and Rezk, Mohamed and Collignon, Olivier and Gurtubay, Ane and Falagiarda, Federica and MacLean, Michèle and Cerpelloni, Filippo and Shahzad, Iqra and Nunes, Márcia and Caron-Guyon, Jeanne and Chouinard-Leclaire, Christine and Yang, Ying},
  license = {GPL-3.0},
  title   = {bidspm},
  url = {https://github.com/cpp-lln-lab/bidspm},
  version = {2.2.0}
  doi     = {10.5281/zenodo.3554331},
  publisher = {Zenodo},
  journal = {Software}
}
```

## Contributors

Thanks goes to these wonderful people
([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/anege"><img src="https://avatars0.githubusercontent.com/u/50317099?v=4?s=100" width="100px;" alt="Ane Gurtubay"/><br /><sub><b>Ane Gurtubay</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=anege" title="Code">💻</a> <a href="#design-anege" title="Design">🎨</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/CerenB"><img src="https://avatars1.githubusercontent.com/u/10451654?v=4?s=100" width="100px;" alt="Ceren Battal"/><br /><sub><b>Ceren Battal</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3ACerenB" title="Bug reports">🐛</a> <a href="#content-CerenB" title="Content">🖋</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=CerenB" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=CerenB" title="Code">💻</a> <a href="https://github.com/cpp-lln-lab/bidspm/pulls?q=is%3Apr+reviewed-by%3ACerenB" title="Reviewed Pull Requests">👀</a> <a href="#userTesting-CerenB" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/christine0903"><img src="https://avatars.githubusercontent.com/u/70207207?v=4?s=100" width="100px;" alt="Christine Chouinard-Leclaire"/><br /><sub><b>Christine Chouinard-Leclaire</b></sub></a><br /><a href="#ideas-christine0903" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Achristine0903" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/fedefalag"><img src="https://avatars2.githubusercontent.com/u/50373329?v=4?s=100" width="100px;" alt="Federica Falagiarda"/><br /><sub><b>Federica Falagiarda</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Afedefalag" title="Bug reports">🐛</a> <a href="#userTesting-fedefalag" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/fcerpe"><img src="https://avatars.githubusercontent.com/u/73432853?v=4?s=100" width="100px;" alt="Filippo Cerpelloni"/><br /><sub><b>Filippo Cerpelloni</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Afcerpe" title="Bug reports">🐛</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=fcerpe" title="Tests">⚠️</a> <a href="#userTesting-fcerpe" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/iqrashahzad14"><img src="https://avatars.githubusercontent.com/u/75671348?v=4?s=100" width="100px;" alt="Iqra Shahzad"/><br /><sub><b>Iqra Shahzad</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Aiqrashahzad14" title="Bug reports">🐛</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=iqrashahzad14" title="Documentation">📖</a> <a href="#question-iqrashahzad14" title="Answering Questions">💬</a> <a href="https://github.com/cpp-lln-lab/bidspm/pulls?q=is%3Apr+reviewed-by%3Aiqrashahzad14" title="Reviewed Pull Requests">👀</a> <a href="#userTesting-iqrashahzad14" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/JeanneCaronGuyon"><img src="https://avatars.githubusercontent.com/u/8718798?v=4?s=100" width="100px;" alt="Jeanne Caron-Guyon"/><br /><sub><b>Jeanne Caron-Guyon</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3AJeanneCaronGuyon" title="Bug reports">🐛</a> <a href="#example-JeanneCaronGuyon" title="Examples">💡</a> <a href="#userTesting-JeanneCaronGuyon" title="User Testing">📓</a> <a href="#question-JeanneCaronGuyon" title="Answering Questions">💬</a> <a href="#tutorial-JeanneCaronGuyon" title="Tutorials">✅</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/marcobarilari"><img src="https://avatars3.githubusercontent.com/u/38101692?v=4?s=100" width="100px;" alt="Marco Barilari"/><br /><sub><b>Marco Barilari</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=marcobarilari" title="Code">💻</a> <a href="#design-marcobarilari" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/bidspm/pulls?q=is%3Apr+reviewed-by%3Amarcobarilari" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=marcobarilari" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=marcobarilari" title="Tests">⚠️</a> <a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Amarcobarilari" title="Bug reports">🐛</a> <a href="#userTesting-marcobarilari" title="User Testing">📓</a> <a href="#ideas-marcobarilari" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mwmaclean"><img src="https://avatars.githubusercontent.com/u/54547865?v=4?s=100" width="100px;" alt="Michèle MacLean"/><br /><sub><b>Michèle MacLean</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=mwmaclean" title="Code">💻</a> <a href="#ideas-mwmaclean" title="Ideas, Planning, & Feedback">🤔</a> <a href="#userTesting-mwmaclean" title="User Testing">📓</a> <a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Amwmaclean" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mohmdrezk"><img src="https://avatars2.githubusercontent.com/u/9597815?v=4?s=100" width="100px;" alt="Mohamed Rezk"/><br /><sub><b>Mohamed Rezk</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=mohmdrezk" title="Code">💻</a> <a href="https://github.com/cpp-lln-lab/bidspm/pulls?q=is%3Apr+reviewed-by%3Amohmdrezk" title="Reviewed Pull Requests">👀</a> <a href="#design-mohmdrezk" title="Design">🎨</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mcgnunes"><img src="https://avatars.githubusercontent.com/u/98760858?v=4?s=100" width="100px;" alt="Márcia Nunes"/><br /><sub><b>Márcia Nunes</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Amcgnunes" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://cpplab.be"><img src="https://avatars0.githubusercontent.com/u/55407947?v=4?s=100" width="100px;" alt="Olivier Collignon"/><br /><sub><b>Olivier Collignon</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=OliColli" title="Code">💻</a> <a href="#design-OliColli" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=OliColli" title="Documentation">📖</a> <a href="#financial-OliColli" title="Financial">💵</a> <a href="#fundingFinding-OliColli" title="Funding Finding">🔍</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://remi-gau.github.io/"><img src="https://avatars3.githubusercontent.com/u/6961185?v=4?s=100" width="100px;" alt="Remi Gau"/><br /><sub><b>Remi Gau</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/commits?author=Remi-Gau" title="Code">💻</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=Remi-Gau" title="Documentation">📖</a> <a href="#ideas-Remi-Gau" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-Remi-Gau" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/bidspm/pulls?q=is%3Apr+reviewed-by%3ARemi-Gau" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3ARemi-Gau" title="Bug reports">🐛</a> <a href="https://github.com/cpp-lln-lab/bidspm/commits?author=Remi-Gau" title="Tests">⚠️</a> <a href="#content-Remi-Gau" title="Content">🖋</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="#tutorial-Remi-Gau" title="Tutorials">✅</a> <a href="#maintenance-Remi-Gau" title="Maintenance">🚧</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/yyang1234"><img src="https://avatars.githubusercontent.com/u/59220868?v=4?s=100" width="100px;" alt="YingYang"/><br /><sub><b>YingYang</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/bidspm/issues?q=author%3Ayyang1234" title="Bug reports">🐛</a> <a href="#userTesting-yyang1234" title="User Testing">📓</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
