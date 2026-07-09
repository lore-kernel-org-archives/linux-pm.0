Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0E397343;
	Thu,  9 Jul 2026 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568170; cv=fail; b=JEIa/TzKLZT54nagGfRjVjQQxbo1pEg/OpdYfEC9+BOzYdSRDBHQK7gEUGf5fLA5j+ydh7ILb+MDD5Z4q5IyBriSwoZ/gOQjElWTgvBA/jvsaclUQXGYR3cs/nUHfgmm4n+s3szQwlrsY3KQRXnVzqq4PgPXtrhgPvxoZbEE05I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568170; c=relaxed/simple;
	bh=Su46rDRGgDNWYEzyrdtSTyGey48uR66Hhasr/qF3rVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEuDBwUtOjyPQ7jP6PfwskFOp6B0giByNvAq/GqoEwebzmcKZg8/+OGc+E9FUfnTDYwNUHbUNM2sGcG2vuUVHd30zCusXVTwr2EW29QTfOH/YXABs9oH0Loe0jTUpGvciswLExCL93nzmy98wpGCzjrzpSPS/gAnOWsh9NGswt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hUph6dq2; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hUph6dq2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbgfiwCJGvLWdOmTuidXmdsfoYDpbYZiwtSVK+escy+yHJPoWVrf/ST3VQIxmRFydohrS0SbKIDE7C1ecx8jyGSIKN7hXWps5TmOcOaTGhDWyc+nvZXHyPcCOQmkF1Jm4S11YW36mCP6nqmOvGAZW7V3PLc4aI1JmkB/nrs/mDc8xz2YJ/0Ojph/eiaSyXv8gaqgBH9Qgrx63/SZNbbo/4bviVB0FyHfzEKHP5L6uy//4wJbY8VW1LwXdDpP5OlXYsW97U2mRMl9tbxTaoRuQ+1RXT/kXDl6rtDsMQk25/AQoqcydaHDSL6WDope12d3JdO3vjP8ia91FFzTFnzDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vouu5AnIEGZpnh6SgPvts/wautlOTNrR7SmRet8OhMo=;
 b=ZA5TVCic4ozhNt3Pdv19aBI/IOT2DQFPMi3Jke9Pa5PPJPfKcz/G4/XcB5OlZLq3i8+YFKcu/AJR+EARy2cniG6Abgtp8AdU15dmJ7HmflNGiuVoGseTPrmjuAOWYEf0YK+QP7lj3jhPCapEiLrXpPgmsWg+gk5uwPtW7T4WxaQTnlsAHB/n2ulhmaktyU8DpAtR7VB+m/E3n5DRXOzlXgqgQ9o5rzl0CXsSCJZLmQR3r79mPyeRNUom+0lgnDCDJdO6DWK39kYFVPgYmB5wBcHDnoPbGP3Nrr/Yers16yrLXJa9qUsGrcQYrHb/fDyFP4m0mJMNyqSgB7wAQpHqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vouu5AnIEGZpnh6SgPvts/wautlOTNrR7SmRet8OhMo=;
 b=hUph6dq2WhuIY/ebE6mGCuld90HNPoUCzmtHIk2HpRWCzDC1wOOeoF8QaTF8CfnT0jIojoSY8O3lVVBDWlS/RTwoMgk7ryE218SE1FLRLIXVuLCdeH7jT8+0oFRXh0R1Ro+vDrASiF3+k9WOLzwcot7td/uLTh95J9X++jcTymLo7CrgzvVjMfwuwZnJWoS6D2mjXo0acb/yAlz1lE9PEO8WmrWRpJNENXlZHc/Zoo9jia6HWOugPQnv2tlbhaUKs47WtoisDiVjuNa94O4wWp938tP33xRRKOYVU3iBLrrRYVkjcChMRIF9ruN2EoBzFXl770NQiv5IrO693NFK2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:01 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:01 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 31/43] power: supply: rk817_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:10 +0800
