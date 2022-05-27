# Instabug Internship Task
This app purpose is to save log messages in persistence container to retrieve it at anytime and analyze it.

<img width="300" alt="Screen Shot 2022-05-27 at 1 31 53 PM" src="https://user-images.githubusercontent.com/42544598/170691519-fd6ac020-b86e-4bc6-b551-aa92aaf31e84.png">

## Goals
While working on this project, to achieve some level of high quality and maintainability:

### General

1. Write a documentation to the framework for every method in the app explaining its use and parameters. 
2. Not putting Core Data code in the AppDelegate file and create a separate manager class to handle persistency.
3. Handle CoreDataManager methods to InstabugLogger since it's our interface to save and retrieve logs.

### Testing

1. Create unit tests for each method in our interface e.g. InstabugLogger.
2. Create tests the are self-validating i.e. they are fully automated. The output is either “pass” or “fail”, rather than relying on a programmer’s interpretation of a log file.
3. Make test independent i.e. they are not sharing state with each other.

### Concurrency

1. Save, delete and load any log is on a concurrent queue to ensure smooth running of the app and avoid freezing UI.



## Documentation

- To save a log to Core Data use `saveLog(_:LoggerModel)`
- To fetch all logs from Core Data `fetchAllLogs()`


