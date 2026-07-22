Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2141B983F;
	Wed, 22 Jul 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708759; cv=fail; b=FO2BdmGeKtkVSBe1ND1q3m9cgjh7bOFbK4r72tPsv167MAldK7lz6GQRD5GOFz7uz5zdAgXIfi6JXk/3nucda26X45cOYVo6XjsKY23ZjmHklwxZ1A/ycJwvEUMyNplRrXOF4ypC+sQYcvxl2V1WjNJcKVO7ApKSUqLKoUsln+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708759; c=relaxed/simple;
	bh=VmFVmKPpLlUjA34zmWzrOZKtlvkiLisJa1BXdPRDBRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/8I4PdUbe7kwwBFtrLE0KWwyH6WZjHXIyEZCzKtm4i3NnjQm6OKqODb1xgsfakoa4t9++2rLlGZS8xvP0KU2vUCbXlAnxzht16SCa3tTtqqqJL0BAQ45fVPKIs6xtarbES4dAl4E6fXI7ynCj0+zSCL9ljU9DTqx4VLgogkI4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mbr7hygD; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mbr7hygD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXpxRZ4zs09DOUFrmibLTGCRoUZAkXlXKY/tWKvNPUyWqI+0VaNaS0776T+KYS+f71xiHSexbQXb1DoslQS8BluowW8k/5X9pDmQhACc9PksmxOz93RJ6D9niOzyEg2GpDON4uRT6i2Zusi+RJeHzZN8aRvERHobt9tsEdppHCGVv8JLkv5MZ2aF5FkAJg33CUEf0oYDHTJwaiYShv8b8KGDeqq1w7EihKA3fXTUPm7UotgG1yfygde2GJiMW+JuaA0EMMOK/1MHLZ1KdKdXi15U+wCN6e2vB3MmivrYi9H8yH3qtyZryWzHiyXlcCWUtcqZOOiBQwhDQFIDrj85Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=YMSFt8FESZxhWW/vmycYpMfukJdo8M/o5hak6WSKBss5BfW4Rma4QNJmf8vxRTXw0u6Hai8fOEfeCIOzKZ5Y0EDgGTE/upcv1JSLQ4wrwxQJhi4DCzdA4LZQkAZSRNsHxEdL+GGUElioQ7KAAS6MlW9t7r9Bl5SMpPnXpYjtUWxnZV8gYlMdbBkBN6UasSLBh+ES3gmx4LVA4KrPwou9St0OoUAA4xr0BfzrgaXvsdEYI3ZTa1wTkRKmfJ9R1p9lpN6U622lTv7UCMjd1tbLJIc9YI+XQ4IzEvdOpvK8ggIJm9zjMV96ZbTjO26C/2xA7lRhD6Pxck2ZuuWIQ7vmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=mbr7hygDw6UVmbseGUfTDlt89NSdv0VUbLGXYBYfX550Do3nLqQkHdgfR4EjkGjmnXTer+KOeDga2arjRR2i5vmPyC/7ElaIRfSQ2/SZbSVlypOzwZ95N1q5Q8tQLcGfW2V0/Bze9Zr+SpDTS08LgSp4vy6YJSwLz0i7JgY5vOREaRY9/0vPgvi0+6cTe5q+c3/h5EvfH4hUfTu6nM44NatQqx8Vphu4MENMew1UNN2KcwGR5NiU6yvYCk+yNr+9tkCwW1MWIv4OUYMUjtXCmMHotX+mv6AY9zsKLAbLQAWhC+jwDc1R/Qmr6++JheT3PGRRHm72CqlUgE4AdOGLUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:25:54 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:25:54 +0000
From: Zhipeng.wang_1@oss.nxp.com
To: robh@kernel.org,
	saravanak@kernel.org,
	ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	jindong.yue@nxp.com,
	xuegang.liu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 2/3] pmdomain: imx: scu-pd: allow building as a module
