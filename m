Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B40315D53;
	Wed, 22 Jul 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708783; cv=fail; b=XpsI3nLTa9DgyEIl4mMvWEKeRTAHdVcxKmCrq9aHKZ/jkRcjfk4PBAG3YZfG/m7KXVp/PpQ6OLSYAkxgcGa60619yP283xmjYMzIKsGF5VKp8jPi9bxBsi3th7uydZB0Tdml9BJFIbFlICbwQfx6yHrhrh0RuGqVcwYAyWk9sAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708783; c=relaxed/simple;
	bh=ueGb0eXd+tC23vJAgoY6ClveYj90zhUHjtTq8jC0XhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxe4wPQtJvoXurLgCBjSB4AI+zIoZep8rc9IDNJKR6+keTnX1uNWrg1x5Rw2C9dJHYnefSMPOmiDWZng5WcH+AI9gGjrWMIWOOFmh7vaVV9ZCu48YXzp6GK9C3sq1P0ZbhYVfaKOyUFjQhZ2tAfmFMS5GQI6o3LdDiIjWpaHwXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PmJY5GKB; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PmJY5GKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y20m5hmFEKsfBNK3qOh/LBdCXsWKSjIi4/bv43SgdgoNegtuZtjd544Ds/RUXlAzsVyo7L5EP9Q/len32c8FnFPsvS1ipwrcBdh5tTXGLxMF0ULBAr1p/LKP/w8LGq4IuR4c8cF9l6Plj7Wh315honziF1NspTeis9BvF7H9A0GK4imSP2rrsqjWSuZMWi8cW1DCDgftxJXF2QvaGQTMHKSoZSUTNcAWdETv/F+HMe3rEhRbRrNGlwqjlac/89Hsuf49bwNTXn0EQs+E8k7d1K6v5S/rVntvf5S/tVTUv5FncXf1Z6PLp73CoWnE76myQ3+TnM8Fx+/lynMk3G41iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNV+Sw/HN03bGWc4Qmapa2Si2X7O6CE7EIyH+uSxPYI=;
 b=IKZnUK05Zz2QCLysZKRrfHlXMSzzqA05NjLAYyGik1P15Lho12s4/pi3yzVUQgmnF/8WSlFQhVaZrMJSY6x99HrPOzl40uH9u8S9lmcsi5F85VOSbMuWRq+rIS+GjAHEaqCkaKi7Ol0DSkkVZeEiugs0X4+Evp17vrOxCK7KMnDXSuTgCa55aVQ1vvRfOscYL0obu1eKEAtdI8kEkZHcffa9z5LlG29459Z8g6PMTqAwid9FLwh231Zl/rIe6oBsMub3SviMNTIOe6Y4mW87BVc3vqZ0hI+/9H88vAz6jGMJdsH6NeXD7RP9Srv+15RC3rJoesGWszA3vxUJXfMtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNV+Sw/HN03bGWc4Qmapa2Si2X7O6CE7EIyH+uSxPYI=;
 b=PmJY5GKB2G0HsGkh8HZasAfHs1lziGSucYz+cMsr+/WrA8j1w+rB7msAIzRiE0lvbsnmUtfOQ9VsVKYp6TAlhPJJ/IkQZ7ULVysdXu1sMwzmJviF7C0UNKkQOIFpYYovufzru7sgTWrjVj4yY1ii5cRd++O0ui3GWfZh2zaVU4asfD5HMlXPVZfvwh2mde3dtKQjUXtgUNmHYoxI7Nh2CIQdn/n91PDpCjvjYJ/L4PQrxTzdsxlROrXmrrbXBAI0t852rBWczvLcL6+U377IkEFpI1RD64ED818N5oaRSUCbH8PQluvg1wyYCFLwcMLM/N8RdCoTMWoJAzW43wM0jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:26:14 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:26:14 +0000
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
Subject: [PATCH v4 3/3] clk: imx: imx8qxp: add soft dependency on SCU power domain driver
Date: Wed, 22 Jul 2026 17:25:22 +0900
Message-Id: <20260722082522.3747962-4-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::7) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 10739405-5095-4b6f-3915-08dee7cae4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gBUwToO+R8vgp/k2vKzJE1j/P8/52jX2mloC3I2h1WwfohU0yqey8oOdaro4I6Atn4P/2LEwx9Ggsrc197TTb8ttO3te019K9g0btoHAT+lPbL8pqUIFenSNZdqGPZv+LSP6cWNb+ss7yUFj5G9FVbsSrXrOjEL/4sifbPOZ5tNFzUDL0jccmZeeaLQ0G5yobSPeX1ubTxq5VL0SroyAgnT16VL614V6uVpxczhSaVb53ij/kxGpoCB5Wu0LZuoexOC/0SkwwXlYsGwOA0BJbEbfStI5QcI8CgZNN95ak4XLRLXziByt/nm1tgaXw9x5llvDyiuwFoWqGcDI3qVkBBznmMywq0X1la4VO/jhXf8ce9H56McVVEP1QRYJuqLRRGN7U9wUiQPSRZRbC8cpOE+aU1UZ3PfyINqE83C0BETQnsreP0jWi4jt2B1td6ZeXHj6pkelBamOrWYO4VlyzNMP/FEK/gbImX4A21L0EAzMjMsjn7WrjngqWkfiXY1mOhV9KJnObBBcNTG1yvIogN/j1HITqJaEInKYmH6kuNSxwfjF2ZlKr8rWrhyhj+TibqPD+baJ/DZ2iBhCGgHlYvGPPljdZKnZVoPy0BakkufTE6pRkSTwfcRKOa56zgbV2Ac2yjtQTlayBO2c64HTYc4sYFkzpAkU3kIc+2QxbtM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGe744N6/psRFzBx0Nk0YaU99M0/eCY6uI5ghQkTvD5T7C5mQTD58LuME+vY?=
 =?us-ascii?Q?DXaearLncbnL0cPUiZTkJORX0nOCQcDVGBkFc1vlw+G8RQbba0RRGqucCYkF?=
 =?us-ascii?Q?K560cqpiaDvN5irYSQTIV9QlpGi6JCBo9wJa095eGws9JpMEZzG7cBBzpSD3?=
 =?us-ascii?Q?fdwm/QsdiwlvmnMpsT34g98PNrt/pp5TXpx1eQolnTtfwCSH0NeEeYbglO8o?=
 =?us-ascii?Q?ZIfNJm+3WH9a1Lf7ZZqLmCdStN6N6TR8osoTVM0Ixuj1hJdh1mE/zZHk+/LP?=
 =?us-ascii?Q?bVaQ72FxDOwCMM8pjydBm83eRLFNpojtF2Mt7g3aFVaGTvUDmtPQjbVBX9uT?=
 =?us-ascii?Q?SzaygVsgLl8MeS/Npzg5F1M4TGxPZmUR1/pU0g5BAH9stNWzBjTeH1lmx/Wo?=
 =?us-ascii?Q?3Cgg87eXMqoaYfU9ZDJjQcmLhYSky0xIFTPxSVmf683OwvKl/83XsToZq2SU?=
 =?us-ascii?Q?hk9PiUF5ksh0jUpSETbskSGYrFAUWXGvj+WHiou3mSx9Bex1FWkyQe13pigg?=
 =?us-ascii?Q?M1PNoh2TcftKLwWoQ3ibY9VUdbcVG76y7Y8PFwkmlxK+yRPPHnuwVdrcYZ3X?=
 =?us-ascii?Q?7sXKbpSxMtjwdOAKS8m+IX8nfOtRCrFP7gpx4I9fSbeBTQnn7hs8awJ1xxwA?=
 =?us-ascii?Q?H01xInJxUoDzn3MtFsjJv2pIzOYiMj2Fj2Qby5RfLvYZv/IUWv+yOZ70W9z2?=
 =?us-ascii?Q?SRRglNxHJskEgLO2kR57UESHe7XSNgesF1xO75nyLobAIGvh3B1fk1O29TRW?=
 =?us-ascii?Q?loSft5Sd/r3nno/jtvQpUAZckUX+2DbdvB9weeA2RQVwb5887/JCDttBw1dA?=
 =?us-ascii?Q?4SpBjlLDQzZCt8MmqApkqgMPE98reu4kaCG9OqwI4WI25KSmUXy0+RpUWO3w?=
 =?us-ascii?Q?2/XXZd82VqXhAdBgPsjb4lOKqsXC960Hy6fJmbpvJ/uz74bd6YIQn753CLnh?=
 =?us-ascii?Q?ONgWqXu4SvH4QOi8hxwSxHE2UDMPA14Jfv3yE5b1zT3Fi00EpxL5MqPAwHn6?=
 =?us-ascii?Q?IwlpLOIOlVAYwX68WDPN4YsC6spVMC4T63tkZocIonHSIgOZNrQU2Tr8gqrA?=
 =?us-ascii?Q?+9lkRNvtDtW9pJT71WnOA6O0L84dvb+Vxl/jcMuGUu0+PjmKt63dcxhPttug?=
 =?us-ascii?Q?b/xFM80akgVOhDeIEiNHiAZvwHHzHL/iIcFmDNNVuPtPymh0GAao4vq7Epv0?=
 =?us-ascii?Q?mz1gpiEa08EZ4NycTUmgG7RR80wERhhJ3hA3d91huVNb5c56Gya9d4gzuE75?=
 =?us-ascii?Q?sRTP96XWlSCmSnRqXg3n6lXGidHnXB1HhROxziAsNX/XNKpt5w7G0nkvtmSJ?=
 =?us-ascii?Q?JRqBNY4Pg4kUdfaHAzfnMsTaTI9lAMjGmT2rbO3MQsHuBfh7jbHZOv13gHU5?=
 =?us-ascii?Q?eiImDXCjP1fV70fnwN3+nTxzAvnC2kEogRW/2dgHbBUwRa7wT5zPpJV3yiz9?=
 =?us-ascii?Q?HmH1dsMzkNlWfv4+T9ATXANCEGzu6exHFkidDgvN8yu8oS8Ql/lbdk5IGp1Y?=
 =?us-ascii?Q?JLZHt9r4tC5Pn4WELlwWake77vVzMbPmA3f1VJgcstRH/yiPqnxf0+WZ9wcs?=
 =?us-ascii?Q?azVBlOvE/eBE2vBWSZnDvA+HVxKHVl3tWNLjjkbaR8WMTDP0C6gygxghkPFI?=
 =?us-ascii?Q?C640xsKUrQsldbnyHEcbsDHYj597UryCvVBbiv603wEFiJHSRf+8xwsLlo93?=
 =?us-ascii?Q?Lsc1Tlxrh/LCUKym154/1MLAbukKI/hbeu8RDOiEajOiq1cVpURo1cU+Wprl?=
 =?us-ascii?Q?GOKifvU6vbEWwPh2fIOuiASwpPwmpWSaySy42Sz6HM64m95UqX104wwbcSOp?=
X-MS-Exchange-AntiSpam-MessageData-1: 9DoyLrcAo3ctvQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10739405-5095-4b6f-3915-08dee7cae4be
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:26:14.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmB2rQTz5BdQ2sdKhY4hdneBBJkCGOByU8yVrYnemPvOqjFmB0NO0yERYz5gvC7aix7soWk+SH1M4EGQUkGBgheLGvXwhZ5FSTcXRJxdS2HNrMwjeA58Oj0U1GLMt4oL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

The i.MX8QXP SCU clock driver manually attaches power domains to each
clock device via of_genpd_add_device() in imx_clk_scu_attach_pd().
If the SCU power domain provider has not probed yet, the attachment
fails silently with a pr_warn() and the clock device is registered
without a power domain.

When both drivers are built as modules, there is no implicit
dependency to guarantee load order. Add MODULE_SOFTDEP("pre:
imx_scu_pd") so that modprobe loads the SCU power domain module
before the clock module.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index c781425a005e..23ef6b959dee 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -373,3 +373,4 @@ module_exit(imx8qxp_clk_exit);
 MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: imx_scu_pd");
-- 
2.34.1

