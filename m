Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2030E0FB;
	Mon, 13 Apr 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058276; cv=fail; b=QED+9LpQK25horjbJZtstjiYmFu7vELdPO/qkN4J0g97CWqJm2JTdny7q1CnRFCaB4sEi0DNx9Ggcm2xHHwDyk91sUm5C3Mlh/3BYSGNneWFY3CPQ05VnJhX3grAXQlXU2VkXwiC2xwz7onzVl9UfpErakymHczZPwE6vwk0+mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058276; c=relaxed/simple;
	bh=HyR5P2Gc4wUPCOQfLOXCduNgiwehZ1qB4JtF4orIZy4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c4sRvwVbHow95Na667UA2DdqFrMqlGDyjzHDFSmd+vjOYt/TQmcPuWyGBNONyoTaooCB6DZBpj2fAAbQa3gv8HIl3/EVMGqaEDcoySPlRUlqhML0eSlKyoYI8WnZJOMt5AaaoLV5n/cz4bmCZ4/9lF5ZVL3IuHXVQEpFDuvG/6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NjL5I2+R; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NjL5I2+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bno7emAf/IpLYlcQezTJ/EueaiMNmlSZBSNPKPt5Zn2p1vGhO0pAf4XvVL8zG4gsx7695yZ5LIzikw647awKI3IW4P/vFYlzzcH8JQLGbaHbbiVjwIjvQExmQcApjSpZDVTbqVfPyadfaNpyBQqW9jOjk9UhbUJ3PFzTVU112j968pPNdUHvbwiKuWoWgGitmQsHnkIvjuE6Yzl3zHmBGQmqOhw8xQUInxBsHOPUREY/B0VEV/e2ZqdWJL25cEMj1sVlD7j4476yR+HU2s6nbQKMCJUVJkN1WpP0X16CR0M9Ddkupqae3OiDU1+Cyke9zLsfJw/AAHFIIR7QzmFpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFFbZddEUWnto0z9mZ5uWHbGYvYfsM4VFXwy822Ud84=;
 b=Ouce0zWrVIMG0KulNY5d0kiFnkTd3/ygQPlpSgw0tw3aE/BpksoVbL9gVrXrCPO2IJcRC/2T+wX1pIFCa4tqABHo4opJXNK0Vdss42RDq6yKuFpHc345Y4MFVr2J7W8PwMLdWX7LaJpZhC5levvIsG2EO2I61c+gUjmvBz5d95Bk3PxAmQZkmD1jZWhNNM6SNlmqwYnpPwJ7dNPyTNacoIkNyfyYYJUuNBt8gu4T1OdQ5d77Uk+BSJF1Zw6voCos5c/JFhPuekvAetb1DZmKenmIeH4UVcveIjNGxIdBQKaCdva2pZiP7IYk+lc/IkmQ73SO63oZepR0vXFegMi5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFFbZddEUWnto0z9mZ5uWHbGYvYfsM4VFXwy822Ud84=;
 b=NjL5I2+RIEy+4ce0aZ0HaBuEIlqxLgWZxsk+oqGRL5EAglm7IEEuxYbmkmPi6v3tZsHFoDWP2EXFMkkr+RXsU0NQcTJPIovdwfAuzPJvZqWCpv7lZ1OMxSVPUVoTNaalRhvNlveQGU9Us4qDNgk41eFXplQ2XEATAoo757LZn4N9QTiB2QHUmjIufaD5OLCVebMXzcpTrdJ+MOjcjvUYgkBu+ZTXyKciEgjPZGvdz0FaJIB5Imn87baABP8fL19sdf+kRtHW5XyV2rPkGO2ZBNudUACrAabPgx7BR4HEWBuLkDGbmq4rlN8MwKys0HZg348lGc2AdOkcjPdKSkyCiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by PA6PR04MB11948.eurprd04.prod.outlook.com (2603:10a6:102:51b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:31:11 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:31:11 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xuegang.liu@nxp.com,
	jindong.yue@nxp.com
Subject: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Date: Mon, 13 Apr 2026 14:30:49 +0900
Message-Id: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::7) To AMBPR04MB12334.eurprd04.prod.outlook.com
 (2603:10a6:20b:732::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12334:EE_|PA6PR04MB11948:EE_
X-MS-Office365-Filtering-Correlation-Id: de0cb26f-a517-4cf2-bc8d-08de991ddf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9aAm4dniCWqB8Ftci1LeFOf4U0zWDamMA2rqnahVZXGB7EKZC5msT4k5AHcOAf0X7deei2K2mY8+wIQBhY8cYNuMa2UDK7EAk0UOIL6CAxLbIpPduLo6kk4NvR+UDMboacJODM7xDAbb1FAq9U4yi/Z8gL/eUTkQ9+mUbkigganQPOyC03J8k4F66AOzJdBo65cWKBYtdqnMiryYhi9mdLCNiPl555EyQa7L0ZpjYgXMoDGNJU69CWBq/RhsTwG/hW27qQq2HIxgIkxqRdVwHVNHecIYhL8VOM1J6zCsPUGG8URjYziBOcYfpCN5mRs20Nx8e0wVXCmLFbofaw9U1cSdcwmqE0MvB/vYL5imRQvvzwT39RooMcY7CTbUYNyFm/j8XI42RkoEGvPCXMppGwo1F2csbGzgvUvO+w61pnsXx9CLw30EJ1qnR3Q2PQaClykPRdbNqF+pidztXCq7/0UED5ARG8oP5oVQbOy2oASgZBVBa9FnIiZTxeTVV1uh74Pg55gl7b6zx2CoU9ht7/H2wUAY9Ajf5PW+sov4mrK8nvRbWCno+1Mnxj7N8tdtbf2N9SaFrxDke7N5wynZi0Hq+pzNnwV4BDFIMGMtrqQy5E9xHtUD1yHITqXW9GFdlPLH4pdL9Amh5/K7uQAKeMqGZPnUF+zxCfEtMaGMZsQ/VitGroYjIpinPMydQxMj7bnIBXrwLSIHPPhr4sofp+Hd9eQeHY1+3PNR7Vd6us3nq7dQYfjGzOQyhHcztZJnuUxZxx9xibbAi+HD9gfSD3xjxhTNDRS9XwZl/R4KDe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1oZVVV0WXD1dm+0BQwg55AxjtkXuT9lZUY14iG0QG6z8+oSEorz/3dtogIm?=
 =?us-ascii?Q?ArCUYb6NGVFWNyTzvb/p9we8kS5CJ4GfH4SDEyYEn60YV83MoiO8jZR6IIwv?=
 =?us-ascii?Q?/gjNM56HvTQGe7MKCL9ZfXnNS/ZRlCHkNhLtqek/KUjuL+yo75DKcnjFwcNl?=
 =?us-ascii?Q?CIEQ2K5muBcjzD3ojfOYaw7z1LhsHX+dcXm5Bq0UK5meXYbiuPmhs3u2Jkio?=
 =?us-ascii?Q?yW/aXwPSYMP2MMi7vRt9/CsYuWan1cfI5y44fx1luPQ+tjKEbMbQIyLALAF4?=
 =?us-ascii?Q?JNEQYpzpqjEyo2/OblKAyVWsaGdm39pMVE0UeCRlNWMedDxRBPtk0HgtWU5P?=
 =?us-ascii?Q?IofNkHc7BGb52ZAEvM5YubIVKm/LVt5wIqUXwMOb6qumuKGH5C5P643klt0I?=
 =?us-ascii?Q?b0qAelsYAx79FPBzK+VN+OstrMVVwu51B00IcCt31RnycXfLS4OyCfXKyQip?=
 =?us-ascii?Q?1wBubhfSnbY7wMOebIn73Dzg4h0C1bGX2Teww0oU6fLqpyfhCHJTp3lqYIfY?=
 =?us-ascii?Q?i4HSZ4NC7EhRcGGVLKJGkNZ68goXuYfYMErOKRzrWOa6NRMKFmRrzztmLvqY?=
 =?us-ascii?Q?CxbBQLSNwpxuSjnnVFjJjjZAuliT2rVasY1vSbjjzxXJE0JpCOt4m0JCkacz?=
 =?us-ascii?Q?iSpyqTos6Gfx62uLsvw96zAKQwqJSL5jhKhujozGEwuPjaGpv001b7MKj5RD?=
 =?us-ascii?Q?kGB1HKZ/goKKnGpiU2zvy0/H4I9j5N80eYaMMnT4S6O/x9kZ1eJfDzBwdTzu?=
 =?us-ascii?Q?gguq1mAGAD5zlcYmdbrRLcL/r98RD0n7sE2IpGMK6+khJMqqefPsapubNcFI?=
 =?us-ascii?Q?8x3rmdKK49PQoID7Jx7pKGmkd9kItGcOQtXBpI4ZiywrSUP7yOcELm44lluh?=
 =?us-ascii?Q?g+LKw6cUAHzdQwX65MkRh1py3U73fTBmaCS0kj5cX3oSRq9QR/mNk78uUKLO?=
 =?us-ascii?Q?TCMZVsmd3nhQhqdADkz+mXbx2Gdw9Um4Hoy4ZSkk+BeJvPmwlrA1wRl3rrnM?=
 =?us-ascii?Q?EtggiQWrW+6u1H6jViDihWdSGz6kJID+5RjljZYXXU2/D9O1FgUxO0dLndJO?=
 =?us-ascii?Q?MPn8H8yD0mZlEuRr/RuazvVeRfbkRAPYVMX1EVXd/hppvj1WBpOnXrO7t1HM?=
 =?us-ascii?Q?CxC5sxv32X26wkpW2Saj0m1ODuiF0LoMPNg4jpOUYrDfh6va9+2HUhnj3uIc?=
 =?us-ascii?Q?XK3P5TkVPn5x8++UtVjJ5obYXFW9UMNnIOtM6r20UNlhihsqAqV6GZQKyGyR?=
 =?us-ascii?Q?uxAG0C0m0VnX4x/CeZbvgvXr1b0GPVEpf/knCy5pJUxMNn3C//EB2XerO+FC?=
 =?us-ascii?Q?pmVa1tsqZXnL0IkvF+1rYUM+6OAp13Hj5VW1HXx4TFa2+7n9qIEvXPFu4Zot?=
 =?us-ascii?Q?wP+o5pOG7ukjp/3fyqMp9Fw6NWZlxsSMEbDL2sn9ceGNuy/HpM80JFstWsXo?=
 =?us-ascii?Q?2SRQsMGpJMeh63CLtl6AY2XChJJ87lZsKJl6NXHxIKX/ka2R6DpB1Dwojxny?=
 =?us-ascii?Q?kaagJsitAtN670S/wetOjAvDISwEF/0a4OjwWbFHuE8JNHpUUz0H3mxRPH6a?=
 =?us-ascii?Q?hUlwW1Lh3MH80w5vP1VzrLuTfwyHKhnTVPLEIkOJbcQYHAUQ9pkj92xsus2K?=
 =?us-ascii?Q?oKcBpAf/Yen0JXv/CvsYNKy26eEJHi95idsuk9ETXA6cevxcqZ5t3AvfGTwX?=
 =?us-ascii?Q?avPw/R7G1vwDM/PiVrHBsdrDHseatiPAgYOrjWRpHSmED6rBaei2mGHhk1Ob?=
 =?us-ascii?Q?ZNHCO06GLw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0cb26f-a517-4cf2-bc8d-08de991ddf30
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:31:11.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TrZkVN8xpafbP8qWlUbrDwl/OhsM2TYOz8EoDk1uK5etV/Mbstax+pGv39VClObk7HkgZqR6yXF5IJ8M8ShpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11948

Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
to allow building as loadable modules.

Add prompt strings to make these options visible and configurable
in menuconfig, keeping them enabled by default on appropriate platforms.

Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
This dependency was incorrect from the beginning - i.MX93 uses a
different power domain architecture compared to i.MX8M series:

- i.MX8M uses GPCv2 (General Power Controller v2) for power domain
  management, hence IMX8M_BLK_CTRL correctly depends on it.

- i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
  have GPCv2 at all.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/pmdomain/imx/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
index 00203615c65e..9168d183b0c5 100644
--- a/drivers/pmdomain/imx/Kconfig
+++ b/drivers/pmdomain/imx/Kconfig
@@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config IMX8M_BLK_CTRL
-	bool
-	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
+	tristate "i.MX8M BLK CTRL driver"
+	depends on SOC_IMX8M
+	depends on IMX_GPCV2_PM_DOMAINS
 	depends on PM_GENERIC_DOMAINS
 	depends on COMMON_CLK
+	default y
 
 config IMX9_BLK_CTRL
-	bool
-	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
+	tristate "i.MX93 BLK CTRL driver"
+	depends on SOC_IMX9
 	depends on PM_GENERIC_DOMAINS
+	default y
 
 config IMX_SCU_PD
 	bool "IMX SCU Power Domain driver"
-- 
2.34.1