Message-Id: <20260709033428.362970-32-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16e9eecf-bacf-4462-2650-08dedd6b2114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3Nc1AAvdOScYfd8OB9LdNilmafXzaCPediyEB5kjkP6XXTbMWqNk5+hJQbKPA9uoVRSIN48hI81Lg1qhpfsswfWi9GkbegYXV3Fi4PZpWL6vEB3d3YShMZysxJqMLY1AG80NRte5f9bpvYoM9BeEsqwN14zywtiavi/0wfKTUzmT58tAq3seTB2x9UPNAXQt8UJiRDSy0+19W/MSM+7nnREBhrzc4z11B8Xe1JQrV2Hqoyak00/2slRvvrxY0iJN6smsFX6G5zr6nUIYryweXVKJpXKR6rTHdSspifvpCyuQVTyAVS2yNbrJHsanS/FmtpLYQ2I4+Z/mskxYTM/CLaQXC1H/IJXkeAnQBCDRxj4rHWFcZwO06vpbYnTGvuezUkWsGsqOgEPC1vlE93Ysq9qH5uZKffPTy15r5b09e7wcMzPW/suFDqOk7Up5nkcyPRAfgdbpL/D+clp7zHT/kS1GVgVzqY9TyEEHN/hkC4HyOdm9OE/yG3D475qIHT1VjYadMJyJTsgdvd/Fp0AA4e5t0KMG9tKZpbpNnp7NxZK5L5GsspGhbYhrmLuRZ++L7DejjsYTwdjy8hLqHPFqjTOEmKEss/hZ8AIAKfNGOY+8YADWPPiZbChpxBk80wRPGcIyKO6kIO3RbR7ORt82PMtQ6efGSWF6y5TrJi5pkPZF1H+lWNUn+YIw0Z2nTmVQdeXEoyhG/O6nNk7TuMJnRi7T8Yx+0APRGpghFUpYNNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZxLepfKKJZpSaQdRTEZ8qiH7+UXp9IcD6/JtOi3wClPggVcAVgnjLrVqyLY?=
 =?us-ascii?Q?aqRxTB5id6ZOjORju+aicSd5nojBe25FY4+LSaJvkbYLwZARkAQSiRtsEy/7?=
 =?us-ascii?Q?Up6mzbqxoPRkBZlF68GbE1+KcJ0hwbdIzQ/7Lv4W7hZvIu7kgYQ95hOhM/4s?=
 =?us-ascii?Q?EA3TONM30J9EGgp8XSGCXWPLWzGCAEeoevSUAQdgtyg2oh1R/X7w0m3fWbkR?=
 =?us-ascii?Q?kTvc0tDB/Vx03SPLbeU0A2LzquHYnRfDLZBwE8Fz84T77awpMu55GEm/DJnx?=
 =?us-ascii?Q?DNt9L9697ozjs9oMHw5H73TDJ9qNStTZDros1CdaqKkMgVNlCJGUWOgaaqm5?=
 =?us-ascii?Q?BCnuhi5aNdkOkbGnTWBAVDc0T28Kfzrj9r2cOlw0mH1YPyZgMf08OQQRBsQv?=
 =?us-ascii?Q?4JSHvTd2iEG6Mo9T/eTRkEZSkQqtzMdIwM5Xw4ONtYtM+jcm25ae3u+dwQwN?=
 =?us-ascii?Q?NJsGNlw/g4tA9sdEwLx04YFFjnKjTCwvqIYCVNGAdPnPX87+qHZ/58TA1Hm7?=
 =?us-ascii?Q?qK4N56uEZ8NrAV0d097x3cD1t1s2pHkQvBrKLQ33K2SUHKedLX5ymHbzc1mQ?=
 =?us-ascii?Q?gOuW5xhSP4OHEF5zukKyp9xIVgeZq/AShvpnadIxMhAVcvAgbpxSve+c/xWI?=
 =?us-ascii?Q?m5EE77uLLvRpqhhSQwE3KN9SJZe9MNfqRvYKD5kLMRaeGWiL8IdEDRYKStkS?=
 =?us-ascii?Q?xobJjfPdl9ANYI1qS0sDWltZhAAGMiDBnztIAt4Nljfj99JKYcNaO7B5DhYE?=
 =?us-ascii?Q?WJppkumFvFavDKUwjtQAQNGNLmAQcZ4C/gGJYibNQngSTqnOYlot6TDHkrxg?=
 =?us-ascii?Q?g27NDUPv4ZSJWhvjjnXz7MlNbNU/CvH+rvMVgalQS4cbs1gR4fZEzcrhg5GK?=
 =?us-ascii?Q?J3SWUDhv2+fyVmfaeICfVY6w7vDMyT5c5Jxoi6hTOSA5jvwMSuJjXvoiO0QT?=
 =?us-ascii?Q?ENhszzDK+kWb9HAAHqkIDvb6lBzN0IO9wwtUE5Khpiyp9L9q7Z/HgeesAl6Z?=
 =?us-ascii?Q?3KrLbel/Dt6Te1xsXoqNoWe0BUNgSs4EdeNTonYEyiMPjvJTTCKStEcjw3We?=
 =?us-ascii?Q?vDxlHxIOxu9L0Yc5yBcPYB4PCwHSLYtE9rHfEG6UADNEw7RpFDVOmtzFtxnI?=
 =?us-ascii?Q?CbEHIgurJNSLyoSTvL4zcAv2Mqu4yJcXS6KSTfaquKoMtDRPiImO6ucRAhFf?=
 =?us-ascii?Q?0q5W0f87wNECv2ORNv1f07snPWHPaAO0oNwfYsBEFoLD5g2leW7DL1zkI67d?=
 =?us-ascii?Q?JoAYXNJA+z6M7kuNrMjvcdKFoOurNaLgzJ5cQSet3DFhQjPD7Cnj7pVqmjGQ?=
 =?us-ascii?Q?45AiS0Pdm0SZC5Ab562pLnLWA5mqJYWduMve+QfYT6KSShE0kpZX1XJF+KsL?=
 =?us-ascii?Q?oWau+58D+lIBFMQAXwGG8RPAmUag/TRaVK55LcCT4G90uG/FdU5uGz8BYiAu?=
 =?us-ascii?Q?CY8VSqG+fzskdWGOEW5eaqsjvHFE/UYxwmPsBcqbp4/SNrRysGsNjdNaRFMe?=
 =?us-ascii?Q?cHCOstlSss9MUDYN1YJ5oNEzf93tbBle7FahAK7R5Ndxs94ud7+J/OW+Hmtg?=
 =?us-ascii?Q?KInq3+bxNmh5bbSjy6x9CEE9qZY3pC9S5dWcAAdw36faUPUOKURLVJL+W/ux?=
 =?us-ascii?Q?8pguSWNLdqknlJU2MmXImP2+Z6nAYFRRfqvUBW0hbPA4wUChqcvKHnsYV7fj?=
 =?us-ascii?Q?7DOUr+ZX/MhEYBnBQz98WoHAbvtMIgAjuYb0+QL1gaprVOXX1WLnVxhwKqFP?=
 =?us-ascii?Q?qQzKIwPxHA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e9eecf-bacf-4462-2650-08dedd6b2114
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:32.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vio2pA0XUsMjGj8p97jTBVqSf1LyEzJ8RLmmbBVnaHPoNoIAkKdfKxZZRvWKNuRU3URivymdk2qPptVnwRhSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/rk817_charger.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 9436c6bbf51f..5558b182a1a6 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1186,19 +1186,15 @@ static int rk817_charger_probe(struct platform_device *pdev)
 					rk817_plug_in_isr,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"rk817_plug_in", charger);
-	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				      "plug_in_irq request failed!\n");
-	}
+	if (ret)
+		return ret;
 
 	ret = devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
 					rk817_plug_out_isr,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"rk817_plug_out", charger);
-	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				     "plug_out_irq request failed!\n");
-	}
+	if (ret)
+		return ret;
 
 	ret = devm_delayed_work_autocancel(&pdev->dev, &charger->work,
 					   rk817_charging_monitor);
-- 
2.34.1

