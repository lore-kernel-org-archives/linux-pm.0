Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1F224F3;
	Thu, 23 Jul 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772356; cv=fail; b=HMCkRSQkuTcV6EGUcfBqzkKIALA0m0fKJ8ztMfK6LhIYneFYOOYZeaPqnM208C8UMw48oL4E4PwEVQh9vPTbzW0DStmIvmNxWwpsfoFyV/u5M//ZRy49z0hZvOOLkozbR7uByh1+Mdv803DxR7Kn8lNJHS3SHWENhh0dz1JVXXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772356; c=relaxed/simple;
	bh=Bg0qJJ+0YOAVWd2E1+aXZaIq2h1ZaJZPIfGz6NGxJGA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lK7lQLsdGvIhtH6SJvD5r9C3fKKY/usTLmNc5pq+Btd6rhSr7XT/HCXGJdcpcgSSNCNMcNII2PmZPWI7nqEDB35cifOpRKFQaGH1KuYreev+v6LyONlNVzlhxSgKds1t6q1Z0rlkYl9RHrPTA8pHYFyFe35m7QT/9rxrxHN/HsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K4N6JoMT; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K4N6JoMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5KTE5hIbLQ2O2o9hSbKihwN/kWoA3UlaTGX2ydvzEMCOL7/oHCoStHvfHJbXKVc9JYPWQL6Vc7nA45+8ci9bPXETq6i6eq7GeGFRKpzXpI2QbNIsOxalmFBmmL6LIm/A1bO7PXM7IRIA5LUyBxcXNLlv/bI0UwAq4mJcIUOvnE9t28IMoLbwVzgYAHp19DkDDvdOsdpnYuq3gQPvY4DkQQkebak4TXrYD1EKwAeIm6l+hpQlaMcwFOrd2x/jkYKqF3AatLeRpzoCh8qrn0s69eLJAdpGSMRZkB9/pDYhVcIN7EbBiLD8p1xitY0OI31U/GRdWcpirbXBsqT/tsQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvry66dAVAORaPK/Dr3YiRSBdUlE6KETP5cb2QHuPnI=;
 b=dpcJT6kf1bq1KeAR0pcZymTMSEjo9W0Xb7ZWx+hF0ftBXMWNYx1cvVELvdxAiKlP3oxM2op7mZtsY8PDsmgjSBB4Zt1ghN2KVovriDhTcPiLe9WFbxB4MkpHr+Tq64biw9/+VMFf8g52IN7+32QOX6UkRCMOBFa0ittk+ikkXjWupDc+yAJFYum9BBHJfruBH74sjShecSz4HlDM5uLSCZ1Bb7iHrFp4j60KALzyUyjRlibfnc1mdhLkcVCw0usdsy4LagqCekCUP3ys4TS31HYieQ8dUDMbz/AOhofMIw7O+PGH7zcoo/ma2S0/EdAS8a0oOpfsgPQ5zxQQvIPnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvry66dAVAORaPK/Dr3YiRSBdUlE6KETP5cb2QHuPnI=;
 b=K4N6JoMTdv4Ev3M58YdRq067s/PhXHdyEwi3feNnkuDyuGCodCv0unODDU4Ke0yXlZtKtgFY7+BTTzsDLotxitnEkmbZElUpak7tedfPA+Dh3U76EY2supRvfm2ViLaLwcrFsDBHtzBW8NC/oJOOa4H7XOR3419dmwvl1xzkELVnQCRraDcVacw9DQYSA0D44EZh0P662yVStOZr0QSpoiey43x1t0wI9mXaLYdNREyAWPnszrh0Z6L09AswlnJgd0zMuBdRiy9oGg+JHmBcA4o4yu106natCT/ZzJhW6anJHoQdiOvxJC6BwEVKFI8wb7BSIsCKpEWESAA14F/T0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:05:50 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:05:47 +0000
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
Subject: [PATCH v5 0/3] pmdomain: imx: build the SCU power domain driver as a module
Date: Thu, 23 Jul 2026 11:05:21 +0900
Message-Id: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0223.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::10) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: 1302d8fc-a960-4df4-1945-08dee85ee36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	g2D85arAm4BM3blDhI9Szb+77ox2dg0uYLH6vGVn4/kwxmac1AGfqyS/g3p0d0pW3/C4dA357xfeUf6PMkPrIdSJXxxvXqnWV4o7ar/14Fu+LY8a5KHb3jgN+Uz4WeSid6wfHhOBrI3gA0YhxSE6WGyGV0vvJmXne/6Azrgr15zd27OBAZnQPEg1vp4hK5u2QlY3eGB6ietdF21ZRAeKYoB/Q5yEuRwV/gyGUvBaenFAsl/8OP7XimI0+9nFgOQs7mW7uKCm6ojf8x+vNqwl8WtMWxBswnPUlagEIxcvsvnEsardVj3iEPGImYI4Lxx560URm4nbdzUoDvxPorT+TqnqnUgQEnsFHZcL0OiDYbtHoG2EyzmakcvdRms85/5fuBt3bUn/DGgG4HMWYpXJeoxteyY6C92dXUO47Sxz1mJ9x5tKy4+8G0gbONlqO020icvM7WVCi3Rld5TJfIWirNgZLSvRbyHsjO35Qs7O9wdQFETYgcJvVzxTSIQsMq4DSFVpxTgsCtVgLZNQgDr2PMxzEz8jjE5CAtVPIRB3d6woSkX7kS1J+vNz37LurqvFIeAZAMq5egASwmPk1lf1U65RLBoBxTZH9PrFk6WfZ44WVeoVqdAVWnTqAouE7CBUSu0v0C6dIqWfOfXmd04Rt6KlqqXGOghm+p2m1gqcW4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdVvZxJVdrYfR1Tg2GNfRpgOsMnBj95wqtxi+3xJT32W+YlXxDx6nSo4FmR8?=
 =?us-ascii?Q?YGRz1durRI22yrCn05kISg8gcd2LE68cn2JZnRrTSpqqn/It5sMfJYGy1c3v?=
 =?us-ascii?Q?aLQ+URszsJk00FsS7FErpwvCqvYFxY5L/r3UPs+Q+rczNre6iOVc0EQXvAbO?=
 =?us-ascii?Q?jBXjDkALxdZ4Lfbn6gibRopxzuZDW+WigQpVtFhvjourJmt9O2bLslqaZu4G?=
 =?us-ascii?Q?bEuc20PaER5KnqBlRF/qAXB851iUzotBTtnejJ1Gs48Fz16wcWU4yCYArspi?=
 =?us-ascii?Q?zmpQp21ndJTbk2uWDrtdStwKZbn55ed8kAqnPj26xBhtVlRRE+SJB8SswYlN?=
 =?us-ascii?Q?Evq21nlzvo4ZVNeeG8dfnF3AB3rW1AKPtSA4c50CKP3GxklGEz3d4wLJWMLF?=
 =?us-ascii?Q?MR0vNSsmsd7TJ2ZbyJikkTR+kK4yD6phagQV60WrJzfyinqb5gZZ1IQzx6u7?=
 =?us-ascii?Q?zBJd3NwmsrItvMpfDNrJny8E+7mc76LsAtQG0sx7POd1nF/GLAGl+d8GELBx?=
 =?us-ascii?Q?YK2SmDgraHwGc5hbi7rQd3FHFWQ+5onIeBjwss+NR4+2m5C7FAFfTwHgBrk5?=
 =?us-ascii?Q?o9kZsU80nEpFcTlLyW1MimWTERyD3pjjXrqXUfThh7wV8tyyb7S1xgAUsRzB?=
 =?us-ascii?Q?hHp7kITWmJREJLIiRC0ATbsaWo7WMQQJTrJK1LvZ2v/NNkwmDS2YL7ZZwwi8?=
 =?us-ascii?Q?Yr/CTPU8rov8En0A4nHwXa3xs6DauXv7IMshzNVqoFQt0YoLUc+y/HSLIC9Y?=
 =?us-ascii?Q?Cen3QyNvphnUHwRoY7w/dSyRYWDPKmTMkHzdl+rK2Dg9UWMQaBYVNsQhQgGT?=
 =?us-ascii?Q?mF4PElzg6k1cXCHpnRWqBFrB+IStAEqYOgDotF3M4rvkFNDG1oi/ilPIBOYy?=
 =?us-ascii?Q?fePC22t0XOyZNE+6CuDu/7uCYQVX/Ign6tu6VTNxSVrVBt3XvWc9MluSZlvg?=
 =?us-ascii?Q?sZKp35+cHaCH/PsRGWXroQylAOpaQOJex745gpBEqFqqngr0C3vMUvd9FihU?=
 =?us-ascii?Q?sCH7ISRjq4JFovdf8bCS35hEtWQbt2E7SZ2FObnni97Edasfcp+VCVUoHWJF?=
 =?us-ascii?Q?q2tOFpDdkiQ6ZFEW61RRF265ENuscJTt7kHA1WskC17wYum9aZK5w1O1xFu7?=
 =?us-ascii?Q?gRw/y8cwXpQ+tYgVdbOu8EyJpfMbgo4qJOgBuwvD+VVw22cdGkfbSk11vjR/?=
 =?us-ascii?Q?byrqPKDd0rRMAf9psidALKFSfsQb+wOw79JxfJhDcbuosBLVOWzCgyXLKwsQ?=
 =?us-ascii?Q?krlyjSkLxZpwJTeXzHV0o+B59sduLhLYkipsmXf8tku5LPBKFQkstOpsOfQr?=
 =?us-ascii?Q?eL7PyZ9VsU8DjElhuMYJTnV87NTcJ7eluiFeAtRjZRZvFmsFzI/DAhHxGzv8?=
 =?us-ascii?Q?cBExmTRQBkEXTrejKHXaqpOjgb/F0dM0UYNbmfSUU6JQK556FwtUd5Gnhb8C?=
 =?us-ascii?Q?sqM5nm1lOe7F7y5d53NL+deWJJi2DBUUatbAZGObGH1hlmHwHFO7w6I1IL6B?=
 =?us-ascii?Q?6imEr3X6MN1re1bET6GPJ1u5UQjiNucvqWxgU2lCVDupXNwMkdzLMjv35qrD?=
 =?us-ascii?Q?GOTPbnU4R/S8hWgk3YPwYdndV8zr25fXeg3nAWdzOHf0MRLXGmwOh/vOmmwF?=
 =?us-ascii?Q?WIASuQ4Nljkdc/GrbRltNc4EN/rzCxz02FWMZi5/utiPw+vurfKGleE230Db?=
 =?us-ascii?Q?6ixWNnoGCtgWlgdPiPFxHu38XTKrFuVTkxyqu7Cf623MrfO2+8PXrQUG4HmX?=
 =?us-ascii?Q?xIMkRHxtUCIc1C4YmMUB7lAtRtuseUCusC7A2sck+VH4+Pu/FKcAtqj1f+m+?=
