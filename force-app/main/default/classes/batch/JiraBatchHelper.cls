public with sharing class JiraBatchHelper {

    List<Case> cases;
    public Integer totalCount {get;set;}
    Map<String,String> params;

    /**
     * @param params url query parameters
     */
    public JiraBatchHelper(Map<String, String> params){
        this.params = params;
    }


    public void getIssues(){
        HttpResponse res = JiraCall.getIssues(params);
        if(res.getStatusCode() != 200){
            throw new CustomException('Could not retrieve issues');
        }

        JiraIssueJSON query = JiraIssueJSON.parse(res.getBody());
        cases = JiraBatchMapping.mapIssuesToCases(query);
        totalCount = query.total;
    
    }

    public void updateCases(){
        Database.UpsertResult[] results = Database.upsert(cases, Case.JIRA_Issue_Id__c, false);
        for(Database.UpsertResult result: results){
            if(!result.isSuccess()){
                System.debug(result.getErrors());
            }
        }
    }

    public class CustomException extends Exception {}
}