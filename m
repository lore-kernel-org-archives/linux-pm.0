Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFA3822AE;
	Tue, 21 Apr 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757217; cv=fail; b=JeDB11I4c9YudqiIKQM1sVjen9TapKYj/NioiePoVWiVnQk0A3tJBaBlsAv+IX1ypKwqxiBU7Ax1LsROFblctlOUEr6tWgtI9AN1XuUgzD4XrxGe/PmU5o0/tDeyPM7fZbHh508J6MxVlu5z0NWR5ZUGNfu6wY5g+b283oUnZJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757217; c=relaxed/simple;
	bh=laKQK4JE1PKTpzz8SU4TMbUVwOnF9jLwp6HDIIySOx4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WWwrPkrMH4M9TNdaFOWa8KyY8GXDXUP6d4NKW/J4j4YFTFhGT+3ZLbzhiJsQbPzLg6tyrxypTkwDRnTy9rZuOMGRPEfyg/EBeO16q/J3ysdaNdvQrCI0AKTDdsq6s9H8hOmTPFTXwFtWu1L4gs94Lfx875NneGVFqeKvkOb+KK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NFf8ssk6; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NFf8ssk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QINFFDjPO04NS4EuN1R+Hl7naUQKotbsCJpKRgMC70r75x3GpAF9wJvDPHRNUPfin88iRRwZSldhjWub7dLygOhNEwKseFnr+i2b+9YezSvHczXGyjB23D4xO1F/ikC9ZuvZDJhYDu3OywsbPHs7xRLnN3zP4GZj4IHUuXqGTbTCLPCm1Um2GUFNDVbMiArpt/YtjcjxRchq51qgRkhC5k6nAPUuNaZize97SmhhjDKyzbC8Ea3C7gM5Los6L3hoKasmU9FRFBjVmDUPRbmuxBNerk6Z6yOve5hkWRpvJomF8eTROjeelFvX5W3myXNET0OZMMrtVXahUKQHKJB/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoyKZNctd3U+/2ft1nhSJRA2oOq+OH0kfUG/4/Vtt70=;
 b=k/nJK9Cm+QK7KqU84WUSe/V7xdtj6u7f1S4XZRa0CTnlbFplk2gWKu7VasTUPyZpbCT+WFzGdF1SjGYeG/+z3pu9hp8jKaFQff6SVN/OxtFRU5qTEmD6zvpI8rkfxM9aVaI7UUz5200So9fihLl3wZK4BYViWMy+TYyxktNn2g5LE6Umg1MoRw7ukSmJ5BKLiYUAsCCbRmBPTbIvnqqW5ibUgoTfxkVEzBIfqD1yH1WeaEiwQB9pMNHvbWS02ZSJu317QGPXGhHkSc36n4UcKO1ZQWRVLuaRoXDIjYbqzA7bLSjkUTd0TiotC21LzYhBC6VpkPWI2TqzP5OC1inYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoyKZNctd3U+/2ft1nhSJRA2oOq+OH0kfUG/4/Vtt70=;
 b=NFf8ssk6Gqq+1lJvl6vswdFxD6L8VtFhmwRvSIgzZ1Lt4/+spDYd3H5s4YtqIsRoeQGKw73+ZzLqbcogbZy/DJG0/u4vKv2LW3IsHHMXyv1asj4EekIEyFbcNixgUkt0/XOx8DHHP/h5/XZlf5Ho5fEvdBrGwJC6n34hXSQNLhdTvH9cz75e8DSmK384qHS0VFW5y62ZFXd45R4fGh991XmFaIhwJhyqK2Q4n2J/MXrXOHFtfu+pbzOPV6Q35nCxiCkEz16GERQJ59dLT9YXK6TVt6MpT0EnQP3QSKBYF1/NzIspH0t1MruPR7rvmh9ARsc4HfuoFkdXG6obFnr/Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:40:11 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:40:11 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Tue, 21 Apr 2026 15:42:23 +0800
