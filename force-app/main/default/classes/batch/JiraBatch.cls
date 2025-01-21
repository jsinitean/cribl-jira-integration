public class JiraBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable {

    public void execute(SchedulableContext sc) {
        JiraBatch batch = new JiraBatch();
        Database.executeBatch(batch, 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Case WHERE JIRA_Issue_Id__c != null LIMIT 50000]);
    }

    public void execute(Database.BatchableContext bc, List<Case> caseList) {
        Map<String, String> params = new Map<String, String>();

        String jql = 'updated >= -1d ORDER BY created DESC'; // Get issues updated in the last day
        params.put('jql', EncodingUtil.urlEncode(jql, 'UTF-8'));
        params.put('maxResults', '100');

        JiraBatchHelper issues = new JiraBatchHelper(params);
        issues.getIssues();
        issues.updateCases();
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Finished');
    }
}