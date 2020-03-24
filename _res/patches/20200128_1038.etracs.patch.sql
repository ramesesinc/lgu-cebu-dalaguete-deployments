CREATE TABLE `cashreceipt_plugin` (
  `objid` varchar(50) NOT NULL,
  `connection` varchar(100) NOT NULL,
  `servicename` varchar(255) NOT NULL,
  constraint pk_cashreceipt_plugin PRIMARY KEY (`objid`),
  KEY `ix_connection` (`connection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 

