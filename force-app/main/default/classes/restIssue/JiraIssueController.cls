public with sharing class JiraIssueController {
    public Id caseId {get;set;}
    public Case caseRecord {get;set;}
    public JiraIssueController(ApexPages.StandardController controller) {
        caseId = controller.getRecord().Id;
        if (Schema.sObjectType.Case.fields.Id.isAccessible()) {
            caseRecord = [SELECT Id, Subject, Description, JIRA_Issue_Id__c, Jira_Key__c FROM Case WHERE Id = :caseId];
        } else {
            // Handle the lack of read permission
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You do not have permission to access this case.'));
            caseRecord = new Case();
        }
    }

    public PageReference createIssue(){
        JIRAIssueHelper.createOrUpdateIssue(caseRecord);
        if (Schema.sObjectType.Case.isUpdateable()) {
            update caseRecord;
        } else {
            // Handle the lack of update permission
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You do not have permission to update this case.'));
            return null;
        }
        return new PageReference('/'+ caseId);
    }
}

