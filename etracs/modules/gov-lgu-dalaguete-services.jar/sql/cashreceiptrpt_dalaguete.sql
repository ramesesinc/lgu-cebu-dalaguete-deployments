[getItemsForPrinting]
SELECT
	t.rptledgerid,
	t.tdno,
	t.owner_name, 
	t.rputype,
	t.totalav, t.fullpin,
	t.cadastrallotno,
	t.classcode,
	t.totalareasqm,
	t.barangay, 
	t.munidistrict,
	t.provcity, 
	SUM(t.basic + t.sef) AS taxdue, 
	SUM(t.basicint - t.basicdisc + t.sefint - t.sefdisc) AS taxdp, 
	SUM(t.amount) AS amount,
	t.year,
	t.partialled,
	 installment
FROM ( 
	SELECT
		rp.refid as rptledgerid,
		rp.receiptid as rptreceiptid,
		rpi.year,
		rl.owner_name, 
		rl.faasid,
		rl.tdno,
		rl.rputype,
		rl.totalav, rl.fullpin,
		rl.totalareaha * 10000 AS  totalareasqm,
		rl.cadastrallotno,
		rl.classcode,
		b.name AS barangay,
		md.name AS munidistrict,
		pct.name AS provcity, 
		MIN(rpi.year) AS fromyear,
		MAX(rpi.year) AS toyear,
		SUM(basic) AS basic,
		SUM(basicint) AS basicint,
		SUM(basicdisc) AS basicdisc,
		SUM(basicint - basicdisc) AS basicdp,
		SUM(basic + basicint - basicdisc) AS basicnet,
		SUM(basicidle  - basicidledisc + basicidleint) AS basicidle,
		SUM(sef) AS sef,
		SUM(sefint) AS sefint,
		SUM(sefdisc) AS sefdisc,
		SUM(sefint - sefdisc) AS sefdp,
		SUM(sef + sefint - sefdisc) AS sefnet,
		SUM(firecode) AS firecode,
		SUM(basic + basicint - basicdisc + sef + sefint - sefdisc ) AS amount,
		MAX(rpi.partialled) AS partialled,
		MAX(rpi.qtr) - MIN(rpi.qtr) + 1 AS installment 
	FROM rptpayment rp
		INNER JOIN vw_rptpayment_item_detail rpi on rp.objid = rpi.parentid 
		INNER JOIN rptledger rl ON rp.refid = rl.objid 
		INNER JOIN sys_org b ON rl.barangayid = b.objid
		INNER JOIN sys_org md ON md.objid = b.parent_objid 
		INNER JOIN sys_org pct ON pct.objid = md.parent_objid
  WHERE rp.receiptid = $P{rptreceiptid}
	GROUP BY 
		rp.receiptid,
		rp.refid, 
		rpi.year,
		rl.owner_name, 
		rl.faasid,
		rl.tdno, 
		rl.rputype, rl.totalav, rl.fullpin, rl.totalareaha,
		rl.cadastrallotno,
		rl.classcode, b.name,
		md.name,
		pct.name
	) t
GROUP BY 
	t.rptledgerid,
	t.owner_name, 
	t.faasid, 
	t.tdno,
	t.rputype,
	t.totalav, t.fullpin,
	t.cadastrallotno, 
	t.classcode,
	t.barangay,
	t.munidistrict,
	t.provcity, 
	t.totalareasqm,
	t.partialled,
	t.fromyear,
	t.toyear
ORDER BY t.fromyear
