# NMRS (Nigeria Medical Records System) Implementation Guide

## Program Increment/Updates to NMRS

This section is a guide on how new feature or bug fix will be planned and discussed before moving on to the development team for implementation.

All added features planned for NMRS from the IPS, CDC will be discussed, and user stories created with tasks assigned to developers. We will do this process every 3 months, this will help us plan for future work and reduce emergency features as much as possible. Please note that this does not mean bugs will be ignored, enough time to fix bugs will be given.

## Software development process

This section is for everything software development related

### Git Workflow

Git workflow for everyone to adhere to for easy collaboration among team members

- Create a dedicated branch for the work/issue that the branch is addressing.
- Code reviews should be done to the repository&#39;s develop branch, and will require at least 2 approvals before merging in to develop.
- Use this [guide](https://wiki.openmrs.org/display/docs/Code+Review) when reviewing other developer&#39;s code.
- Every pull request should have details explaing the change made and prefixed with issue numbers.
- Do not work actively on the &quot;master&quot; or develop branch
- Please follow [git best pratices](https://deepsource.io/blog/git-best-practices/).
- Include issue numbers in your commit messages.
- Final reviews and Tests will be done from develop to master branch for release.

### UI standardization

All CSS and JS in NMRS will be standardized for easy extension.

### Database Updates

This is a guide for database update plans for NMRS

- All database updates MUST be done using liquidbase
- Follow [OPEN MRS convention](https://wiki.openmrs.org/display/docs/Database+Update+Conventions) for database updates.
- NEVER share SQL scripts to update database schemas.
- Modules that create database must not alter generally used tables like concepts and all other concept related tables
- All Database changes will need to be properly tested before release

### Developer Tests

This is a guide for the different tests that need to be done by the dev team and IP (Implementing Partner) before pushing out the changes to everyone.

- Please ensure your changes have adeaquate unit tests, this is a requirement for code reviews.
- Follow this OpenMrs [guide](https://wiki.openmrs.org/display/docs/Unit+Tests) to create unit tests.
- All new and exisitng tests should pass before creating a Pull request to the develop branch.

## Pilot Tests

Guide for test at selected facilities

- A release branch containg all changes going out with a set version is created.
- Changes will be deployed at selected IPs facilities and run there for a week to be sure everything is working as expected.
- Regression test will be done to make sure everything that was working before

## Releases

Guide for release and distribution of NMRS

- Minor version update and sometimes major version update is done.
- A Release note is created detailing all new feature and bugs fixed in the release.
- A date is set for a final release of the version.
- All IPs (Implementing Partners) will release plans to deploy latest version to every facility.

## Issue Report

Guide on how to report technical issues on Github

- Users would use the git issue tracker to document any issue met.
- All issues will be reviewed by UMB before it can be implemented

## Managing NigeriaEMR Base Components (like forms and Concepts)

Guide to regulating the creating and distribution of NMRS Core components.

- UMB will be solely responsible for creating and distributing new concepts on the NigeriaEMR.