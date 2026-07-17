Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944E2F5A29;
	Fri, 17 Jul 2026 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256546; cv=fail; b=OYwDvSO9oxzM+XgG84NqxRfOsTMhoBDurOsoBxO7nJ/ANdqQIuAunCtASIP+Lmsw4hVCqln4IHrkaRnW193EoFuqzXHhyA4FDHcET2y0B6KNOk2lXwKMH3PIcc5RwtV0NWcp1VrIrdnKfgd09us1H5PwRkqjqbWYyTgIPOBDWSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256546; c=relaxed/simple;
	bh=ROJBcd6Yy3rWWtZ1Rag2EkcVzFfXHmxS5s7SdzwTc4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GIwyLB8WrzgZHo4ddS1/Uq1Kbo+/87hC8MDlGdt9wFWlIKssE3oLZ3GV6Wc3+34MX/fLeH+lQxD5q7LqRIvq7WE47lfAH/y5LYdbm62lAlEK0Ibo5BXzlhdytf5ntUcNX/C4dbBGHwjGaREv0SmEsHzy88zI7KH/B30+vPwzYkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZLgcvov3; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZLgcvov3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBefqG+FWXUwJmV92s1FT/J0xwPlT59S0mAvpWfElzHnui23E/eLvqbjnieCvgchZjs0osU9z7A/Pr7iwJAIJrXIp7ITPmBsArrpLkxWfFPmAUs5K6vYw9O3/A/yNcCFBaf2OUv8oQO7SzQaQEhxwbKyceXuF4I3QW435iD++ZFqb+7NDhtYg1WhfhMk1PzA5XbZo9kq0GVQo9DkrN59jLvthLNI7vle+bkWnxKX7wPYH0/rVq0cf2ILm4A9VhqJPZGFJk2CvVwnuJes6VxV7sb8MdDh7R1xVg3bHoJgomWR0XqNoghQgsvJEqJKi4UjlcpyrFMxoDl38LMjGkUTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxBEU4MvMeVM6Vm0++C1uC5yOORNlw8Oh5q3SstrPL8=;
 b=CplcAE7md9iJiTKUUg5cnN1cLY2pHQfqsM9HO01OMzshLSmqfy/kMNxtJXkjdOscoEAbUsPPINdp4sH28cz2zwzrGljuH7h305BVaNBAHvrxosUNQNU9Yn99f8L63TsRUY0OidLLFSTXPF1mfa62HQVaBbEGanVFeb+JGf0izaufwRZ7Wknkgd4RrretSGjUVh+DF/SdkS/prXDHLW7ODa66bAc9rMNtW9X0bvX5xZ5I66X9wOKp+TeZsYxrGA4Me9PBnc+CX3XreWjNurtdxzSsuL5U2u9pGvH1cUs9ZOljdM9OEuy5aFKYN3bW91GrVLkrL7qFAm91Lbym0vCtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxBEU4MvMeVM6Vm0++C1uC5yOORNlw8Oh5q3SstrPL8=;
 b=ZLgcvov3YcxuawdQQCnq8XlfNNMIylYnOtB52WMEkHMFcNPKsDTGkHUGvjWApTKRm0Po5zjnk0N+4UTL3PChS+aMptwPW+wnAmUuB/TTFJsT+TrIsEwFl3rGMtiK0aC7XHvJ2yZTVswB+HLWitDQjfghOKVXULaIDoELaSKPfZzPRRlOFf57FJlCDRglA9xhc7SSBeXG8CTJEELjm7a72Jyk3uPIrUDb3yFgr3YU8shwPPW2iEOxP3eiIqBGKtfdVKZM4gfWt6IVvn3iEfZo4NQnjkCZ1EYh5meOpccKu3cbDU8ZaQQU68WLqMGyXxVn+MZsXZKnKy6hHXFHdVVcNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8504.apcprd06.prod.outlook.com (2603:1096:405:3d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 02:48:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 02:48:58 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pan Chuang <panchuang@vivo.com>,
	Laura Nao <laura.nao@collabora.com>,
	Fei Shao <fshao@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL DRIVERS),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Cc: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] thermal/drivers: Remove redundant error messages on IRQ request failure
