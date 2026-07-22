Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31A3368AA;
	Wed, 22 Jul 2026 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708739; cv=fail; b=PRKIQi6GO0ehKxZOocgXUAVyrlFQi671OU9hRx2fcYkTdD9PIqueKeGfefqaIjekjYNQP4LHhnp/1ONmieonAWYt8rjn3QZ9UNJxpKTUf7gHQxuBJQkoBkB0SLLQEQFrJYICSyQoYUPXEWO8Up47HWi6/vuCFtXAm6pwwVVhiSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708739; c=relaxed/simple;
	bh=cczwjxdnkvlY2oVBKAfHS87m564WJs8UFPzkN6cIlSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mm8P5o/SZ6psyG5Mkdw/YoIjPGGg1edH2JU3brH4zZuYphQ1N0wAlAyki+j45JJ5Zz2lPDVjkdlpFQjg2TJrfag7jmxdYtX3iXV71vmV2LaNyqrdkFOsYZkgUiYt6mUpBmHXxp23cYOnXQvwFyRkDctiwkQgIsHiMUaHzyBW95M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d5wccF0f; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d5wccF0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSdXxhEWfOr4p1nxUSSwDmHbGEz6enPGuYAwkaGSA1DiKykMoEv4Y0k97vs6kG/OOCuvlCvEOWAqiZyXajWl4B0Ejs9WJc8uaSIT3IlkU3IgMUdaP5v3EpUr4qss5wTQdgVX3wnw41EIz046vrwixd0/wLTcJEeOhLg5EZPsL/bN1c1ZUqFA7vrdh+w1seeFsbuUwSbHCdqeCnuQIsDbIha/deIzrcM07RHtFAw79j0vXsz7oqws6+qfQzGZgivcXN4Lx70NVwSE7mHBRYtyGX1+XloqO4WHzQqDc4bypeULcO+LR1+YFMX0RzapIzZppjUwpndKB9oQxRX9JXF3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq2PpBE58j0HiItWIAvzWbWFnxfLN/jemWO8rBkdTFk=;
 b=r3GcJRk+RPrAOkb2tobkOwIrWt6cR+f4Gku0s9VI1RF6xBGhqqxOEpa0sctPSAuckZsosN/gh/lWieJ+RaJlFb8stp3HH218sV3bdZxYe+qg/tzCS1NlczWJT0qk+FNNwrdMVQ9lbhf3GN/Z38h7ez97YX60Y0/eVXT3eSFebblSeZY6BbIALVmRB+pi7VzNCWaTJOx+93XwZiRnx0n4X+lBU9mO5qHmqYM21V4vGcikbIWqoOjf0OC3nuOJjkF5YaRtuC5cvDRyzWzXLj01+uFDYoVqMADH/Pi1O/kzbEEMmsxb6XscRr1wdQ+qFpSUEJ9R5r0aIhUJiQ1fiHCmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq2PpBE58j0HiItWIAvzWbWFnxfLN/jemWO8rBkdTFk=;
 b=d5wccF0fZB3rF2oUM3i5wvp4J76NbH587L5LfPyEk3K4vVhRbwqrmEes29Bed7kdV9/qyLImu6sD4CsGEK9AY4P3n55PekMQU+bIMw95Qm0Fr8QHpQzy3r2J4LkDslcHsUTydEymMOGjUD1VbuD6Wm30fjUvKq4rWvAhch1GSdyMebSWSfluCQMBxNztmdGyvTRD/9HNyY5k/5AvBIgNx5wwD/rqfnCYULSDlbhRT87/tdxya5lv15gZlCsXzBTIKAiQllYl38epJ7sVbObelzhKDcSN644rbmLjTin1BTwdfGVQZlbVhomLV7GMb5F8wCb44SzN9YuFogZIyozibA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:25:30 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:25:29 +0000
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
Subject: [PATCH v4 0/3] pmdomain: imx: build the SCU power domain driver as a module
Date: Wed, 22 Jul 2026 17:25:19 +0900
Message-Id: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0362.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::19) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eda8cc-97b4-44c5-fb4d-08dee7caca57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yLfxSIEU6iaDI0qjf9DSapPQ/lNZWPup7VyET0H3QdeIAliGBM7lSEsu5o1a7mcTaZu0iwFo6nMwzY07iNnju4XmuOX4TYoi65uNyj6S2lxHm9uxBfrrUSYR/mtgSqZz3RcmN1TJ9LjWsW/RWkQo9CIBXvISLYauioFcSfnqjS/LQi2Z5UM/qlvoQjUWNoXyRaJ3PfSMhqMzD64yWBpv3lf/c0QO9vPYHXWU1vrjmv4cUmXwPxOOiOwyZCBnnKsmhROMWkueFOcnK7UnWBpxJOfH3dXO8kc9HUCu1XQ7KyLcYOn9Cd6zFqSgSxiwlUWeC6y9+0fr+xc8hFjiLL1dnGQPAWR8GK+nV8nvIpDdIW5fxX5kvXzPFC/CIHm1en1zOiqh+glIypO+HkgPKPZrDWl4NFa75RMj96EdZvORDIdQQAcksMr9EdXANi2mJa8BHEGprohEiTfwf/+9K2aV1KENVhlsHaQd1B74D+aw0Yh2Mrgf4WFDU7kaoBEbt8xc2p5AN6SqwfKxwT7At20sY9PUWA7yC2wo6y8Xu94E43RhGgFDygIuO/96zuAvjyQ3wBWnh3Czq0edWwgUeDVjeGj93PIyEt7ydpOH+nOzOHatZSOnXwvgP8C1gq4A0Mfy9Off0eNBa6zylX9VvvTq94ebnc0+goJ2bS5Yi2/UK5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdEvgdfRe9yJp4L/Y9JlmCaRWI5DE222hGAVsOsLiVh95I/UYHoIm9Z2ih5P?=
 =?us-ascii?Q?BmHBJa5h8Q9K2hN0+TRCDcnU93CeVa4Ir24qdZGmFesQcrBAktFx8OCdnP9z?=
 =?us-ascii?Q?pq9Y2+DN0sdnW7hlJ0YGc03/JX5OVRQ5rLOLA26yjRbB2fJJo+MospcjaKXj?=
 =?us-ascii?Q?qCdPNELFcOLjr4yuf7qZpLIwIgC6zVPesaIo0xRmRuz5kwkzW9ZRJ6UJZm0P?=
 =?us-ascii?Q?mv5kgZ334NKJmLlhGvSMyPWEu5VwTTCFNgEgGpxRiszdlg1ynR8keScBn+hl?=
 =?us-ascii?Q?0C/lvtCq0QYUB6Kf4BFy7B5fxkoyJnb1czlWjcehqaAx8ez8dHbwiVHyYjC4?=
 =?us-ascii?Q?PWsdrSKWL7zm9Y8pu2MJB01oTEnHOLqAF70FzgAxlKK7bf8OQ+MVhCqM+dHv?=
 =?us-ascii?Q?1RIGQF8mNJUr3U2Y5+F/ny4iNkqhyuJQUmhYURHiW3OsYTTBidgriXnOyRY6?=
 =?us-ascii?Q?XxdZcQlmeST+opJqmZ1ZgudsTmfjSRJHkPubdMJiHvsuK2Y+ybzfL5xTQptu?=
 =?us-ascii?Q?CPnqnlQShl2b7Bxf1nh9kJVHhyVzODyM6FBe2MrswEHHbnw7CSPxRmIRRaXT?=
 =?us-ascii?Q?/56O8gFB+rTwQEhZZ1yfDxhECBQSWvvmUEHUTU/5UPU3FcsYJjugEBtBqhTm?=
 =?us-ascii?Q?8ObHX8wHCrE8WN2zGFv/AUZCtYgnj68+iPNkWQM0+3vMpBF6HBz2h7vL5WGn?=
 =?us-ascii?Q?lLuibP52faFTshK2ST8lLrCpWo9SF45gTs157iYoX8HKzF1yaN8uADUIyNXu?=
 =?us-ascii?Q?jvzDaoEIV8orOXhdBOnT+FXHSSsDJtZt7bhGasVk8I9hzmgVji72dG0x/ct5?=
 =?us-ascii?Q?dXGgQfR2WKe12vZqicZOBPov4SvYPKqBc6tbUHr/OMpwwSOfMts1K0Jt5ihu?=
 =?us-ascii?Q?6hjX6Xa+idKJhzDo2NTXfyzvlDFOWUzmpZlM8ssgTTGO9b11EOFhhC2xSwI6?=
 =?us-ascii?Q?CXSHnvzveSGqgvuB6lfP6hL0axSg1hpAOGyjsA5FPcpobxKnZYPZCmilz6Wp?=
 =?us-ascii?Q?KB3JK5ccDLKt7eWYep4q9y6x0/kGIVLCum3ruUKGq+WIYUBBLoeeqM6T1Kg1?=
 =?us-ascii?Q?CWz0/4I2SKMXciI90cB9ZXN0rCC4RCu5h2zZXaxzTOLkc4DGLGrF6/IVo0fb?=
 =?us-ascii?Q?0KwdHmF7oHBnDRve2xhQm5wAoYyIeP0Qylshji3i/p9Y+sz/XM/uwlMotbbG?=
 =?us-ascii?Q?/rbgEaRHnBj99OuiZIqUOH/dQNbQt5FOtLvRhpK1IwivHP4w2tZKUOX8km+C?=
 =?us-ascii?Q?32gpfW9eYEM5c/6KFWW28NAgXnvQ7ZETaaCne/a1U/0fTWMlB5LrxDE6JieL?=
 =?us-ascii?Q?ldTTG3xydRAlqQwa1XeDcpdWCKZDYuognK1cLglo4UR9WsCSLGKea+5bULWA?=
 =?us-ascii?Q?4Q5oUoPBVf2VCI6JdpB+wtflcdTTo6smAC0dOzT0ndA7yVohFmVoicDFiyhc?=
 =?us-ascii?Q?suJaNpV+BoJsvjJTr4gJSQhX0CilfjjJLyHcQ92uSP28seHj3VU1OMaMRAHS?=
 =?us-ascii?Q?RJRoRJ4dywyKoKBAA5rNU9Ncg/XJJ3WpAwFNSf8/OyCG4mZj25izm3DS4I/F?=
 =?us-ascii?Q?InQZV+bqXLn4V3gqJQzKPWhx/4Si5vbgMDjquDoILw3js02TOxxes+Sr+/NQ?=
 =?us-ascii?Q?kGDEFe7WIdcW9IgD5mZizfCQ2t3DcvvX2zqqJ+hsfcHFgNjAhWl25sIfHdrx?=
 =?us-ascii?Q?txgQsSqaxPPzVSvRDMHDzMzGx2l6N+xA6ApC00L+rOkTDcM2UpnhaTnpjEkq?=
 =?us-ascii?Q?6s+lA5z2Qy8HV+SRqHDUnUIhMWsoP+Ye61v/9eyLeImNxvZUZv5E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eda8cc-97b4-44c5-fb4d-08dee7caca57
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:25:29.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ltAf1xZHXkr/EI/v2yNGVbaDh+1U1T+mzl1E97xOIey+TH9Ot/vT+wEBerLInMPGY0wv89/zFkTnmmUh7v2qubagGrRoKTGTN23+IWOoBziIizbukbCDErKBJZRRvIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

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

Patch 3 adds MODULE_SOFTDEP("pre: imx_scu_pd") to the i.MX8QXP clock
driver so that modprobe loads the power domain module first when both
are built as modules.

Because of the cross-subsystem dependency (patches touch drivers/of,
drivers/pmdomain, and drivers/clk), I would suggest taking the whole
series through one tree.

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
