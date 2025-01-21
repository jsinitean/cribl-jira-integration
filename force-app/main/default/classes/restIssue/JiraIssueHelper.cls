public with sharing class JiraIssueHelper {

    public static Case createOrUpdateIssue(Case caseRecord) {
        JiraIssueJSON issue = JiraIssueMapping.mapIssueToCase(caseRecord);
        
        HttpResponse res = JiraCall.createIssue(JSON.serialize(issue, true));
        if (res.getStatusCode() == 201) {
            // Assuming the response contains the Jira ticket number, write to case
            JIRAIssueJSON issResponse = JIRAIssueJSON.parse(res.getBody());
            caseRecord.JIRA_Issue_Id__c = issResponse.key;
            return caseRecord;
        } else {
            // Handle the case where the issue creation/update fails
            throw new CustomException('Failed to create or update Jira issue');
        }
        
    }

    public class CustomException extends Exception {}
}