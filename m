Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F503822AE;
	Tue, 21 Apr 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757207; cv=fail; b=THxtmaNZ7mmYi5eWbPQeQ0Li+EnKhv3hpJ9qNgkxXTYYY1Ql4HxwBmPnSGi6ZPnwz1S7B8wHHIz5dw4XFWt+3tHQoKq9ByVwHqR6/WKAwVRw1ePS7828/CNvHz1GGM5CRiIey12G8MUamjdjnSdNCI8pouVdTPZT4G147917Ovo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757207; c=relaxed/simple;
	bh=gA79yqJnH4KwaKvGzqON+0SA9EDEqpuvW2H5bnRAu64=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kESqexhvYlBaSPk7zVWE27Iq496/FVHU2XGs4n1fKsM/PmyW1RuWxxPorK4nvbjbd5yQIDEIzhuFg78NVpGhpct7tcuqnoxwpQc49Ggy/719+8UM2xTyZTIu2xOscOej4ewr8I2Iepr9iW5Uh7aEY9DWkPkhvWwi9qrzD3wUf8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZJpU1JNy; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZJpU1JNy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZpg41ZGHrQ4T4M/vF7Yg3SgvE05qXlkTxkt/TVKI65o4RUw2EZIaD0ivyutDByDQ8wMe4AMFqLEXknbVKZ9Gi4o7bLBnkZThryWvtNhbX6gS/+JDw7iFIua3NbVSPpj2ZaW1/KndvnFVQ57AvdrsDidOhsB/HQu4Vfl//3kDPNcpGWaSMd9eBY6st/NDKu+hfAhi7y1tGf/VUbWdYa03obvi+1n5ev62fd2vB9zB2mPV1qISnWJcFU/vIVRSaf8/8V7qDqfWk6uaNg97IgzQq4vCraEy66XUVMwRbVBZi6u9BgpJXoYN1Q67q89v9XJGhK2c1CyPJRtXRPIwC1BOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbodrmBgx8OkmuDXW/5edobqXvzAlAXjoNFf/fQmAHM=;
 b=syEpKDR05CEvoYcpGKTQagw0VkPmJMW55vV7jabVy5CGo9yxnSKZhTtqncM4xSqcp8hbEDfnA1rmaB2bsXtXRdUhWZUIfSdXoMNmQJMY1KboL2Wn5oq2YZjwZdV6g3c16O8IY3WMkfI+7X60x6xDCMjcypnwLqRzH2yu2jwz2uEpRZ3xiCn/z7YzwGB3oiVkxS2qCW9KC+5Au8g5fVNqqnFYuxkc9QzEmluL5iKPFFIDKo9iIuCi/1Xj9KHG3Ppn6cyCMp549dljkqpn+1VEGOFviEFq0Z9ZrGGeC9fhnZRlRhT7sHgr2ZAx0Dg2xG9w+rdA8FxaG8SA+pPk6nG4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbodrmBgx8OkmuDXW/5edobqXvzAlAXjoNFf/fQmAHM=;
 b=ZJpU1JNyrmgteX2z1AJnmwN1cb2SxsOQOiPt6ghpIlom/1VeD4EFQqjyGa+vT31qZ/gul8bUAyGuMM3GEpqf2TIEt0CW34yB7gwygeCM1Xo2p1DcVvpkjo46TKC7JtSON3UdovPBytIDNKgxoleDKXZ36teV/+/89MEfnOZ0t1QbmUoKhGq8PQmCWQqdk3KsB3dFrfwKqRbNKP8Bi2euwTQVsN/gquFWVGrvjwX+rFFkoTscDpElPSlbS35Rl9jt1gcuchlD+bQZ5eZFGxmK0VCwsqJ8kqPrCJ8gDTY3uxtUrFtpt9fj20d/JMeXJqZo0NL06Nrv9A4BjE1skYlEhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:40:01 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:40:01 +0000
