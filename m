Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF52BE7BA;
	Wed, 22 Jul 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704529; cv=fail; b=F4jcXtVPHRFtJITGXaa7AsFHXD5Uzu3rZLhHjXtY+vnx4Vz0+zwENd7xTJOTrk6xR8dHDTHvpyQfpr+O5Lw3ZziDdbcg+UGQjD7gYODodTdjMXEN7zbT0iHDbaaOmw+rWVE+6RbMaObA6Uau+5ctBNifU2t+akxQ2v4be8Q/sTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704529; c=relaxed/simple;
	bh=feVwKpitV8psZfhC2BeG0vM5g54VVAp67aum7RHUB68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hpEJToE/yjjOzMW9K5BFD2Q6Q8FkRO+FqVp/w24xAvzGWdk3NUf7RJypSNvWZYdgtsTRD8xUY5ek0oZFEtwMjlKh9FErHObacB7QzyE1Luf8FtoJwCWk1LSwlLdYLEMM0fhfuAM2nkP5YDR5+vgAg36XsFQc2AqYQ4v4NssFqw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YCBlDauA; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YCBlDauA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEpFp89CT1OI+SfhlrWTdSIQfqID6F5WWBIWiLntG8C/2q5oeUbPBIVNhKvkmOUGfM7xdvM40plqJPFOYv7p/r+JkS1q12+sbBU6592uykwz/1pSbG4qSauQ5h7nC54qOoAzdxPwKmFH+LXKaBIZha4XaW7C9JOLCoeM/AUIGuRnD0f3N1e5g2DENzOlJJb1lzsxWCt5quyyR0Q3b5zqUQ46rKCrLqodRk9vuSpjQCGipTglmkfBoHurS3LbknQSgXewqCC85l2nyi0F495yrogn9G0ZbhV1q0Vi4dHv9kK8JU/ajO2x91Z/7I25+mVT9Fc98iryViZJY7YKfYMAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7ZzcsrvLOshxNkzPuERsn/mAc59mJcbkDgb3soKwZU=;
 b=CTC9NEzKSTe5a5uwa25PkTFqt+XzNl2HDeKl5SMT6jfz+AyPoS4dl1+2a6kSnQuBSLeCIoti23GwQCZcJeYfvuNMMgFEyrGnX+LodGDNgt85X0yeC9EWnUDotaBY0hC0/vtjk04HT/7HSCKt+wI59JtDzc6MGZk85OEORG48h01CRRa9vNCQL1ItnH5Ac2oyksdW34fD+3VxbZFqVL5n8QZ688QYftLnCwSGONc6fX3dPL0CrkTawiW7d0fq+e3OcWGGV5wBpVZc3Z4OL9JYB7qGJlZjTTCdIMwZXdSZF/9+beQ5YCmwEvF7rdrvyae6qlzILTKDH8UT/DDqKAuixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7ZzcsrvLOshxNkzPuERsn/mAc59mJcbkDgb3soKwZU=;
 b=YCBlDauAGEbJtEizsEDNA+yBZMlcIryJ/irOj1ls1kvDdOEr21HW4FlyM4trTJaVxKtaZ4siN14zZtALRQDuaKeBwoNPkJbIq0UkG5nh1rAbgIT6n8P7hmxFslR6AdBrsGEs/UZMX+7IXYgXYFb9v+IqtYWJK4Z/rCCw2Y+9C6wVsrpbfxPKX4Li6hHZjgRdmDZ05dqKTNug9Ze8KGY913SCrC+CiE0Jem4CuplS14AcLMzBq/x847W2FP8YT2iYYOYhz6wMwwPIBKgNVVmUJEFirs2SDAJIwNuumiFWf+gyRSgfd5UXetGHiCP92aTIrn3yDVA+IahpSoqBsI4eCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by GVXPR04MB11523.eurprd04.prod.outlook.com (2603:10a6:150:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:15:21 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:15:21 +0000
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
Subject: [PATCH v3 0/2] pmdomain: imx: build the SCU power domain driver as a module
Date: Wed, 22 Jul 2026 16:15:10 +0900
Message-Id: <20260722071512.3494011-1-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::15) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|GVXPR04MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: 59213c1c-c5c2-4006-28a8-08dee7c0fe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4mPVNSTjuy17GeMLtVWeh/ZpaXlBoG4HsaZhQF83yOR8a5i5zbhRL+EofvfPiUxV4kctWIdzI2mJoeepnGUnVFlnzQua1nNHNe2KbBDhFDjlEFmqo5kKJFSH4gGfG+qwBETHq+5natCMC46uoyVN+sFDoxoB/t6P+81GmFrV74dfdqTwv1rb6PN37ndOcrN1r7fwivnux879Jha+x8oAanv9+qqiGXRQSyh3LvADl4EZB0de/Ecj/ZioYjiGkceJEbCNHeh9ISXPpmEP/+zKtgp4/qGCL9TVxvmzzJWtUMTou6ptUsyZYY56ngZJxahY8hA3nOl2aiqFuYfvhidheJwYw8ynEarPNX7N5d2whGu1ClykC+K2jMyHkd0kRDkglLPWUpvEGp93ei5XVsbkifuo8JZXxableDWNiEts0okyJiTCM5r3t/VhO8a68FA5BiIxzo0L+3LLkmT+MFboay553ARQt4aYpy40vZ/4iD4k0eb+kP8SF1GK5xI5F30NGGXs0+WDmiDd3roYrFkulkT9fytq8scODXljRonXmNHxcfuCKz+umqq+mNXUEyA+0wTcvBKjYwiljFOR+by1pB1coJeK8BsX6nrqZNkYt1apzrkdbmeuxH0X/f6BgWOI23koFQbmzebH0Kg7h2WMnGNBPNiZLyomtCoIYCVEE8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dh6E7OVZTFxJORxUZA6YgCiAbrEbx/CA1t//yNSgGo/Cillj7WVx8kWj6hgf?=
 =?us-ascii?Q?oLuyHoxzdy/3Ed8YXcL9Ro4JVEdykk+G6tl7hOWsuie9Lld4WCAjTKJkwYHd?=
 =?us-ascii?Q?1o0JGQVjVEUbKxjvoYbbOZtbw9WTxc3M9F+lZ0hYrFmF9s49cOX84bb/Qn6D?=
 =?us-ascii?Q?PVdKTP60GUD+I6or1fkYbGkcx+6BPCgmZ9qhuDDQyz1xbGOexfx3+bwdnZp/?=
 =?us-ascii?Q?z2XP2AmbQQegyPYjVciSqni9BiJp6yJXDknn9vQRR3Yl/WGBFdhr6RdsEEL8?=
 =?us-ascii?Q?ozejasYrCzDudmOOMYzPsCltOoTaZ9nmVrVTuLOn0nb9PYQdeu/Ml59BEVfY?=
 =?us-ascii?Q?difiv6lYkKOH0ZHVOgyygLoQimIbLMi/G8pfav/nwewV4oPSBmTLsq2ljQu3?=
 =?us-ascii?Q?bR/PclY2PKQbmgfehHUlnZSbfZ8cbK7/Kt1npdW73HLMt2aHWjXeDNryfckt?=
 =?us-ascii?Q?7xNnEpWO6EugJt9mMoYEXa+BAHdyTkDy8h3Ia3egDSlFAW5wmqMyfJHfyQAA?=
 =?us-ascii?Q?qfCJM9xcnyfOWhiB4Lio10jZ0dhN8127jRbwMN2V0h+WcQeYpLMTu16rIbHB?=
 =?us-ascii?Q?mUpzaYgkrHaShTN0Qp9kudhsxTQgp8MjsP9GukJbOGBEn9E/m8kYapKZ37Rl?=
 =?us-ascii?Q?RLyPxNZ1oLuXz1iX5EOV7WVjTCZKta79RtGn/wAg7nKVx7ALU5s/ypKLyPJW?=
 =?us-ascii?Q?UbhkJZMHG3PsE2WRL4dH9r0QeNpINYo3zSXSK9jTj4MDYDrFEuicW+NRiJip?=
 =?us-ascii?Q?y1SmwxlMh2ywzsHC7UTjCUk7Oxt4xZFe12ZEfB5SI01DufxHbSzXzqPm4wV3?=
 =?us-ascii?Q?ryKyYqsSBLYiey3bmOtw5Jt1elbTxiPgiDo0Vq1EmWwwb+NyS+6OI+rsKaYS?=
 =?us-ascii?Q?DrhxXh0amF2mMkkDQeC+us3FI0HxpQtR2xlaSE4Q3r3nyJEfTlLH/5OGfP+M?=
 =?us-ascii?Q?oQR5UB9xZBNSRDReorBDw91DASGyvMYuoKNMHJwVS+agdkeEUmdn8NlXkKdR?=
 =?us-ascii?Q?PkguezpAHwNzLHGzvc7QkTi5CUeYuECG2mQ77iwI7rcOPhE2tatjtx9ZG4IZ?=
 =?us-ascii?Q?8R1ALfgpatjO89l/JQUse09WB5eW33VQemxREXjfgfH+oe92DQAVtnEBLX0l?=
 =?us-ascii?Q?+IY0pCGnnBUz8zccfuQGzH0vKbKwLMqMTM4UUldKYhqkePsumdsaPBa7wotz?=
 =?us-ascii?Q?T1pN/R9G2OAtli7FhsYdS3VXeGvgjSu7ER0P45nDvKWU7K7Zcy3IRjGMibeP?=
 =?us-ascii?Q?VtQROxjuna4t957qV6VmfZhgCmZrpnwRKfWI66mqGf3GbjwKVmsfsaGbMUUG?=
 =?us-ascii?Q?26c/te7YbIQLasIXtC47y4JERcJD+dQRSGrv9eWabsYCF3KhCBkLjWSmBNTe?=
 =?us-ascii?Q?amBLAfX3uJFS1QSLNolQYUdi3wzcp/hUNQl+OM43CwDXHSS4W4/lqLN92f+f?=
 =?us-ascii?Q?+vI2FCcwxC1qimP2dQZ8ApY3koSrqAIgMSOvxb0HY/xCoZe3TQcvgIKU6LGy?=
 =?us-ascii?Q?5eMfF92J597Sz//HrDMtD9ejTfb6/xTmS8y+2sTn49QhyBCtnJYJ9YF1SFeM?=
 =?us-ascii?Q?9XnOzEaCQSocjt5BXrYP51dpP8x7MGkpoK8NYqThuWgC/cncsAseFHV1feyK?=
 =?us-ascii?Q?YMCpk1i9gWbfcg//5PdbKfNusDYXvUV9yrcFU/TKRj0Ee8d0H+HGmuIjbcsp?=
 =?us-ascii?Q?yAAfrX2Uenmdq62eRgzyQxFilll/LV4loUZQvbqan8cETkkhY6Ay5sob5Pmt?=
 =?us-ascii?Q?2cMpnlouSV4LvxxxlKsER779uKHHtuzX7eVI84do52ybN3Q0rexJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59213c1c-c5c2-4006-28a8-08dee7c0fe01
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:15:21.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoBgYAkYrvIqk4b+TQHzfyNkIQf5uzNt93zwISKxmsT4PT2O9ft67HOniqXDu8FDyspIAEcBwcTfZoNVctbhu7lCetNqUiYQCskuiN3ZWCAJjDtQmWeCD5usC7lB4ace
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11523

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

