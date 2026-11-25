Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608891;
	b=eAGa6nKg0MZ+pfTWIDr49yWuk8Mx87vrSmsvfrLlaOnfYKnNqjJ3Fdr1HwK+5W95685i
	 JIcmsq6Xk5Bhinw8Dt8UWGLJSp5rQvlDvnXYaUTMjv9vMzfDMrTB6DlkaRp5DIuKD7hL1
	 UXtPoaVBui/fWuGiFzawdLxe46comfjpCNP5334SD9aX0xSTX5l32JJj8da+J2rfp8b5I
	 czqiiw6ZeY905xDWyBK0DT7I1BrOj6xuI7obZq0680Cr1lWo5oJpg1gEvQGjeHBFNE4gw
	 pY6Eu9LF/XlD0i6dSKTpb1xLASUwJ2B6agUSSKMZ0mrjL8KYPfRlrAl5r8s//y0+eJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608891;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AUZFQzAZSn2rMUpP+dnRE+pCtqGtXGviWvOCuKiadM8=;
	b=GcmSb8K+cDmunKnXUnUG4srbdbjDe7xW0XCPLIsg9gtdlWReMDC6Qrm4Ay7f6mEKvj9i
	 K6lkAutu1Z1auKUistFQuUZzSo/MjGN2xXj/KOpV5DjJBwYxmZExEiSCYgTd8VvYUV1TR
	 vTEzw/0am6XVD5S9Aze2VVsxnqh45ayg3YERn56RONHETBaIsiFm5nYr2XgQIEEH2S8Ya
	 iZ/7/4hQ6MsqyKE6nwr4SYEzVX0Dw3HuPc26KE7tm6lY3IKVqbx37n68d8CW77aAysvnG
	 lvksdsE33WvhmDIun9EnIj31fIwZkRAFlbxczML3Ma7aMjfT4IP9bk2dEgzIviuD7hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DfnSe9i6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.63
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253E606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D253E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DfnSe9i6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLoabGOOsXleW1ZOWw9k5bouWMQ3t+nrnb4kCKxA5IoTkiv2o4tD7dHHxSFn95j6RUkmqEPux2CJ8LGFnMNBc5EMNJTo0nNOSBfQHSrB5lirIhDft+g/p+SZkd7+8tNgyXPNHQyy3Ujx5i0CEHdALzeXpNy3rNvsvut6g2PZGIF9wpg8u4iEyMQmgtcrOOHTH0dlsu9Mvcds57jpoOo4pJK30z0ET8aQLUlhsrMHdUg66Gmc7kWP84V7rTNKj/MfNqMuIb7Nv7/w0Yns8U6W4a2GPBHqNMFydqRevNJ6p2D5/kYFlESzsZSPX9Ow93Kvde1iB2FJZVUaXxbgbes8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUZFQzAZSn2rMUpP+dnRE+pCtqGtXGviWvOCuKiadM8=;
 b=SkCLQ0NAk45QLMcbt5C6PrDU0sEQXeT6WsJbvAqFkxtuJwJvDMGUJUrbUNMRICKXwkAvcnyT5aqEhiYna5kgsLen5eSbz4Gk7qqVQzOR5j5WbB6ut8yDBNgCQmEzQUO9JLjxBUZZv2QwUCLVPC2wOprBYDsCWbrAwM9FP4Nmx0z7KCZD/gDBr0OkkVNnudIRpf1ORzPydkGgNfMw5OSHy65/jW9mXa+SDjUM1VwZ5W4vuoK9uFcR5pJKCvOPwT9u9w+BoN3QXre4JfQPrYAiBFxGZYWXN89rK5qkQs1w27SImyw8t9BHSaG62tsmclDS+X6dM+i9ax38+/Oo/XPMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUZFQzAZSn2rMUpP+dnRE+pCtqGtXGviWvOCuKiadM8=;
 b=DfnSe9i6OTLACbycbpiArpOy04FD7ByRklX5o5IaHOaxu98BKFQqsHvdn9YwPoorWalmQzgGYI26Ekk5RXISocl0YYi12YJwnS4cK2yy6wHsiFI8zf43fu4dZ38xUOFL7+VAB2zpSMtOD9/fWeX8agZpYs633iZv1c5tu/qnvETzP5c5D9W6JudRLbkfG+3opDG/h924Cs7Ro+XNIOuloLVOzMpcpa09M3ZJdwpW8ADLP3sjLE2Jh8zNwzq8kZujKgkPJAPicu+d7UFtXILCTDHiZ6UJi8Zbfkx5k7vkfvlvIUWlvL/t9H+bDC0zEcnU85oI1NpgcQdd4Qm9QTDfSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 12:14:40 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:14:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
