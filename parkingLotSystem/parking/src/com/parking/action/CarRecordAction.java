package com.parking.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.parking.entity.CarRecord;
import com.parking.entity.Reports;
import com.parking.entity.Users;
import com.parking.service.CarRecordService;
import com.parking.service.ReportsService;
import com.parking.service.UsersService;

@SuppressWarnings("serial")
public class CarRecordAction extends ActionSupport {
	private CarRecordService carRecordService;//停车记录Service
	private UsersService usersService;//用户Service
	private CarRecord carRecord;
	private List<CarRecord> carRecords;
	private Integer user_id;//用户id
	private Integer cr_id;//记录id
	private String dateReport;//开出时间
	private Date intimeCR;
	
	
	private ReportsService reportsService;//报表Service
	
	//分页
	private Integer totalPage;
	private Integer currentPage;
	
	HttpSession session=ServletActionContext.getRequest().getSession();
	HttpServletRequest request=ServletActionContext.getRequest();
	
	/**
	 * 记录用户停车记录
	 * @return
	 * @throws Exception
	 */
	public String addCarRecord() throws Exception{
		carRecord.setIntime(new Timestamp(intimeCR.getTime()));
		@SuppressWarnings("deprecation")
		Date dateRep=new Date(dateReport);
		carRecord.setOuttime(dateRep);
		System.out.println("-------------------------------------"+carRecord.getIntime());
		int addRes=carRecordService.insertCarRecord(carRecord);
		Reports reports=new Reports();
		
		reports.setTime(dateRep);
		reports.setMoney(carRecord.getTotalPrice());
		int addReportsRes=reportsService.insertReports(reports);
		if (addReportsRes>0) {
			System.out.println("--------------------新增一次报表信息");
		}
		if (addRes>0) {
			Users userSession=(Users) session.getAttribute("user");
			int changeCSRes=carRecordService.updateCSByUserId(userSession.getId());
			if (changeCSRes>0) {
				return "success";
			}
			return "error";
		}
		return "error";
	}
	/**
	 * 查询用户停车记录
	 * @return
	 */
	public String getCRByUserId(){
		Users userSession=(Users) session.getAttribute("user");
		if (userSession.getStatus()!=1) {
			session.setAttribute("userFind", null);
			user_id=userSession.getId();
		}else if(userSession.getStatus()==1){
			/*如果当前用户是管理员
			 * 就重新获得搜索的用户放入session
			 * 用作停车记录页面的返回
			 * */
			String userName=(String) session.getAttribute("userName");
			Users userFindSecond=usersService.getUserByName(userName);
			session.setAttribute("userFind", userFindSecond);
		}
		int pageSize = 14;
		Long count = carRecordService.countUserCR(user_id);
		if (count <= 0) {
			totalPage = 1;
		} else {
			totalPage = (int) ((count % pageSize == 0) ? (count / pageSize)
					: (count / pageSize + 1));
		}
		if (currentPage == null) {
			this.setCurrentPage(1);
		}
		int begin = (currentPage - 1) * pageSize;
		carRecords=carRecordService.getCRListByUserId(begin, pageSize, user_id);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalPage", totalPage);
		return "success";
	}
	/**
	 * 删除用户停车记录
	 * @return
	 * @throws Exception
	 */
	public String delUserCR() throws Exception{
		int delCRRes=carRecordService.delUserCR(cr_id);
		if (delCRRes>0) {
			return "success";
		}else{
			return "error";
		}
	}

	public CarRecordService getCarRecordService() {
		return carRecordService;
	}
	public void setCarRecordService(CarRecordService carRecordService) {
		this.carRecordService = carRecordService;
	}
	public CarRecord getCarRecord() {
		return carRecord;
	}
	public void setCarRecord(CarRecord carRecord) {
		this.carRecord = carRecord;
	}
	public List<CarRecord> getCarRecords() {
		return carRecords;
	}
	public void setCarRecords(List<CarRecord> carRecords) {
		this.carRecords = carRecords;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public UsersService getUsersService() {
		return usersService;
	}
	public void setUsersService(UsersService usersService) {
		this.usersService = usersService;
	}
	public ReportsService getReportsService() {
		return reportsService;
	}
	public void setReportsService(ReportsService reportsService) {
		this.reportsService = reportsService;
	}
	public Integer getCr_id() {
		return cr_id;
	}
	public void setCr_id(Integer cr_id) {
		this.cr_id = cr_id;
	}
	public String getDateReport() {
		return dateReport;
	}
	public void setDateReport(String dateReport) {
		this.dateReport = dateReport;
	}
	public Date getIntimeCR() {
		return intimeCR;
	}
	public void setIntimeCR(Date intimeCR) {
		this.intimeCR = intimeCR;
	}
}
