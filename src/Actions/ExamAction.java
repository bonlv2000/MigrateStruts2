package Actions;

import Models.DatabaseClass;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.SQLException;
import java.time.LocalTime;

public class ExamAction extends ActionSupport {
    private String action,coursename,size,totalmarks,question,ans,qid,eId;

    public String geteId() {
        return eId;
    }

    public void seteId(String eId) {
        this.eId = eId;
    }

    private DatabaseClass db = new DatabaseClass();

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getTotalmarks() {
        return totalmarks;
    }

    public void setTotalmarks(String totalmarks) {
        this.totalmarks = totalmarks;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAns() {
        return ans;
    }

    public void setAns(String ans) {
        this.ans = ans;
    }

    public String getQid() {
        return qid;
    }

    public void setQid(String qid) {
        this.qid = qid;
    }


    public ExamAction() throws SQLException, ClassNotFoundException {
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    @Override
    public String execute() throws Exception {
        if(action==null) {
            return "examPage";
        }

        switch (action) {
            case "startExam":
                startExam();
                break;
            case "submitted":
                submitted();
                return "result";
        }

        return "examPage";
    }



    private void submitted() {
        try{
            String time= LocalTime.now().toString();
            int size=Integer.parseInt(this.size);
            int eId=Integer.parseInt(ActionContext.getContext().getSession().get("examId").toString().trim());
            int tMarks=Integer.parseInt(totalmarks);
            ActionContext.getContext().getSession().remove("examId");
            ActionContext.getContext().getSession().remove("examStarted");
            for(int i=0;i<size;i++){
                db.insertAnswer(eId,Integer.parseInt(qid.trim()+i),question+i,ans+i);
            }
            this.eId = eId+"";
            db.calculateResult(eId,tMarks,time,size);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    private void startExam() {
        int userId=Integer.parseInt(ActionContext.getContext().getSession().get("userId").toString());
        int examId=db.startExam(coursename,userId);
        ActionContext.getContext().getSession().put("examId",examId);
        ActionContext.getContext().getSession().put("examStarted","1");
    }
}
