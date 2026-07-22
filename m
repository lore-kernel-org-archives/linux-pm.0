Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD303D3D16;
	Wed, 22 Jul 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704546; cv=fail; b=W6Z00Q6iy1tswQKS3Ng8nu3AdunXH8HuokFl13E1FbcmO4BgCDbUmpbwSnyOv0/4V8G2LjxzVGfFnOsOfC3XWIbTgTKu85YOTkC9+3Y2ctnpCBTBjDDqf9UHM4Yu10/d/Y1Ye+BSStO0Aa4cBqEdmCgtoP8F25q1C1yYwgQUkKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704546; c=relaxed/simple;
	bh=VmFVmKPpLlUjA34zmWzrOZKtlvkiLisJa1BXdPRDBRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhZzemj/mYAt3yh8M2inXRGk5AEPJTiHtpPjDZsM1bdOPQCHjUXhnRfACNmPdMtKmtJQsmj8urwWCOPSkU0nUSPLZG0j8JjgyGgF915io6i+aPVpW2yxQwBCopo5VmAcz5bvgPLq0RkutejND2KNNiV+B/dTo0jNP8KS0NLR0eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fhSsSBF4; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fhSsSBF4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIkNh+aAeA+h3m9hnYSOx0I+kABFFyjkt12gTiXtjwqvHXdPKYigGrXCzsH4GcvosEwfxMJuaU0qtP6vy+Or14y7/F54TrbC8HpDvtJw4OtC9Urhz8j7Sgehbq8M2qGPrhVYi27H0gPsXAtn01OXlhvRGMY7XRCJYRm1BmDImr1GJyQz7Aw/0clXuDd2TaiH0vZRkNUvF6kiJo+wr77EQ+TlgDEJrso6Iq2PS2KAJ1FpdqCsYFUYTvXtaghM5MoOl+MqgG7iuZarFO6ym207+VbJsRMjqr3+OuCrIku2hr9JhlBLKB1mWKgu+5xJK5AgC8Akbm9H9d4xvrRmgRs81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=ORBftuSiOgEApIP7HVcpAciVZQWuhpoVLE1R6Jo7imEcNHVJ0EuO1aWTewzITmA7wmNtyLbaOzO7I2wP0liLKc9kuw9061RcIln3LRBxHcw+fCIo1NASatqyCWqZzeBWowQi+tyVKgKSxgi1uUk86x3dF1daAoZjS34/TvOB8P9jc8lm3pznjQ8WOSlWnl4G8oJPQk79VLKhsM+Rm9g++AhrXv1saaSluPJ5KLbZItygRDfgoLkrhWJNnE2QIdOodk2pgF0nMPkC2iCvFCsTZGk3BZKk0npOA0oppoKl6sxhZIY0MIs0aVtFOvc4ZMdkjnEvsHbB78uvEo1W+1UZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=fhSsSBF4fEHpfzyLKSPo43IWyEHsCQlg+IGD7EM2y5QoKl+BbrOcl58aVLZP9qYwE1YtK6J0bJEUJrGTAzi0goyEOaTA/7pt0bFLiwZeJxTPihzm/XMGRFL7dGSUSGDUVUTrgVUHOcr1Y0vlDQOJiofDUhpJDRkAMNvFnxkDDMyWcj2ySvJUJGAyMxNrOPzIazNbAJ+UfGafvfCCYr6ybI4K5S/ZOZPND/A3o3Q+jm09KWi+1De90Pj8WxE6nY7gGWK6hrPmWHSZ4CPUd7mM78Zp6m9RfP+DkyVz9RFSig+h0z6F56aj/7HO2ZvizKBIVWeleJVA8CytusAjwwNLSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by GVXPR04MB11523.eurprd04.prod.outlook.com (2603:10a6:150:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:15:41 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:15:41 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] pmdomain: imx: scu-pd: allow building as a module
