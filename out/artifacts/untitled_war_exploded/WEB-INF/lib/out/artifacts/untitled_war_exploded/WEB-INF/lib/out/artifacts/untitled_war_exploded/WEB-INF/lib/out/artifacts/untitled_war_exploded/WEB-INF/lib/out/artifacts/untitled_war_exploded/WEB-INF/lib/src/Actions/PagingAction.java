package Actions;

import Models.DatabaseClass;
import Models.classes.Exams;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.SQLException;
import java.util.ArrayList;

public class PagingAction extends ActionSupport {
    private String action,index;
    private ArrayList list;
    private DatabaseClass db = new DatabaseClass();

    public PagingAction() throws SQLException, ClassNotFoundException {
    }

    public ArrayList getList() {
        return list;
    }

    public void setList(ArrayList list) {
        this.list = list;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    @Override
    public String execute() throws Exception {
        String returnPage = "home";
        int index;
        if(action == null)
            return returnPage;
        if(this.index == null) {
            index = 1;
        }
        else {
            index = Integer.parseInt(this.index);
        }
        switch (action) {
            case "result":
                list = db.pagingResult(index);
                ActionContext.getContext().getSession().put("pagingItems",(ArrayList<Exams>)list);
                ActionContext.getContext().getSession().put("index",index);
                returnPage = "result";
                break;
            case "account":
                list = db.pagingResult(index);
        }
        return returnPage;
    }
}
