Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D14534B9;
	Tue, 21 Jul 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628571; cv=fail; b=fuzKkQW8MGoy/iMfH9PCd4zS8nUB4bJqOM/FBHeSMtCXPO5+vC/zqXpIkJ0lPRalpxYZDutcLC9jlAPNP3THYnOX4LqU0LTFgZIFx293ZZaadNI2IDkWpXgURL4ezL8G4EyXboJeNd2EwWTlz9wWvZTSLh+KMg+PS5mFEHkoRDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628571; c=relaxed/simple;
	bh=FZ++PEWFdOTXbJyfucnyNKBuKPAWQTtvACcE6Y0iqWo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T+ri+6PuN4uxtf/BPyXydRJIPCCNJ0U/ZCdvd0hrNHZKj/UQ7tvpJQoVWviwkvUvBc40b9zO/kEo/PhN+0DJPa/JMWNgDm9955jiSP65uZr3CxWFNkuC3fypS9qKBaeXVA+FI4H9hdvTz0QSoSFV0Q5w4A32vBcXhp+x+snTYiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JkWroM3C; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JkWroM3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpMJdEE0gyzCYER3SsKgoNOJphzaqemSfzjsBemr/2SqasOkCOiNDKy3m0qcq7LZJpp2KixDeUDbfXj1R60Et9hOkvIJTf9UBsPkaeXlSh8nLhKuh9T7QuCpGC/WrdukAzLgAS/TZ3VbCa/MWxLt8BkNPry4TvfyfWQntd5zj2e3F3OMrwrIf2LirxNae72dvbeUPM4I3Dp605IfHI3lTLAMe8f3vXRJk8imxjzlwQ59fEcmkCvi5OsPpVpVbrKOzoAI7dyODXqqRJzNySijSy5GdDWH9sOyWXFzrZRw3iQjwy9xf9UllRm2WJzP7rH587w8Bmv72GtlmBn9wLqE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcZD1jSKoIY1xTex/Oh3zSiwouHikiKnj7xl5RnYOKU=;
 b=fpW0GUoDn1K8wm5sK1uizdWXX/gIA9bOH3FsKB5+cRRRq0KJ9s0sSykDmH7KrezNjWrBUcGI51vf9IysWtvahrRPUbNcBS3OhQUxErS0ra3TPiqvZOb1UbETk7wZMpfisnS7Ryo0jWpNL7glTZ2Fc17+NI9u+n+l967uqaB2Wwhdq4+tsENffdGbPohVv/HIaDK3Jm+3pTFImcWoTg7+0c1BG25YSKjy55TMTvy744u6622fOF651BAwgJdZlys6x/ijXBtz4qz4HCuz2zInF2ka9YB4c9iO14eqfkCTjNqvdKk95+H5pY80TwsQuBIMVXldctz7Imcz8KbK/9uMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcZD1jSKoIY1xTex/Oh3zSiwouHikiKnj7xl5RnYOKU=;
 b=JkWroM3C1uvhdkN1iycR+I1AWnxqQxlnfZsK75P7ATJKqTmX6dx5D01vfXxnFAIdeUSVdQiFsL6M5UfY36ehFh6rXt6dQjm76ufIzgmrHktAaXwyWxKEMQkX/XKcqlTKon3YR9uvUdolWAPpR2JWrxCwKW3/uHOkMbqBA5mzXDU5NfD39/b0dlbd0yfIYCOOCIVXStr/c21tXnAxSweU9BkNGtTJrU2Iy9GDpirAztp3obbo2axVPoWnXIvOz9gQy245xoW37+fOcv8KQwLBdzYqF78bRaXeGHiMJ9WNisKt13ZhBccbNj0auUKO1JFFlvaueDoA2t9frGoumk0aNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:09:27 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0223.015; Tue, 21 Jul 2026
 10:09:27 +0000
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
Subject: [PATCH 0/2] pmdomain: imx: build the SCU power domain driver as a module
Date: Tue, 21 Jul 2026 19:09:15 +0900
Message-Id: <20260721100917.230923-1-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f05e9ff-1239-4bbe-0289-08dee7102535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jdsMQDMPNGcnu7dCyJesczNoGwF9ZBpQB2Z7X0DhE6AFZobz3QU1SvDlJdcYOnZHYPxWveINnQP2N0bIbmqEdzG3bcvW9YvUf1KntgYcRo4Hn222xV1FYT79FDkNtVlCWeZyxCG3IRBdZe2AY1YyGmKdHMGfh/MEF8vLgF46ts9u87WIZJT0fdu1wh56UE7KVUwC+TZmj8Q557znBtH7E2aRwrQmeTdVw8HlhL10i3X+7z8VAhqjALr1ybKo7BzAg4A2Y1qKvfrZp/7R3nYtHYIqyCMS+5PH/RCFJtfHFCZ4lRw064200/ytlmcmFKbaGMnCAgNZNsr92ykxkG8O9mD4qaZ8mkL99NqqSpwr/EncTA5DZH9lyi5kiIchFanJwjDaiRM90Asi6NB9OhFlv2cuTUhvt0y7JQUATvBr03LsQHZAHMxcYTCVXy7SZziftFIuS9UAjIigbfpF1D/JpQsuFDmb2KfA2OOR9ubWUC6WR2SQntyU0ZPJDnFy9kfNwd7kz1MPExMvvTozgtdRNylD//Rwl3IllSqIqAXIT0/S8RLXBPd2mQOfM+RDApnOprW7OK4TkD6Qb+4bmteOW7bTQym2UwyJ3niB47VjzOfEGA5hh/I2/9SHoumFfz2dAa/lgUtlldI7tVzUhu4v5O53lVifWCzjqK7uidwRttI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ribjNvAQxBmS2zw98z+VENNJLks4n58k40trnfTlLOe3Lq2Z0CouXamks7W?=
 =?us-ascii?Q?bAqwVudDZd4643VYU0TS9cyHaew2ixycc8bCc0Hc1clYqsSo36NhFbmF48dk?=
 =?us-ascii?Q?m7685VkB2W/z7t/6+jBCLObYba54UNHXcvTeIleKi9FK+Izpg3ZVYzzh7Wh5?=
 =?us-ascii?Q?0JdGpCzlZA6pvIIWCu+C1f2sTUwDZCuK3SNog0h12ihPtjjuMWu6jGyoPQtq?=
 =?us-ascii?Q?qno/U5ZdsUI9hGwfEeULsjog4V43OAejo5A7ivvnwRb/GGAC0Y09XuFyTZwh?=
 =?us-ascii?Q?9NaQ/NsyDAYUKTCrRJFgyms6yCybkQ0jlcbO+kM2ixqpKPNp80UNGSg1nWFJ?=
 =?us-ascii?Q?GmPLoHgg59DhSxdN8U+jYMCHxnHUBwo5d1w0cO0LeJ/xXqXads0w4C9B9Uj1?=
 =?us-ascii?Q?4L/a9wmCADizQ9tghZ8IMNGPUYE9ck83wy2b1+ozRFXUgGk28W8YR11TDh+e?=
 =?us-ascii?Q?WzLU4TmcEZ63ENlKWjE/V2WAN+3dF/1XOXQFSNYGr5s2ZdnDvJDvkpl2w5nW?=
 =?us-ascii?Q?Vacd9gs3eVDrqYQfcKt61SaBAY/R59qOShWuDRbv/9ku7APBDBj2aNcDwq6+?=
 =?us-ascii?Q?1pOO4dsTdPaO+FwoKuYkXcVQROLAPD1NBqIecb1pTxK4HDCU/9Zrr3S6/e9H?=
 =?us-ascii?Q?nT2Oahwa8p31eHYK1Ko26tjklNUgyOwTFTeoWOD6rIzO2xoeegi9e5oo6j5k?=
 =?us-ascii?Q?TCl9scHUDdknSMcOIvojlasbYlmtP2+cLdULcCnWTHgbkMSRqy4UVdji0KJk?=
 =?us-ascii?Q?8cgWFcqPsH5dDjdXg6ehNdxDA852jbgA6mqs+jqs3P950iEGNKZqJQscfx4d?=
 =?us-ascii?Q?pRz9HtMfOe6ylNxdgiTtQOjsDXhBPFws/wDeD8/iVjXd1d7JwzxpXgh0usi3?=
 =?us-ascii?Q?gv6LP3fPxUDobRNxeOoHc/i+Lqx5bI1Sp/oUpVYE7eoTupq9RgV4azcTWIyf?=
 =?us-ascii?Q?xfggw609eNj4xGbMGii8TnqZdapgYTEb2GA7pMfb1pYzpi3G3p5eXWpzBC/y?=
 =?us-ascii?Q?NzTGM+x33vnTEiq397cZeWa1je0xyEVLq3VUPQV2dyur/ZIj8e6mRkNTgd3j?=
 =?us-ascii?Q?1J4RuJfcEbeXZ/qm3BWa8vgoYBj0WlGaJur+AMKrdilYcJJJRayFYxRL9LBF?=
 =?us-ascii?Q?hFlR+nGnnfMLcYvMPpA3s143d7i4wLaN0zTTzJ7VU6cC5l3TvN/12oXE9yKF?=
 =?us-ascii?Q?Uy8lLv53GtQLs475tiLGDxNyeubPaecADfIxHYeFvoBgj9Tu3IFlMDMgb1q+?=
 =?us-ascii?Q?zfqzhynnhDUGB+I/1xmwHV+g6MIbSf81EtsXaWwsoiUyCVQuhyoewqWnU+dD?=
 =?us-ascii?Q?nlEJWtzxlj6nX8x8BUakyLJ0lW9oHdz4pXn+VlDe9sp2Lb2wchMY5in9h48M?=
 =?us-ascii?Q?di0pl36wCb5KwfihlhJQ06f+UiUO5lyVJSwsYv0SPpCKzcl+oMQErX1SIb7E?=
 =?us-ascii?Q?3fBgMLKn/wjNb23o+SLjMPkX6Sk0Xcsb221lTRmgjbIi5qVH7hl7dD8QQVdw?=
 =?us-ascii?Q?pB4SBvmv2S5ymML0NP24lxprtFsBzYmGJEhghQq0OfcQh2ELtiqrJG5uVchV?=
 =?us-ascii?Q?mRexnmZsR27qzYyv4BnPh3QGV/BV57xubFJ4WqiRitiLSE4ZBroLDBPwp5Or?=
 =?us-ascii?Q?3+fbikGYAcw8nE5Dp0j9jXGcZuNld5SI5RKuKJOm+01D7pE+1yJu419DNdiA?=
 =?us-ascii?Q?d25/5Do1bx8MZ1c1UmPMlExtZAOrKbmggfyGM6vFOYfG+bcZtsp+aPCbOiPZ?=
 =?us-ascii?Q?2AEHfmfM/VK+u0L8i/W69txkzEFzl4HajiG0kHYFco5EgDvpu1n0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f05e9ff-1239-4bbe-0289-08dee7102535
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:09:27.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95z3i+UynrzDMPpMcrPbCRoMoenjv4Au9JNEaiJvhD6wJFijtwGqU59Uepzd9PfOm9/Wbq4qXHBn7yLTjkVWPI7AcJkc4ShwgvD+3KdFlqMrVTmmdZNWllpiY3m3CLYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

This series makes the i.MX SCU power domain driver buildable as a
loadable module, which is required for Android devices using the
Generic Kernel Image (GKI) where SoC-specific drivers must be modules.

Patch 1 exports of_stdout (which the driver references to find the
console's power domain) from the OF core with EXPORT_SYMBOL_GPL().

Patch 2 converts CONFIG_IMX_SCU_PD from bool to tristate and adds the
necessary MODULE_DEVICE_TABLE() and #ifdef MODULE guards.

Because of the cross-subsystem dependency (patch 1 touches drivers/of,
patch 2 touches drivers/pmdomain), I would suggest taking the whole
series through one tree.

Zhipeng Wang (2):
  of: export of_stdout symbol
  pmdomain: imx: scu-pd: allow building as a module

 drivers/of/base.c             | 1 +
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.34.1
