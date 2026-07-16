Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013029.outbound.protection.outlook.com [52.101.127.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6863BBFD2;
	Thu, 16 Jul 2026 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193788; cv=fail; b=pDmIShcVAdrRSmMEhXRtFmi335Nuk9GUMc1EbjpsE1+Ge8ivqFXoA7/uW8G3gAwkav/M3Os9eAqbAQrNo+KNMRQl+acwhAjagINfS4eTMDbCDF7JUZVO0FEawALMnTaDoaF807Whid1V94xVRmR5B7uLaPL5w9NXtanxObfDdn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193788; c=relaxed/simple;
	bh=9h57UDBUxVwrYkEvjRM5n1cJN8CUeIw24kfOKHUBidI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lLOyseUpeSaBkEDzZDoEa8a1NzK2nb+0uLot5pfR9qJhXQupW5ogwYicCpdFOtU4urvt3cDM+lWwPK0+P22Z5T5/ffrM60DlTZwZbUeY7f6ffKA9qlG/ozLLakbwpT93VxmE3v51BvAHKUR3GrV03cHx0b24AFsweD8hf6QeB78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AIgl+sDd; arc=fail smtp.client-ip=52.101.127.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AIgl+sDd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2hdto8aJ4gytLb7/tn6gUSn+8WpQmvHU0Yl2TR0iOnm8apB4ZDOi7rqZN00c2tqObLV0YKmGrZPLimlsa6SDClukeoGllrPmjPya6O9q08XbKrUs6hv9N2d8+IeX0Her6YixZOLfz8I8XDvW9X/awNdjuHOUnhNx9sogS4x4mR/yoWl24tJuzHGFkhtbt7a1PdTkQr1BUDZSv868Ykih4lf6Q9tTuYlNa14wcJrB+qXUnj2+PUeEKekh8c3r2N+YxEkt64LIyrN2BeSTVFBZl/ZYN5ThJeGXjh8MJ4eWXr35AzZ5Qyrgl4OP5vJ+YaOwN4iufjur+Dm1ONPgHa8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYpJdbNIeGIBd6gyNL6OnFOvFBQacy+QZhxMJw0CzPQ=;
 b=pmynwDEDNbQD4qym3CA+s778KfVlUC6DlIkvHQVL3ebV8Exu6zZm6qVZhzLzf+ddH/gzDDwzqfRXveVAAaxJrTx8pLS4olR8DOjy6he1WCfad8iYUQ2KRLKjmAy5q252g6FKr0OBLSTSIgrsSyq6XX4hnTr8HXLiWBdTWBg1Bbm/KbJfwIiJb1Rlqf2enwgmRxL+0ooQRZ2Tkz+gXi3tZxhmdDRW/CTUDCXmIMx4UF6F3exBZHpMJh3zwtzERCtioBKzvoDMCIWTP37alIjiPshQ8OhQX2IC7s6VjeCP3jNb1RJHdY7JiNWyROBvtSnRdEJmUM4Uf0FVg/rMUwL54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYpJdbNIeGIBd6gyNL6OnFOvFBQacy+QZhxMJw0CzPQ=;
 b=AIgl+sDd7+tuQZ9iT7oEN2c9Q5NhhD4d6Ev6yIYRJ+ALaO7DY9ZPFsC7IyU4aIkdtDS9NwN9VdrxtcUShTnq2nGsHplyAY1WdNmFmWcfGzniOPToMdIQPNZORO+RAkBA1x0IPDiXgU4hhH1IcYldpw/0rJshamp2jWbWHadX8Uvw1elRznIAk60rvLo5HVLUfZAJERmN1W8ZvEH/psdVivMEWo3gfMG0wPWtMvpaNgmlDfu8RVf4J2MD4y99XaFrgXrAAsnEy+Im66ypQzGg76wAJBpxCT88X8ILTgwJJzgL+63OHW8D/HT8fMUWC3OzU2C6lwjceERiXLlOtamkxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYSPR06MB7344.apcprd06.prod.outlook.com (2603:1096:405:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:23:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:23:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Walker Chen <walker.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org (open list:GENERIC PM DOMAINS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] pmdomain: starfive: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 17:22:52 +0800
Message-Id: <20260716092252.251107-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYSPR06MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eba1ae-2307-451a-a26f-08dee31bd674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|23010399003|11063799006|56012099006|6133799003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	5nn/iMwCLcKNQ7C/w0O+jtcnQqZ8dMedVItDz6dQS/NIp3oUCZPUD+4rdourHCA7jYZcTwfwKgGe/mkd5FE4Jl5LQRrohMUIQ/u/1ybXkkp7Ww2fsMnV2Hp2Nc8Bp45esVpk9Nsvi8hRfdFBiPqzbfQnrLh9VglDlqSHw8zLAkM46yy1v45ITUaFsxdW5pBNPVKHO/4FJXafOul0+5zVNS4jW3s1cbHzRcRdq7r9CbsnvjFt5wRKctKThymtWl9esjFrRUYP9LKtCoMqHncC6gfF56j8k3fT9grloL1V3MafwmYrBDgT8Vss8N0yMa4tEwHBgtaQiB+XohxmKhydfk08tEBEBi0VIaSKOTIASE1ghKjgaDeaiAAfREISjoTfelpYbAxHorx11ui2YYCK+yqhJndvP3xmb6lB18rdOei6TbnpIg9pux36WaJ1+yvO2msl9EHv8+BLwfTT30DIFQz6jVqYd3CzMqeJCzJ0XdVCcsrNZD59YVqXs4Oavf/N15ngFGnZWBjIsnrCGG3f4UMPgwqM2GKTr2L9a6EEfojxEwGmSssfCkZE4bW88FByTxwTye4Y7j6tCwPDHl4hldhpaWig7p1J7Sz+8wJO9p00r1fsE2I7KkCwLrG2YpAvpbId3OAT8vc3tdDTgzBfV9FBMznyHbNk0o+imqfYCQbNF2XC14i8AgBTULjNriQob81SgYSLyvOp3jd5A3HSkZeu1a9Bzpjud47BwXVjcII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvI8x7Syxgb2Z8A7qpGaAcdgqE8Bokbjp5TgIQSbsCEiSaBn5tkUcqOMfRnv?=
 =?us-ascii?Q?WoleM69W5pcitQElx1Cn9d/dbdV9qwbx6DLezJgdDW4y7P1Eis1Ob+3aMQiQ?=
 =?us-ascii?Q?E1ITkl9fueXIa7VxTKPPAqY6//C++Z2WZsD5YIBR+rXuf7GS/3Qx+KvLegCj?=
 =?us-ascii?Q?c+kqR9e3HbYlM+SwdGMG4Z4tSvm9EJoSfs+s9ej9syh2FH+A2ir2EAPfPFC8?=
 =?us-ascii?Q?+8yIqLcZMxg5QfIJIusKlxCS2dFAqDYmn+VOafXUtC4XN0uVaDfuY40rRiqo?=
 =?us-ascii?Q?0N4qndoaLH03Cq3LrH13gvl2aq0jaBOhZ+4aTk1REfjGTUFuao4ipskyo5Gd?=
 =?us-ascii?Q?RzF4YiUvL+9g2eQn+ALWDF1kQTlQcFp1fERYQEYFBonBNVK5wrRIMBmxWzAh?=
 =?us-ascii?Q?0Z0ie/9WPzW1BHMvmVE2bjUogUB/bWN4uqQGPMIlLKkpH7VAyt+HoWP5voH2?=
 =?us-ascii?Q?Xl0j7s/RMzW29mtf7VxvwsBlPQ7i+cYduSuCbYIUNWkn4veUNUuaxNXPnzV7?=
 =?us-ascii?Q?Qs2xMrqe3BKAaBxUB9umlLgJ3CoGGOniw7AVtyginPUFAqwNYSIUCvoVVZ5E?=
 =?us-ascii?Q?iO40u8+3S9VoGkSu+NRqJXCLvAE5xPpfS0Am65yeHwQnxNwoIX0YIg9i1/YL?=
 =?us-ascii?Q?o1SipoMpAAPt4EMAxdVxs8i/O1f5Wvo+S5w6aHnWO2YexgXt5CfqIulWVT8A?=
 =?us-ascii?Q?RoHSbSKvS6kBRJh0DThdwT/eh9NLhyy+oFR0OLFJsLL4Io8SBjr6HCAB0t7z?=
 =?us-ascii?Q?xPErQcVTzFzD5TyoI20x8ljS9ORupR9y8/MzBr6W5/CANABKWiX1dSzzkkfB?=
 =?us-ascii?Q?U0ylexOweNoei9y6pCaVHx+j5dx4fccnlLWDuCRpQuvYVfbdJXCuRJxh/8y6?=
 =?us-ascii?Q?rD5k/OCPcJKPo9VBpKGL7sOaqB4MgNSt6GETTlJdc7sIqKcCSvubrVeOFYEo?=
 =?us-ascii?Q?sWKbdrvIwNvupoN582MGHBT9VCHdUVpXBUVC2bpGQIqs31R+E7WMiwUfkex4?=
 =?us-ascii?Q?35ySVxDVdjT9KhlP2KyyucgDBvPBx1vMjMurXnUOncGHlQQDrJZh5APn0n67?=
 =?us-ascii?Q?PTeeT1lRJ3X8i67FCfWWkrIp5ymMC36KStXPnC3KnHrRxzYTpzHXn6KhQzb3?=
 =?us-ascii?Q?4EnLXKjXibmTDaAxcacsBeyIYMf1rTdhs8EZmTqx5bYkqy0Lv4FGTlPwV8zE?=
 =?us-ascii?Q?Zdj3TYrlQb7Z1CBGNWFAsqfQm0Q42rIcRQcOtADDug6jdiU0GIoIFaxGn31w?=
 =?us-ascii?Q?gfRkIXzc+7oPnslJCsQ5t5FVpcpkX+DI3k2FajtweN0j1fJQH5jVL9ri83mR?=
 =?us-ascii?Q?DcyMaW6ll3RwQ0N1zhgUIfs255k8s0V4BKc2ANnbKY6++eRpeTVbKnJBBaMr?=
 =?us-ascii?Q?Th5/JERdIPkyon61tv57IDarBJQXKGzmPZe/ioLit+HvWDcX/hdeEsN4E9NK?=
 =?us-ascii?Q?QwVrVySaZ5+ztozOljvfmLLhz6lJ3wQjQ9uN91sRnWFmd4INTgtSCoE4Ibvu?=
 =?us-ascii?Q?Quxm6Cw7fRpSabZbCp8kL5mcugEQYO9K9e7LxJAUv8wlKOUD0CuBguEhYyls?=
 =?us-ascii?Q?JkSR9JmAymaEgID5t+hQGkXZWOC+i3Mu9S81seFwpMBwrifVzTwmFqV0ab+4?=
 =?us-ascii?Q?G9dPiZ+Ap1USooUxT6NsZQ/CxRjr20tRV4eft/6ToapXvpTMf15wFY8dMErL?=
 =?us-ascii?Q?Jh+FqboOspcXGtak7UF6SiQk+N+8k4WxSd/SQpT/eU4TdvEJ71rFkDxw3Br8?=
 =?us-ascii?Q?14ggYd8dDQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eba1ae-2307-451a-a26f-08dee31bd674
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:23:03.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAjKleajsnflYTvQWEnXU/AdQpEUoh8hABTQZYDC3Bvi7hQmotgxV+WjNVEzbwO922cycsDrJv7+4fksykLKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7344

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/pmdomain/starfive/jh71xx-pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 74720c09a6e3..aff07b0f5523 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -276,8 +276,6 @@ static int jh7110_pmu_parse_irq(struct platform_device *pdev, struct jh71xx_pmu
 
 	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
 			       0, pdev->name, pmu);
-	if (ret)
-		dev_err(dev, "failed to request irq\n");
 
 	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
 
-- 
2.34.1