Date: Wed, 25 Nov 2026 20:11:41 +0800
Message-ID: <20261125121141.29455-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261122205136.138173-4-dario.binacchi@amarulasolutions.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4710f1-c7eb-463d-94cb-08df4aedadfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|7416014|6133799003|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ULKUQHqsdb4YPOJeXLfE4M/RbcKF2A412BkfhXgqk0e+aIFVQlbR7XfuDXDFNGl1fBmOoIXmXn/t7532Gi8kp88wkRNEUfdLqhOuPhKv0/AlojYrImIojAf9xfaBZzBxvzZbY9SJO/l8nnMWVb455JyUPDd8gNK+2vHa0rwt89mImx2leZQs5F2hHv/y+sTAYIaA1JDD/TibnNyqyTHSsh9ts7dbJCX+QyNjSjdcfKkQl9gTRfJN/4YM2xvRLsT0Qozeh1KUHdUtacclMuMNK2wDkPt9ud0ErLPX8uuWg7BS08umoQb6/BktKV8UF9Q3xu1zEUQ094mrATM2a5InT5zxJpfNxaqZabUaP9fmL7uraLb+kSDSxDQ6DgXt5EWFYmVHTmy9vRWORkgmVw0HYN6ObVR5LswisOgJNW++/i0dt7GiNW3yOUwj3OzwTXNkgs7qcpJnRCQDFNlarkL7ptEoHJSnpAgNjv3ddRofnWSTjkpgAIDmd4GrGGL9OFYnO3dDo9I9WZ+lhH6NkHKMEOz7YoDrrD3zE8Hh2avF4zpHnFW8aeakXFbGhv1X6x3fIm9VNzdC7uTzh05eBK7OSIIecV/1ayJ88GuIDkKaQTQ72+bAss3uAv+S0gHTLHrqWrqC8Q4lgCqz4WG5Wt7kvidS4wAHxHDFscllKxtvcuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9dZHA7y7iEA8duIrKK+9oIDwQslSQn1c/CWyD+/RiU2PqFXWBeqte5bhpfA?=
 =?us-ascii?Q?/E5RWE5FrSmsx/8GdlWHx8vDzWf2gxHH6UydOAMkzFE0JRRXPhk04j0vdT7N?=
 =?us-ascii?Q?CdgdhzWB1PPQ/PgbbtWK5rod3VfF52wH1e+AjVNXNujiQL4BRSeZYdYDpBVE?=
 =?us-ascii?Q?kvcjT+Q0zgo2T/72qNPC4i+Q4iAv7yqblhK31Xj5C+iz/ZL6Rf6hfobPtPCp?=
 =?us-ascii?Q?qa32Tq1K0b8DJt4MLkWB6ruPcsZT3oRo0aLzmVSKrMsO+Hw3KaVUnkKov6S2?=
 =?us-ascii?Q?ThcG5BxzadGFs43AHBOZ5hcAMHRjvb6VmZgYYPYzO4bcGklhA2TZiQ7M/0oh?=
 =?us-ascii?Q?5DOgWg0LPuh0rwYi2zmxiQfC2GQ7zaqmNMeKdTRAERviVO85vihmpdjwHhEA?=
 =?us-ascii?Q?bDWrh0wk38fdqcvHF45g4t0ulX5yL/9hdlm07SUVtZCcMaog9dlIoBt0Tj5g?=
 =?us-ascii?Q?WuDxAyxEDSDgwKdq93RM4tQcUWTQ6TJzAeLFxECcZ2fNaML6ySJsENiPGGon?=
 =?us-ascii?Q?wE0Q6fwkGDlOY5Lac6+NyHAwnHrlD5ADc1OKs+1PXPdSpshwBxC6px5cb8TN?=
 =?us-ascii?Q?hmbRdVZV1ByxO/5YNqS7TxOAmaNfTIgZd5fqD05TKjO/sBdEsyUgFZA5Gxks?=
 =?us-ascii?Q?dVRz90SE3JR1fnvtZDwFO9tfimQC+Nm97z7vmkFLJJbXBL9vVwSTjxYsoQOE?=
 =?us-ascii?Q?kYi3U5pL+BoNqIEDGahxtlnkbED31xGp6Nqex5ME3C50G5/qcVwJKaLzvaIS?=
 =?us-ascii?Q?b/xKIkntnf9gdU+X9r9oAIP/gBPXuPyAOMfDm+pvTPMc/qedR7+OrzUL0EKJ?=
 =?us-ascii?Q?KLvtjEqvb442DsQ3peX2Fmb9ujVqaLUMWHHEJ98ibK0x3MDHGaWCRaLcwX0P?=
 =?us-ascii?Q?FKBQyQI08It4BBVG9yHojQmJATSv4jp1uzO5KY9bHHTzIksntBCq8n85hWv7?=
 =?us-ascii?Q?zNsrk+fmLbUHerq/1sZWCEtYD1bxCph6/JiO6WdXXYVx5gQ3EDKyBxW8OhDY?=
 =?us-ascii?Q?jaJ+yqmWi/U2/kfOO0Vyv4dXkbP2DHi+OUSDbkvqGOxTuC96D7/SXT8LHIV7?=
 =?us-ascii?Q?IloKYBqZxCqs1H5CuhbQZxPYYa39u1yQ/T/NFYzmvSEdRl2Sum9b9lHTbj2v?=
 =?us-ascii?Q?9rrc2NsfpNOYB5xC4i5q8s/hq50YmNoPu8LBeDqmSVw2VtFks6WQhbwWRO3y?=
 =?us-ascii?Q?5mRseK+8crIVXS0bcp+wOuMKk9q3uKTPJi2lHM/N53SIQAbQeTMinyGOw2b0?=
 =?us-ascii?Q?0G7EmeCRWIlBmk/kug0WuHW58kX9OrpxRlqjV4yGK8BMXyGJxzsPs8UIiVss?=
 =?us-ascii?Q?YLC12ldQecWIozglsriIthy0aK0EfrbZHrh85B6uLzFTp2rT0Y2T4M+7YNep?=
 =?us-ascii?Q?UFt7JofWuYsTTHEb8XspWOZPhTIlr+/1wnQVP0ULmRjDnEdl4lV8jG98SGvg?=
 =?us-ascii?Q?E5vFlUasMLiRlroG9cu1fCy9sxl0g7uoRjqidEOr5dNLTj52rAPiPtr2gm4n?=
 =?us-ascii?Q?JdC7Otj2gxBhO50iz+rQct+N2QTHnEFDr54MEqZfh5n6maUn4EXYl/ajw4DF?=
 =?us-ascii?Q?qVqLsqMN5GHHoERSZzvOIKPTcakF9gukA52GgQhxBjdwW/s7xmi5haCvU0D6?=
 =?us-ascii?Q?/B5ktCybEKLcqrtrxWeHs3Z3L+QBzuVa6beW6AXOZQKBFcAhyELxorc1i9Po?=
 =?us-ascii?Q?pbkEf2udl31S7mBSYRZngzPn7OC/bnE0cp8cVzOEPlsc4Ru6fkf9aq/KJivx?=
 =?us-ascii?Q?gPSw4uq458aI6n+eF2uFPoL2ua/4IhEXLi7Yb/B1Ywq751Y6KKzS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4710f1-c7eb-463d-94cb-08df4aedadfd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:14:39.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSlaZSBCpkS+SyBv/dNyAlepoXFK1wED6UgxyKAZJkRBYOuTnGrZP4jH1VhiHnf4XO8L90/7Ur0Hc325ge4Ro0RyyurePNPsBIpwesc6A37nvg40Jd3D59SvI9HClkSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