Date: Wed, 22 Jul 2026 16:15:12 +0900
Message-Id: <20260722071512.3494011-3-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722071512.3494011-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260722071512.3494011-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0300.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::12) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|GVXPR04MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2863c7-ad5e-4e35-4afe-08dee7c10993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6SU2Xi2MnIL0Rsj5WupowLseSo17k4dA4P1Pn9mFmh+3ogMYRwmyoPHt5b4zJsGuSoN/tamYrM3m+4PqYy+Iw0qAaxw8wpdJu1Fxk34cJ9yZW9pP5BgqGkP5eCQzNYh4KKjN8iiX2M5eLq6AEgyMl4Ah9ufMqlSHn9YhSmaWrmOSqE46XQY4v0elpDD6iBga1jizgJkPuPZGpyaCYkcWa4gwKA5zDDRPcGNhWuvbk13oavbqtV5QZrHkAseQr0qW66C/Y1aKGyIBczGItWQDYFGTCe7gjGfeaaKgGijrHiV9wGhe7zC2l3x9I9kvLMvAxrHNFMM1o9H8R8M4fKRQUycAiXxcJ95a6dDc14+OvMw/CByqqezBhfmNTLyT/tnTyaF53TNraiGE+OmODIKOdiuGdLu6WUr9pfW3WIM+a68vcAYYhonbUywWT60m6D/A0DzTNkOu72Dherv72QKnqSwfj2w3SauwAkNnuyYlmEIlf8SpUfj+paC9wLJ8qLTdZ33bo3Cl+k03Xg86bADEXZvDb5qc/2p1zLwjJxQYUfb8Gjg2aBOEIcw8KYvIFHLtka2jLyXmtXuNcarPfjXmpSKsZZU6b+fxYNJdQ+98nzhEJK/iWV0/MJFOFv/3451A2Ab46IxAttyiB47RmOFrBvcJv20N4otEQxv3qiM6dUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3fuCHVVgKJJucR3GXZFB86S7Ai0wBoZhcbCXbLldmamLeIao+dUuyXgEbh3?=
 =?us-ascii?Q?0IXYrApopK/FtHUgBd80SbENDwQRRQR0dx30li98D2ldaoRow01/PsfHKKAS?=
 =?us-ascii?Q?3CDfpZMe0cLb6QojakCYDLnkvFppZoPuMNZ0FFwht+dn817Xybdcwp/LW2nP?=
 =?us-ascii?Q?UMm8HRfceWPdB7WxtKnNoEe/9qdmnWFQKVuz3cgShvetcdpEF2Bp7HwFA7sb?=
 =?us-ascii?Q?1kaYnAm9nodEgq9X+NIHqavDB6YwoylyPwS3z7xaEVxYtey/TrMZ+WKxVSfw?=
 =?us-ascii?Q?TeHz3jqnXCL8/38aCC/5dJysifBURDkBePAWJF/hCYI+rt1M/GbS+8PCn+Rw?=
 =?us-ascii?Q?jVEC0Gbo2LVDr27+ERVIVs0g8mAHUVCHJy9DCt6MiKAC6x23ui9NDosG8nHB?=
 =?us-ascii?Q?O7Mw0YzknyW06MjlJK1uKiptn0OumnuUyPy6/OGX3JGfiiCqm/xt/7BCY+I9?=
 =?us-ascii?Q?Q1ubWKBZhWhzFBf+T+NM9rVOoP4u6PY3zacyny5qubcsp7ROZ3XPAnAmCCl0?=
 =?us-ascii?Q?76clJYqgve4EoDt/FoGI7ehDlfpzmAEPp+KKZPNSM3UDc7YCCqvPMoWEy9wh?=
 =?us-ascii?Q?xwRHv2XaS98e/O1Qoa/ndID8p7KFE+xcdBt8HiOVFAJ0HyiFbfhWPq+lBtQh?=
 =?us-ascii?Q?OK2y6TP5bA23HrT/s73jq+F0mEs7UZIkYYm7sry7f8d8s9/xC0UgVWCJyUYX?=
 =?us-ascii?Q?a2ZL2+QzevY263xUdumWxisAgphl4cA5FQdgE4XbbbCZ0rFmojc8v9/Q71lL?=
 =?us-ascii?Q?g2W3f3P9MYKKjw26FarnGIBRfI//5FPz6FjYlu5KrJVzKPx7rnxz0xDrMn9A?=
 =?us-ascii?Q?VygOwhrBxsAxp4Q9uzXAKyT7/ju6z5CnDdKMU4VoMMxaPMGACsDHyFWbaJPQ?=
 =?us-ascii?Q?FaGgJ7Pj7OGwJMvVL2fgDWNBIh7mCCIP+6KFATA/66EzR0kpHx8gKbchtQ9e?=
 =?us-ascii?Q?IquiG9DZHT3IncZHoKhffBY0gAVYlI3huqPoo4LOnlKM3cREMFIHKCkNAtmZ?=
 =?us-ascii?Q?KEh/LtnoZTF6rZ1zu7vCGXiGd6UyZGknh/CyNRm2bhnwTZ1+wfKeB3kBONh8?=
 =?us-ascii?Q?we2xc5EZDjWrOmgCMoawV6j+t5mIedI6W6CmrDQw+0bR2h6y9oglE/AaYlJp?=
 =?us-ascii?Q?6seEw2aQwYTY5f77qSAg1aGPgHtSPzpW2uSFmzuA58ZQdgL+cSN8NPLJzs95?=
 =?us-ascii?Q?i8UzV6nlqSqVPE6JQu477QlCcQtShWJIqqP6dcTVhas73LV5Jf2qHUYjXJ0M?=
 =?us-ascii?Q?SbQwMmTNnf7pVIVEy5QAmVDdN+tzdnpjg6xgdwDb7tEYuBjXNEkM+GNyUyWe?=
 =?us-ascii?Q?75NUN0EQxYZWUwG1ZfIEI/ZWTdNZXf+MVFVf9fnf0YXNF+yIoK7eVEaTNtZb?=
 =?us-ascii?Q?WuZ1k7XUyG8ublJRKYbnq7CpFOFMzaNkxkX8r+V97vQj89wGDX20+nE7p0tQ?=
 =?us-ascii?Q?xeAbCD+rsuZc4mqqTvtr+yZ+Eg86zkRI0Rk2injLlUGb5w2ZwItoPEx0vGMl?=
 =?us-ascii?Q?1G6L06WR5FR73aW6TzhwLrqy404p+NHFo80Iw+RpeZ5fJD024PHTEYDbPpPR?=
 =?us-ascii?Q?F0vItFlwOhQ/6QQJwGrkUvbDBejII/iKbXsVhzCDoNDBfV71XMkbeqvRI6gI?=
 =?us-ascii?Q?APv/6/ZTdVbxsXAfHgrb/+s/f0RbUOfWPgvzcziksIvd3+R4eTiIPrKXBdUk?=
 =?us-ascii?Q?PVvs7hBtBmA4ashz85/MYVJD9H+9bZjKbPs7JgqR9fy8xfVWQfKaZjpNRlOp?=
 =?us-ascii?Q?1qSz1RxjaAzvTIoHeKdybVc7tGYiZiPB+A3+rmVe+HqDKW8RQGeF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2863c7-ad5e-4e35-4afe-08dee7c10993
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:15:40.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PU3HGRde039zy7Z+zgKooNRFcN6VXPlkWPTjW4uvJxJEUepOYo8aHhUnOXRp+1Sy8DeDNYXvVOkrK0BEYTQO+SiTcg0+n3NJdEBO7NaqXec5xJgi618LIMPQHyLTu84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11523

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

