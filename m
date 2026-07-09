Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0E33BBC6;
	Thu,  9 Jul 2026 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564308; cv=fail; b=ChXAn78MOIs+z60AXfZ1IMrBVQhUn7uqfwYZZBzomBdP0sUVEeSnj2S+qdT3UnOrOmMg6gKZmgxuoc4DzVf1Z1m/O+pVb5rVHAK+kNur3YOUfGySSqQLagsQCHfKl2Lx/tWWSNBDk7AX2miKpqgauvtgughgqLyYZy/8+J+hgiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564308; c=relaxed/simple;
	bh=dhGQx2imtv0+1q4oB0PoWoI3SHHFAFK3gYWWIfOOiOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQQieY1XvnsDLRPV8i3YWGywvg+mIE6HTbDzl7USowXBLbDO/QAnz8nLYht1oZGQ5qZxy9+CLxvWMxhawk5PRt9wMrnV6I2ceJUIiszY2p8EqoLnc/IkqPf3OZslGrGigdXNPViE9OsKJsdCpDlpzc8LnMnz+gtZl/ggRbjP324=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gnj7RRzS; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gnj7RRzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHmPQWcUZOVABZsp+CpphtF71xD31kgfFJMym73QUJWJAIQUDZccMgv/Dol0perpU5YxFc9I+mjOXdid7JnqJZvHrjDNg9qRubtt6NLi7UizM1H9w89ahbkxpWU2uQc/5QQtMmznfgs946EU46pXx0cqEllvChuMYnqPyKwyeEC20DGz9Na7fS+Fjj4pW3pZt0/NzEkjKux+zLY4UjBbYh25ePLHXiiwrdnT3CvZkx/GHLZyw6KDlpJ5+a2xkK8z6PKDlIhipoUUpcjt0o0/z5LmQadGD5I2Hcpjz02uRkrJDGXOvuKu8jgNAsi5hDyw874faSctaUHVsAFj29qW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs32AK32pWsus7L0Pa+YsIUJT0z7IZb+TNH40pU26KQ=;
 b=et1xTRy+ORpmdss7nkFEMKjoZNSomQ4jBK0WZcgge+MxCroSiK82jfjHDFj5znu055Cne/+b2KCnz2eLwUvRf6jwoU1OA9uC2lZQK8VUnw1EE/9e8oZU45vCely+yCrWXX7+LEUHwRGJmFSwxme+APFmpSW/7eYa6ZALpGqlTrRC0TAov5J7TxZTLCcVFJAAZEzaNWGNIT3+V/FbSnk9Wj2iHFPeSw5ZaQYSgkxLSZ6Ja6qu17SqhbJbIfnT0Nghr2IkoJWkkuViMFnpLAaBYSunfif3r5YynTmZQuGORWvun2KlLNyDwOz53vC2f0DhHH5Nr9AIMhQl/LCmb9uqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs32AK32pWsus7L0Pa+YsIUJT0z7IZb+TNH40pU26KQ=;
 b=gnj7RRzSbHjEYHvGv6gp4U5TQV5XYaR+8OWyLbKQZtTRJbeWR98lj19PuRMzqMwjUKsmx+ad1Va3pLVDoxUfeKJ/1xhajzrDw2RxmvhG2g8VFpZD2UGY73091GZuNJpHOtJwBjsySH8HdfevXxIy4vQFHEOqVDFWc1Zx+7lLU0Ifiv0ms0gNpJTkOOKmgPXtv9d0esG2WaCR8QGWK5k/S6xYEOQh5na9Eu43mVolr5bsWbwdbpUydB3zRp4h8n0VBqC6V7mQakupMn/SOR0roUfGS7XbxRJ2cz7JCLV6g8DnojLi7eZS8btD+GPidBRi/Ht5bHYS6rFL/aaDuwQOQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:40 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:40 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 03/18] thermal/drivers/db8500: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:06 +0800