From: Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH v5 0/4] Update the thermal support for imx93
Date: Tue, 21 Apr 2026 15:42:21 +0800
Message-Id: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF0q52kC/02OQQ6CMBBFr2K6tqRTaJm68h7GGKitzAJKChIM4
 e4WY5TlS+a9+QsbXCQ3sNNhYdFNNFDoEqjjgdmm6h6O0z0xk0IqgaLg1M4mv43tk5eIaFHdodS
 Opfs+Ok/zp3W5JvYxtHxsoqv2BRAIACYDY4w0yIH31D2yuqJzN/eZDe3WamgYQ3x9Zk35Vvz6g
 LsFU84Fz5UvTYXailL+Etv/qdh5EvZekTxtvdKItReg/966rm+fh6GNFAEAAA==
X-Change-ID: 20250804-imx93_tmu-7888c85d176e
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
 Jacky Bai <ping.bai@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776757357; l=1531;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=gA79yqJnH4KwaKvGzqON+0SA9EDEqpuvW2H5bnRAu64=;
 b=40DHlikiX614jZsNdCVcUt/CxajuMErTut58IWJknVA2dC8fS+0UgZEX/dcVqfCBlfuVC6SDq
 D711EV94zwFAZ110VGK95ZewuamYQbgifZtVNmOj8sOm28AFC2luokP
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: a294be87-dc61-409e-1b4a-08de9f7931fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SxL2vL/XOP3Yh13xYMcXQbWinavJztbhXnJ9ZIdN1QLDuCQG8HJ9Mbqih+PlmKZS1ddYth9y62e5IW3tj41aOOJSKUq3JXYKI/38UBF87KZ2NNxmKOBPMw5GyUfjI+8gdh8b8UGGoU9VJuaS3IZCafgiTv2bxFwQZLjV51sCquugwZaKrn66G/MPG3VuUHl1FgX+S7lH3uIn0KmHa/IwJFnxINHN/+yeiuWLjihbgMA+8dmGb0InT/vsDhtqE4jZV+1GqYaPcZ2a+rqe4ipt91y11flICQHgMNKlykWHW71fMwe2VMEd9My2poqr3ijHntPywv/UJMsjvOOAvzRKWxIvhdEgYFxy/R0/HmtmsL6yrqG8A4avSlXAzTpklJJkA62JqKCGTSKCLcJ8mcm2MExgKA/gS8FryOKF77VYl+yUu4BUa0AItPqpaJ9AmRwq2ePJ+/csMgMSDdNCN4/Daf/mtResEX05FbCN1QL9miCYCZ/Mwb1TxbMjOqkBokTqpZbEshBIMKfjShunANI/RBIe/lbb2O65977PQ8ha0b1HizPHXaP2Pcx62gYGX3OHhhuAqD6oKH/Zh1uafImJLH4/fN/TjIU/fT1UUUXa3j/Q2KKWvPtT8oytqwWmHMehruolkTFVlAmTgauTjxzazyLIjDpt1NFue1YWBxfDvqem3Pbo4wYrF2e6izMRY44XtWvD0S1xgiMaI+7R2xgFevp7EQzRqssQFz3uF5J7k44TC32FHyuIr7TBu1y7iv/dm1pVtFYplCW1cOTn6XB3HSfU6X7isVDqG8lQ4JP4cJLbVuhDRwaYoRUf2+U+Hkq2zEnLIRpnh/qS5646lRd9Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dyttQkE4QWdSUVFkbGM3WVhESGtIeWMxQ1haUjZyU2d4MGFoczBhUWgvM0l5?=
 =?utf-8?B?RWtBQjFncU9kN1A5aHB4RjFEcmJJTG9SVk1VbDZjZ2JOb0JXWDE2bDVma1l3?=
 =?utf-8?B?U1YwNkNGQXFHcGFvZk9TbGNrV2tDOXpPNlJHR1BLeWtYS3hvVjFVb29UMHhz?=
 =?utf-8?B?UTUwWU1tSmZ4cWV1RkVwQk5HaUpoNTVMcS9nWFRldzlSS2J3RnJsU3J6NlVY?=
 =?utf-8?B?MlVrNGM1WS9LaENYT1FqSmsyNWU0OHhqYjNRS1VlSEwzU1pYMnpYK2JxTjJi?=
 =?utf-8?B?Zmw3dk0vNVRwM3ZkSGd3VzVEUXlxQmFmdkxqT05JYU8xZzhXaDRpN2EvZG9Q?=
 =?utf-8?B?d3NPdUdnWnF3ZWxvUzVXZ3VTN1ZPcnc0aUNtZEFZYXJQZmgzUlNXSG52cmhG?=
 =?utf-8?B?UlE2NlAvaHpXb3lNS01WbG1JaGpKZUg2UDlNL0VoZnN5eUhpeUxsRnFGb0hJ?=
 =?utf-8?B?eVhjNmxLUHg3RjNOQWlGNHIxNnB2OFprNkJRMXpCRHVpVzJvN2liZWRVQUox?=
 =?utf-8?B?TTEwMXdON0JXSWt6cWl4dGhKVm1pQlJiZkRSMWZaVVVXdkFHODh2MVlwaG1y?=
 =?utf-8?B?WGxzWVlVS0tkbGFYbEZFZU5hM2NCa21rM1RWZWUwZTY4MjI1NGp5Unc1c0FT?=
 =?utf-8?B?SVpuYjB6Qk94OW93c1RFbDh2SUlvdHhmOCtvN3BZYit4aWJqOFB4cHJPS2cz?=
 =?utf-8?B?bTV2cnhBY21QSUxBQVNUemc2VEtFK2srczlER1huc3ZOdWdEUkdLbXhGMDNX?=
 =?utf-8?B?Z25Rc0NBL1BpUElwRGxoWUxSdytvR0tMOXgvZERvOHQvOFFtMytDZUYxZ080?=
 =?utf-8?B?ZVE3MW5nckpZamtlU3VCNTdhZ0FpdmRGNHJxbmRHYlF1UjVvOEQwYncxd2xz?=
 =?utf-8?B?TEdTOTVYMkYwNENBb0pvMy9JbmZuMnlLY3oxRGVjcFNwYXkvTWp5THpUZi8w?=
 =?utf-8?B?ODQ4WFpNbi85L01YMU0xUEk0eXVxNnB2M1lXNU5GNFBpYUdVOWlkR2Zsekdz?=
 =?utf-8?B?TWZPL2U2a3JQbTRtR0JvSEdDZ3BIU05pZXU4eXF0V1ZDZjR0bFZjb0ZnR254?=
 =?utf-8?B?MlN1cDRWdVVqZlRNcWhOZXBIN0NLSllLcVp6WGN2K2dCMTllQ21DMFVqbVda?=
 =?utf-8?B?U21nRDk0em5QcTBsenB4RmtER1lwZkwvQ0s3OEd6eFJJbkgrUi9yRUsvN2Jk?=
 =?utf-8?B?OW9rcEZxbDhIaW9wVlFrRGJqeEMvdFVYNFdHSUpaRXRBVXFoU21vOVorQ3R1?=
 =?utf-8?B?WXBqbFd4T0JkcjlSWGZwQmNyaUtiMi9JQmVEeFVQaUJMeDY3TlFVUmRXb3E0?=
 =?utf-8?B?TlRYdDMyUjk5UkxWM3RpaFRJN2hQdzVpOWRBUTRBS1luTzdPR0YydmtWQk9n?=
 =?utf-8?B?bFFyMHEwc2VuQkkyejBnL3RuUnJnQTRqbFFrWGdlMXpZQVRyamMzRDVFK2tR?=
 =?utf-8?B?QUNPQVk1Yk1uY3ZKVTlOdzR4aVI1Z1d5Y0FYVXlpekhLYVB3eVlUSzBtQnAx?=
 =?utf-8?B?S0FySDZ2dFZ5VGxYMDMyZGlIYkpObERDQkZzT3FueFQxRUFSL2RqVisvOUtR?=
 =?utf-8?B?SVUwZjVNaFdzL0ZkTHZBOHREUzdRbDlIeEFNQnpjUjZ4TnlzRmtRZUNlMzBW?=
 =?utf-8?B?ZFIzcmFmekc3Qmo4OGVwZ25RRTE0cmRvVkdMWHgwMnh6OVpVemNwbjNRRTBJ?=
 =?utf-8?B?dXhUaEw1bUU0dUlIY0FzWnJMTk1TMitYZk1KV05sNXBKaldlSWZHMEo1bmtZ?=
 =?utf-8?B?N21OZE01aUlxMk1yK3J3RGdPU05jakpsQlNPTDJmbDNtNGVUUENObEg3SUhL?=
 =?utf-8?B?c1dXOFRDZE5acVYzMmxqYnlBTGl5TTU0anhyN0x3N0tmVStQTnk5MzdxUElY?=
 =?utf-8?B?blB1ZWV3Vk5BTTFvY0hRNjZtKzEvU3BqUlNUakU1Y2JiNWZuMWdNYVNTKzFR?=
 =?utf-8?B?ZHBmcWZjd01DY1JJZmN3V0w2SnBPMklaNS85anlwZHNTd29vY0xpK3oyUGcv?=
 =?utf-8?B?bXQvZlNrM09kOGlIbWNLNld5dkZVNk9TMVlNTWRXbFAwUFVtZ2hRMXBKdlVR?=
 =?utf-8?B?c0JRUkE0L00vVHZOZ0x4ZTVzclI4Y09GRE5SU01GSXV3Wm93TEZjTHA1Mm9z?=
 =?utf-8?B?M1ViT0VuV1lSVXpuMTl1NEVuNGt3Z0ZlYlF6ZmpHTGExMVJzRVlVWGF6Q21C?=
 =?utf-8?B?WTFqLy9NcUpVbXQ1cCt0V3Q0YTl0bkJ2STJxZXZyQ1VVcDVtYm41ejQyckk4?=
 =?utf-8?B?NlYzRkNyQkxiOUVlUmlFcXEvUm83S0Z2ell1cG0wZzhWNE5VdXJMSlFpSDU1?=
 =?utf-8?Q?Wyxzgt+/gw0xQhKz8X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a294be87-dc61-409e-1b4a-08de9f7931fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:40:01.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY3T+wIZV09YtCz91+I2qVwdMPZl5VqeT4ZkFbqp9WTAesu8OlyVpDVTPWFe8uBFawUJpr6DMVzyikoCkKh/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

The TMU (Thermal Monitoring Unit) on the i.MX93 requires specific
configurations and workarounds that differ from previous implementations.
So, using the 'fsl,qoriq-tmu' compatible string is not appropriate.
To address this, a dedicated compatible string and corresponding driver
changes need to be introduced to properly support the i.MX93 TMU.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v5:
- Drop the unnecessary macro defines in patch 2/3
- Add the drvdata info for each of the platform as suggested by Daniel
- Link to v4: https://lore.kernel.org/r/20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com

Changes in v4:
- Include bitfield.h to fix the build error for RISC-V
- Use macro to define temp rate threshold related settings
- Link to v3: https://lore.kernel.org/r/20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com

---
Jacky Bai (4):
      dt-bindings: thermal: qoriq: Add compatible string for imx93
      thermal: qoriq: add i.MX93 tmu support
      thermal: qoriq: workaround unexpected temperature readings from tmu
      arm64: dts: imx93: update the tmu compatible string

 .../devicetree/bindings/thermal/qoriq-thermal.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  2 +-
 drivers/thermal/qoriq_thermal.c                    | 82 ++++++++++++++++++++--
 3 files changed, 80 insertions(+), 5 deletions(-)
---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20250804-imx93_tmu-7888c85d176e

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>