Date: Wed, 22 Jul 2026 17:25:21 +0900
Message-Id: <20260722082522.3747962-3-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a401bd2-55cf-42d4-f63c-08dee7cad8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	P7hCpfcvHGYxIBx0ARS1+48HUuvP34ShlvoRYCFHqR6bOiXJY88R9uQCGcuW0bn8txt50Yu+SbFnYz/T3UktSZy7nKq+gXGwBwRJlhuqjUW91YVVOjY9WnQnQYiliCI0pgOE+mE3+0F8vn1vN0lgKn0VX57r2QEfMvCuzRpIa2a8Iz51zbKFgdbF2LbAvi5Xmk8y8yZk3NDrcQ1KKS25AU69TLsbgUxgEQQsQTHW3VrtTjbQvXPuPEXwmHg2S9gAlf7c/tUYekOt0U0EKnHlHycZHhm2ZpDHlNcZNw7pYOB4ktheH6O2BhTyxH0fhfoyef/ssQHwmCFrHCxIXqqSDkOJL24li+01Bk4bgm1Brqyj4FFEVW6MSKi5wVFhowLmzA6H+YuDeL02DETkD3HQnWdm4DzwV1tJ2BB/sE44RKHrwaH5GKkHpBBB1DX6+QxvLYDtpiXG6AolWKCGfGyUBUbXGf6vqYo+TMOpGeiBhFA4izEvD5L83xm0jGPR+iGe/Y7O2OUBRTSsyWsI/XA9vk3f8/tsFCM+R4qosO28muhSScvOMIBgjc+4KCvoy7HtOW8EN/2XfmCxtfGIAtxwXxP8x/OjuccqRQGIzNc1htpxGqmj7c3GDTxxnLWuxorddgS6dnYkhEveo1hc1sIRxTW8BwNvwYe323bDwFJ9oNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1Bpz9C4dSg1zhVHrN2Poo46mrzRQws/VkPKvOAP6IvvXYCd1oOvQweS0Rqb?=
 =?us-ascii?Q?CP+Vl2s/tpezylceMHsrwB4r9rl3WQ1KZ48USS/pF66dpcvpBXexoXSA2cHf?=
 =?us-ascii?Q?6bYCofk101grofW8PmIKGkDrKGm9MwGxXaFInzcZsQMGLRWnzG9vow4yXYX1?=
 =?us-ascii?Q?19smPQ2RPAEX+jzkayU/6O4JQBUt7Jl6aYlWxPMv3eCKUUAkI7A+Jw41aN+Y?=
 =?us-ascii?Q?rzs+oPAKKDMpfY91nOugD0GqCyQa3qKxj2ESGXZXDnvNrQou7pZYv/CPWYNJ?=
 =?us-ascii?Q?aD2a9oKEAhuw4+wVagQXVwkz3fBdabR9fRk0VmbwN9P8O4ksaqVV4V/241IN?=
 =?us-ascii?Q?6ezbpjQm2v06/FvOIfggD4CJ/nXYHM6PZ8mEIM35FuxKx/wGmEA0jn+cPDZq?=
 =?us-ascii?Q?Wwe3B/dnAs/oobcnngSAxH1Xrinp5X/F8UyunYkRA4TUTTz5/oSAvZUhLLs9?=
 =?us-ascii?Q?QG9Py70biw7H0dMwwQhl/hQ27MjEA5S5QHiKQBlfJ7xeje2coaeTt+87kzMe?=
 =?us-ascii?Q?F0GsMmkLtnbMTCDxIsxiHF+UJQHd//OOyEHp8F3V+mRz+F8ndNZp0OvfhtN5?=
 =?us-ascii?Q?OkcWnanOQ/WzwvQwpmS6rKn3b316c5jJiTIABsO6rSzyZGWvpqR1Lr1tXfA/?=
 =?us-ascii?Q?hgeFXjmALfYTWTHxfY1YraSqCUzRU2BhBMvsYhyVFDpB2z/9HgjiMM1SAauX?=
 =?us-ascii?Q?ubVcAHrtLdOX0Mb/J1Fr6CHCKqVEWUyVK0NYfF8He/o3/1Ab9Oy5ej3rdTCV?=
 =?us-ascii?Q?JvAXrMbF2vKnhfoPnOhogPIzZkPidutCDWjt0RYMiuclx8J5s7vbU7sVA4kZ?=
 =?us-ascii?Q?KmwyED24fN1LzDU5ABxM70PL5vCiiodvzXdl4gJF2bheyVEdqv6XeKqavb1B?=
 =?us-ascii?Q?IBdlpkBIeRfA0+ZiXBc93fZShT4svxLGeqZZtAtcId049F524XBpMhAIBnRO?=
 =?us-ascii?Q?4R6GTRxCnKELNvcfFK0zhCqCieZD80RR/C5rMujnrheVKDbfvwW+2ESynJOD?=
 =?us-ascii?Q?TsG6fScO5cJQGBYQf0oUh6xs0aeYzKvOH2VJpyGsgIcTlOkeannbpTYVvghp?=
 =?us-ascii?Q?MogLjj1rnDkN4byKFEq0ywb9Z6O+4DurBjGF24dE0b3n/End1aF5Blsz54Rp?=
 =?us-ascii?Q?DbJvcKlqAPzjgn8i4pHwMwFNlxscsvgxBpNf5yalIhn4GJbBg6PiZpqF20ty?=
 =?us-ascii?Q?V/h1eiPAQQhD06ydQIU+jlrez3qCYOUF+mVsMDsB9AJB5k8Eu8rCQgq8zxct?=
 =?us-ascii?Q?3iAACUeiOjR7HEEdbIOsrBkm9F0aqFDomahMkcdDhAq8TaIeZvlsFXr06Hii?=
 =?us-ascii?Q?MWQbDnJVfZn/PXYcShW9I+KYBW/Jd5UkxHKm/brbDDH+ULFSNViksVyHYNN8?=
 =?us-ascii?Q?X1uCWIOfO/P1yKAab2eAeEtWSztzSfuMpNQzXqaUd7IaNZeO24T32CzIMvvI?=
 =?us-ascii?Q?dJKQ4c8BvBz4n7PyFf3XOVnBcWKoFTxc8wkLPqekAPFR0/18hL+robBYiuXQ?=
 =?us-ascii?Q?QqKPmgiP3GUA3jSQLmLbubQx9v6O6pHy/GtSwtaEumriE+pZuxSNUwDeU8u5?=
 =?us-ascii?Q?b44VrEm5/qXp/7CXZK/J791AFioGJFX5qmQaPrph/HntLUNUor/wS1gT8o0A?=
 =?us-ascii?Q?aOxkADwbvu+hZHPWVTvQ5XcdDBIbcr9EEk22RR3cFu/FoeXTagDdQW2A94yv?=
 =?us-ascii?Q?8jkt3Vyyigi0+A9yIJmOWOy0BJKWwQzDJDRsbmF3yAD1FKIFUJ0gCq46MYIH?=
 =?us-ascii?Q?9yEgeqYax/1Xzs1qbrG1qQ408M86OD9NDS7wJes0uQNMwDn6yAcL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a401bd2-55cf-42d4-f63c-08dee7cad8e7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:25:54.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q9ui0EHSSVlxFn9/Z9TL17zlqwIl7RMgnt53ex9DcQ8u6oRYkCHOF35OTslYaAB02RItnPRbyPWUsgX7Gn4LzioAhuioFlmK9n94WyHYj98JS6sOVxtfUaULw3XHZ/w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