Message-Id: <20260709023048.599150-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f58d30-4a0f-4d42-b626-08dedd62350f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	VPFc/339Km9cbxGlIG91UeuyVKGio5WZ01gQksaOc7X0j5CXS71HaPV6q+wTmNf6bICZrd4KQaIl6+AfaFGjAS+nDmmhfzVP3eQ26tzAYQOaCC3XyTZGPdKrem9NkP1JHCeNuVuVuC7FoxXvdYZI6ow2LYL8SXh0kuNre37h3YpwPkyiFL7wAmzxsVJ9YwKrbIvIZ95iRYNkOEXP7Zr+sz+c7pB2i+k1+AZh2RVIrkSaflW8iAFhC3ZGKa7aFQ18SafQCvS/ewRe4NrVSJrdvezDLdZfQEgMxFhTArTxIzK4SiAr8uDOHcaawbQHsK/6cJH+sxIJbuctsdCCTDmblaSCSa5KUuUMEmAQuyDc0+tc+EFwQMZndBdxv3LOGUedIuewrWSHO9poxeO5wZ8EU28FKpOXB8XJ8BJoz4pInI3gLYVny9QpDXwyam69gTcusAuFAIdO7lFVrjs57TA7Bg9LO8iVeX3FP3kvbDR2PjA3qnQkS1PXIslGb7PLzH+lssSKDgnuTTITifgIi40d93kLZsawnGiBD1rV0dHEBCbEiuI8MkWTKgo8r+WpnWbaV2vSRTHvqcQ2KhIkKsQKKIs/SgBPM0fh0upUNzXRGspQT64pmSFksMVCAx+Y8ORZVCSsZNpS1DtGCCIfGBnicaoV/CIXizlPH6v16klTUT/1Pd0ZO6LxK10zvyEp97iVc1fiTmoYvfBNrRSk+h5JqlwzqsWTww2AbH2E7Fc/p0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTgVenOD3dYHFgMzVAJFz+skdcs053/Xhe4V4OGnJ5CBTWhRH7UYW47TVRDs?=
 =?us-ascii?Q?q9dVrH9fe56STse/pPGaQ/7tYLf202lASWF3gp+D8K+w5qA+Bld5ggZYOFHO?=
 =?us-ascii?Q?7e8kGbeqcppbqUg7Kqpyn1YrG4k+3wvSJyp/0OzmrV3fOOkR3Tm38L+MVRHE?=
 =?us-ascii?Q?JrhV4g2YGE9UdPfFN/sZJDHBPQRgM1tfJmjrni7cSGU8EZ281nlM7JDWK5FN?=
 =?us-ascii?Q?vZgoEBlMsw2osKNP18C+i0HDqcascpPxo92MVn8YjQUKl8+9epmjf6W6XinR?=
 =?us-ascii?Q?mCYMMh+Pqdo591tubusBjjIKQmVR36I2TdWn2NuCKVy45Rs7+gWksv31vp3A?=
 =?us-ascii?Q?lTvPB5ennEr24HGfDH4BCJ4laLmu1wqBLT9ovp1Gqz5875MAJHOX/lbhz5/b?=
 =?us-ascii?Q?BT0we3qBTlvN89yaib+37z7kZ0pAOEcv6B4Ye8sVoNYUHOL+rAGVRWr4vP9t?=
 =?us-ascii?Q?gSauLNE62U41Bxp/M1RjQ5UWzGjKXaH+zq4TuLIc0HmrA+muUznJust+2jVO?=
 =?us-ascii?Q?k5Zy7GrgmYg22naiKTlFRc0CVnh9lnhMqE+sOvQ1jsHbluTRMGAclcoq6R15?=
 =?us-ascii?Q?pt64/8vrWa6Viu286ewuuT9u/G1desLSBS0Z6N0qV8CHoPonlrGZVArCQ1Kh?=
 =?us-ascii?Q?M25tea3Gx47jpTpayCPtMWRPY7HB//bnXjTcX2BBMToHx+N6ugpAiSzW7J9t?=
 =?us-ascii?Q?fdhvrpFE75my4kzXtOYYv5IhFhH4cPtslwqdgtbcEkQ1pWDfvfONqdNfCzQw?=
 =?us-ascii?Q?y/lL4CwUepnoL7umtDyyRqnzna+itBKjV89cJJbBn0/2XaCeTLgerSVzcNCk?=
 =?us-ascii?Q?rIW6NJLKwDeBKr8X6+At6Vg6K9knuxPkqEIlaodacLDOuZpgXIAU3jbvcKCC?=
 =?us-ascii?Q?rLJzsedHbjk3AHjfd3jRgqkw9GHiE7sd/Q5AR5/rg8xlveAp+NZXCwtXdYt0?=
 =?us-ascii?Q?TIfs49sHVIpirOq0QVrxKC/lkOQ8cpzPV3zTCIPz9J/9UcJ46EWzD7sw6F2F?=
 =?us-ascii?Q?2El5r57ZcoiWxT/z61Zdx+N2+Icbm77i2tBU5cMDpevj2KXBdfaQpRUMpIp2?=
 =?us-ascii?Q?pmgjglKnWbeujTIdazYC0oGK/qVPzrIArwhmlSOtwAdPTs5QcgiflJVBtzBI?=
 =?us-ascii?Q?3BpwbV86qmegT7CWw1NzBR3WLHdjHpawzPZ3LsaTYBWJQUN9BVijJbguHqa1?=
 =?us-ascii?Q?6U9lFwvvDobSleNzr51/JqGhx2LLEZjLjf4uGKbQF1za6T4q6+V475EBo/fp?=
 =?us-ascii?Q?1qsMIfvskUsCp4m66BN+h3Djo4DP9t6GIQzH6v+tt5O3yKuCuCVU/253aJ/D?=
 =?us-ascii?Q?WzFUcvq6Zv8/KVHbGxzFvCIlDQXsujG0AkBWMc1wb3s90I+/DemcVCI4s/Es?=
 =?us-ascii?Q?U3fraCGEZnRKTeq6ygPN8sLK3qiuPyjpnUPoHCYApTmZ6MwovGSWwvCtaJI9?=
 =?us-ascii?Q?wNAaWSIFM5KbPqi/0zT1HtNnS40XTWfdE0+UPkiI2TM4MKaTDwrHQwx4M9b3?=
 =?us-ascii?Q?yOywmMvjlDvCRndKa3P0VqKE0IgvmognIsDzIYImTFGvWpmybIIEVO64PrXP?=
 =?us-ascii?Q?+kkhk0O179iPUUYWXe4w+dHKge61XQn11S/v6zrWLBR+jKhwlPbXwK5N1l+/?=
 =?us-ascii?Q?fsBDE7KUHWXpOQgTzOVW8DJDxzSexD3gdG8bUUCCgImDCrvWRnktFxWU6iZH?=
 =?us-ascii?Q?HlP7n3LihXHWYYK2NTsv06H+ncu1LdXT8X3r4Nc/tThyX1gb1XMSGtGyEQI7?=
 =?us-ascii?Q?IPvlKt7gIw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f58d30-4a0f-4d42-b626-08dedd62350f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:40.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjDOGzoQX8mLuAXN4UaZPmoyKxwvypw2Iav5uLVVu9kIP5jMshJ6YIVjba5fu+yQ1STY14SSbrnl1u4JPOr6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/db8500_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 576f88b6a1b3..c47aa9974c1e 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -167,10 +167,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
@@ -179,10 +177,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.34.1

