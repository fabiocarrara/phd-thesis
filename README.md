# Deep Learning for Image Classification and Retrieval: Analysis and Solutions to Current Limitations

PhD Thesis (Draft), October 2018, Fabio Carrara. Currently under revision.


This repository contains the LaTeX and [Asymptote](http://asymptote.sourceforge.net/) source files of the Ph.D. thesis of Fabio Carrara.
The template used is the one for Ph.D dissertations of the Department of Computer Engineering of the University of Pisa.

An up-to-date PDF of the thesis is available here: [http://pc-carrara.isti.cnr.it/PhD_Thesis.pdf]

## Summary

The large diffusion of cheap cameras and smartphones led to an exponential daily production of digital visual data, such as images and videos.
In this context, most of the produced data lack manually assigned metadata needed for their manageability in large-scale scenarios, thus shifting the attention to the automatic understanding of the visual content.
Recent developments in Computer Vision and Artificial Intelligence empowered machines with high-level vision perception enabling the automatic extraction of high-quality information from raw visual data.
Specifically, Convolutional Neural Networks (CNNs) provided a way to automatically learn effective representations of images and other visual data showing impressive results in vision-based tasks, such as image recognition and retrieval.

In this thesis, we investigated and enhanced the usability of CNNs for visual data management.
First, we identify three main limitations encountered in the adoption of CNNs and propose general solutions that we experimentally evaluated in the context of image classification.
We proposed miniaturized architectures to decrease the usually high computational cost of CNNs and enable edge inference in low-powered embedded devices.
We tackled the problem of manually building huge training sets formodels by proposing an automatic pipeline for training classifiers based on cross-media learning and Web-scraped weakly-labeled data.
We analyzed the robustness of CNNs representations to out-of-distribution data, specifically the vulnerability to adversarial examples, and proposed a detection method to discard spurious classifications provided by the model.
Secondly, we focused on the integration of CNN-based Content-based Image Retrieval (CBIR) in the most commonly adopted search paradigm, that is, textual search.
We investigated solutions to bridge the gap between image search and highly-developed textual search technologies by reusing both the front-end (text-based queries) and the back-end (distributed and scalable inverted indexes).
We proposed a cross-modal image retrieval approach which enables textual-based image search on unlabeled collections by learning a mapping from textual to high-level visual representations.
Finally, we formalized, improved, and proposed novel surrogate text representations, i.e., text transcriptions of visual representations that can be indexed and retrieved by available textual search engines enabling CBIR without specialized indexes.

