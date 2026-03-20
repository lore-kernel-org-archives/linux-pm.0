Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334F1A0728;
	Fri, 20 Mar 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996107; cv=fail; b=JO4lDaykAcFsV8MnJgCXRIgBrOEMp8WdrbFPR77mm2rKd4odVVtTn8wwRtzR9peV3tRjYmha4pEMu78kF6qWT/RcSR0Bcwl0C4GgQsxNZr2aPRnZgzfxISFpknURr9AHy46/TSUq6dr0xnx4u1gbMwXoYRvpoBiZzJ5/TiA7RqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996107; c=relaxed/simple;
	bh=No93PT3eb5cR8lJOUe9cKPnH5bURfIWqsbB65GIQoLg=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=XEt1o4x616x6r6vM294mHQ2aXJHwJhGAPnjWvJhtBYjkBZuAf8NjHBezrY9igu7m3uVuTrDBVidBwafkkZHbYD+LHucNRXCxadFOnhVkD/Bo99NSM3o2vOkhgjLuTR14LGf5L8+S9KMGpnMsmoGOzwyFfrIPEoit+zejfZOwvU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XUYJA7Y/; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XUYJA7Y/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPZqP0DNwUJS4iCFHEVDtGtv6CP5CDdryHjSZ1CMnWkrJ8ZreuN5nPndqe1/ZSCKBzs+hMAhwyvl/2KLdpJWpCH23pTnILBbdxLDVRK/ouV7ZLeCBbAPcItNuCP+UPvl4FvTOWmYb6DipfI9AsJ0pRnIhX2yM0yP0U0kzQUqNLm/KquP3zw0NuLnwu4AMIVWrPWApCKk+9iIieuzcA+p/qcGrZYOsfqpsGJlf34SdAzFr9150XtUT3x1/vagjbsEQyfmIKbVDQxgEonuCtNqG/0wv1wPWFCu1fivvyQ9aZZB91CUfBQFhtTN6BlOGnO67KvzdtBtMx2AVGovPYZXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1drRuRD3PYIEacBs1m6cvTcn99IugJEkS9Axa2eCjSM=;
 b=y7m9JHxkzlFZ4sFnKRq7Xk7oQf6YB2xkGXD0j6brHcg/LobdvjY6ZtZVNFPnXwau5y0oy1Nk+TK0g0qUjLns1P8K1Ju6DPhL5XHOo8Bz2XetsrtRrmYFJPDb7tDhCf8wr/720bZ96baqpgSC9gKQ/TlD9MuFNGWwQoIFOaZy2hyy3262UeI7SF3vwHnWn3DnZVx+ygxkPCv4d4OUVfbCxKFNgjWL01d+/tvpnDNlY0kxjQsN4mSsirLXs2wCmsZz4XjMGyJNuQIc0r7wQw8icLE+ltMID/sfxOwciYtpEcQB3nKTUt83wvX0us33/DgI/8an1KFetN5sxE11crjVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1drRuRD3PYIEacBs1m6cvTcn99IugJEkS9Axa2eCjSM=;
 b=XUYJA7Y/Fueu75aqraqQJpF7bTKgum/B8kUu0V8V60i/Ji37FuvWDrRd6ovOCjK1vEoOWNtktQMYb2GOLFGiQEQk0+kZBaHBS+d2GdKrkZ/vcLGJhceyceKtJr/6Txr/Tb2qNmypw2CmUC9D1sv5cfnocRJv6MLVLAObJAyL+IAn2qovK6X+a6Ov58jxpGEX7Q5bDgqe4Qz183QJ9+WZqxy5ftmm5mNSnb3Ea9RxzR+GeZKNAkR2qQT4mMuEyOZslLUJdqQJV2aOa6xS9CjffCtflVjiq/wdmfS027OiLaRzyz3Fn8GykeFU9C4YGnJTY+JN+6PZFqEBbnfLd9fbmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by PA1PR04MB10366.eurprd04.prod.outlook.com (2603:10a6:102:444::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 08:41:40 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%2]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 08:41:36 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Fri, 20 Mar 2026 16:43:46 +0800
