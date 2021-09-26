# Approaches to Structural and Functional Neuroimaging Analysis

Jenny Rieck

Workshop for Cajal Course on Aging and Cognition, 27 Sep 2021

## Workshop overview

This three-part workshop will provide an introduction to different MRI-based techniques to examine structure and function of the brain. 

* Part 1: Structural and diffusion-weighted MRI
* Part 2: Task-based functional MRI
* Part 3: Resting state functional MRI

The workshop will cover:

* An overview of how MRI is used to generate images of gray and white matter structure, water diffusivity, and blood oxygen level dependent (BOLD) signal in the brain
* Steps involved in preprocessing MRI data, including identifying artifacts and conducting quality control
* Common analysis techniques and considerations for each modality
* Advantages and disadvantages of different experimental designs used in task-based functional MRI
* Examples of how different structural and functional MRI analyses have been applied in aging and dementia research

## Resources

### Suggested reading

#### Basics of MRI-based research
* [Bandettini, 2011, Seven topics in functional magentetic resonance imaging](https://pubmed.ncbi.nlm.nih.gov/19938211/)
* [Logothetis, 2008, What we can do and what we cannot do with fMRI](https://doi.org/10.1038/nature06976)
* [Soares, 2016, Hitchhicker's guide to fMRI](https://doi.org/10.3389/fnins.2016.00515)
* [Catani & Thiebaut de Schotten, 2008, Diffusion tensor imaging tractography atlas for virtual in vivo dissections](https://doi.org/10.1016/j.cortex.2008.05.004)

#### Analysis approaches in MRI
* [FreeSurfer for cortical parcellation](https://doi.org/10.1016/j.neuroimage.2012.01.021)
* [General linear model](https://doi.org/10.1016/j.neuroimage.2012.01.133)
* [Partial least squares](https://doi.org/10.1016/j.neuroimage.2010.07.034)
* [Multivariate pattern analysis](https://doi.org/10.1016/10.1146/annurev-neuro-062012-170325)
* [Representational similarity analysis](https://doi.org/10.3389/neuro.06.004.2008)
* [Resting state methods](https://doi.org/10.3174/ajnr.A3263)
* [Brain network metrics](https://doi.org/10.1016/j.tics.2017.09.006)
* [Dynamic functional connectivity](https://doi.org/10.1016/j.neuroimage.2013.05.079)
* [Graphy theory for complex brain networks](https://doi.org/10.1038/nrn2575)

#### Cognitive neuroscience of aging
* [Framework for terms used in cognitive aging neuroscience research](https://reserveandresilience.com/framework/)
* [Cabeza et al., 2018, Maintenance, reserve and compensation](https://doi.org/10.1038/s41583-018-0068-2)
* [Grady, 2012 Cognitive neuroscience of ageing](https://doi.org/10.1038/nrn3256)
* [Reuter-Lorenz & Park, 2014, Revisiting the scaffolding theory of aging and cognition](https://doi.org/10.1093/geronb/gbr017)
* [Sala-Llonch et al., 2015, Reorganization of brain networks in aging: a review of functional connectivity studies](https://doi.org/10.3389/fpsyg.2015.00663)


### MRI Software Tutorials
* SPM
	* [Andy's Short Course: SPM](https://andysbrainbook.readthedocs.io/en/latest/SPM/SPM_Overview.html#)
* FSL
	* [FSL courses](https://open.win.ox.ac.uk/pages/fslcourse/website/online_materials.html#preprac)
	* [Andy's Short Course: FSL](https://andysbrainbook.readthedocs.io/en/latest/fMRI_Short_Course/fMRI_Intro.html)
* AFNI
	* [Andy's Short Course: AFNI](https://andysbrainbook.readthedocs.io/en/latest/AFNI/AFNI_Overview.html)
	* [AFNI bootcamp](https://cbmm.mit.edu/afni)
* FreeSurfer
	* https://surfer.nmr.mgh.harvard.edu/fswiki/Tutorials
	* [Andy's Short Course: FreeSurfer](https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FreeSurfer_Introduction.html)

### Large-Scale and Open MRI Datasets for Aging and Dementia
| Dataset      | Manuscript | Participants | Age Range | T1w | T2w | Diffusion | Rest fMRI | Task fMRI | Other Scans | Longitudinal |
| :---        | :---   |:--- |  :----: | :----:| :----:| :----: | :----:| :----:| :----:| :----:|
|[MIRIAD](https://www.ucl.ac.uk/drc/research/research-methods/minimal-interval-resonance-imaging-alzheimers-disease-miriad)	|[Malone, 2013](http://dx.doi.org/10.1016/j.neuroimage.2012.12.044)	|Controls, AD	|62–77	|X	|	|	|	|	|	|X	|
|[DLBS](https://fcon_1000.projects.nitrc.org/indi/retro/dlbs.html)	| |Healthy	|20–90	|X	|	|	|	|	|Aβ-PET	|	|
|[AIBL](https://aibl.csiro.au/research/neuroimaging/)	|[Ellis, 2009](https://doi.org/10.1017/S1041610209009405)	|Controls, MCI, AD	|60+	|X	|X	|X	|	|	|Aβ-PET; FDG-PET	|	|
|[IXI](https://brain-development.org/ixi-dataset/)	|	|Healthy	|19–86	|X	|X	|X	|	|	|	|X	|
|[PPMI](https://www.ppmi-info.org/about-ppmi/)	|[PPMI, 2011](http://www.ncbi.nlm.nih.gov/pubmed/21930184)	|Controls, Parkinsons	|31–85	|X	|	|X	|X	|	|DaTscan 	|	|
|[ABIDE](http://fcon_1000.projects.nitrc.org/indi/abide/)	|[Di Martino, 2017](http://www.ncbi.nlm.nih.gov/pubmed/28291247)	|Controls, Autism	|5–64	|X	|	|X	|X	|	|	|X	|
|[HABS](https://habs.mgh.harvard.edu/researchers/data-details/)	|[Dagley, 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4592689/)	|Healthy, Preclinical AD	|62-90	|X	|X	|X	|X	|	|Aβ-PET; Tau-PET; FDG-PET	|X	|
|[ADNI GO/ ADNI2](http://adni.loni.usc.edu/)	|[Jack, 2010](https://doi.org/10.1016/j.jalz.2010.03.004)	|Controls, MCI, AD	|55–95	|X	|X	|X	|X	|	|ASL	|X	|
|[OASIS-3](https://www.oasis-brains.org/#data)	|[LaMontagne, 2019](https://doi.org/10.1101/2019.12.13.19014902)	|Controls, MCI, AD	|42–95	|X	|X	|X	|X	|	|Aβ-PET; FDG-PET; ASL	|X	|
|[HCP Aging](https://www.humanconnectome.org/study/hcp-lifespan-aging)	|[Bookheimer, 2019](https://doi.org/10.1016/j.neuroimage.2017.10.034)	|Healthy	|35–86	|X	|	|X	|X	|X	|PCASL	|	|
|[NKI Rockland](http://fcon_1000.projects.nitrc.org/indi/enhanced/neurodata.html)	|[Nooner, 2012](http://www.ncbi.nlm.nih.gov/pubmed/23087608)	|Healthy	|4–85	|X	|	|X	|X	|X	|Breath Hold	|	|
|[Cam-CAN](https://camcan-archive.mrc-cbu.cam.ac.uk/dataaccess/)	|[Shafto, 2014](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4219118/)	|Population |18-87	|X	|X	|X	|X	|X	|	MEG|	|
|[UK BioBank](https://www.ukbiobank.ac.uk/enable-your-research/about-our-data/imaging-data)	|[Alfaro-Almagro, 2018](https://doi.org/10.1016/j.neuroimage.2017.10.034)	|Population 	|37-73	|X	|X	|X	|X	|X	|	|	|

* [Other neuroscience datasets and databases](https://en.wikipedia.org/wiki/List_of_neuroscience_databases)
* [openneuro.org](https://openneuro.org/)
