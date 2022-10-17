# *CSC Notebooks* dockerfile

This is to keep track of changes to the dockerfile used to instantiate
containers in which CSC Notebooks are run.

When creating the *CSC Notebooks* workspace and application, this repository can
be directly referenced, see detailed instructions below (TODO).

## Steps to create docker image, a workspace and application for AutoGIS

### 1. Create a docker image

- Check out this repository
- Adjust environment variables


### 2. Upload the docker image to CSC’s *rahti* repository

TODO

### 3. Create a workspace

Log into https://notebooks.csc.fi/, navigate to ’Manage workspaces’, and choose
’Create new workspace’. Fill in the necessary details, and choose ’Create’. 

As an example, for the 2022 iteration of the course,
I entered the following information:

| :workspace name                  | :workspace description                  |
| -------------------------------- | --------------------------------------- |
| Automating GIS processes 2, 2022 | ‘Automating GIS processes 2’ is a Masters’ level course at the Department of Geosciences and Geography, University of Helsinki. https://studies.helsinki.fi/courses/?searchText=GEOG-329-2 |

![Screenshot ‘create workspace’](_static/images/create-workspace_700x545px.png)

**Note**: CSC Notebook workspaces have a default lifetime of only 180 days. Be
sure to create the workspace late enough so it lasts for the entire course.


### 4. Create an application

Navigate to ‘Manage workspaces’, then choose the newly created workspace in the
left pane. 

- On the right side, open the ’Applications’ tab and click ’Application
wizard’.
- Enter a name and description (in 2022, I used the same values as for
the workspace, see table above).
- Then, select *Jupter Lab* as the interface, `

TODO
