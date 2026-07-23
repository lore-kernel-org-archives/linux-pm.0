Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5933264CE;
	Thu, 23 Jul 2026 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772389; cv=fail; b=Ix3YdADL2JBM1BNt8By13aTxbzheLneKM8oTPL2kF73YzEqHbZtcURRJtFdopjAaRemzhTAbfEWSlHSWgAgGsr1Ad0jndemUKUB1kyOOTs2rRxs2SZ/xKQ52GiT4P0wWBhNF7hxXd1gGOnF+LK1uNMZO+rYlIm+xFkMOZKCuXaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772389; c=relaxed/simple;
	bh=Os7jfviaDVLDT5VOxO7ti70kH/OVQexg5nga+n2DOl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNuMKyaQsJ8tD7Fhs5HLH4Zvi2nBS8SKKYN6tTqxh7uSozUtQFzcW9kP07T6YMn/wXQPuoa3OR0O3rukAUHXqyQZKR7z37jiR1jTPW9b2bxEIHKhqmAp72Q6t5FwJgneZP/ZwCh2CquY/7gHjGMrD4wMgv7kRXeS0r5Ul3ATCYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kZ5993Kx; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kZ5993Kx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNZcSfBvVDDo5hU7D/DC7QOQUSQC7IKdzBOByv7mYtnes/6YPZKbQh1Hz3f14ldOeE1y6uo6WdF/dbhz9IgqTrk9mG73sG48WYVURzLnTSRO38al/aKRdUstJ1SlJ0L/BypRDrgSVxRHEjKwTPmb60OMknGHAVo++MYKITCQwB8Uy1bzdTM2lhPMHtXLeyjStWB/JLTMK5+1hSotbCdcgKf22lp1PEhS7LdAe1HpjV1m9zjDe0cTeMxVPAHPYulGX57jIDSKFJI60lnaKdS8MIt7TpKLlTKFHeqV7Uq1O8suhDFoow/MTvuTHXRoTwiDQUHmo25t0L95mO9AnmTizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIPKtroqZpvhXYpTbpoPhGwzmrUHIB7e89/hThOd/hA=;
 b=EZewqSkKOC1xYgoeqhQ5BjMuv1ab6Wub8pZpWukEzF1xrXlZu9PA5wkHfhEktRg88BS9ExpUP/pfuPKVoBU2VRBTz9V7WhFqJ/l9qpC7ehoVxTo1fj4BqxqNUZFgPIV3pMVcKVYfZK1Kn84Ry2ps5Mpi6xb2zx4YwjdU6ifDbVCzcqgi720YqbjTnh4p1/rI2VEw9oU11CmwEr12wTUxvBI6umiSEMJLTo2SKJoInk//788UO3F3e9on0Ovms4Jz4XifgmFqVPq7bgs0to8rFgqpDIFpWV2zABrF4eiSoETIM6J7qKwE005XXeeLCqAQmGAHh6e+LBGA2p9nwUEXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIPKtroqZpvhXYpTbpoPhGwzmrUHIB7e89/hThOd/hA=;
 b=kZ5993Kxc0x9GAkXyMi/Rlqxjz9VT8qD5cSpwlFgO5+W+eYzO1wB8rb1cRrt1RKMVeFitn5FAfEqkdf5L62SaLzsz/DGgHH4vexAWSBugjnqib0CFMybP2xGUdamD3sN/C3Vg+YIMKQAsS6E6P7DlawOYRS4qwJWIEqyQ8noweRI2TRs4qKFaH+BIE2tNf2ffUAXPvlzTieyR6p/W6ueAPgf+J61s/kkreO0CAfrey2sTwXBkro1IyR7IkTkFjGclq4OD42AI8416lzsls/1R4DvyNVG70F1C9OE7LueJT+8DjjtSQDsF72PKRwoPR4S6lsUniEHchf7iz+rRh8KUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:06:22 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:06:22 +0000
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
Subject: [PATCH v5 3/3] clk: imx: imx8qxp: add soft dependency on SCU power domain driver
Date: Thu, 23 Jul 2026 11:05:24 +0900
Message-Id: <20260723020524.1886806-4-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: d70196d7-d20a-4184-5198-08dee85efe14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zXyLZP7FozDG8kJ1if3lvWZezhVIX9k5OyvCzAU3q6derSDxHS9WXJaidtKCUn1U7kx3DExMjkyZcLucY2PbZvaAsy4ovsYsCR6Eu8pnqsapoBGDu899boCk1I9pHCYZvIwbS8KwviEBVZggi3Sjj3bXv8C8WINKTbjQDcEffju3Rb1RMfTYC9RCna7u41Uy/fl6PfrewS/v2t2AZYjeMiL/mIt6UpQfY86SPWDum9u40dDftWoX+urK4Z5y9nMzzoNzK9QBgcri3VBx60cBZwG1SAt5r43i+WRZkQw53AjJTfC/8QKJspr5p0YJTDswUENSOAvzubgZC23CQb/AvAZOTD/JoM4EMU+N1Pd3KuZIMHiRGue9GM2ap1zFD1rfnjBWaEkTjbR2mJb3NcZN8IDl1onEJ52+O1eE5Ifnk4ARGBYT3dFNoGUyQyiqL6bnR11T23VdWslAToLD5l6XkW+eJ1XXWHY0uWfLOPjzJpYAjf9pbjPt38BdjmJDzdBvIup7lxPpY6nhNazvlUz8xwn0eDP/5OMuqP7s1DBQEt8Zrt5ZP6mkVm8jdiT8ZARqtlzEjogcUGefRCaZSbcqVCnLfbMdn7hoxD9qCU3raIW01Tp53fVZLoqzXiIBttLYfcj8AXb02oLSDbZf3fMXPYaRrQXQ+3Y4XAiUWTO0N20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IrP8Ro/MMvudvprwGZeuKNsdJt5r/Bf5V53HaIcp+LUus4TH/QueZ0yUy+j6?=
 =?us-ascii?Q?K22+euxriPS493dBkBfi2aU+xu+WIDCo7b42sfds/CJdSbW1PliCTnjIXr/H?=
 =?us-ascii?Q?1YWupi0KuzDlaV7fuiJ/00YXB1iLnafh+fBJbFC2KhYcGSYQah1EdurDl7X1?=
 =?us-ascii?Q?YXo8URbbyzfUvBqkKwxShZQmTvZsvAh/RdKknKvv2MC8S+uw4Gs0vFsHeEzL?=
 =?us-ascii?Q?PBIhNLgysFdYKToHbbLrm65grnylOAWBfCAFyIw2/KfMoajJZPGlD32XjCkT?=
 =?us-ascii?Q?8f63grIPuhytBjJn6j2CKKoXPaFhE0GYaW/i9PcoI2Ze5yfZbN640hKECf9q?=
 =?us-ascii?Q?JtoqHJhzUVsm+VHZpD2kuIuEWxFeP8/5TLbKJcMwr0elOvkVPEOziRU2ZD2G?=
 =?us-ascii?Q?4gDBAdBTazSiLBGg9GLIW17+BgydJmxhSn/Uk1djTJUWBnJMy4HUQM/o3YAn?=
 =?us-ascii?Q?3UtntvjKgB+I3jbTOg9sZU01VzBTN/ajivx5NS+ZBpex0Mv3g3UG2ciCB9hA?=
 =?us-ascii?Q?CuHZpGuyUAXACfOKcjJquZ9qU2kD6KWqCFJEqfOvtPBapfWSI1H5mgAedGn8?=
 =?us-ascii?Q?6i5VtpZpWgyRx9jTLL6TQQnS/JROUzRwQPoB2BqmvQtQ+L1Y9+le0MwmkBRX?=
 =?us-ascii?Q?mNZMMshWUjT6LvjWlpF5IqvliGk2t7cyQk3tpNcqPoIUiVHYPYAqne9W62Mt?=
 =?us-ascii?Q?kGI+cC2b1IVMzwhvy28Qhz9nH72d/IZjnTwiqxqiyU0qnUt1Pr+X0iVS4dym?=
 =?us-ascii?Q?sZvQud8YNuwxAwz4rW+bfGQTnV8Q9uJRrrUVs4PJzvIlHNG4Gv8iWe7RMDH5?=
 =?us-ascii?Q?1jHioEjHdAQqWH8pdw2U6/p5b0U9/Y9FICuvLIpAqYWAjYvED9FSffcSw8xo?=
 =?us-ascii?Q?iF1kSneKO/Q3Ylfq4DAQ5LQcef3j+pzaOYJjYI9/xpW/NyCDkREKzehXghtz?=
 =?us-ascii?Q?kNvAiPjcMFonZY9QxcDqzTsffXXbtSDwR6tc+pXpSe/t7QR90f5I/cxvV3CR?=
 =?us-ascii?Q?1R04zfmrcwjHE0dabJsL3AEdBFEP2gHzCHHrSs+kj+1N+hdTSbMVBTUtpTq4?=
 =?us-ascii?Q?ekTTC6VDpLy/uua2ZsCbhiWYMCaFA1+4k4EtGVWtV+ufi7KcQK+2Kahkw07y?=
 =?us-ascii?Q?rPyPt1EZ4cneBRt+pH8jcyo7yBtZUoVayh/hBuUC0c6ngknizHXYH8sAGz8c?=
 =?us-ascii?Q?H6iIGwxrBSyZL8Ljl5SpevJQjYHjrQWtd0xWo3uoCmzKVbdYD0pbNHfzj4+W?=
 =?us-ascii?Q?ORKKD+w3crWxUqqnfVeIJzZlSL1xrQyyATeFL/rghTgDP6RDbq7vTuLYOWhI?=
 =?us-ascii?Q?u2oWFFjpHFPcsVnvFwHwgcIarle2mIcEa85qTPxoqHdQtpLyewF7T0y3EOip?=
 =?us-ascii?Q?o49aixLomgyMFCMtEV3b5O7mLONoXeVR+1vFyd8pn1MtxZU0c0y7jp882P2M?=
 =?us-ascii?Q?zqesxsBDfrT/ki82ozyMR7ECNVNNFtgul9oBoMZHvup48XYc7GqlLU9wukLG?=
 =?us-ascii?Q?m8vVSxNRCM1NhaeWMczFrjlM1vbFn/GPaiw+3O3AW+g+FzFO9tiQjyIb3EeL?=
 =?us-ascii?Q?A58dMK5r+GBWteiznPMOWl1ny84Dw2WH/UVQ+78xbYkoA5+KIqDqz/ED7PmK?=
 =?us-ascii?Q?bZ+VAaHRi/CwMr4ftgwBF3OonDnyWbXkYP3TMBR2LBkhsL1thEp+gEvrbZdi?=
 =?us-ascii?Q?QImOV8V24qQtkioUdM0EfKI59P1vc5WIfPX6t5P0XbLZnpD7ABULlBkJuP+E?=
 =?us-ascii?Q?jEJ7tbLZL/PhXpITUHZYX7kDlNaoP165HUaqVh4Ruovao1O0aP16?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70196d7-d20a-4184-5198-08dee85efe14
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:06:22.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iOKP4s4tNkHME1zhbrHLjPaTKOd57n9QAxTZPKePVTejjM+rXZ/IG0GQcQQ1UWhVZfMqfcBlSHwM3A5JN5a2+DhVXmO0Y7k9FV/laXd4wVaL18EVSnokWbzH4IeU2fE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

The i.MX8QXP SCU clock driver manually attaches power domains to each
clock device via of_genpd_add_device() in imx_clk_scu_attach_pd().
If the SCU power domain provider has not probed yet, the attachment
fails silently with a pr_warn() and the clock device is registered
without a power domain.

When both drivers are built as modules, there is no implicit
dependency to guarantee load order. Add MODULE_SOFTDEP("pre:
scu_pd") so that modprobe loads the SCU power domain module
before the clock module.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index c781425a005e..17302ee628b7 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -373,3 +373,4 @@ module_exit(imx8qxp_clk_exit);
 MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: scu_pd");
-- 
2.34.1

