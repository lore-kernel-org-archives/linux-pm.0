Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DC466B4E;
	Tue, 21 Jul 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628592; cv=fail; b=nljXTp2U5UmAsm7J+4OxjvpVK29LrCYvtYNf4xfktAAcvi6PEFyOm1qyIQCEUgBI+3gRNIb9FKDLYyltrMVfY3zUBG/0rJgrMorM/sEk4c6hloghbMpZ02F2StPG6PrRs5Ye/gLRN+Whumyi3JPBMGdEUUfBbOrLyYqjNsSczUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628592; c=relaxed/simple;
	bh=Sz+6U8VxnUG6WFpiY02CVpNLT3h0Q2c6Kc9ih26wWWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aA7VDpCgQqcDkeiJGnj/ROPPX1BSx/hmm9tqU/fOykE3w2Yes9LlFnB657mBIqT7E6Wpt3sKytQoI0d1C4atYXZNo6VElfY+HIX5d0NeNtKt7ClPOFMhl5WsT5SFBKLjYMNgj6Jcxfe7qRCKjNWfjlLvmi/c2RicH6sW2Uiz4Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XkigFZUo; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XkigFZUo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+UlD6N2WYf7f90cLv7hkzwoQfu0/DkLy2qu7M4D+hUSmXM9bp5To/SsZvcZ8HNNcY7jG8pGlB3yPbF1RgZ7hZ+xqJL3wQIlsDjRj6tFo5gvu1rPI+eiVfQShAxSniAl+2kh7FREGBYUQqymmKk+2urqWOemY+0b0J98i8nglRsK8+J0IhXTPrJZQdh1JLohKwy6xOLVdLFwsk1gESPm4YwqndAPKqPeqkyJtEDBYpFL8cxfGG0LJRyjbOO0/a7DGNRg3FKYFLnimQr3cfbOtjHs8jgio7E/1Vxye42FGHPa1Amk4JkMyVWSpIdKa2bwxmsMlNGmc0PugQbULA9TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPCb5PthHM3LqOJip35JQf0oqFD311vI4NOd6mTiqco=;
 b=cq5wzgo94drQv4gHm8vfJ2tURMLUpOeTrCzjt6NL8eWH8eNJtZpPTGCNif2MJ73AxX3cnD64zyvzVAtZoV6zsnq9OWilSNd8i4mYjG/6xA/iJnShvLrEG6TFu+N3Bo+27sL61xXi4Fur7WOQ/wpj5O6+y4nFjTie2gBEHIe6iXMP6TB+ZD/513uP1How+g/0YDcTmC0YRiWGV/zo9qJVp5NLTzPzxH0vSCB4NLVumpCcCGpb4/N2XxXsIE0toHJ7k5dDMSsMsGtoShFuJJE9mff4IKlwd904eyJFsNnzjq75qML+zSu/OLztw8y7sCst7T+RJaUjwvMyjbbHQ2oRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPCb5PthHM3LqOJip35JQf0oqFD311vI4NOd6mTiqco=;
 b=XkigFZUoknBn+W2ZjFSnxeiecnnEOs25sD9pW8HCxzxXZAsuIWWcdXN9DpAiFRDqw7jyQhH6y2rwc/v2pwhym0CuLrP6KDImPrZ3H7tX202Use0S2W0JdLk20GaCmDFmoyt/Iy7+GHC3hj5opORwCb7TcFHiVl80a3S8b18e+8QoUldYwclEsr9JCkaaqxVvlUkBfC2JWlrlXoeeGW0InXF4T5r6N9wqHG2WcG79iDg98onhHxfi9CnOT/EmhLCSy7+cZVp57utOkiXEuz1JdtTcnWhUCVq9K6KZ78dgS/lwwmpNdKEyi6ydRf9m+Y22cBdE+JRa0pS44mmNhAKNNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:09:45 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0223.015; Tue, 21 Jul 2026
 10:09:45 +0000
From: Zhipeng.wang_1@oss.nxp.com
To: robh@kernel.org,
	saravanak@kernel.org,
	ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jindong.yue@nxp.com,
	xuegang.liu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: imx: scu-pd: allow building as a module
