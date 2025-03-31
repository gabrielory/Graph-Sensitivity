# Graph Sensitivity 

This repository contains code for computing the sensitivity of various graph families using SageMath.  

## Repository Structure  

- **'sensitivity.sage'** – Contains methods for computing graph sensitivity.
- **'PriorityQueue.sage'** - Contains a class implementing a binary heap.
- **'graph_families/'** – Includes classes for constructing different graph families, along with supporting functions.  
- **'graph_families/sensitivity_calculations/'** – Contains scripts that implement sensitivity calculations for specific graph families. (These are the files that should be executed.)
- **'out/'** – Stores the output generated from the computations.

## Running the Code  

To run the code, you can either:  
1. Download the files and keep them in their original directories.  
2. Adjust the paths in the attach statements at the top of the files to match your directory structure.  

You can run the code without installing SageMath by using **[CoCalc](https://cocalc.com/)**:
  1. Create a new project.  
  2. Upload the necessary files, including dependencies (as specified in the attach statements).  
  3. Run the sensitivity calculation scripts directly within the browser.  

  If preferred, you may also use other cloud services or run the code locally if you have SageMath installed.

To change the output directory, modify the file path inside:  
- The 'output_results' method in the graph family classes.  
- The output functions within the sensitivity calculation scripts, where applicable.  