Date: Fri, 17 Jul 2026 10:47:10 +0800
Message-Id: <20260717024733.374913-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c0ec1a-9f13-4380-d939-08dee3adf31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|52116014|7416014|376014|921020|38350700014|10067099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pQx9aTDciwY3fdv/LB0skxjAywhJDNyGBmkRCFVFW1FOv+ib+NQVtBYuBDA+Gau7Clv0LXi/roHs8qq27fbv3Ns9NJwJDmIwbE0vbWGwFm7RinGJPFCb8DL9PRW/lzm36auCo5AcS/cEVEyJv21kLNshNV1EBNO9erT20iIVaXYY3tK2LjYJSVkccvndBT7ypPIbDxSx5JngH6xQVK2ofPk56ju8ke7qyfehQ9PKagvSQf/548Mpc1FWyhmWJY68w2rhVT5ZEudK4Va4gSZJkp5DIEznUME7Gw5vLmW5P4RtOAgdTFPBPCL8fuE2y+gRFYBbHZ1PGTEv+350p+Fp2hVFPqZkEdLH5Agy4znx84/Uk3CbQbWKiLvMX282siqnf0/p10zt9Mogf7eYucmLXUx0fHomDLKVjHIS+c5n4EnmYmL5e6xrHU0HnYqHEg/vOJsIwJ6d/uK9m8aMovhhNEECkVJysImQPeX/QSHtEUJ2GWErgaVpqeKOmY4pJC1BaoPF/1FqxB6YTmKDW9oK3y1282wS7BrvvO8gKdZ2HfN2e65aHgHz4Vm2MXROLEmC4sGN61nnZU9jRnIfq1FcDHLhXz7lo5k/c/zC35vEWIZCpZ+wbDXxwAwijZpDM9lc6shMB/FnYxhCNvVtbDp3l72Ge51ykdlYqC6q11dsliHKLqETOWA+Z+K0fO5l3HtnV8eX4DR3eNZJmJhJLqqGdeNgfE3nNFEyFE94Y/TbHd9ztzQflqUaFLkrNfKEDTHB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(10067099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eIZ2kEO8stSwN0i6bFGwDgmL4kv/A6Af0JJ1OtpXa/K3aQ0+Gsyw0frJQO3M?=
 =?us-ascii?Q?L2i0EcEioms8fmhMldYBebDeVXabJAMmvyLRk4bh+eC5nP07mwVpwZ8suF7H?=
 =?us-ascii?Q?jTC8+WX0Pd7QuDOlydmRv+J2f0ybFnywHYy5HmYn1epvZJ2h3U9A3aA7vE4M?=
 =?us-ascii?Q?mdmZEFwhwyEspBvirR4WlxAIV+dwLVOIPEKkHC28TKT2DV1iR0PABcndIL+p?=
 =?us-ascii?Q?GWzfqCPS9AY8bwvJnxJWHr02zwvjDI2evG+W9KVgdGpKdMyTVH51fMAg+kC7?=
 =?us-ascii?Q?nTJOO5eEJ+RdPZiMs7Rp84YesJtGGu+YYkgK/Zo1CJkCseSlmymxq5zSH0DA?=
 =?us-ascii?Q?2vs3e8qZI4AHD0uYGFj3hRLnXbx5NyHINHctIaCSsasjriqvJF+FF6HQrm1Y?=
 =?us-ascii?Q?GSoHYjmCDuFpDa6VTB1qFk4u6ShJgSzLPp7sgPZpWMMxg4I1I/ZVVmwHlb/S?=
 =?us-ascii?Q?nk+XDO03vyJ0TV57Fz5TyE6Gg8ArVH4iW2d3cmuExfB4TdJHa6HIEXSmDjOZ?=
 =?us-ascii?Q?ePi1tbdLnnKXSQuTsPhDWBDHghwLB2LmjC91zz+EGQUUj8GoI5OFSOaCIf1U?=
 =?us-ascii?Q?3gxocIinCmfhqzRk/mILkgLqoYv7HjvMl4nqOrD/yDbasdfUrZO963t9FJzA?=
 =?us-ascii?Q?wPTH7Vl2d6oQ9TIgyBuXhFrnKnWux0h1n0iHtcFztzMCtvgRyRA09+tAjip6?=
 =?us-ascii?Q?wjvsCRhny3YOeLb9eFFr/MBX2kgHTDxCXASmuDLA7avk024YcI5F9N8/iDk/?=
 =?us-ascii?Q?KKD6d41aM7Lakz+T6xx4WxOQizyg8GL969VqKlca4NQDHBT2edPFUOhB48Ya?=
 =?us-ascii?Q?0X3LPWqfufZ3JlDOJAmENTa7p4KQKxK1pzW2uBc+SoRJd9IJOF0KYEtOwF5T?=
 =?us-ascii?Q?H2FvlHxobiPVYmMFrIL35L91O0rD3iKPnfn/vQ7jvxW6XXDnglbKPnjJ8iD3?=
 =?us-ascii?Q?57ltuGtXUBx1v8gc2U4gkvd0TUoRigS3sPS/l0D+tRyq3rzPnP5fOENdvId+?=
 =?us-ascii?Q?QHmnL007tB6fZpk6UZeRv5dodbcZLd0uS7uXPFgF2ev772zEGxyZTtvCWRhq?=
 =?us-ascii?Q?NVdlZ5aHKImC7PlGCJrJ39jk98xd+bT2FH8L6iSfx9aX/0vmLjAsktnRdSqN?=
 =?us-ascii?Q?ihouWkWxeXggLfvDTFyBqyNZv+q/Q6Xj2goOHbpDKGYgEFfSeo3Uzxhfkf40?=
 =?us-ascii?Q?ayI/CUReX5RNLwHwEBPTdi+y2yI9bKPn7WZyGATPtbVrRiEItE+bvPeYtsbH?=
 =?us-ascii?Q?yD3uUL/2S25C1WrTw+JUIUd82uaKnK5QHIa7iWQnSnnyeXegw7zReXecCqCf?=
 =?us-ascii?Q?/lliq13+lqeTyD5oLouussUii2vnXuS+lnbh9HdEgjBD+ieuK9ZoknF2KI1B?=
 =?us-ascii?Q?kZlCKchVhz/gq8mL1cs4Yk2DtWG+ioBmMi/lkSilOqFXOsS699W/WctDzMxy?=
 =?us-ascii?Q?WINHCcbNNLxTZqqC+52xgA/p+7ntECLx1xycYiftoNKZ3i4r1dePoDEq7tp9?=
 =?us-ascii?Q?Nbi1SWfV1QRfrqNiXbLXESRQaeYfmjMBeUjSPEG+hTRS+brr4zkL0Km/s00L?=
 =?us-ascii?Q?gYprrOcXSkHk3bgp3mMmjucGGalkVaUPaVCYTB4QPVzFXypz2P5KK9BGqiJ8?=
 =?us-ascii?Q?DiCv5ahtZeFOfUiyvXshU7yMT5JrUCa1h9E/65/KTQ3IfRKxrbI8cjj8nXYb?=
 =?us-ascii?Q?JhKPpjm1XVgJVMAFSQNRLfvGqJPewcqdmKRyg023y0IMtCdQnlhJWcZ6c7Ab?=
 =?us-ascii?Q?fqzr9j3MAA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c0ec1a-9f13-4380-d939-08dee3adf31a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:48:58.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDmfT3eVGpTCfnzJSUqOYvkzEyfz5gUSLoaUy67aaRecoEoP3WPykM0OA801gtQdz4xPEqBPYigAsQ/rB3jLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8504

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/airoha_thermal.c                          | 4 +---
 drivers/thermal/armada_thermal.c                          | 5 +----
 drivers/thermal/broadcom/brcmstb_thermal.c                | 3 +--
 drivers/thermal/db8500_thermal.c                          | 8 ++------
 drivers/thermal/hisi_thermal.c                            | 4 +---
 drivers/thermal/imx91_thermal.c                           | 2 +-
 drivers/thermal/imx_thermal.c                             | 4 +---
 .../intel/int340x_thermal/processor_thermal_device_pci.c  | 8 ++------
 drivers/thermal/intel/intel_bxt_pmic_thermal.c            | 4 +---
 drivers/thermal/loongson2_thermal.c                       | 2 +-
 drivers/thermal/max77620_thermal.c                        | 8 ++------
 drivers/thermal/mediatek/lvts_thermal.c                   | 2 +-
 drivers/thermal/qcom/lmh.c                                | 1 -
 drivers/thermal/qcom/tsens.c                              | 5 +----
 drivers/thermal/renesas/rcar_thermal.c                    | 4 +---
 drivers/thermal/renesas/rzg3e_thermal.c                   | 4 +---
 drivers/thermal/rockchip_thermal.c                        | 3 +--
 drivers/thermal/samsung/exynos_tmu.c                      | 4 +---
 drivers/thermal/st/st_thermal_memmap.c                    | 4 +---
 drivers/thermal/st/stm_thermal.c                          | 5 +----
 drivers/thermal/tegra/soctherm.c                          | 8 ++------
 drivers/thermal/tegra/tegra30-tsensor.c                   | 3 +--
 22 files changed, 25 insertions(+), 70 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..b1c2bf28a90e 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -444,10 +444,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					airoha_thermal_irq, IRQF_ONESHOT,
 					pdev->name, priv);