Date: Tue, 21 Jul 2026 19:09:17 +0900
Message-Id: <20260721100917.230923-3-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721100917.230923-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260721100917.230923-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3506dfec-a408-4e83-1112-08dee7103069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|22082099003|18002099003|10067099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	oWlDq5V9KakDvYELWrbcJcmONJcNzCi9bzh2xrHIog5/+jXwvaJoOOFCc6j9EhPXwjfcAKf8g/O4yrNxkWMFPsBdPF0ynzp+E0zzd6BeSg05jamgx8uCqU/epcvaWCn6TdTxy5ibDhxHrlgUzgFFJ6b+XDEdel1KXGgW45m996rFIHWc9THJPxlJz1doybDCEoKpb70Ou7LcP10I5v8xNnhllmN9Njq8rmz1lD/IBrn4SARaOrxQ87Bfs1N1l0SVwW3QZDzYTrRVNnMJ++EywU8SzhCGR4w2tceuDY2jB1YxPF4KYHLkm5IiZtts9TF1gDw5GZvQ4feT7UUx4wel63tKz8l3y1/1+AbqgK+zvMoDu9TQXGtzo5Dy2EVgDXkW/b9W40L/sT353LXaZ7jTWi4wH7aBButmq2xcUtvi5glx9BKAvYO93h+pLRjJFyWifac2LWnF1gpmJ1xQfrBfjjQIKNeTaHrKa9Zh7M0Icu/Lhq/QfJwsw17adz2kR5hPcG8qRyqUgPsKlhhdWGdEWTrP9tXbIqpoIxbmCwbh2xBIxUUKbWPUHrBsvalt13N+J2BeKKnVaGetIf41hNnopOTKj7+E5poVl7FbUH4ju2cj1nxgxP4x3xnP3dpA0tG93Y3XgV3ftOnd9mmEtHbllz6X5m6Xl+wRQnkVca5NoUc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lo6yl6RWiyeO5jlekvDaqmzsdNsDgscsOKn0OXKi/RTs4xWrNwFWVMnu8NVl?=
 =?us-ascii?Q?vejW7UDB+MswIoCCFfWPMgehlJQmK2wyc6RcWIZtVaZMN+0NpPdE5KO4JjwY?=
 =?us-ascii?Q?l1jKL9VcU07b8Wm1wpKIvNik6zD9q+kHBisp2DEOXozPAdv+CLRaRMKZUhRz?=
 =?us-ascii?Q?XqpMwW+HOsLFzaMK3uB2qGdZyerTVhNLCRk6iFuY06Ubb56gmKvSwnC1Qk08?=
 =?us-ascii?Q?CMXIwYkrGS+0WIcCC2VOph6TmVT8/HIi6GS2KGj13lX0Faatk+AoDZqm53XS?=
 =?us-ascii?Q?MXuj2NwLwDasVEjnIZGw9vja5BLUpwPbKfbdPQArKsYkdXqeFKCbOGrixaQa?=
 =?us-ascii?Q?pHnDtYIbJVVytKaqiLltkIYQmasptE/5VmUEiwyRNHMcLUjuWwPqXZLfSbus?=
 =?us-ascii?Q?fEaw1v7TMQv/qTeq5SIjEUtTnUuMJJM2s8mrJymudkDygEuDLv0+KLOpLY9N?=
 =?us-ascii?Q?nXB1BYWC7IhCNHQeNZ964e6LBrGmhNgBl5Xb22XYWatIAEFfQ3VunZMr6gx+?=
 =?us-ascii?Q?Cu1mdCdJ558PY+B+UWNY6isjpY1bSCQ2JLObinDLl0Gbyraq7q4N5AmLhzPW?=
 =?us-ascii?Q?W8gjxVDygyG/4vagtFicSKANU5iqJ/X8+SsDQQq3kRRAlPhTuVC5XG3IZzUE?=
 =?us-ascii?Q?Lvx1A7oAQ0O7YH/PRZeY+5lM6WWHLPgIoFmBK2cx//yLuD2Sx9mVLr+BUj46?=
 =?us-ascii?Q?3Rbol6FBbSrNrtNCSBJ7//J+fGkW5MQT5yyzmTTcm5FUWpGUf4sAIIm4bu/B?=
 =?us-ascii?Q?kSa8vlddgGvClRA4i4xVe/X+gu8FI2QJlQfMQYEAl+UouPKoQW807NtMfcdB?=
 =?us-ascii?Q?kUwsS5ROXXOAW71dDS3nIxEppo398V2QzImfs8EM3xmlbL4szGtf5w1fWMcj?=
 =?us-ascii?Q?Ey29UYNLmaa0uc2knScSaT52wPyEOHDuNTDVKoYK6ecOUqHDnuLWGQCbr8U/?=
 =?us-ascii?Q?ZHtD5Rj3I8vbeJ/qC4GQ+++q3DccsFuNO27gNXSkMYN3jSGE3UKnnRp2s17H?=
 =?us-ascii?Q?gY2yqIC0irgUGMMDP+4WaFWTA3AmyOwTHKFSmAj2IxTNueFkuSeBxz+WJOYZ?=
 =?us-ascii?Q?D3OLvEb/ED5awwUFgGGnOp3VOPhiaaIL5fhzuCkV9Cxx2Ek2BPtHhbKSOyT7?=
 =?us-ascii?Q?78YQzneIcOi78KwBRT4xr2pGPRWHTDaxHVbR4g5NH47RoMSigL74bC+69qTr?=
 =?us-ascii?Q?/ZKhi88bUS11Q5c2YnsMXGsabLJJta3JvR4wtJHAMIXmGUkqYa52meg/E6Wx?=
 =?us-ascii?Q?eUtIfLr3FnotTWYcC5VOO6b4IbzqlcN1y8IfaC2WzO0+VtwVlAvrJEAvOk5Z?=
 =?us-ascii?Q?8qsL7lLVpo5TekNHvEaKvwU7oVZBFCWZjwhV4yGDw+f6FWvDT5hx3ZhA8KAY?=
 =?us-ascii?Q?GvlZqwnnoDnEg0kIfjaYZay25NwLlmJA27Z/h/qJRbnRXOyn9PIv+U9c7AsI?=
 =?us-ascii?Q?eb6+E2kMou/7cF6zzlW69n9Gm95lf4JHS7a6kNGls2+xZLaBTF68xABioBGr?=
 =?us-ascii?Q?ODPuXP+ex3z8ZOJHBXLJlDKLsodWvjfYrtiOKo8y9dwXSnXdUpCRZ4jMtP2N?=
 =?us-ascii?Q?2Jn1Iq3RxdNdCxmkI0nexRdydofIQXDxYd1+6cQRIAu1JYOsTNYTsTX52R3m?=
 =?us-ascii?Q?1z3Sz5q73ha/AOSkk+A36tALQdy+s95l1AF24FV//FtFkcMK/qMsM1P7pmDK?=
 =?us-ascii?Q?VUqjlbIw8yJc9+YwkXwTyWlbVrDTqZhUhxLIaFo4dvIbCJpTocwzuFnDDFg5?=
 =?us-ascii?Q?n3nDPFhafg0UzGQDdnF3XskWtU39O8w3x9bSyz29iMxM307pzolg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3506dfec-a408-4e83-1112-08dee7103069
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:09:45.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n21vcMP3eCAPxsuVPmfaKV7QCl2lbZQrQ21TsPZIBseMySLLP0vh+T6kJPVDCzuiml82LXv5myIwba4n6f2w/X0Z5Y+ImyYbhClHCm5UfvjRJhO5aPK3mrVDG1KfQFs/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

Convert CONFIG_IMX_SCU_PD from bool to tristate to allow building as a
loadable module. This is needed on Android devices using the Generic
Kernel Image (GKI), where SoC-specific drivers must be built as modules
rather than built into the core kernel image.

For i.MX8Q devices running Android with a GKI kernel, the SCU power
domain driver must be loadable. Without tristate support, power domains
cannot be properly initialized, preventing these systems from
functioning under GKI.

Add MODULE_DEVICE_TABLE() for OF-based module autoloading. When built
as a module, use module_platform_driver(); when built-in, retain
builtin_platform_driver() to preserve the existing initialization
ordering.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 3ec33667a308..21c7e2505087 100644
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
+
+#ifdef MODULE
+module_platform_driver(imx_sc_pd_driver);
+#else
 builtin_platform_driver(imx_sc_pd_driver);
+#endif
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-- 
2.34.1