On Sun, 22 Nov 2026 21:51:12 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> The blk-ctrl domains are all registered as off, so a domain left on by
> the bootloader is powered up again by its first consumer. On the
> i.MX8MN this resets the display pipeline set up by U-Boot to show a
> splash screen.

Linux will finally take over display. so is there any issue here that
resets the display pipeline here? Any I think U-Boot has driver_remove
to make it in the initial safe state.

Regards
Peng

> 
> Read the state of the domains from the blk-ctrl registers and register
> as on the ones left on by the bootloader.
> 
> Enable this only for the i.MX8MN DISP blk-ctrl, as on other blk-ctrls
> (e.g. the i.MX8MP VPUMIX) the registers do not reset to 0.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v4:
> - Register the power notifier before powering up the bus domain
> 
> Changes in v3:
> - Keep the bus domain on while the state of the domains is read
> - Remove the domains before releasing their boot-on references
> 
> Changes in v2:
> - Take the references once the probe can no longer be deferred
> - Clear the boot-on state when the domain is powered off
> - Release the references when the driver is removed
> 
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 128 +++++++++++++++++++++++---
>  1 file changed, 117 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 7d6735728d8c..04383d7e40cb 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -83,10 +83,13 @@ struct imx8m_blk_ctrl_domain {
>  	struct device *power_dev;
>  	struct imx8m_blk_ctrl *bc;
>  	int num_paths;
> +	bool boot_on;	/* Left on by the bootloader */
>  };
>  
>  struct imx8m_blk_ctrl_data {
>  	int max_reg;
> +	/* SFT_RSTN and CLK_EN reset to 0, so a domain left on can be detected */
> +	bool boot_state_readable;
>  	notifier_fn_t power_notifier_fn;
>  	const struct imx8m_blk_ctrl_domain_data *domains;
>  	int num_domains;
> @@ -187,18 +190,87 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	/* allow bus domain to suspend */
>  	pm_runtime_put(bc->bus_power_dev);
>  
> +	domain->boot_on = false;
> +
>  	return 0;
>  }
>  
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>  
> +/*
> + * A domain left on by the bootloader has its resets deasserted and its
> + * clocks enabled. The registers can only be read if the bus domain is
> + * on, so a domain is considered off whenever the bus domain is off.
> + */
> +static bool imx8m_blk_ctrl_is_off(struct imx8m_blk_ctrl *bc,
> +				  const struct imx8m_blk_ctrl_data *bc_data,
> +				  const struct imx8m_blk_ctrl_domain_data *data)
> +{
> +	u32 rst, clk, mipi = 0;
> +
> +	if (!bc_data->boot_state_readable)
> +		return true;
> +
> +	if (regmap_read(bc->regmap, BLK_SFT_RSTN, &rst) ||
> +	    regmap_read(bc->regmap, BLK_CLK_EN, &clk))
> +		return true;
> +
> +	if (data->mipi_phy_rst_mask &&
> +	    regmap_read(bc->regmap, BLK_MIPI_RESET_DIV, &mipi))
> +		return true;
> +
> +	return (rst & data->rst_mask) != data->rst_mask ||
> +	       (clk & data->clk_mask) != data->clk_mask ||
> +	       (mipi & data->mipi_phy_rst_mask) != data->mipi_phy_rst_mask;
> +}
> +
> +/* Take the references of imx8m_blk_ctrl_power_on() for a domain left on */
> +static int imx8m_blk_ctrl_get_boot_on(struct imx8m_blk_ctrl_domain *domain)
> +{
> +	struct imx8m_blk_ctrl *bc = domain->bc;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
> +	if (ret < 0) {
> +		dev_err(bc->dev, "failed to power up bus domain\n");
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(domain->power_dev);
> +	if (ret < 0) {
> +		dev_err(bc->dev, "failed to power up peripheral domain\n");
> +		pm_runtime_put(bc->bus_power_dev);
> +		return ret;
> +	}
> +
> +	if (icc_bulk_set_bw(domain->num_paths, domain->paths))
> +		dev_err(bc->dev, "failed to set icc bw\n");
> +
> +	domain->boot_on = true;
> +
> +	return 0;
> +}
> +
> +static void imx8m_blk_ctrl_put_boot_on(struct imx8m_blk_ctrl_domain *domain)
> +{
> +	if (!domain->boot_on)
> +		return;
> +
> +	/* Sync, to power down the bus domain before its notifier is removed */
> +	pm_runtime_put_sync(domain->power_dev);
> +	pm_runtime_put_sync(domain->bc->bus_power_dev);
> +	domain->boot_on = false;
> +}
> +
>  static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  {
>  	const struct imx8m_blk_ctrl_data *bc_data;
>  	struct device *dev = &pdev->dev;
>  	struct imx8m_blk_ctrl *bc;
>  	void __iomem *base;
> +	unsigned long boot_on = 0, bit;
>  	int i, ret;
> +	bool init_off;
>  
>  	struct regmap_config regmap_config = {
>  		.reg_bits	= 32,
> @@ -250,6 +322,23 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  					     "failed to attach power domain \"bus\"\n");
>  	}
>  
> +	bc->power_nb.notifier_call = bc_data->power_notifier_fn;
> +	ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add power notifier\n");
> +		goto cleanup_bus;
> +	}
> +
> +	if (bc_data->boot_state_readable) {
> +		/* Keep the bus domain on while the state is read */
> +		ret = pm_runtime_resume_and_get(bc->bus_power_dev);
> +		if (ret < 0) {
> +			dev_err_probe(dev, ret,
> +				      "failed to power up bus domain\n");
> +			goto cleanup_notifier;
> +		}
> +	}
> +
>  	for (i = 0; i < bc_data->num_domains; i++) {
>  		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
>  		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
> @@ -303,7 +392,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
>  		domain->bc = bc;
>  
> -		ret = pm_genpd_init(&domain->genpd, NULL, true);
> +		init_off = imx8m_blk_ctrl_is_off(bc, bc_data, data);
> +		ret = pm_genpd_init(&domain->genpd, NULL, init_off);
>  		if (ret) {
>  			dev_err_probe(dev, ret,
>  				      "failed to init power domain \"%s\"\n",
> @@ -312,6 +402,9 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  			goto cleanup_pds;
>  		}
>  
> +		if (!init_off)
> +			boot_on |= BIT(i);
> +
>  		/*
>  		 * We use runtime PM to trigger power on/off of the upstream GPC
>  		 * domain, as a strict hierarchical parent/child power domain
> @@ -328,37 +421,48 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		bc->onecell_data.domains[i] = &domain->genpd;
>  	}
>  
> +	/*
> +	 * The probe can no longer be deferred. Releasing these references
> +	 * would power down the domains left on by the bootloader.
> +	 */
> +	for_each_set_bit(bit, &boot_on, bc_data->num_domains) {
> +		ret = imx8m_blk_ctrl_get_boot_on(&bc->domains[bit]);
> +		if (ret)
> +			goto cleanup_pds;
> +	}
> +
>  	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "failed to add power domain provider\n");
>  		goto cleanup_pds;
>  	}
>  
> -	bc->power_nb.notifier_call = bc_data->power_notifier_fn;
> -	ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to add power notifier\n");
> -		goto cleanup_provider;
> -	}
> -
>  	dev_set_drvdata(dev, bc);
>  
>  	ret = devm_of_platform_populate(dev);
>  	if (ret)
> -		goto cleanup_notifier;
> +		goto cleanup_provider;
> +
> +	if (bc_data->boot_state_readable)
> +		pm_runtime_put(bc->bus_power_dev);
>  
>  	return 0;
>  
> -cleanup_notifier:
> -	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
>  cleanup_provider:
>  	of_genpd_del_provider(dev->of_node);
>  cleanup_pds:
>  	for (i--; i >= 0; i--) {
>  		pm_genpd_remove(&bc->domains[i].genpd);
> +		imx8m_blk_ctrl_put_boot_on(&bc->domains[i]);
>  		dev_pm_domain_detach(bc->domains[i].power_dev, true);
>  	}
>  
> +	if (bc_data->boot_state_readable)
> +		pm_runtime_put_sync(bc->bus_power_dev);
> +
> +cleanup_notifier:
> +	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
> +cleanup_bus:
>  	dev_pm_domain_detach(bc->bus_power_dev, true);
>  
>  	return ret;
> @@ -375,6 +479,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
>  		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
>  
>  		pm_genpd_remove(&domain->genpd);
> +		imx8m_blk_ctrl_put_boot_on(domain);
>  		dev_pm_domain_detach(domain->power_dev, true);
>  	}
>  
> @@ -709,6 +814,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
>  
>  static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
>  	.max_reg = 0x84,
> +	.boot_state_readable = true,
>  	.power_notifier_fn = imx8mn_disp_power_notifier,
>  	.domains = imx8mn_disp_blk_ctl_domain_data,
>  	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> -- 
> 2.43.0

Sent using hkml (https://github.com/sjp38/hackermail)