Subject: [PATCH v5 2/4] thermal: qoriq: add i.MX93 tmu support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx93_tmu-v5-2-05ea1969bb9f@nxp.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
In-Reply-To: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776757357; l=3819;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=laKQK4JE1PKTpzz8SU4TMbUVwOnF9jLwp6HDIIySOx4=;
 b=hL5IZo+vtOIQg4z90gTdUvnSfVOEhcEjI36smI7wml2zUidl+5o8oMMFwZPmOTokYGnTwxgRq
 W09HZEUC/v5DUCR7CZo0cKKxizL7+7gxwgfFIlmW8JurloJG+G0K6rb
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ec4fc1-8c79-423b-bfca-08de9f793842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rs5tyVACgBxOhr3x6n/gPwJo+BuwdcXQfHlEHVkZlcxRCn6/gtpA+niBLe/G5pA3wLJLDu/x2fRvr7eSg+lA0dML54qvWdsvKtcrrt1uoWWLNBCgq1bdhQGTQtfjcfvtCBpIFHPMYRJ62TSPtsNiLHbxS6HAF9xysd+6+EvkkTSEWCzfGE+ErKb4saw/K6ypgMp9t+SXBCq+i54z/I/F5LIzWiaZI8alyyzH8nB5nvHlfqZY7ggOAZtjpYWZxk6KUOSLgDUPHADx3b+dSxH86wpT5nnlwwvloNq8kyIjhu6HYOhPHtPD8B5hEVYCKv35B6S/N4SyoaYx4MLARCLgb7PvxaXChl0LNXQ2bdQ3P9leKXG01RljcGmiXF6gB7fB9NicV7/NjdHU9LexOQ3nQb89ut+lvEqkyxwLK5BoOjJ7BEcdNiQIqiBUbDDnlInIbYwRIXHoiVeA6+viA5qwXUij9zPu8Gh8GTgjEFfIXyG7QV3xQNhRWYmiC/REoUqiuXizaDZJKDOp/MKPEaa4K78NqDild4O8qnpfeed3B8iQ9YycjHfFtd5cXMuBVj1GC78dhAgPL4UFpPueAFAqymDqONTJ5q5h0h/xQ9C71ESNiQCwp5xEaqCyXTV6TtOgksX145PKsW1mgjRjP0pX6dwrQDDM23FYfstVN3nm2FnVO1AZTzSjneo5X5MnHMmkE2kIrSn7j7QoQjm2PvJzLh2HInsJnQN759+J5njAGrRPMNemkoMBjiMichFLO8L9+zML+0gbDtrdCPsMjobggTR6w3Wtc6s04mxnfrX1H9MCWXV0nHx5Z1P3GTAS6Q+l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJKRWYxblJVc091dDRFbXlKZG9zY0tCUFFxd1puV0FUMkZVUEJPQ3cvTFVz?=
 =?utf-8?B?TWJuUHRvNTl3UnptZko3a0VETy9sb0REMHJ0cVlNcFdxNSt2QnNaaFZ0N0ho?=
 =?utf-8?B?MjdWb2IzTzhERXhneHh6WjJ3TUtaNHEvTWpIeE9pc0plZFFVNkpSRWtWWEVR?=
 =?utf-8?B?NjhkWDZEcDFJQTk4cWRCenZTcmRKQVU0S09QQ2pHSmFpR3BlQUdTN3hycjBH?=
 =?utf-8?B?Qk41VnVISUdMZjhYMVNTRXo0czdkaVB2R2JUTWZPckp6L28zVUdmOEs1V1p6?=
 =?utf-8?B?RUZBSGxDNWpRWXpRSXlIQjFSbzdyYUNPVkQvNkszNXpSOU1VQmZQMTZPWXN5?=
 =?utf-8?B?NUNjdUJFUWRZNVRaVVJSNWJVME9zcEwyelozeE9OSXBKbzJLdktpbmZuQldo?=
 =?utf-8?B?K2Z1S3RhaUI0V2g4djNvTEN6S294TEpJamUydVlTUzJKbmlBOXlwVHVva0RV?=
 =?utf-8?B?c1l5bWxjQzlZeE9ZZ1NyZSs5NFlVckJBVDRmaG5oRWNEWDhZektRRjQvcTl4?=
 =?utf-8?B?Z1VmMmFtaTN1OVJxVGRGM1VBM013MkFCNUhrcDkrRWFRcGlQTlllcE5lSlVV?=
 =?utf-8?B?N090Z25WSTNTWGFVQjJBWGJVK29pVFpZTUZvWTB0U3NlSGNpOUwrR2EvMWpl?=
 =?utf-8?B?L09oQ3RSaklucEtnV3ZwZzB4Ukt6bkNQQlB4OStUcmxWRC8rd015cmIxeFdK?=
 =?utf-8?B?TWNXWk1aeDJJUEN3MVdwZzJlbUNZODVsVEhUYllWS0J1a1R0QUR3d25hcDRi?=
 =?utf-8?B?d2RkS0Eya29aM01BVGwzNUJkMm92T25Zc1FENmFrQktLUHluaEpkZm9sRSs2?=
 =?utf-8?B?SUFxdWhiM1NZWm5IckNMMFpZbWh5dnJUTHFQR0c1Umd0U0Z6UEdMd20rQjRs?=
 =?utf-8?B?TWdJQ3V6OFg5dEo2NmpVditueDUyTEoxVHRrQkc4TXlnTVd4TFI2MFZGNXJM?=
 =?utf-8?B?alVTNzhhWFNyaFJOc0lXbnlrenl4blphdUxuRWlGa09nSGNzMWZzL3dYeXdw?=
 =?utf-8?B?eE5XNWlraEplRWt4T1ZWU2hoRkNBNHBncVBtZ05qbFVRREtuaUttS1FGaUtU?=
 =?utf-8?B?YU1NKzhhNFZRVVkyNzlQS2U1WTBjTUJVRE9TV2o2a21tazlCSXFVV01wdVNt?=
 =?utf-8?B?MlpoLzljRkNUWGU4QVFRbmVuVHBWMGFSMWJsY1hlMnNWQWtZWWFvOFY2OEJu?=
 =?utf-8?B?eUVieUdUcWJpbjArTExPZlZBSE5tWGpOdVNzcGE4VG9UWW5CR0ZUcHQwVkMv?=
 =?utf-8?B?VHkzSVZqNmJVaStabUxycnk3VXVtRXNRQlRIaUpCdjJ3akpBTkxmWStOTndN?=
 =?utf-8?B?RHJWMEZqOUZXcVVaTmdaVkZRQWx6M3BRTm8vOGhzNDlucS94RGgyWjJqUTlW?=
 =?utf-8?B?V3gzY3V5VzlUVThPNk5DcjVRd1FIcDEwUUJqN1NJNURqZVVRclpVUXQxajJj?=
 =?utf-8?B?MlFielVndlRJU0h4S2NmMUFYZ1RpK1JQd0p1R0lFL29DcEVQaEhpWk5GODlx?=
 =?utf-8?B?ODQ1RUtiZzBrZGlhdXdDS0I3ajFqVnc5SmFkV1BKcFFXSmo3K0NjZ3ZLL1FL?=
 =?utf-8?B?bjR5bFZxZDZTL0ZVTW1obXdPZEMxNW9rWHY2UXNpMCs0Yk9YdGlPT1Y1SzFF?=
 =?utf-8?B?SFV5aklTQnd4WmJmMWlIMk9MYzhCRzZlaGtrUFNoUmo0bTZtYXhES1JNbmJk?=
 =?utf-8?B?RWxNUHhaU0ZZM2s1YXZ0UUdoZy9QaThBeVY5SDVDamRiUHRUNGZ2MnBQbUgv?=
 =?utf-8?B?d01DRXptSU5IMS94QVdPL1BFbTFFOUJFSDhVbXVvbzhyS0ljZVlFZUloaGs4?=
 =?utf-8?B?STZ0UWFxWkd3RDJGZnZpdmphSFBxWWI0ZmZvbE1rZENSa2JBQko5WWZ6OVZX?=
 =?utf-8?B?SXd2WUkzeHU0QWFMeFJTekM3aTVIa3pxa2NZYmtmTENpamtxQVdCNXN3RWhj?=
 =?utf-8?B?QU1VK3ltNHBzK1F2V2MwU2I1M3pXMmxYZmovQjc0bzNITGNzUnUreWpwNWFC?=
 =?utf-8?B?QmNyR21sakdZVzcwVE9UR2loOVNQRmI0bUNVZXBGdkJsM3JQMFJqWVdkSDMx?=
 =?utf-8?B?Rk5WYjhadlNScWZPeEdyM2VZZ3k0MHdSMnNuamJnQkJvSTRyaXFqcXJ3WlJm?=
 =?utf-8?B?Qk9OSmhmd01nTzlzOGhKdVVlNmZ3NGNhejBxdk5tTC9xU2Q1ZG9nbGpWZjdF?=
 =?utf-8?B?cDJjNUFDeTFySkdjM0JFZ05nV3BPOHdiNGNBeDlWY1VmOU5WbUFibGNXUjQx?=
 =?utf-8?B?dXczWDljcUFkQnVMc0J3N0FyZVBTYk9sdmVCZHkwQ044RGpRNjJ0OU5mUk5a?=
 =?utf-8?Q?zzWX9UiE0LGj+SfmoS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec4fc1-8c79-423b-bfca-08de9f793842
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:40:11.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKxTo/MekiOdf3+OGZDrPSHWOoVnsX2fFgr1Iwmf42K6KNYDqJpTcJbUusehgQ8kGYsDXKXbsREK9EZlhF93Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
from the ID register is the same the one used on some of the QorIQ
platform, but the config has some slight differance. Add i.MX93 compatible
string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v5 changes:
  - drop the unnecessary GET_TEUMR0 helper macro
  - add drvdata for each of the platforms

 - v4 changes:
  - no

 - v3 changes:
  - use the drv data struct for match data and refine the code
  - update the copyright

 - v2 changes:
  - use the compatible match data to identify the i.MX93 TMU variant
