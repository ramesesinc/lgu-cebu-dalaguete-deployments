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

