alter table collectiontype add `info` text NULL 
;

CREATE TABLE cashreceipt_group (
objid varchar(50) NOT NULL ,
txndate datetime NOT NULL ,
controlid varchar(50) NOT NULL ,
amount decimal(16,2) NOT NULL ,
totalcash decimal(16,2) NOT NULL ,
totalnoncash decimal(16,2) NOT NULL ,
cashchange decimal(16,2) NOT NULL ,
CONSTRAINT pk_cashreceipt_group PRIMARY KEY (objid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 
;
CREATE INDEX ix_txndate ON cashreceipt_group (txndate) 
;
CREATE INDEX ix_controlid ON cashreceipt_group (controlid)  
;

CREATE TABLE cashreceipt_groupitem (
objid varchar(50) NOT NULL ,
parentid varchar(50) NOT NULL ,
CONSTRAINT pk_cashreceipt_groupitem PRIMARY KEY (objid) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 
;
CREATE INDEX ix_parentid ON cashreceipt_groupitem (parentid) 
;
alter table cashreceipt_groupitem add CONSTRAINT fk_cashreceipt_groupitem_objid 
	FOREIGN KEY (objid) REFERENCES cashreceipt (objid) 
;
alter table cashreceipt_groupitem add CONSTRAINT fk_cashreceipt_groupitem_parentid 
	FOREIGN KEY (parentid) REFERENCES cashreceipt_group (objid) 
;


drop view if exists vw_income_summary
; 
create view vw_income_summary as 
select 
  inc.*, fund.groupid as fundgroupid, 
  ia.objid as itemid, ia.code as itemcode, ia.title as itemtitle, ia.type as itemtype  
from income_summary inc 
  inner join fund on fund.objid = inc.fundid 
  inner join itemaccount ia on ia.objid = inc.acctid 
;


drop view if exists sys_user_role
; 
create view sys_user_role AS 
select  
	u.objid AS objid, 
	u.lastname AS lastname, 
	u.firstname AS firstname, 
	u.middlename AS middlename, 
	u.username AS username,
	concat(u.lastname, ', ', u.firstname, (case when u.middlename is null then '' else concat(' ', u.middlename) end)) AS name, 
	ug.role AS role, 
	ug.domain AS domain, 
	ugm.org_objid AS orgid, 
	u.txncode AS txncode, 
	u.jobtitle AS jobtitle, 
	ugm.objid AS usergroupmemberid, 
	ugm.usergroup_objid AS usergroup_objid,
	ugm.org_objid as respcenter_objid, 
	ugm.org_name as respcenter_name 
from sys_usergroup_member ugm 
	inner join sys_usergroup ug on ug.objid = ugm.usergroup_objid 
	inner join sys_user u on u.objid = ugm.user_objid 
;
