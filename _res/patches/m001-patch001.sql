drop table if exists sync_data_forprocess;
drop table if exists sync_data_pending;
drop table if exists sync_data;

CREATE TABLE `sync_data` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `orgid` varchar(50) DEFAULT NULL,
  `remote_orgid` varchar(50) DEFAULT NULL,
  `remote_orgcode` varchar(20) DEFAULT NULL,
  `remote_orgclass` varchar(20) DEFAULT NULL,
  `dtfiled` datetime NOT NULL,
  `idx` int(11) NOT NULL,
  `sender_objid` varchar(50) DEFAULT NULL,
  `sender_name` varchar(150) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_sync_data_refid` (`refid`),
  KEY `ix_sync_data_reftype` (`reftype`),
  KEY `ix_sync_data_orgid` (`orgid`),
  KEY `ix_sync_data_dtfiled` (`dtfiled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `sync_data_pending` (
  `objid` varchar(50) NOT NULL,
  `error` text,
  `expirydate` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_expirydate` (`expirydate`),
  CONSTRAINT `fk_sync_data_pending_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `sync_data_forprocess` (
  `objid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  CONSTRAINT `fk_sync_data_forprocess_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `cashreceipt_plugin` (
  `objid` varchar(50) NOT NULL,
  `connection` varchar(50) DEFAULT NULL,
  `servicename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8