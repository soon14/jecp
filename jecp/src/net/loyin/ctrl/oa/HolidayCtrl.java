package net.loyin.ctrl.oa;

import java.util.ArrayList;
import java.util.List;
import net.loyin.ctrl.AdminBaseController;
import net.loyin.jfinal.anatation.RouteBind;
import net.loyin.model.oa.Holiday;
import net.loyin.pageModel.DataGrid;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * Powered By loyin 龙影 刘声凤
 * Web Site: http://www.loyin.net
 * Since 2008 - 2013
 *//**
*Holiday
*/
@RouteBind(path = "holiday")
public class HolidayCtrl extends AdminBaseController<Holiday> {
	public HolidayCtrl() {
		this.tableName = Holiday.tableName;
		modelClass = Holiday.class;
	}
	public void dataGrid() {
		List<Object> param = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		/** 添加查询字段条件*/
		String qryField=this.getPara("qryField");//查询字段 以逗号分隔
		if(qryField!=null&&!"".equals(qryField)){
			String[] k=qryField.split(",");
			for(String q:k){
				Object t=this.getPara(q);
				if(t!=null&&!"".equals(t)){
					where.append(" and ");
					where.append(q);
					where.append(" =? ");
					param.add(t);
				}
			}
		}
		String sortName = this.getPara("sort");
		String sortOrder = this.getPara("order", "desc");
		if (sortName != null) {
			where.append(" order by ");
			where.append(sortName);
			where.append(" ");
			where.append(sortOrder);
		}
		Page<Record> p = Db.paginate(this.getParaToInt("page", 1), this.getParaToInt("rows", 20), "select t.ID,t.tile,t.STARTDATE,t.ENDDATE, 1 ", "from " + this.tableName+ " t where 1=1 " + where.toString(), param.toArray());
		DataGrid dg = new DataGrid();
		dg.setRows(p.getList());
		dg.setTotal(p.getTotalRow());
		this.renderJson(dg);
	}
}