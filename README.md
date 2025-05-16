## Example CHANGELOG output 

Here is an example of what the CHANGELOG could look like:

```markdown
### Executing NiFi Flow Diff for flow: `MyExample`

#### Flow Changes
- The destination of a connection has changed from `UpdateAttribute` to `InvokeHTTP`
- A self-loop connection `[success]` has been added on `UpdateAttribute`
- A connection `[success]` from `My Generate FlowFile Processor` to `UpdateAttribute` has been added
- A Processor of type `GenerateFlowFile` named `GenerateFlowFile` has been renamed from `GenerateFlowFile` to `My Generate FlowFile Processor`
- In Processor of type `GenerateFlowFile` named `GenerateFlowFile`, the Scheduling Strategy changed from `TIMER_DRIVEN` to `CRON_DRIVEN`
- A Parameter Context named `Test Parameter Context` has been added
- The Parameter Context `Test Parameter Context` with parameters `{addedParam=newValue}` has been added to the process group `TestingFlowDiff`
- A Processor of type `UpdateAttribute` named `UpdateAttribute` has been removed
- In Processor of type `GenerateFlowFile` named `GenerateFlowFile`, the Run Schedule changed from `1 min` to `* * * * * ?`
- A Parameter Context named `Another one to delete` has been added
- A Processor of type `UpdateAttribute` named `UpdateAttribute` has been added with the configuration [`ALL` nodes, `1` concurrent tasks, `0ms` run duration, `WARN` bulletin level, `TIMER_DRIVEN` (`0 sec`), `30 sec` penalty duration, `1 sec` yield duration] and the below properties:
  - `Store State` = `Do not store state`
  - `canonical-value-lookup-cache-size` = `100`

#### Bundle Changes
- The bundle `org.apache.nifi:nifi-standard-nar` has been changed from version `2.1.0` to version `2.2.0`
```
