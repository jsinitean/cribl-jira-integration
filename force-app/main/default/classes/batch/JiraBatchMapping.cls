public without sharing class JiraBatchMapping {

    public static List<Case> mapIssuesToCases(JiraIssueJSON query){
        List<Case> cases = new List<Case>();

        for(JiraIssueJSON.Issues issue : query.issues){
            Case c = new Case();
            c.Jira_Issue_Id__c = issue.key;
            c.Subject = issue.fields.summary;
            cases.add(c);
        }

        return cases;
    }
}