X-MS-Exchange-AntiSpam-MessageData-1: uJ+L4ed5JRxoTQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1302d8fc-a960-4df4-1945-08dee85ee36a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:05:46.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5PrXsgSQwffIyOMPcbilO0pCYZEO31sGEmXuY3yDE16MaYRIOB8Hgz5/avCLjsSxqupL9w7dNSPZqobeO+A5p7M+eQefGGBnTslp2pP8ehcgAZ/RSrlDbj25FMBuDnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

This series makes the i.MX SCU power domain driver buildable as a
loadable module, which is required for Android devices using the
Generic Kernel Image (GKI) where SoC-specific drivers must be modules.

Patch 1 exports of_stdout (which the driver references to find the
console's power domain) from the OF core with EXPORT_SYMBOL_GPL().

Patch 2 converts CONFIG_IMX_SCU_PD from bool to tristate and adds
MODULE_DEVICE_TABLE() for autoloading. subsys_initcall() is used so
that when built-in the provider probes before its consumers (e.g. the
SCU clock driver at device_initcall level). No module_exit() is
provided since the provider cannot be safely removed at runtime.

Patch 3 adds MODULE_SOFTDEP("pre: scu_pd") to the i.MX8QXP clock
driver so that modprobe loads the power domain module first when both
are built as modules.

Because of the cross-subsystem dependency (patches touch drivers/of,
drivers/pmdomain, and drivers/clk), I would suggest taking the whole
series through one tree.

Changes in v5:
- Fix MODULE_SOFTDEP module name from imx_scu_pd to scu_pd. (Sashiko
  bot)
- Add Acked-by from Rob Herring for patch 1.

Changes in v4:
- Add patch 3: MODULE_SOFTDEP in clk-imx8qxp to guarantee module load
  order when both drivers are modules. (Sashiko bot)

Changes in v3:
- Use subsys_initcall() instead of module_init() to fix probe ordering
  between the power domain provider and the SCU clock consumer when
  both are built-in. (Sashiko bot)

Changes in v2:
- Drop module_platform_driver() which provides module_exit() and could
  lead to use-after-free on module unload. Use module_init() only, so
  the module cannot be unloaded. (Sashiko bot)

Zhipeng Wang (3):
  of: export of_stdout symbol
  pmdomain: imx: scu-pd: allow building as a module
  clk: imx: imx8qxp: add soft dependency on SCU power domain driver

 drivers/clk/imx/clk-imx8qxp.c | 1 +
 drivers/of/base.c             | 1 +
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 8 +++++++-
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1