This series makes the i.MX SCU power domain driver buildable as a
loadable module, which is required for Android devices using the
Generic Kernel Image (GKI) where SoC-specific drivers must be modules.

Patch 1 exports of_stdout (which the driver references to find the
console's power domain) from the OF core with EXPORT_SYMBOL_GPL().

Patch 2 converts CONFIG_IMX_SCU_PD from bool to tristate and adds
MODULE_DEVICE_TABLE() for autoloading. subsys_initcall() is used so
that when built-in the provider probes before its consumers (e.g. the
SCU clock driver at device_initcall level), fixing existing "failed to
attached the power domain" warnings. No module_exit() is provided
since the provider cannot be safely removed at runtime.

Because of the cross-subsystem dependency (patch 1 touches drivers/of,
patch 2 touches drivers/pmdomain), I would suggest taking the whole
series through one tree.

Changes in v3:
- Use subsys_initcall() instead of module_init() to fix probe ordering
  between the power domain provider and the SCU clock consumer when
  both are built-in. (Sashiko bot)

Changes in v2:
- Drop module_platform_driver() which provides module_exit() and could
  lead to use-after-free on module unload. Use module_init() only, so
  the module cannot be unloaded. (Sashiko bot)

Zhipeng Wang (2):
  of: export of_stdout symbol
  pmdomain: imx: scu-pd: allow building as a module

 drivers/of/base.c             | 1 +
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1
