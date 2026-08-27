### Automate


## Need to finish up my moving-average.R code so that i can do a pull request
not yet

- [ ] **The entire analysis is automated**
  - Data reading and cleaning is handled in a standalone script that creates intermediate output(s).
  - The analysis is performed in a Quarto document that reads intermediate outputs.
  - Files in the R/ folder exclusively define functions and have no other side effects.
  - All scripts run without errors.

- [ ] **The analysis produces the expected output**
  - The Quarto document performs the data analysis (moving average).
  - The Quarto document creates a figure that is a reasonable approximation of the original.

### Organize
Meets Spec

- [x] **Data are properly organized**
  - _Raw_ data is contained in its own folder.
  - _Outputs_ are contained in a separate folder from raw data.

- [x] **Code is properly organized**
  - At least one function is defined in a script in R/ and used elsewhere in the workflow.
  - All code in the repo (_except_ in the scratch/ folder) is required for the analysis (i.e., no "safety blanket" code remaining)

## Document
Not Yet

### Need to finish my description for the  titles and then add an image and redo my comments

- [ ] **The repo has an effective README** 
  - A short, but descriptive title 
    - A README’s title is set to the repository name by default - change this!
  - A brief explanation of the repository’s purpose
    - Paragraphs or a bulleted list are both acceptable options
    - You may include an image or logo that represents the project
  - A concise description of what’s housed in the repository
    - This includes information about the repository structure or file organization 
  - Details regarding data access
    - Any necessary information on where data lives (e.g. is it housed in the repo, on a server, in a library/package etc.) and how to access it in order to run the code
  - A list of authors or current contributors (for collaborative work)
    - Consider hyperlinking collaborators’ GitHub profiles or other professional profile
  - References 
    - In an appropriate, consistent format, including links.
    - Don’t forget to add references for datasets too.
    
- [ ] **Code follows a professional style**
  - All code files follow a consistent style (the Air formatter automates this).
  - The code has an appropriate amount of comments.
    - Comments are minimized by using _meaningful variable names_ and _helper functions_.
    - Comments are used to [explain the _why_ of code, not the _what_](https://style.tidyverse.org/functions.html#comments).
