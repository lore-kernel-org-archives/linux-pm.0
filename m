Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A9346FB3;
	Thu,  9 Jul 2026 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564357; cv=fail; b=jZeslvVkVsX/RYvgA/4q+QGhKlAmgvvGEK6uRflV/dj31zsODgK5C5nHaN1dZSkB8n2ObCN1gXuILEGclFljeifLxeZJm25Vjdqly1hBGAPhK1uuc/pNVznhb3KgkfmfN+4qZpkotEUxsWIMbqWTdDvgqAEgL0Zvm2XqP5tfhXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564357; c=relaxed/simple;
	bh=PSkJQG5yA5mB/RPHaAcdhldS2wCDXXMV/DdSQLHIe1Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Btp8YnnSyKek4xORj+gV7IeK437dasTYykA+f2V/2Cpjo3Xj0yX0Mw5MvrGnsgFL5gMp9cp4wu9HKbG+G9GeMR4CYtvVSIk6zBorlBXFXvhKrtiUhi/TvW76FmldaCzXKrs6WFXctNHROJJ/M987NQCLTczCBLFv0qqllvBpU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mLhkxMRT; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mLhkxMRT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deIcj45YzQw7UGx8lls/35xOssPFWgvfebslz//EVkZ3XQQeGaB2v9uUe34ILE4+m9+cS/iZOBemPqTZYhfKKEkrsIyoUQoMbmc3rE0Mo9QHBwjHINpqxjGkFEfXYfdg71Bl26DuI/G7bg+30VCR+GbxS40YM/VZq5dtLWv/w1aS/SkI6Dh8owRL/dL5/KrYpPt664J+bFlLMb4Dkm8xfI2AyQ2PdQSer7kONd8eBVqOnwFOttHwlp1o3c/oK9h95cGOzv2E8xBlGtbHiPeYsDbg+lKHUvWHp1T7MGgEOtUjDVgLzjAiahXNrIaOQQlY63Xz7zQunghTd1hMI8Ng9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNI4Aa2dEkdfLZTYxjsix6n1T+pweP7JwapvcKHaYNI=;
 b=tTgxKjiz0BLLcKd2YnQSG1gGPa4w21aTOWNQBjkpMEFURJv1GF1p+qenT+noDMXJQX49oxbETcldy8KePp2Fy2mjzeO0rd38kFAyoFwYYyGizaTyaWGVTJnt6TvPCDg40HldIxZcEXV9wrPuByukCDXqSVG6NR61Auyl5Lay8bgXBLHFSqRGv2hU1UxF/KyXhzltc4ME3hFcyvFr522nTYqhkSoNrPCxstQLkaXmNNhv+WnYs0aFvqTtkgw/IftwjzkB40xfozK+lsLxnTr4yonx5fDloctWqVhkPc0RkSEsia+Q64fspgSgoPoJcZelzTtcu1gTEO/uhLC5bkseKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNI4Aa2dEkdfLZTYxjsix6n1T+pweP7JwapvcKHaYNI=;
 b=mLhkxMRT/9k1huhO+uQ/j50usfb2UJwhuL+Ks1vEjh4oDdRzFwTvztoVRCUcO6fUs98hO0edENLs1BRebg0kATvYv2JPW4XkfGkAcsVv4SF6p1nfscEjcwKiPmoXZ8Kuqc9zTYkLN81tYiZ+Ykfe3rEN+IFW6RF5JcdfKEGsBiTkRMS7WdSgwK0om2ubL2PqgdOLe+JRkLCBsCBBZxCvoIZW5m9Wj+1mEv8KFngltg1vPDNxJQULNEhxVSCVQ3BPEiyuC3wUUikR4Mg8LKvDNzq1Xddhcqs8yBkg09LgTmqMmj+J/Bapo4/pzaoesCVGj0CANcNlB0O7kJQ5AKl2Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:32:32 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:32:32 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Pan Chuang <panchuang@vivo.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/18] thermal/drivers/tegra: Remove redundant dev_err() and dev_err_probe()