---
 drivers/thermal/qoriq_thermal.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..297a855311f3d6a8d527794abe17ac86c47bf152 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,6 +25,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55000c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
@@ -73,12 +75,17 @@ struct qoriq_sensor {
 	int				id;
 };
 
+struct tmu_drvdata {
+	u32 teumr0;
+};
+
 struct qoriq_tmu_data {
 	int ver;
 	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
+	const struct tmu_drvdata *drvdata;
 };
 
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
@@ -225,6 +232,8 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
+	u32 teumr0_val;
+
 	/* Disable interrupt, using polling instead */
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
@@ -234,7 +243,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
-		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		teumr0_val = data->drvdata->teumr0;
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), teumr0_val);
 	}
 
 	/* Disable monitoring */
@@ -319,6 +329,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->ver = (ver >> 8) & 0xff;
 
+	data->drvdata = of_device_get_match_data(&pdev->dev);
+	if (!data->drvdata)
+		return dev_err_probe(dev, -EINVAL, "Failed to get match data\n");
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -376,9 +390,22 @@ static int qoriq_tmu_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 				qoriq_tmu_suspend, qoriq_tmu_resume);
 
+static const struct tmu_drvdata qoriq_tmu_data = {
+	.teumr0 = TEUMR0_V2,
+};
+
+static const struct tmu_drvdata imx8mq_tmu_data = {
+	.teumr0 = TEUMR0_V2,
+};
+
+static const struct tmu_drvdata imx93_data = {
+	.teumr0 = TEUMR0_V21,
+};
+
 static const struct of_device_id qoriq_tmu_match[] = {
-	{ .compatible = "fsl,qoriq-tmu", },
-	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,qoriq-tmu", .data = &qoriq_tmu_data },
+	{ .compatible = "fsl,imx8mq-tmu", .data = &imx8mq_tmu_data },
+	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);

-- 
2.34.1

