# NMRS (Nigeria Medical Records System) Development Guide

## Program Increment/Updates to NMRS

This section is a guide on how new feature or bug fix will be planned and discussed before moving on to the development team for implementation.

All new features or improvements to be added to NMRS should come with a detailed description of the functionality and use cases. The collective team involved in NMRS will review before it is merged and distributed.

## Software development process

This section is for everything software development related

### Git Workflow

Git workflow for everyone to adhere to for easy collaboration among team members

- Create a dedicated branch for the work/issue that the branch is addressing, follow this [link](https://wiki.openmrs.org/display/docs/Using+Git) to see how create and work with a new branch
- Code reviews should be done to the repository&#39;s develop branch and will require at least 2 approvals beforeone from UMB and another software engineer lead from another organization other than yours before merging in to develop.
- Use this [guide](https://wiki.openmrs.org/display/docs/Code+Review) when reviewing other developer&#39;s code.
- Every pull request should have details explain the change made, the part of NMRS to focus tests on and prefixed with issue numbers. See [here](https://opensource.com/article/19/7/create-pull-request-github) on how to create pull request on GitHub.
- Do not work actively on the &quot;master&quot; or develop branch
- Please follow [git best practices](https://deepsource.io/blog/git-best-practices/).
- Include issue numbers in your commit messages.
- Final reviews and Tests will be done from develop branch by UMB before merging the code to master branch for release, reviews here will need an approval from UMB and (Unit) tests will be run by the Continuous Integration (CI) build.

### UI standardization

All CSS and JS in NMRS will be standardized for easy extension.

### Database Updates

This is a guide for database update plans for NMRS

- All database updates MUST be done using Liquibase. Follow this [guide](https://wiki.openmrs.org/display/docs/Database+Update+Conventions) on how to work with Liquibase. This [tutorial](https://www.liquibase.org/get-started/using-the-liquibase-installer) is also great for beginners.
- Follow [OPEN MRS convention](https://wiki.openmrs.org/display/docs/Database+Update+Conventions) for database updates.
- NEVER share SQL scripts to update database schemas.
- Modules that create database must not alter used tables like concepts and all other concept related tables
- All Database changes will need to be thoroughly tested before release. These tests include
  - Regression – a new database change should not affect existing implementation.
  - Load test – an SQL query to retrieve a data, should not take up to a minute, this is also subject to the part of the system the query will run.
  - Correctness – an SQL query should do what it is meant to do.

### Developer Tests

This is a guide for the different tests that need to be done by the dev team and IP (Implementing Partner) before pushing out the changes to everyone.

- Please ensure your changes have adequate unit tests, this is a requirement for code reviews.
- Follow this OpenMrs [guide](https://wiki.openmrs.org/display/docs/Unit+Tests) to create unit tests.
- All new and existing tests should pass before creating a Pull request to the develop branch.

## Pilot Tests

Guide for test at selected facilities

Pilot tests will be carried out in stages, all tests will involve all departments that directly work with NMRS. Please note that pilot tests will be different based on the feature implemented, some might only need three days while another will need a month or more to validate.

1. First deployment is done in-house by the IPs primarily responsible for development and used in a facility for at least 3 days, all issues/bugs raised during this process should be resolved before moving forward.
2. Once the first step is successful, UMB will create a release branch having all changes going out and an incremental version is created. This release could involve changes from other IPs.
3. Regression test will be done by the implementing partner and UMB to make sure everything that was working before.
4. Changes will be deployed at selected IPs facilities (One each in all IPs facilities) and run there for a week to be sure everything is working as expected. Facility with high number of patients will be considered for this to avoid issues that comes with increased load.

## Releases

- Guide for release and distribution of NMRS
- Minor version update and sometimes major version update is done.
- A date is set for a final release of the version.
- UMB creates a release note detailing all new feature and bugs fixed in the release. This will be review by all partners who contributed to the release.
- UMB communicates the release through an email to all IPs and the wiki is updated.
- All IPs (Implementing Partners) will release plans to deploy latest version to every facility.

##

##

## Issue Report

Guide on how to report technical issues on GitHub

- Users would use the git issue tracker to document any issue met.
- All issues will be reviewed by UMB before it can be implemented

## Managing NigeriaEMR Base Components (like forms and Concepts)

Guide to regulating the creating and distribution of NMRS Core components.

- UMB will be solely responsible for creating and distributing new concepts on the NigeriaEMR.