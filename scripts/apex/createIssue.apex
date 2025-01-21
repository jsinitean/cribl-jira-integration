Case caseRecord = [SELECT Id, Subject, Description, JIRA_Issue_Id__c, Jira_Key__c FROM Case WHERE Id = '500ak00000ccoWfAAI'];

System.debug('Case Record: ' + JSON.serialize(caseRecord, true));

JiraIssueHelper.createOrUpdateIssue(caseRecord);