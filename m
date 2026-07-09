Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F903AB272;
	Thu,  9 Jul 2026 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568141; cv=fail; b=cFqwLeeWPOZuVgJDLhUomBq9Ac7bmRVPP/LnesOijRwdtPtHf0NptHvnQbfoxNCM6sf/P2SHivY95FWYvJexfjwCvULoR6G81WyMLwdV/S+yAOi+xASETMoRxiaUjd5Dnq8SMH4NwLEWzbO5U3qQH2GuLkARhdLtrSdcExp4dJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568141; c=relaxed/simple;
	bh=7pHWKwScujuUYxNaSVuyTjMzU4RKR6hmUK/Cv7z83S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rL0ddqeRjHCZ+pheA9AwtKn2XYOnzTC94VfjE7CmQfHDYsKe/0ALBeqwmZr6LpuKOwORPzvSJlDjWPZ6rC5mx9/Zggvc0rQU6jyADDtj7X4y7lKwwh4R2GcO0gP6u0IUdXH9cBWBpLMdg3BwyxPtDJreiUin2GMmMXL5gRlpyfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C3ur9gNE; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C3ur9gNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGfg8qP29JfTQ7wyijGlFnMl8tAKjpKflqNZV8Thy2R6JtG4iMjXM51r/+yv8k5ZFWp5HwNwA/+qbhjs3rhhGAAamQ8ntgCnzaZnq9hpOyphfbjIqH8kLALjkYjm6obc0CudfoIF1gRqGBhmrbI79PhI4KSjC8AEy/f4DHsVxlxhrS9dcmPsFWJrP0vx1FXf4I4pjU9mG3HPWj8ErY440T3ImCWzB6q9e6AAVOntvDWfLa4Ad8cPGW8suOe1TfS/VdX+QqJGYWYGZd7SY8NS/ejgxox9wIkR7/fvAMen4f+nLgEQRK9ZmWTBWKQbcK5MhHlNUVQ9lWrPMtG/YRUIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mACxZw4iuvq3plH4aol5hOXH6HzKJ7npSVredSCjJg=;
 b=tqe/qyUeDhPKlTQzTMvLlaoAEiCN07Q7nNuNhGhKyIabtLU7ZCC023dnpnONgLnVts9ee4yiiDztURUhzD193CI60c9DMZp9p+9AtSScRxFELv6V4YaE+gpzsBhxnoOiDTn5cbFn+RM+RStuGrE2I/ZRbcdWwIV4ETVhRIEvEv5G6r8kslEc01M9z8mAoFw+mCNiGgItLIoiwC/CYKOT3vxOlTBUKMPmn97kIQDDBJVEpqfkbhXC20u/x0P4cmDDX80Rxoy2u+Sz8RtHA4i+lOFHVCvKFihM5yrML+TSk302FGrvJ28D5cMhe9z+cpiWtXxS4LK08c2r32TOdVGvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mACxZw4iuvq3plH4aol5hOXH6HzKJ7npSVredSCjJg=;
 b=C3ur9gNEvCPoCg1UesQ5BtDWEqIOJCFhauBEB0lon3FL3yVY59uInePSn7J0fFsqJvtYuCSD9XM7Q7ho+aGT+fm4rreahkGtMsyKEmAFHbbfdwN7xDGEiaeZMDNfQ2VAbNz5WaX/Hl2VbUKxaoUDYW9OJpkj3XEG4sHmKgVl2JfrygTN7nz2lwfy7SBdIpEN8ZFuE15ShvsZOC3YFvgDgfgESkyisI70tBPKXF1lf+GGjdG2TkEWTYi21+7Dmp5ed0GDVP1SFY0/2zbQ7V+KChHEWH1yuYEJS4tTUmrLQcgz1lNC62dTOjGgc7/LoqtqfEyAqBYQD4Jk3P7HtCbzIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:28 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:28 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Samuel Kayode <samkay014@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	imx@lists.linux.dev (open list:NXP PF1550 PMIC MFD DRIVER),
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 28/43] power: supply: pf1550-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:07 +0800
Message-Id: <20260709033428.362970-29-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: ea396dfb-d942-4571-58c9-08dedd6b1e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	imI8wEkWnhb0eHRwSzbxornQhszg8ctHSrLzKxOpEk0gm80AlnH22+kVeusOaCvbQgs82G2Etrh1p6anWaUFtZvTsDIMUFbfSmM1jfMswsFuGxDFDKSu3zQpQTcCHJrTtJr/OOXTn1zI+Ayi2EireZe20Yn09m/2irrlZTdPJAz7LpINFMZhNMf6EfiuQAzGlSlaPfzUkq94oHeZwlzDKrtOq76nfTP5sJcxW9HREcNsFl92zWtPFlmd01CtUqZqmNKWHvI5eZ2xQ9qXGNMfijzDf1ej382v8bJYfOTb6haa7MNoJrSmwt0JAEiYm0L9aRUsvDV2vY4SwSufCkv0nd2ErquQXmGZpP/IX6YhMzO4I73jgO0s+3cLClM15/8zxO75+fh2I8g/N8EGAcPcwGfJ6T+BPqLUU1CCEd9xiw6KkM3Z+k09Yzc2L8YBYsq1sg9qd3/iyzYvHr/f+xszv7mFi6mVyfeLoqTIttHD/jmznmlh/n/yJDTAvDnhxO3AuLkB1V6CwuiStvgNLgt0JxxYBnOIxPVqh6Rmid0a/16qifsRHJ2bx+NbalNakb21NLxaXtHaxW0ndlA5oqIHNlq18d6ReG4UQoZu2gWwfpCtgICFv5GVqARHPBSUzyK3SGo+SjKdk24ui6IBFYZWqxA+oGOnRFfEhmxawOisBoGbF+6K1UMLffjfORvq5ztUQ58XK+kBcz9SlVaZCZ4QB4dl5mgKvrT16rjOyxDAK7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZcA3o7fzg1VxYocOKyDmn08R4ys5oz4li8BF6MALANnNeYIAqZq98rZdMIj?=
 =?us-ascii?Q?ugEevbTvaSRUzHZxwaXUcgX1ECp9X/XYT/X/OjS1zfibSNBaXmy4XJQFAbz8?=
 =?us-ascii?Q?ngz4qyBKvApEQF0u/VJ7oirYGNwjFmJXCf3EXs3JNIfocn9GvcM+sQVH6X8D?=
 =?us-ascii?Q?wctuzTMDkszQN28xkWSQHVauJcyb099+ob2N6piROc0jHd4AY5jEMProXXVD?=
 =?us-ascii?Q?IfwUvkn6VtDRMJ/dMquyAiyOkNsiVyz40ISHNKtmgkzGM9xQChZUVy+lDU6Q?=
 =?us-ascii?Q?/eqo6fuM/iLd1ZO/et0r5B8gF0aGNo/KJRPAOqvZSyhsFaDVi+9wHNgThobu?=
 =?us-ascii?Q?SHC+fQmn5L7lwIHG5gyYXWnsqn480bc9q2gq0lEOgDABTGLo/XmIt10L/dj9?=
 =?us-ascii?Q?biXXJaRjm+Nl2o7Sjz3x8sdbYOY0smCC0LdyCvVuq9tcf92Y8giX0YKZhncG?=
 =?us-ascii?Q?T8VeIqOu0SXi14Rq077m9vWhXUlzBNeVzqRZnJK7l+cipnNC61QPehKoVON9?=
 =?us-ascii?Q?Sa3zuWxDruF9mzwerE120Br9r5gxxHquwbInWIXnqb4f4ZJtW0HQqIkebxSX?=
 =?us-ascii?Q?CVux3Wdua43bJ1OVJWvx9Bb+T5sYvg+BxqpnfvEE0fQ0PteM/gWm9erg3kaR?=
 =?us-ascii?Q?GPlPyUJU6ME/XMLYebl6ET/rkfr3UaCREQKQIPk4zV3goDBqNPA35m0/DfMf?=
 =?us-ascii?Q?GKWpi3SgEyGyr/F8aMl3ls0LYZSZzBj/foAcnOgNaKldnzOMroHqMXa7fnDW?=
 =?us-ascii?Q?6+bm9W9osJcBioIluvGb5Yg0B/Q59znOhJviMAVpCJ1PCZqZbsXWS0k+Lrmr?=
 =?us-ascii?Q?N0H8ZFMUD9pKncaBOGYmrHEY5vUy9t++1mP9dCxCdS3MIXWL2ffa7RXWMrBF?=
 =?us-ascii?Q?a16HGrK3RWOM8pxJZ2WG7OFaKm0UwcOd2edHQTBwjl2rwAOYYSt/cwG6BkdF?=
 =?us-ascii?Q?rcKtTg0SubJX3rTgQmeDHriFLptXkic41DdBumPCXM7sFexDrU3lARnZ4v7P?=
 =?us-ascii?Q?pbz7SHRzd9Mnk/UaNxN4Q0vIkMQWWONT6U2evi0zFPuwMa3iaGomco75Jm6h?=
 =?us-ascii?Q?F4OcSXdi1ffixB9ovsTZs89P5+gAW2RjzNamnJ46/kfOB2C0Vn3LK+wktc24?=
 =?us-ascii?Q?1Dd5fzJYCFcArYKd/JYmyu9J1rd24oJRCcLE43wfFLpjll5NohF1Uik/u8QB?=
 =?us-ascii?Q?nGIMlkr0YnOC4aPVJAe1PNFtQalMmtQuzlem97PiQjBEndGXdwdZ1lVORWeM?=
 =?us-ascii?Q?O/ilNlK0g5SucsA7cWDegbKQkdSG7fDqSCxvv8a9BpETnkKawfQinMbLJ/IK?=
 =?us-ascii?Q?aT/fHA5XN/+4J2zvUsww+2O+d8N2hlDYoqd64pQ/PCZEzSvsPlfmEwB2Sinb?=
 =?us-ascii?Q?Mm4vJamBQxeuFkF0enEjOdWIVW4iTG41/qMxKJdN71laN/hclZk9DvfIEGTP?=
 =?us-ascii?Q?ZX1lZinm6V32GE1cRzKkIonLV+1/rQ1/zgPtXaEIa19ZQ+KMgFbhM0KUWGWY?=
 =?us-ascii?Q?+94BTnZ7eu1Tnutd16xfrUiRkYSkcFD4a6u5OqF2b1wjOlhp3QW2su2h7lVU?=
 =?us-ascii?Q?PGcB5ST4o2FyzOXpHw49bjZgkEhTOV+my6Mt8iVmxStBjUiXY8h1qLdVRDoI?=
 =?us-ascii?Q?ggQa7ysQjgK0AfmV36FXoOCjcJM9+S3d8+hLrSFR5GQ5NxSHWgXGtPurduhA?=
 =?us-ascii?Q?W8NY//1oZHgaPnUsZRe2AAjAw3JVG8bQnyxgOwWtpz2Qj2ki3z0MoOqJh79o?=
 =?us-ascii?Q?oLMRAk14cA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea396dfb-d942-4571-58c9-08dedd6b1e94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:27.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFhGm7vIOARP0Miq+mMjBNGTLMxxxtlKaFAyiwk3tx5Xh+4PFEr5II/KrIh8Wplp/8nrETbxxqY7+jNr/A5J/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/pf1550-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 41036f4cb64a..94fe81bab5a2 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -612,8 +612,7 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 						IRQF_NO_SUSPEND,
 						"pf1550-charger", chg);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "failed irq request\n");
+			return ret;
 	}
 
 	pf1550_dt_parse_dev_info(chg);
-- 
2.34.1

