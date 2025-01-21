public with sharing class JiraCall {
    
    /**
     * @param endpoint the endpoint to send the request to, 'issues'
     * @param method the HTTP method to use, GET
     * @param body the body of the request, {"key": "value"}
     */

    private static HttpResponse httpHelper(String endpoint, String method, String body){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        if(body != null){
            req.setBody(body);
            req.setHeader('Content-Type', 'application/json');

        }
        req.setMethod(method);
        req.setEndpoint('callout:Jira/' + endpoint);

        HttpResponse res = h.send(req);
        System.debug(res.getBody());
        return res;
    }

    /**
     * @param body the body of the request, {"key": "value"}
     */
    public static HttpResponse createIssue(String body){
        return httpHelper('issue', 'POST', body);
    }

    /**     
     * @param params Jira issue search query parameters
     */
    public static HttpResponse getIssues(Map<String,String> params){
        String endpoint = 'search?';
        for(String key : params.keySet()){
            endpoint+= key + '=' + params.get(key) + '&';
        }
        return httpHelper(endpoint, 'GET', null);
    }
}