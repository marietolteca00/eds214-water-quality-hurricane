# Automate

#### Running the entire analysis requires rendering one Quarto document
*Meets spec* - The quarto document is runs without error, and produces analysis.

#### The analysis runs without errors
*Meets spec* - There are no errors in the analysis.

#### The analysis produces the expected output
*Not yet* - The quarto document does not produce a figure at the moment, but the analysis produces the expected data in the data frame. I suggest taking another look at your ggplot functions.

#### Data import/cleaning is handled in its own script(s)
*Not yet* - Marie, I suggest that you make separate scripts that have your data import and data cleaning functions in them. Then you can source those scripts in your quarto document.


# Organize

#### Raw data is contained it it's own folder
*Met* - Raw data is in it's own folder

#### Intermediate outputs are created and saved in a separate folder from raw data
*Not Yet* - Right now everything is in the same script, I suggest creating separate files that contain your clean data as csv(s)

#### At least one piece of functionality has been refactored in a function in its own file
*Met* - Rolling average function is saved and used in your quarto. Awesome!



# Document

#### The repo has a README that explains where find (1) date, (2) analysis script, (3) supporting code and (4) outputs.
*Not Yet* - README has some but not all of these components. I suggest adding information about the contents of each folder in your repository.

#### The README includes a flowchart and text explaining how the analysis works
*Met* - The README contains a flowchart, but it is in list format. I suggest creating a flowchart in another software like word or Obsidian, and then putting a picture of it into your README.

#### The code is appropriately commented
*Met* - The code is commented with useful explanantion, but there are a lot of extraneous comments.

#### Variable and function names are descripitive and follow a consistenet naming convention
*Met* - Variable names are descriptive and don't contradict eachother, though they could be slightly more succinct.



# Scale

#### Running the environment initialization script installs all required packages
*Met* - Yes, though a separate script for environmental intilization would help meet above specs

#### The analysis script runs without errors
*Met* - No errors in sight!