Subject: [PATCH] pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-imx8mp_hdmi_hang-v1-1-ccfce0517999@nxp.com>
X-B4-Tracking: v=1; b=H4sIAMEIvWkC/x2MWwqAIBAAryL7naDSi64SEalr7YcmCiFEd8/6H
 JiZGzImwgwTuyHhRZnOUEE2DMyxhR052cqghOqFVIqTL6OP62E9rZ/AcTCdbrV1UmuoWUzoqPz
 LeXmeF8MvmsViAAAA
X-Change-ID: 20260122-imx8mp_hdmi_hang-e7c5b4bdf1bb
To: Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996235; l=2208;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=No93PT3eb5cR8lJOUe9cKPnH5bURfIWqsbB65GIQoLg=;
 b=T87dhvhWyi1M+8wgxYYUrN9kSGOqbyuHYzBEp54u38LPOHTAtHJPeHLlgVC0H6YEwXO0BrOCw
 bsMS8qWdF9AAcKqNC/brwOLeLKxuOvtwnoLd8AyEzRJEHfzQm9oy7Eh
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|PA1PR04MB10366:EE_
X-MS-Office365-Filtering-Correlation-Id: bec9951a-d311-4057-5f8a-08de865c7ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0WvwVqRgdxFmZ9UMm6RIGo04ksE4khz1Jrqhe6QR8BO2qBQcpO0WJXPXRUymQj0GQD9K4c4eK13NueImlSSm5dDpGdg+Z7T9YiEU09/0aio8hSRUP8BllcpJtPtXGTIVTOoKfJJTAiSUYdHc8QKTCKEwPpl6N3lkvCoftGDF5wtTUFi3Qb73NyzoWIjg/B4swdPxHiMGtAlHgLaFipMAEA1jUEPvYomi84m2k1MTVTkQ7g9o/nPQJ1optaK1VofDhMLjMerJn3oR35yEIhBGm383xM9bTKTazSbKCbU330of7PgNJ0lHNzAihMHC7VQ7L+YmqDAo2KgJyv1Bi07i1DxXMMrBdw2MZjuTkB0OR9avGXOXz45K8kx/7ITqNM+BxyWrUaNQHpgBwHziXG365yjbIbqyHLq0A/FTODTXxc8KYdIQBP5bmf0K3qol3XaW2Hszs0iHJ0crtfQZNYxBFumW5ZDCmjgdvN3A9uHBUcfReLTpo/+BBDZm/7faRs18+YO40rjMuJRCWw0DWFhgJqiDsw6+/EVmnMAH1Q+DRHqeTjlmchNMqwMp+kfN3Cpl19kSdM9r0QVV4YGj5ZzHnq0VfFdgC0xpDe4DQo/IA11Qo+7vXbCyW28ckCoXLxdOwi74T+7YqhPOYrkuG5D0OVdrIXTETv8awhHcTLEu/aMBb5A2XJk8iaIDgoyli0+FpvMD+LpRSx9V+zE//NwjAEcekQL+nTal5iJc/a7ofKBjaEa51oGCX0Av/mSYwTpzcXWJuGJCWNUksiP7h9mpXnZEGg1lx399CtS2nnOynmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(1800799024)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEppa0MyR0VFdE1JZkVqNnJTQ1dBU3h2UC9aOTloRGJrdVhqeU9NSjdGUnls?=
 =?utf-8?B?ODVEWms5dE4xL3NPcEZKczRZbkVMWGdNSGlTUTdoc0h6aU5aMHByUlpscU1X?=
 =?utf-8?B?Rno0Z3FOcmJ6VjRXK0g2SnQwVlBOQ3NBemN0TFFzTUZNZEJXN3lJbWR2M0V1?=
 =?utf-8?B?Uit5TXQ1QjZJRFV3Y1QwT0llRHREb2RKOXlRMWtDTTIzdkhUQXd2L2ZqaWxh?=
 =?utf-8?B?a3VvYVJCTFIrdE9YT2U0UHBma0svdXE0Nis0Umk4TDErSkxwWlk3SWlwZkJC?=
 =?utf-8?B?NXBOcTJJWWpWMmZXdC94MTlFMVhrWFJGc0JUbkN5LzlORFB2WjgzNnZSRGJC?=
 =?utf-8?B?citIMVE4V3JLSUxhUFUzMU5wVFA0aDJCOWZUaklydC8wZWpaQnR4QW5KQ1I1?=
 =?utf-8?B?QzZLMWRReVRFQkVVTldzR1gybWxQRGh4SzV0TWJaakpFYVAxMVNTUmQ5QjV0?=
 =?utf-8?B?UTNRek9OLzljaEhlRnpqTHlyV1FXSFpmL3J0UVkvL1RZb1E2OFBTdGFmMkR0?=
 =?utf-8?B?eWFtbC9mR20vN0IzNzVDM0JWMUoyem0wTm5DWFZwdXY4cWUyMmRrcEJaU0E5?=
 =?utf-8?B?ZDFvUTZScjh2N01QeFV0U0huUXN2YW9kNmVmSWFUVW9hWnpwaUNVWmdtMFBp?=
 =?utf-8?B?Ukh3bmxraUQ0T0RYN3VVT1dNS3pITnZYdUxlNWZzSndjTFVUYTZrbGpiZ3hm?=
 =?utf-8?B?Y0VGV2VhVkFjV0x0a05VUUNRRU1EUGFXdDlDU0xpdFZQRFQ3clVZeDFmWDhD?=
 =?utf-8?B?RjBXdi8vZkl3M1dXWDVvQXVYM1FrYjltZkgzU01VNk9qK044QlYyZ0VNR1Nx?=
 =?utf-8?B?SGppVkR2Y1oxeHBZZGcwTFo1Y3AybkRBUFgwZmxkVGdkZklzVzFYKyt5dEtV?=
 =?utf-8?B?LytxODFSS1RQdExBMVN4bEJaZWNmWiszNVlCaDdhaWlPZEZybVFqQlo4NVlz?=
 =?utf-8?B?UlQ4dkxBdjBNVExPRC9VMWl0bk5MaWNUYlJ6aXI3VDhZQjZ2RGx2OHlXT2hD?=
 =?utf-8?B?bHRpMzk3cm5kZ2tWRExVKy80V3ZNUno5M01iRTNvR21tb0hyRjJxVmVzeXAw?=
 =?utf-8?B?U1pJNHAxWksraXRsM2lUNkNlOVVnbi91Z2dKUnEvb0JEZG01VHppOEJzKzll?=
 =?utf-8?B?WXg1bHhlK09nZjNXZURzUVVRd21sTkU5OEQvYmYyamxIdVlzU1JkaGhuVXZx?=
 =?utf-8?B?SmQ4WmpNRDB5R0JmSHBiNGVaV3FLTldLOG90T3FqZlRBbEpTNjRnbnBVb21U?=
 =?utf-8?B?dCt0ZzhlSE9RWXFVL3JCWDVzSng3NjZ0NXVUcVBOWjR0OWh4dnM4dHRVbGIv?=
 =?utf-8?B?M1ovM3Jjd05wSFM5dzNkRWY5dGg5VVFNa09oZ2wxK3JwN1llWTZRZ2RlRGgr?=
 =?utf-8?B?cUdybzZ6bVN1cnY1enZNZ0ZCcURaZ1V2RS9oNVRoZWtkMm1Qcm9NOEVKcHNy?=
 =?utf-8?B?RlgvM2o3Sk4xU1ZFNmZlNDh4dVVPUnByZlZHcis5c2JUODlZdXczVXJmNjUw?=
 =?utf-8?B?RklWSlROdjBNSXFwVXdHNEJFUVFzNUxsTlZFVFdIeDdkVG5LeHVHeFdMMFIz?=
 =?utf-8?B?ZFVoeXEzRFJ0REZNcTh5Zy9tY2phNU0zTEk0OEJrN21IZkdVWnhRSGJjdzRz?=
 =?utf-8?B?dUVJRDdocEhnVkcrcHkwZytMMnpFNnJYL3lMU2pNUUNXWEtRMkVTelVEUVJX?=
 =?utf-8?B?Y1VYdFRUVGdsaHI0dzh0RTBPaWJBOFBnVmU1NTJIZFBaY3hqSHlidVlIYmdk?=
 =?utf-8?B?UE16VnZtWlFodTg4QnNjdzRDTUdrbGxlc1EwaXZ1WWphYTExWXlDd2xibUJo?=
 =?utf-8?B?eS9zYkNZV1Z0SVFodmJpaDdRSnVWQUhhcjN1UzZDVEJHL0ZjeFRtSm1DMDZZ?=
 =?utf-8?B?Z2xvTUNFdDk3eXlHdG11MHBFbVprTEUwMmxQc1ExNGMzWGNEWnpiU04wcWJr?=
 =?utf-8?B?b0o1MUN0VERnYUFuRWFLcm8ySTNJS3JzUUZmR1BYWmlHS0k0V0w0WHI2a0xG?=
 =?utf-8?B?ZmpiMFJPdWlKNkRiYlAxU2dUN1ZNcm5LTjJyWVNVdndpLzFvMng5ZURnMWlI?=
 =?utf-8?B?WG03cDZMTFl4ZGx1SHluZXhld1Y1bDEvdktxUllJYnZWaVFLUmZ0aDRvaWVV?=
 =?utf-8?B?algxWjRkbGQvU25CVWlMbHVVY3NEbWhuMkFtUmVWS09yQ09PUjJhR25GVkU0?=
 =?utf-8?B?NnhBOFFwbDZ2QzByS2N2ZFlNTnltMGtPeHF1bW5rL2tXWExaYjBNcDNoRFlu?=
 =?utf-8?B?RXQzYWIrOXVyNnpVZ0FjcnVocmY0OG5LSVhyanNxdThHZ0NBNlJkU3BscXRU?=
 =?utf-8?Q?aM7x+I1P4jMmVEpYnu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec9951a-d311-4057-5f8a-08de865c7ef6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:41:35.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrT8NowaF0qWnudOjYjsFW3sYnq7Cq9FmmKcznXdEGa+2tJv/gdeAvPAow0c/fk/3HNE243FU3SLfz/QKV2UcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10366

