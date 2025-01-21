public class JiraIssueJSON {
	public Fields fields;
	public String self;
	public String id;
	public String key;
	public List<Issues> issues;
	public Integer total;

	public class Fields {
		public Integer timespent;
		public Integer id;
		public String lastViewed;
		public String description;
		public String created;
		public String updated;
		public String summary;
		public Project project;
		public Issuetype issuetype;
	}

	public class Issuetype {
		public String self;
		public String id;
		public String name;
	}

	public class Project {
		public String id;
		public String key;
	}

	public class Issues {
		public String expand;
		public String id;
		public String self;
		public String key;
		public Fields fields;
	}

	// TODO: Add description field with Atlassian Document Formatting

	public JiraIssueJSON() {
        this.fields = new Fields();
        this.fields.project = new Project();
		this.fields.issuetype = new Issuetype();
    }

	public static JIRAIssueJSON parse(String json) {
		return (JIRAIssueJSON) System.JSON.deserialize(json, JIRAIssueJSON.class);
	}

}