-	if (ret) {
-		dev_err(dev, "Can't get interrupt working.\n");
+	if (ret)
 		return ret;
-	}
 
 	airoha_thermal_setup_monitor(priv);
 	airoha_thermal_setup_adc_val(dev, priv);
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..44910a953439 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -913,11 +913,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						armada_overheat_isr,
 						armada_overheat_isr_thread,
 						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index a9ffa596f7c0..5e23f9e00847 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -356,8 +356,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 						IRQF_ONESHOT,
 						DRV_NAME, priv);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-						"could not request IRQ\n");
+			return ret;
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index cf1706569e6d..46005b476722 100644
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
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 4307161533a7..17ed0c5b7767 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -578,10 +578,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 25915bb702be..274eee303142 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -331,7 +331,7 @@ static int imx91_tmu_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, "imx91_thermal", tmu);
 
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+		return ret;
 
 	pm_runtime_put(dev);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 5aaacbc53478..416d89c6287a 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -732,10 +732,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(dev, "failed to request alarm irq: %d\n", ret);
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index c693d934103a..c5131423ec9b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -308,10 +308,8 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
 						proc_thermal_irq_thread_handler,
 						0, KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", irq);
+		if (ret)
 			goto err_free_msi_vectors;
-		}
 
 		proc_thermal_msi_map[i] = irq;
 	}