Convert CONFIG_IMX_SCU_PD from bool to tristate to allow building as a
loadable module. This is needed on Android devices using the Generic
Kernel Image (GKI), where SoC-specific drivers must be built as modules
rather than built into the core kernel image.

For i.MX8Q devices running Android with a GKI kernel, the SCU power
domain driver must be loadable. Without tristate support, power domains
cannot be properly initialized, preventing these systems from
functioning under GKI.

Use subsys_initcall() so that when built-in the power domain provider
probes before its consumers (e.g. the SCU clock driver at
device_initcall level), fixing "failed to attached the power domain"
warnings at boot. When built as a module, subsys_initcall() is
equivalent to module_init(). No module_exit() is provided because the
SCU power domain provider is a system-level resource that cannot be
safely removed at runtime.

Add MODULE_DEVICE_TABLE() for OF-based module autoloading.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
index 00203615c65e..472e9dec6bd4 100644
--- a/drivers/pmdomain/imx/Kconfig
+++ b/drivers/pmdomain/imx/Kconfig
@@ -21,7 +21,7 @@ config IMX9_BLK_CTRL
 	depends on PM_GENERIC_DOMAINS
 
 config IMX_SCU_PD
-	bool "IMX SCU Power Domain driver"
+	tristate "IMX SCU Power Domain driver"
 	depends on IMX_SCU
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 3ec33667a308..e3f9e741daf7 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -531,6 +531,7 @@ static const struct of_device_id imx_sc_pd_match[] = {
 	{ .compatible = "fsl,scu-pd", &imx8qxp_scu_pd},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, imx_sc_pd_match);
 
 static struct platform_driver imx_sc_pd_driver = {
 	.driver = {
@@ -540,7 +541,12 @@ static struct platform_driver imx_sc_pd_driver = {
 	},
 	.probe = imx_sc_pd_probe,
 };
-builtin_platform_driver(imx_sc_pd_driver);
+
+static int __init imx_sc_pd_driver_init(void)
+{
+	return platform_driver_register(&imx_sc_pd_driver);
+}
+subsys_initcall(imx_sc_pd_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-- 
2.34.1

