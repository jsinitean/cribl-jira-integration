public with sharing class JiraIssueMapping {
    public static JiraIssueJSON mapIssueToCase(Case caseRecord) {
        JiraIssueJSON issueJSON = new JiraIssueJSON();
        
        issueJSON.fields.project.key = 'LS';
        issueJSON.fields.summary = caseRecord.Subject;
        issueJSON.fields.issuetype.name = 'Bug';
        
        return issueJSON;
    }
}