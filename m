Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499072BD5A8;
	Thu, 23 Jul 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772379; cv=fail; b=qjOlEQTRX/pY6PoTWgoj3JrJUm/T1sSAs///P1VFY8GYFKEYTVcZKtY3zT756JfbJXPMPqi8znXKl65CrVuXXOkkBI+ihrFSxzgCORHit8L3bOT2RbZmr1EBxCmidLY67mQdM3UKb7jReedbclbyG06KI8FZWWfQozVLQa6kV5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772379; c=relaxed/simple;
	bh=VmFVmKPpLlUjA34zmWzrOZKtlvkiLisJa1BXdPRDBRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6C15FAhp8ndfqepXfU7Z+wHwTK2l3mU/BgjktqtrRALI8wceatFXPeFArVwehvGrx0q/KTIbMi1ZDNxJTWP+Ot1nFKabHz4AzQlGpUciGj5fK2rzp94DI2/26Alz56zpUg8Exl7nIwKWlvsuoT7X4u61Kp+hUJpVxq+ROBnd6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mOVFgoA7; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mOVFgoA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zjs0LqrxZqJM8Q71bF0Y4z3wmdObdEaJTwCXS3ZUUUqZn+ONu0zWfkubSrGRarvWqLXlITruaVVXVecKT1i7dtRCFU6pt1b5WN584FgI1fU4fO5lPgR5xuibphm+lUDMfaDz/ua7Vz+RoetAXB/AGUr+dohTnL6bO8MATpPIKkgXJVbpwTqv45tuIYMYD0TqduZgVI/AT2C3irQSJOlLF1ZSKIvBswHN8for4gX4r/HdEABgg/NdZeuX2UwFlwmZZaQmeoL3cG99bxJRe/ufkpLV5Zi6ebaDa1ADnQAdWgvDgOza/Mx06/dauSwSS24//HkTzKn1GPvPJJmRYkXnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=kl756W+ibjMPjCcAfC6A3TYemh2tR3BpwQXfg8xsqzbr4fvPta6Cg+9Ghu9/fyM3NAKx/1LzurchMUpBNU6qV5htKs8hI+Mwhh0eTahID7nQg55Hhwfg28ElsjF2aoye6MEkvfUlPO+b8qT9ZF2le4hNz+XjUn9G1FjnipHUdW6E4MWGAY55b7VEE6X638RJ/F+ngq1LuZOOeT6+Dc934A7FphPs9uCekc4DPJEC3KDJQG3ijCnAE2ISJc0qnzwfsTaBxTG/z++yRUTNspp48Twrbu4BI52vGKYAYPnSE2gOyY6ZmraOx+MiIlpbs7dG7mF1UoBoZZxwMegiGLql4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0egRuN5Dmr7gJaWHYdDui7Y+hFn26oAjmmAntaO3KIk=;
 b=mOVFgoA7xz5l8pWpUf8ewtHEy4ViD+3TFfHQdpreajSVr2KAA6Vnf+mgyry1HhY13JCFYySRemUP8aggO6RGuDrjwLUnK8cMuGtN4aCphBSrV6YjLfFCBt2NypX6zus4wabapj3llhrnAk/Y8b6TFrt9nXkBgR8y15A/Pl2ShjHWmSPL6BEbaDdA3xQ0/SKuu2mmz9vZ+1mU3iwJgffrkWSRc1avMctbN+ZLQzZRI42Fe8m5TjtfDQJLZm3nyj10WrVAlOMwe01QqvTdrJ+HZlaJnq/p3q2a7HRteMScpHAMNDddDPGDD8c6eWMVquCJvsFhWJImAF3ecU8x4EahSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:06:14 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:06:14 +0000
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
Subject: [PATCH v5 2/3] pmdomain: imx: scu-pd: allow building as a module
Date: Thu, 23 Jul 2026 11:05:23 +0900
Message-Id: <20260723020524.1886806-3-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::12) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: 123ebee4-6f4a-4ec7-5eb9-08dee85ef743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3PXwXHohs0gFSHvxyF+ac1G30nDrC8NEk4aMRsmfWaZ1Xf9isfN2OhTpeCsp+iLWJOCj2C9er0ZsWTt+xggRUbISevPpUVdWwLGLc3WDDE0/oKIAZwCB/vAZ4I4X+xUGGq2RJvdQNP6Q/aTvytHr0WscCewC8cOliXx928EcQxaxeGB5LsKVIy83wy2ofqBiF2Mgf6KmGfEmKFRQhCOSAv621GGBR7yODbo8hSQ9gHhHlqVU39S/Y3qf5GtZOdPobwABPZ8+Z+821FznXfE04MSHFm2YbP+EfgCNy1hlzY2rdJznvjtwCI7PEosW4tnezmlSmMZJKBP5tbURyTaFDjv5D0/p/krQQGayCbrUbE7l+7l8qIGUE3GRJVi22j9mvyy6MVzcdKS7JdGaiWeeF2xKRVSumZCI3TiCSsce4zgO+AnSJIa+3IlHjIjD1J33D67MFwYB54onXM9x4hpBL2E3q/crehDBJBNcdUIDfQME8nk+EUh0Ylrk39GjoaPXXoCW0NvZalou8rCO9n7AQ3nRFF5VTIRWAxA6ERsHOX4V5Y4Vn7mnBYDdcA+UtVMLLxS41kVV4GoexW1H8GdQtx4FsAeGQ/X6AdFT6/uGpOUIfLFlQMYQulRD77wZ0pDUwrP6zzpxC0x4UsdhwjhjDF1Cji4F/Cx8fvx7njkAO1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRGxXE6+sfLJOoijJDVjsYCGJF1u9yG/fwAWU3mWEv+JdG0+Wzop1YQZnYVo?=
 =?us-ascii?Q?q5B3Un3eIAoiwfPHNrd660iqO97G0vr3ckrR9FhFembpgz+rrCcJzr04jY/z?=
 =?us-ascii?Q?lmoxt2izrTr3GfHJBg30Fd6OlhZ9j/RlzHnKxNK5lOPZQ8lgxDvJbf1Ig4V9?=
 =?us-ascii?Q?IlWkyrMLssJVdfFLfPcsKCp6N8PuvSxR7YzoCftCxLBJO/UsntfocawqhH/A?=
 =?us-ascii?Q?RwUAXt42rkUNSDslrKSP5hVn00jLsj/FKlZwIA5fLH4kSHIBK6TZzveTS4Hp?=
 =?us-ascii?Q?fFfYJJoXHPPqXwnHLiBACytA8EFQiwSo7nHG88nxzA6hmBAzsiyy4TcE/B8V?=
 =?us-ascii?Q?fG2q6Ys0tm0aaFdfKmXHYJOGCm9J5Pd11zYr9l01q1FGRbY2gb02LZ2JPHp2?=
 =?us-ascii?Q?cjWbjHPgbP6joO5ihlMgR0SFrTuFqAexDmkvCj7i7EsyCTOfSRzV9B+Gb+fi?=
 =?us-ascii?Q?WOkbFIzuHa0UVBgT9pfx0hDrt8LibmWQJ/vizgpZXKRSILTECQf1ZqJrX+Mv?=
 =?us-ascii?Q?DcDE0fqxk8asPDDISUjZxt3pNMMxYl91oZAHrO0Eo1H4fxADmiYIGkslofLS?=
 =?us-ascii?Q?kDFbgLdWyriKNyAV+lf8TUV3de75A8q2hir6D0BqHKAkBxPxGWMVp3YyRb7e?=
 =?us-ascii?Q?QUbiDxXCHeT6fOkUC6teeeUwSVM5IOvYLHAxtgVaJuvf6Ai/FreADMVja/qv?=
 =?us-ascii?Q?WMvWk2M/fC3M9V5c65dhPwqfUy435pjvAFwRKrv5idAkv6oF27Cp2wdwn0am?=
 =?us-ascii?Q?NZAWc7FGtGSFtWmM1H4OSBQocpQGt6vpKE6YFGbA8fM1cqBL0APRWfXnm5e9?=
 =?us-ascii?Q?O0m5qGO8XPR0fuQ9ofZaIWsuDcSPLGMr8flMIHKa4LZgOlosxblUP9x61NSq?=
 =?us-ascii?Q?gDD4CfZlSTsWOZ2ydmlWBRmOn7t2TXDAgNwJYwONT1T+VOor13D/711QvMBj?=
 =?us-ascii?Q?RBEHvRwWl/S+kEDKeEhB3qdIoNwSwUFHsBkTJyyELusuV3H9ow/RgVaB20Qb?=
 =?us-ascii?Q?eR7Zx6Wd0ll7fWG6gYofJ0KRS/HUIm+Hl/jrmgdj+so0CrHMHvVD12q1iUU5?=
 =?us-ascii?Q?jKv9Qn8luLFkJ3pb7OZ4kbP08+YeNgEyRB+aut4BstzNkHmhcfRSbtwB6vZl?=
 =?us-ascii?Q?NA7lCuLjqz7H1hEgHgFnt1BU40prc2Y7Z4PyEHXzhfjM47G4vewI5J9CVTdT?=
 =?us-ascii?Q?d8mFH8ud9XY6Qk8PFgRPGYjPt83LsoRE2XgxnJsnGXHOBAUVUZk2EzgaQU1G?=
 =?us-ascii?Q?qkxoXP41GHP0We5MiEf3MuFze63AANrPmYAiP8tWpsudd513J9oPNI69SrSK?=
 =?us-ascii?Q?iGz4DKNjD0EIZ8ZBirVLHPQ/OW/Lwb/92UKZPTfxZCR7kZpERRPaGRlJVn8B?=
 =?us-ascii?Q?Lm6QgEHuebzyGOK6OPiPaEnpkPTM27NtT5t7dKnU0sgp0H7vVzbRHwu9kGMK?=
 =?us-ascii?Q?DrC54MyaX5Ji+KOgcJG3oyHAxusCJHU0W55RuyI6HISo8BGM3wPbMaCzHyap?=
 =?us-ascii?Q?r4pLn2bMC05lVjYnqHTNLRBcUu7tVCNwkpvDdxle2U/hj/1gzeezMmKqBfLS?=
 =?us-ascii?Q?GwEACd3zs1Jgpr+L63Xh7FnvEGis5pcLvQV7zw9ZUd2vgC0AvnVmXc/tzq7z?=
 =?us-ascii?Q?OxAhDMEd3jsNBZPr7nuyumS4Op+NO9w+/KvYrN61QNVnFBvdUKR5tToZwIiJ?=
 =?us-ascii?Q?Gt+cVT4Ibz9bAjQMvTxpvtEZiRervhI8B/fRUl86d/7dUE9MWgIuGyeL0Hpm?=
 =?us-ascii?Q?+RB8soYw7VpY72vhr5KNdXsM53rDOLqsSdEeOaGbRYBHSJCvtyi1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ebee4-6f4a-4ec7-5eb9-08dee85ef743
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:06:14.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+BM5qMEAtThsPxw0ycpgDi158oYzqByM/dlBeSY1l5eCRitKABvMglDoZ6boms+kvt0EGsWt0l8/oMgLoAtNVMFgDF2eKUSmUHxvfgZ7jSm/Je8L19RJppIeIdN/vCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

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

