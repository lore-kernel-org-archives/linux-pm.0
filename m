Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039F331222;
	Thu, 30 Apr 2026 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517479; cv=fail; b=Czhto+6BQhO9e1XCBzvCwLLnkjXfMIlLUVo5N3KnjlU7QU7OUqM22sheACg2pGcaQDB7g5qwmlhSHeDzf19hlBAqFOus70EhGDPDQ6blsUrNce3f+c+30bZESbvaXzEBOk7qMiQ+Q5YVZSvzHzi+GfVMxRSxc65mgyDwtFmYt0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517479; c=relaxed/simple;
	bh=8S6ORMcuc7UpWX/ZKKVZaU1MazGCqEOX7rcAV8wAmlU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jjxkDO8kYiKnvbKVJd4FYQ8LX0qU3ZDIyumngw294xE/w0su7d/czhgQREyEnBuSZCLgJsN75RSHL/q2HQWVoE+dLpJtdvcoNARBlu32m/15E3wrjp8qB4I2/zL7fUEMiBkPCjYRTd0/UE2mZ7wksfwJvosNuk1vvMjUvK9jtEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NNAKqYaG; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NNAKqYaG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCzMBIVoU86dQxu9kYyjz6b8HCRKfDclkaWqdBCLG5YUJtrTzcGoYtCRWgWB8ROC649v1W7QCgA+xBCoy8Opq8pojxnk8pRQBo99QiNKz9Zb2YZ+gSn9aWuMGZfY8+/bfuoXmCyIQ3n1nYrpV4kZ4RTh5BH8SV4HY0CX5EjFsMpyzl/wHJ/kurtxmpcdqfVbXBBzcN8q6iQrYrugC2ACneXEAT2zPinRIIq+2TwC1qyl0ZliSDYYMPrcj34yqJ7RuIW//+zbN3r8Tn6pRTf8hirRHniQlAljThOOVZdxjF1BmiSMGhacojqaKU/0Uf15TC3azCtmR+oZEQI4OHdUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdcq2Xkk7ht/8B7hALvf5znxQkn1nVXiA/2dIi+ymvo=;
 b=TkM+toSVOLB3mQJj9aa2cihd0CZZ2vcWVsLTIit5FM14h86Wim6pvgudsRtuDYaO8MTmOQCrxKRfjxq4bbnpM28DhwHDThHh+4OKudCSGR799SS+ht71Lr0Yod1gKcrGZsLsJEJ2ExtFSruAt7LwI3L7H67JyQwbqQzdqh8K5uQ5CZyD0/Vca91st7up7Ywxt2y+zb/i92k4YfsGuyoXFkNwwT/byI+Hcnt+SFY+5GxqkN9+QZBTtS5nsLn7zaavLLd2yjx/KpUd/Pc62ABsPb/EOZodFmeK4MuZCe4+F4PwAGpiT2KWTxv5DAJH3vBqC/2+mWik7locZs7QX9jpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdcq2Xkk7ht/8B7hALvf5znxQkn1nVXiA/2dIi+ymvo=;
 b=NNAKqYaGZNRDSIJmGPqu3gKVIX+SV197kY5hd35cxgEH7ZB3LiITNOdwLQfM+2mbZCV7U1ZPCi3t7Ix1oW3nIIlnYEMNHIl9myMk6/hsKWNKdSDbxVNNRxJJ4Ds6cJH45n1a5wTSdbjYcLUENK1WwDRvWXCve1/jxh17t+TkLnyv2HKjH/y0UFygj1h4BWUhPJbw4OTgdqsDarZxMPFgBSVC+KOSMZUkRiSyT8oKtgWsqb79wXxtsi0T+tFrBfVN8VGAX4KYP15WbxGqySd2tf1Py9KubG40faTWehHQ5e944bCkQwjfYVUZXP5eLHgLTFvjWn9bWCsDrZgv363AIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:51:15 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:51:15 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 30 Apr 2026 10:53:32 +0800
