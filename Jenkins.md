# Jenkins Pipeline for Flask Application

# Table of Contents

1. [Overview](#overview)

2. [Prerequisites](#prerequisites)

    a. [Instance creation](#instance-creation)
   
    b. [Plugins Installation](#plugins-installation)

    c. [Configuring Email Notifications](#configuring-email-notifications)

4. [Pipeline Stages](#pipeline-stages)

    a. [Screenshots](#screenshots)

    b. [Jenkinsfile Configuration](#jenkinsfile-configuration)
5. [Poll SCM](#poll-scm)
6. [Email Notifications](#email-notifications)
7. [Overall Workflow](#overall-workflow)


## Overview

This Jenkins pipeline automates the build, test, and deployment of a Flask application. It fetches the application code from a GitHub repository, installs dependencies, runs unit tests, and deploys to a staging environment.

### Prerequisites

#### Instance creation

We need to create an Instance and install Jenkins. You can install the Jenkins using this [file]
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/303f4503-7e56-4f28-b236-43cd91eb3a9e)
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/f56ec02e-c4be-40ab-9cfd-9c43115dbd52)



#### Plugins Installation

To support this pipeline, install the following plugins:

![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/db0c2af3-0963-47eb-b3e2-3cd58d9c404e)
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/c282baaf-734d-4bc3-9a45-31a30e21b12e)






#### Configuring Email Notifications

Configure email notifications by navigating to `Manage Jenkins` > `System` > `E-mail Notification` (scroll to the bottom) and set up as shown below:


Scroll to the bottom of the page and find App passwords as shown in the screenshot
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/cb807ad5-a75e-40de-9197-aa6fc8713a51)



Copy and paste the code in the password section.


If configured correctly, you'll see "Email was successfully sent."
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/3f5b5784-cbff-453d-b326-c8b4d7e8b792)



### Pipeline Stages

The pipeline includes these stages:

1. **Checkout:** Retrieves the application code from the GitHub repository.
2. **Build:** Installs application dependencies using `pip`.
3. **Test:** Runs unit tests for the application with `pytest`.
4. **Deploy:** Deploys the application to a staging environment if tests pass.

#### Screenshots


3. We need to click on `settings` in the GitHub repository, check for `Webhooks`, and give the instance `public IP address:8080/github-webhook/` as shown below.
4. ![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/bd58a00a-7fdd-473b-ae3a-629c5ee8f0da)

5. ![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/4a5b090f-9314-449f-b480-4343ea09a853)

6. ![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/6a68da27-bc25-45bd-abfd-30f2f836b317)

7.![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/c34ccb96-d37a-408e-ad40-32e9b3ef9be3)
 
8. To generate Git syntax for Jenkinsfile, click on `Pipeline Syntax`.
9. ![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/dc50a65d-39ea-4ce2-a28a-ba369db82bbc)


### Jenkinsfile Configuration

The Jenkinsfile defines pipeline stages and steps:

- `agent any`: Allows the pipeline to run on any available Jenkins agent.
- `git`: Fetches application code from GitHub repository using `git-cred` credentials.
- `pip install`: Installs dependencies from `requirements.txt`.
- `pytest`: Runs unit tests using the `pytest` framework.
- `gunicorn`: Installs and starts the Gunicorn WSGI server to run the Flask application.



#### Poll SCM

Poll SCM checks for new commits in Git and automatically triggers the build process to deploy code to the EC2 server.

![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/9c334001-0442-4e79-8e1b-66a352766bf7)


### Email Notifications

The pipeline sends email notifications to `mohankandikuppa119@gmail.com` upon successful or failed builds, with customized subject lines and body content.
![image](https://github.com/mohanvedase/CICD_GitActions/assets/139565500/c6f7b1f8-0046-45ea-92bb-84f4096fa50d)



### Overall Workflow

1. Checkout code from GitHub repository.
2. Install dependencies using pip.
3. Run unit tests with pytest.
4. Deploy application to staging using Gunicorn.
5. Send email notification indicating build status.