Keep the NOC_HDCP clock always enabled to fix the potential hang
caused by the NoC ADB400 port power down handshake.

Fixes: 77b0ddb42add ("soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 8fc79f9723f07e34fd3f5162f2c9c549dcdaeb5b..3f5b9499d30a0c8fb8ad8ba3b638d7de1fc55ab6 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -352,9 +352,6 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
 		break;
-	case IMX8MP_HDMIBLK_PD_HDCP:
-		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
-		break;
 	case IMX8MP_HDMIBLK_PD_HRV:
 		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
 		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
@@ -408,9 +405,6 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(7));
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) | BIT(24));
 		break;
-	case IMX8MP_HDMIBLK_PD_HDCP:
-		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
-		break;
 	case IMX8MP_HDMIBLK_PD_HRV:
 		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
@@ -439,7 +433,7 @@ static int imx8mp_hdmi_power_notifier(struct notifier_block *nb,
 	regmap_write(bc->regmap, HDMI_RTX_CLK_CTL0, 0x0);
 	regmap_write(bc->regmap, HDMI_RTX_CLK_CTL1, 0x0);
 	regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
-			BIT(0) | BIT(1) | BIT(10));
+			BIT(0) | BIT(1) | BIT(10) | BIT(11));
 	regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(0));
 
 	/*

---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260122-imx8mp_hdmi_hang-e7c5b4bdf1bb

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>