Subject: [PATCH v6 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-imx93_tmu-v6-3-485459d7b54f@nxp.com>
References: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
In-Reply-To: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777517621; l=4712;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=8S6ORMcuc7UpWX/ZKKVZaU1MazGCqEOX7rcAV8wAmlU=;
 b=kgFN0D5dsKqm3DmzWYSrA2Agwus3EbO8rEITXWHdIaXw+Nyg9DRAliSthV0b/yflLAJ/1sMKI
 3OGeWlg1EFGCpS+8YUC+4ZxRAgzSLvTWd/BJwB/0dIvI1FBQHGpVGqI
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: c685f6e7-9c21-478e-61e3-08dea66358bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	FqFTP9NjZ4hIZYMZizdnqRrDTkECkU41IPiVgS+yAYebGqZwUdOwwE8mx6qpjFslg5yeZek4bwIx6Mz29LL+ggPlEWegHSFN+9XrwiPHql/fn2hkD+mIr70Zas6l//iTh0r0JDZLMaehmGx0ZMRTIp27ASlnAu5D+F33Jinvr1+Rnkms/d3Q1M6TYCm671CZsxFedURPMzwvYCD521/KsIvFiwth/gD5IaDlCwPHew054ti/sMpf+4tgtIHp4vEXsQp2ZvLGxWpWOepYktmvJc3Ilada7cYqcBE7vnFFQcjhZ4eXtC2jZTTutPyRLQ0gXpWL2mY4unXJTg9QepV3TdUJBh26xbWWk8uLmhCuftYiHHFPv/s5Uc2DgYOb3QmyiA5Scio+OUrI9EdN81m3E+NkO1XOw41KR+NVhkYGnbrIprBBYTcoio4QMTB+pDb/PUPgj2mCPR6o4qG8y42i8Rzir1O4Vou4KD+OVbiVfVqsvaBTgurUirOgtJebYwAEP5ccwNE8Rt/lwCS4nuaQNUA/zhF7zf9wg+8s+Arfjur1uQEyIGowgTyOkuTK6yYzLK3hqpQm0KTfQcaTivgBr0Z9bgl8ayno58mkhHwWjLc24F1dv+mK+4h5h9zjz2JeZi2GTwEzW+Yb9EcKT/JY2YQm6iNZjtSOSh+Eo22CcSWHUUEp8Zb4YIF7v7F2jIKBunm1XlxTxGvMJuthDL0N0yupUMDi2YJvl6bBi3Za74yeWzJEobRaUj07jIfZWi+Rn/TOnuS0Qan4Zyx5PwCZMugWbLteZb76z59QKAqtuSS2pmhYHaUdg7zo4zsc7XRD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3lIcHJDc2tUeVhUaEtha3orSGZLcFpxVytjZzd3SHQ5eDVDeEkraE5kY2E0?=
 =?utf-8?B?Ukd3aTBTMUJ1UUkzYjV2T090SGdHN2RncWY0YlcxTWE1VU9UUnhCdVNNTGIw?=
 =?utf-8?B?QTBrSFN2R0FYdDVBamh6UUIyZjhRV1ZGbVcxTmp6aFdMaGlvTlVEVk5uQk5S?=
 =?utf-8?B?YnBQYks1MG9GOHFsZmZUalBVSVo3S2N6UFhhdllmYUE0dVgwVDRSbTVNVHBy?=
 =?utf-8?B?akRvU001R0ZFMjlWVEZhQ3ZIVWExYkplclhJdnkrVDluQUpDVkRGMHA5NGhr?=
 =?utf-8?B?d2MzaGtQeTJMLzZ2SjVFd2RIaUJ0dXBpWStlTGlId3J1NHNkK2tGK2NtWll2?=
 =?utf-8?B?L25vRTVEeDVNOVg0dTJnNHdxUzRyRlMxb2srejE2U0piNDBSVWFyNk54TXhV?=
 =?utf-8?B?aDgyRzJmT0pOM1dvQWV2azJDT2dLV2pnWFJmUXhjbW5jclVWRCs0YTZJRkE4?=
 =?utf-8?B?Mmc2V25YZW5jTEFWYjBYSGtmN1dvZExwZ0loSStqa09kdkQxZlJ6V25RZ1pv?=
 =?utf-8?B?a3piY2ROUnR0WDhmODB5MEFHN3RYUjJnaGRwclRaUTlOWk9GSGhVSUdIb1Nn?=
 =?utf-8?B?Rm5PdHRxTHdMN1pDYXlmeDA4MjRVUFZnMm9neUw1WkhQdUlka28zbDg0OUdi?=
 =?utf-8?B?enY5MG5zc1hUZW9RUS80QVg2cWpkYTR5UXhKT0dndkpNaW5VSXFSd01JeHA4?=
 =?utf-8?B?bk1vbExKVmNzcFZQbjNYYkd6TkZ3SkdQSW11cEJqS05rRXg3UE1QQ2NRMGRH?=
 =?utf-8?B?bzNIT0pFdk9lNU04UXc0YnV0T25Td3pKenBaL0FpR1I2U1BqTWdzenJlWWhO?=
 =?utf-8?B?VUl1aTBXUW92ZXZLL0I5Q3V3cXFXcEFPTkxpZDA2L2xpZTFOcW8zSGxaM0RM?=
 =?utf-8?B?cmd1VnZqYmMzVFMxdGI2d1kxeEtnaFNXWHR2elVzazAwVzdTRnQrSGt1Kzl2?=
 =?utf-8?B?cXcwZ3dKa3BqZTlQQVJMeVpVSW5TZTRUTnFIZ3FpaFlCcTJkNSt3YmlCSEd5?=
 =?utf-8?B?OXpmV3l4c1lRaTBlTm1LQW9vZW5aRTZTZWZQOUdac3JkR2RLajRFVVhDb00y?=
 =?utf-8?B?QUc5bmVQenBoMjdrZHBvVGhadnM4cUZjOU1iVk5vbGJxalJ0VGhlQTd4SWZ0?=
 =?utf-8?B?dHBuZGMrVmhmOWFNMUV0MXBITXRQSHpzdUtNaVVQQ0hDMWlIbWVTSUcxZVM0?=
 =?utf-8?B?dUo0QXRXTDh0MU9nYUphUlhxcXZvTi9NYWVRRmxtM0NUdHpZRklKR2ZBV2oz?=
 =?utf-8?B?K2diMTJ4cFk4eVEzRHR1NnpTVGxpK3ZuaCt2ZWlqOTh1LzdZZ3BxWEFGbzhG?=
 =?utf-8?B?NjQ0TDQ4WlZpMGprMGNnd2g5ZW14eWJWckcySE9PcjhEODA1MEk4ZVVmS1NB?=
 =?utf-8?B?SHdUMEpnd054dW5JYUxvbFBKeTdKajlVZUpXd3Y4RHMzTzFkWlF4ZUtBbUxm?=
 =?utf-8?B?bTNkc1Y5cDJjWUQzSE4yNkdwc3kvdk9UTWswQmQ1R2FPTjFoOXk4KzFlYUUy?=
 =?utf-8?B?U2YrYmc4RlZZRkR2S1hpZlNrVEFKS0d3U1p3L3ZIeWZZUEdPd05ONFg0ZHFE?=
 =?utf-8?B?UlZqWEV1Y1BzVHFPcUVZWk4wRnhxbmtZQzdhWVU3L05SSzd5Q3JBMXROWWY4?=
 =?utf-8?B?RWZpZFN3cDU3UGdia2lEM1VVSS9zV05vb2laTkdIOWZvMjk5VlQxZkozQWpt?=
 =?utf-8?B?Lzl3aXNIbHFuOFFvMGF1empBOEVrNStnK2QxV1NoSnZacTh6cyttRkdSZ0pX?=
 =?utf-8?B?cXhZZWJtMHNLTkl5cG83SjBiVFNOL1FFRHgyY0VhMlVPVnh1S294M3Z0aDVk?=
 =?utf-8?B?SmZ3ekx1TnJWS1hsVnZrMkRtcmdlWjBITWhCb3VlRnE0VVROK25lNFB1VmVS?=
 =?utf-8?B?WFkwL1U4bXVYU0ZzWmdiemI0SGt3dzVhSEYyQnRORGdJa1pwSmdkcTN0V2ZV?=
 =?utf-8?B?OVpnTzc5ZzBWaVBUcFVoSDcxWUJnV3lrdlNwV1FKTlY1V1F0VjlaS3lWZHor?=
 =?utf-8?B?RytRUHZoRGROTlIrc1pvYkZlYjFhbWQ5WktiK3ZwaDdhZ1Y5ZDdlWUppT2tC?=
 =?utf-8?B?TGpwWi92NkZGRzVycjVTUU5UZGJDalhjYjBXcTU4b3dMR0ZEZU9xUmtJaHJD?=
 =?utf-8?B?RmJMQ2ZJblQzc25WMjBDZzROSStDdVFRL2NieXdLd1ptbUcreGZ4VW52Uy9x?=
 =?utf-8?B?THRSRS9wNURXZlhMMUwxdDJKN2ZTUVhFanFCd0MzTm8vOHc4c0pnRXVQa2R2?=
 =?utf-8?B?WWR0U0kwRW9qUXhXWkttRXU2NjluMGlCZTZDNFRHRVQvank3L1BRSmw5VGJV?=
 =?utf-8?B?VW40OUhwUWs5dUZudWYzb0MvL2NjTld0SWQ3MlBzaUhGWWVuVEkwZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c685f6e7-9c21-478e-61e3-08dea66358bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:51:15.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XxSs6zeDmgSfM9AKrXldyBu+9mw6EXB5jbfG30R9MlrhitnzJNjsDqpB6ttNX4NNUVqh3dseCsvB1iLq8Dvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

Invalid temperature measurements may be observed across the temperature
range specified in the device data sheet. The invalid temperature can
be read from any remote site and from any capture or report registers.
The invalid change in temperature can be positive or negative and the
resulting temperature can be outside the calibrated range, in which
case the TSR[ORL] or TSR[ORH] bit will be set.

Workaround:
Use the raising/falling edge threshold to filter out the invalid temp.
Check the TIDR register to make sure no jump happens When reading the temp.

i.MX93 ERR052243:
(https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v6 changes:
  - remove the first errata check condition in get_temp function

 - v5 changes:
  - replace the check errata macro with inline function

 - v4 changes:
  - include bitfield.h to fix compilation errors for RISC-V
  - use macro define for temp rate related setting

 - v3 changes:
  - refine the code with FIELD_PREP macro
  - add errata doc url link and refine the commit log
---
 drivers/thermal/qoriq_thermal.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e4b61d531e44f6927b74e79a81f1e63dda7f9aca..35439ec5f8bcbd97e20ab8e770f5ee00e812da1f 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -3,6 +3,7 @@
 // Copyright 2016 Freescale Semiconductor, Inc.
 // Copyright 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -30,6 +31,9 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+/* errata ID info define */
+#define TMU_ERR052243	BIT(0)
+
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
@@ -45,6 +49,15 @@
 #define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
 
+#define REGS_TIDR	0x24
+#define TEMP_RATE_IRQ_MASK	GENMASK(25, 24)
+#define TMRTRCTR	0x70
+#define TMRTRCTR_EN	BIT(31)
+#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TMFTRCTR	0x74
+#define TMFTRCTR_EN	BIT(31)
+#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TEMP_RATE_THR_LVL	0x7
 
 #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
 #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
@@ -77,6 +90,7 @@ struct qoriq_sensor {
 
 struct tmu_drvdata {
 	u32 teumr0;
+	u32 tmu_errata;
 };
 
 struct qoriq_tmu_data {
@@ -88,6 +102,12 @@ struct qoriq_tmu_data {
 	const struct tmu_drvdata *drvdata;
 };
 
+static inline bool qoriq_tmu_has_errata(const struct tmu_drvdata *drvdata,
+					u32 flag)
+{
+	return drvdata->tmu_errata & flag;
+}
+
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 {
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
@@ -97,7 +117,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
-	u32 val;
+	u32 val, tidr;
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
@@ -130,6 +150,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
+	/*ERR052243: If a raising or falling edge happens, try later */
+	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & TEMP_RATE_IRQ_MASK) {
+			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
+			return -EAGAIN;
+		}
+	}
+
 	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
 	} else {
@@ -245,6 +274,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 			     data->drvdata->teumr0);
 	}
 
+	/* ERR052243: Set the raising & falling edge monitor */
+	if (qoriq_tmu_has_errata(data->drvdata, TMU_ERR052243)) {
+		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
+			     FIELD_PREP(TMRTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
+			     FIELD_PREP(TMFTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+
+	}
 	/* Disable monitoring */
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
@@ -398,6 +435,7 @@ static const struct tmu_drvdata imx8mq_tmu_data = {
 
 static const struct tmu_drvdata imx93_data = {
 	.teumr0 = TEUMR0_V21,
+	.tmu_errata = TMU_ERR052243,
 };
 
 static const struct of_device_id qoriq_tmu_match[] = {

-- 
2.34.1