@@ -394,10 +392,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
 						proc_thermal_irq_thread_handler, irq_flag,
 						KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+		if (ret)
 			goto err_ret_tzone;
-		}
 	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..aeaefbbd5d8f 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -245,10 +245,8 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 				NULL, pmic_thermal_irq_handler,
 				IRQF_ONESHOT, "pmic_thermal", pdev);
 
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 88f87badfdf6..4d40fc706a53 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -173,7 +173,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
 					IRQF_ONESHOT, "loongson2_thermal", tzd);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+		return ret;
 
 	devm_thermal_add_hwmon_sysfs(dev, tzd);
 
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 85a12e98d6dc..f4a1535f4806 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -121,19 +121,15 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a9617d5e0077..d357968f362b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1491,7 +1491,7 @@ static int lvts_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
 					IRQF_ONESHOT, dev_name(dev), lvts_td);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 3d072b7a4a6d..99396b93eff5 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -223,7 +223,6 @@ static int lmh_probe(struct platform_device *pdev)
 			       IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			       "lmh-irq", lmh_data);
 	if (ret) {
-		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
 		irq_domain_remove(lmh_data->domain);
 		return ret;
 	}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6e3714ecab1d..b5ec70201e2f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1258,10 +1258,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 							dev_name(&pdev->dev),
 							priv);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			*irq_num = irq;
 	}
 
diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 6e5dcac5d47a..cf80e2655416 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -446,10 +446,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
 				       IRQF_SHARED, dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n");
+		if (ret)
 			goto error_unregister;
-		}
 
 		/* update ENR bits */
 		if (chip->irq_per_ch)
diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index f0e29fe633db..c44f5b8858d0 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -461,10 +461,8 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, rzg3e_thermal_irq,
 					rzg3e_thermal_irq_thread,
 					IRQF_ONESHOT, "rzg3e_thermal", priv);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ: %d\n", ret);
+	if (ret)
 		goto err_pm_put;
-	}
 
 	/* Add hwmon sysfs interface */
 	ret = devm_thermal_add_hwmon_sysfs(dev, priv->zone);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c49ddf70f86e..08891608baa6 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1773,8 +1773,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 					  IRQF_ONESHOT,
 					  "rockchip_thermal", thermal);
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..56717bb50d60 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1102,10 +1102,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_RISING
 						| IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Failed to request irq: %d\n", data->irq);
+	if (ret)
 		goto err_sclk;
-	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 8f76e50ea567..e3dbe4df80cb 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -101,10 +101,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 					NULL, st_mmap_thermal_trip_handler,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "failed to register IRQ %d\n", sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	return st_mmap_enable_irq(sensor);
 }
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5d8170bfb382..3290da7ab607 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -390,11 +390,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 					stm_thermal_irq_handler,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "%s: Failed to register IRQ %d\n", __func__,
-			sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
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

