# Implementation of a Decision-Making Solution

## Project Overview

### Description
For our NF26 project, developed from February 2024 to June 2024 in association with the Université de Technologie de Compiègne (UTC), we created a comprehensive decision-making solution for a healthcare facility using fictitious data. The project included several key stages: setting up the working environment, installing the data integration system, populating the data warehouse, and creating interactive dashboards with Power BI. Robust technologies such as Teradata for database management and Gitlab for version control were utilized. This project provided us with valuable insights into ETL processes, data lifecycle management, and advanced SQL & Bash scripting. We also improved our teamwork and time management skills, addressing challenges like data format inconsistencies and technical documentation. This project significantly enhanced our ability to automate reporting processes and make informed decisions based on reliable, real-time data.

### Objectives
- Informed decision-making
- Reporting automation
- Data reliability and consistency
- Easy interpretation with intuitive dashboards

### Features
- **Data Analysis**: Integration and centralization of data from various sources (patients, treatments, resources).
- **Reporting**: Creation of interactive dashboards using Power BI.
- **Technologies Used**: 
  - Teradata for database management
  - Power BI for reporting
  - Gitlab for version control
  - Teams for communication

## Project Structure

### Key Stages
1. **Lot 1: Setting up the Working Environment and Designing the Solution**
   - Discovery of data (Excel files)
   - Setup of technical environment (Teradata VM, Gitlab, Teams)
   - Design of various databases and tables

2. **Lot 2: Installation of the Data Integration System (SID) and Data Ingestion**
   - Creation of databases and tables scripts
   - Usage of BTEQ for SQL execution
   - TPT scripts for data loading into staging tables

3. **Lot 3: Populating the Data Warehouse**
   - Loading data into work tables
   - Transition to SOC tables
   - Script execution for data processing tracking

4. **Lot 4: Calculating KPIs and Developing Power BI Dashboards**
   - Views based on data warehouse tables
   - Power BI dashboard development

## Implementation

### Project Files
- `install_SID.sh`: Script for SID installation
- `LAUNCH_LOAD_SID.sh`: Script for launching data load
- `insert_to_wrk_from_stg.sql`: SQL script for loading work tables from staging tables
- `insert_to_soc_from_work.sql`: SQL script for loading SOC tables from work tables
- Power BI files for dashboard visualization

### Dependencies
- Teradata: Database management system
- Power BI: Reporting and dashboard tool

### Usage

 1. Set up the environment:
  - Install Teradata VM
  - Set up Gitlab for version control
  - Use Teams for communication

2. Load the system and data:

```bash
    ./install_SID.sh
    ./LAUNCH_LOAD_SID.sh
```
4. Develop and view dashboards in Power BI.

## Learning Outcomes
### Technical Skills

- Understanding ETL processes
- Data lifecycle management
- Advanced SQL with Teradata
- Bash scripting
- Power BI for reporting

### Soft Skills

- Team collaboration
- Time management
- Addressing technical documentation challenges

## Challenges and Improvements
### Challenges

- Initial understanding of the project scope
- Handling foreign key constraints
- Working with Teradata documentation
- Data type inconsistencies

### Improvements

- Enhance technical documentation
- Optimize scripts for performance
    
## Authors

- Tobias Savary
- Sacha Sz
- Nassim Saidi
- Martin Creuze
- Alexandre Labouré

## University

Université de Technologie de Compiègne (UTC)

## Conclusion

This project significantly improved our decision-making processes by providing real-time, reliable data, automating reporting processes, and developing technical and organizational skills.

For more details, please refer to the project report included in this repository.
License

This project is licensed under the MIT License - see the LICENSE file for details.