Date: Thu,  9 Jul 2026 10:30:20 +0800
Message-Id: <20260709023048.599150-18-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e9098db-618d-4f52-77ab-08dedd625455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	ng5DR7Lfg4jp5dJ3NuBWZ4mD9iJ6RGU4xdwPqdGkQbG5OZKJY5jIrdyq8nbIu9STtE0miCP27JJmTbToKG5bDwDcZ8qS5O7bYsStE8y1ZHqmVdidEaB8NjOfEUwkIfSdIEQBW0gNstx9iC6TkDtKVrdKeKAjY3lwkzvfMzzfA7J1RKsBf3ag2aNXYDrA7pvQgCICP4R4OrdMU/v0Wpvj26cQod9T1pE2rz8phL5R6sPTARczIzr4c95Gm6zFcC19ks8/AlcIew1g/UUac2NTWitSJZYFZR/TVZlpoa9WcannG05ThOmT0UbGe3A731hWEleUFk6aW97ae05/c6KkwM5STcxL3NN8GX9jvLgImFfSEIZh70xHR4J3WxciqADOzjfY18NqX63GRgeRHTbn+03yE2DdqQStk2pXXBbOlm98p5yED5xLl831/wwvuZO87ypw0Sv223qQVLwtxwLr7Iab9w+SYZ4wa9dMixBfdb84tJ4aQT5i/uhtD8XIL5SIHUsmUqNuwg7yoZB/QPjxBIJGIio/juajABlPa3AdYZeUE6odIBbH2tmbUv18jpuxhVg6fQf+T2zdVHwd5+SYhzGns8QR4Gx/vK8sEnd0lfBkWF48dP471Ln611RI0lwilIVc16PD7pw4Bu5tUsKnvThoCfpbrSvDvHNaoUnkPM4c0D0r8P27Zf4zvj1di/O3iocGqW1CoD66eX++JKrfU63zq4KBnTfRd7lAWm3vVCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVkzjktzxAOcDUVekkSGJP/YrhoMMTjOYrINFmjHFiRT+mQhA+HNNrKOKB2x?=
 =?us-ascii?Q?teWAjqQ+UDxMJENjy0VITjMqnnCtVCoa6IrUU+10PCGIim3c+vAzNkRBEQ3p?=
 =?us-ascii?Q?3nudSSV/r7YAsLQoB3Ft00mvC31ZTdfQK0E0Jus9z8cwJk8S5V291X6Yxmrt?=
 =?us-ascii?Q?vbYiX241HiSzFCRFVZLjD++ctrfhwAE9OMWfaDWdJ3Ie/cJgzhR66QILi+SP?=
 =?us-ascii?Q?zqU/EPpapoXuS6AhzZN25Ie+YKIvAMKHt0ECL1SR7g4RUnS3aIXKeXugWV+3?=
 =?us-ascii?Q?MYCCkc8Cfitk3gm01Zb5SKx8lpO+CO8Hd1FLyQpTr4H9X5FY2YAVYybfeZPW?=
 =?us-ascii?Q?WlBlxmaokuDb5z33pL19eEl7KPPhisgXwll6A1Y0qEX1aZjAcVuAy3zSV0hi?=
 =?us-ascii?Q?gqQpfd/HRNDKUtvnay33jIjc9eqsVNFOxYtqNm2lZ+RJHDaD4hyYtrb/CohZ?=
 =?us-ascii?Q?/rVmx6+8+FwJqZFg2SeGLt/vkQZ7DW5laQwZUJHvN0r5fjAZ67ACn8ceEJMj?=
 =?us-ascii?Q?/OJko/ApejfTyTJc/uYHj4r2rTJxSepj0XUAWMVjOr4vKH9WOZaSSyWivEMd?=
 =?us-ascii?Q?RBR+DGwEVDic/+5wg1Sod6qdNj8LXzEwqxodeMEjuxRY+Pq8a7XDIyhOn22x?=
 =?us-ascii?Q?kQ1OrOpcT3k6vdiigwG8xWI3fqNUHFvEzMqfLVvu9skacWv8VmO/OhqUhLyh?=
 =?us-ascii?Q?kTRhxsEH/O4D1f2l47LZaUFTrQmP130NLfshLup4Z5XWKCeuVYK/1XnPrItt?=
 =?us-ascii?Q?tjMD4hp0vgZ720k/L+BR6kDeTPaHy9mE5ZPWu7AwSh8xOilonuOa+V+YiA62?=
 =?us-ascii?Q?6RjOBbSorf1xQOpXlvOo6OmFQt8c2L1he1LdvdvntVdpAFh0DMh/fRheATuV?=
 =?us-ascii?Q?HX4lGwtnNDzCklQjbUptD0ggbzum+xxs7i/5TsdwCuyhW9tG71SoURtmrawR?=
 =?us-ascii?Q?bO1pi+F3+Tz5rbCQJF4dnH6uxbZA6YKA3gW2pXqV0embhIC+Ex8n5g59yMZz?=
 =?us-ascii?Q?C0V+B0pnytGM36kM+LIzBHl2lDxyKzYmIaCRKvuIcpdPbuHBRHRe02/bh9mH?=
 =?us-ascii?Q?S07K7bqMPOXIeT/B3RH+sSAsKBk7KV25jhqUg+e2EDcYs7pFEDmtC5lPSHAs?=
 =?us-ascii?Q?FNib1RIxg4A+yyyhuoyjNu17tSuJc9mhxtqI5ZNFPj7AhKT1inJ/YSd+Sa1J?=
 =?us-ascii?Q?Kk749jEE/KPVor8UKHgXedcOduj2U2YOuNyAYQer9Yr9lmqjWStM5eSPRjc7?=
 =?us-ascii?Q?gOVLf3qaG8BevF0LZUWq1mQDhS/9xMFtK2WUhvrBLdmUgw2at8Qhf2RzHa0b?=
 =?us-ascii?Q?ubcJjd3YaUJCfsACHwdD0lntak/Ph7L6rRBKPlzJ5KDvkGCRhel4mRNn7XcI?=
 =?us-ascii?Q?znGj3m+a1cFfpMmpQ2IQFlz1YjEzAddYYFu/jGW0nPzztiWR1YpTm9Qri4y3?=
 =?us-ascii?Q?JJZHds+ikCEKfN1/tOuAc/UwJERUYILXVsC9k1qVC+et4+OYVPO5fUeKNJxq?=
 =?us-ascii?Q?ypd8WmGBdocybTuowi1V1p/ThsbOMa+TQ2ajJ6hkon/olnlx5W/N4Tn+UGnM?=
 =?us-ascii?Q?aRpBPolrvuTrGabJ5yAQkgDrUqyOznoMMn3RtSHFQqc9438YIvFKvYBP2tTk?=
 =?us-ascii?Q?YwkgeE7aef6OH4EdH9cR2UhF25p7PumiQJkS4dXnmDmUabC+nLUkZIRjX/ar?=
 =?us-ascii?Q?N6grHeVXwHczWtnsot+FAleT/PxA32NWtGhy+x1g7rVW8+b59meOHiY+a21u?=
 =?us-ascii?Q?2Mit0XLdFQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9098db-618d-4f52-77ab-08dedd625455
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:32:32.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zfmrgS/hRkCwdaTnktMpioLP/hXXQJD52NXMtys/bY7sq2B5BgGlILy/Yp4HAbG5fOG5N3MKXMsHMEVG7J9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() and dev_err_probe() calls that previously printed generic
messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/tegra/soctherm.c        | 8 ++------
 drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index d8e988a0d43e..f74acf13b24d 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2007,10 +2007,8 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 					IRQF_ONESHOT,
 					dev_name(&pdev->dev),
 					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev,
 					tegra->edp_irq,
@@ -2019,10 +2017,8 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 					IRQF_ONESHOT,
 					"soctherm_edp",
 					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 6245f6b97f43..10a5ab1fe1b9 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -602,8 +602,7 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 					tegra_tsensor_isr, IRQF_ONESHOT,
 					"tegra_tsensor", ts);
 	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to request interrupt\n");
+		return err;
 
 	return 0;
 }
-- 
2.34.1

