Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E32E1746;
	Mon, 21 Sep 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985028; cv=fail; b=t/prPefAJU1qm/QUwrR6R46hlhGKp4oA1g2EWfTelicikNLH15/tPuLmkT89/nEHaeIlRh9wWuy5IIdR1MGpa+vlHmQtb59d+WoGi8gHT4jy9eu/oKVmZPXE4xngwCE4j8j16j+geYJ8k4GcDYv/4VgKmtM1obyoKPgY/mm4Q3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985028; c=relaxed/simple;
	bh=3KdlQgjKlYTY2s3yhqsjG+d0eGxNJmBw6upBiHN4kDo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=n1rgW2O3f+Yo5d3sHA8ndaJF1bX+jKGT4n0msSezqG3u8AMN5TMSExjm8OcPz9IDdTG7rQeh4dJujNYQ+zi670nzVRE9L7WVBsBAvnC2DHhYoQyPjPhC2HdmAUFxsdRZ56XrK7kz/Owuwt2K1f2S8mxBG0WGBiD0KF9lf21Bm0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jIThMgxe; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jIThMgxe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATkxRzV3mpZ/I9RtwkjAoEUwtNjHHtKWouFRlJILWRq75JFZBve4DX2Bv80Z7L7hGeA8Mh8O6rh3nUCJemD06w5nrmebY8lXHiaF2LF1Pc2NJNl/VGxSrx0LIiDCFmLXnoniWxvHgvWB9rrvV2QBcUgFG2bC3FG2ztVyVPWMg3c/rTvHXjZYQebGt3g2GVrq2VydxGqZu71p09K6Gyzsoqm8wsGKRZsax0sP+sgzJbY6L6qjjQfNWG+Mlr2PEQf4I7QSUQr6Qf35XAh32fTROcs0ohyMBo8TiJlyQsg1kK3jk2PDF6NnFPOkvRsoghwzAdx3MXB9b71ofazN8tkXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Gj2h5WwqVqckf2W2yn046r/4+SLZ3Jy8trSpPA7cQ=;
 b=EPzPFrGODauHQq54ZDXIxZNBCe1IwlR2qhuoN5nKCqBp21YhLsnuTprsi61hbXkCmUWqyk53Nu5fnKSvsB74TrvMfuFaEilgMY0gg5i2YdWNhVGVT0MC9fBtXWGUZVrQxMKc5R4XP9j23ZgXMqz2BcydPMNemfihHOUmfV4+5H/4PVqD5iho76u/4/b4qhS30cRB1J6yIC9Crd8kkXXpbQGOMGiljTrMo3oCwxMmzsrccPhGvDP9s2cpGsE9eDZaEtZ9ojUiYcTkj4PBVJtcDAYljhfGOZo9LKSXx1r+0m22YTk2Yfh72EHDbQYxHo1NnTY63E13LD7h89gdWwoDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Gj2h5WwqVqckf2W2yn046r/4+SLZ3Jy8trSpPA7cQ=;
 b=jIThMgxehmpaOuKf2CvvtREm/WEynWaTeOKFKq89lZlaVhDF8yAcih1vK3AVTmyjFLUwXNkgFxO8XoW5W7a0aZQbv9FpgEd9/Bx294Ilquxu+XfToKyd/zKQmz4xAy+o7DV6myakn+Qz6V+avHKf1xAiL1dT4brPZlI8FF7xkcxZe6H6VIvXAv5SFoVydoeXuoVftwStO/9WLdDYJ0HxUWJdmq1aokZzz0+RhMtFqzTA5P1/i+3i9UZKAcdkC9wJweNk4peW0VmYokSitTwjt52syERI2rsvrupdunOdynFYJ8phbDQit6pPNFnTFUQC5TFP164wFtHpCo9y2ESopQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:03:43 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 10:03:42 +0000
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Mon, 21 Sep 2026 19:03:34 +0900
Subject: [PATCH v3] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-imx8mp-blk-ctrl-v3-1-c86b0a9d4781@oss.nxp.com>
X-B4-Tracking: v=1; b=H4sIAPUAsWoC/2XNTQ6CMBCG4auQri3pD7TgynsYF7QMUhVKWmwwh
 LtLMSYalm/yzTMz8uAMeHRMZuQgGG9svwY/JEi3VX8FbOq1ESNMkJJSbLqp6AasHnesR/fAOhM
 NE7LgRHK0Xg0OGjNt4vnyaf9UN9BjZOKiNX607rW9DDTuvnq+0wPFFCuuMhAgQUhxst6n/TSk2
 nYo+oH9CnIvsFUoaM1KKIms8vpfWJblDb/yqJoEAQAA
X-Change-ID: 20260911-imx8mp-blk-ctrl-c46f26783073
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>, 
 Ming Zhou <ming.zhou@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To DB7PR04MB4698.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: aaeb1587-ba63-409a-a997-08df17c79dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NAxXjsOqQP8pEo3v0Z5QUqDo78qITOhYdAMygxplVcjtm05f04gClBiXaCRhIt18qMq7JAxW3WgazWmhHjUoYcNLQzC34EBpafK+UsN5TMDb+kKaQvXvcqI8l44n6lvi444P9EuExTyedFQx484waE1WSqTAbXw6AytvnBTLRd5DaEeluRNOLinzVvseryePxJYkWAt61VWA5LYGm9HwuifGu3U5ASC1K+FHBUhsjtE6XbLoQPdAGogq8p6CwEwu/P5vWX+Wf5bAahFuQXoPLgIur3dRZR7kD5ezhRFeBIVhZg3IuPToeXT9qrFYTt2tmn25MbSlZOtKFh0sIbmerzmCr7ZGW7CGMfAiDP4LaIuuZlotfptYv5yA04DlqSc+j3lYY8X2+B4lJq+HFvvbWnghX/ZqJXsE2OFmsxFaE2nrzi08uOMWbbALPF86mB6WdO3vXTxhOZFzVgichDWg4/wqyCptCBEHaEFY6CUT/GVcVdkX2BOz6ky0wk3CWgmrL1YXE/AuApjrjdMVHuIkCU/EPPvyhkzLHTMUE4KsWZTTZC/0bfHzfxqK96z2RV6/GFqIfH402HHIyzVv8SEQKZVJ0EfOn0FUVyi45/VjVy1l9VP3XhFlLEQ1pE1MtVQ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBqQ2RDcUlVMEFVY0pqVmNqVG9acUpKbnlEVWVzdHY5QjE3N1NINEdWTVQ0?=
 =?utf-8?B?djJKVGNsNERSMUt4U3hQK1VISC94Vk1oY2IwNlpLTHZzVDVPTUdEdy9FNzdp?=
 =?utf-8?B?KzFySnJpZGRQQTN3Z20yYks3QzNkRGMzV1pZVUJsTzk0UXZiTHdxZ3lEMkVL?=
 =?utf-8?B?WFJkYXM1b2JKVmJrWmZ0cXExc2NtSUdDUkRFRGVwQzJveHBlb3ZDejZTTDNz?=
 =?utf-8?B?TzhKRzVKOUQ0Sm9CTzliQmJHTlBYWUNQcmQ2MjNYem9BNElhcklOa0cyaTJ0?=
 =?utf-8?B?N2dJeG9rcGNuRnp5VFo1WExGNkJQT2c2NmVmVXhmNnRnNmIvOUV2aWhmVDNs?=
 =?utf-8?B?eXo1Sld4MTF0RVdoY2FFeEhxa0xnY3FVckpDZUNSTFptUXhWMW1kZlpTVnZR?=
 =?utf-8?B?ajhqVDJXeHJrSEpXZDg0SWI5UlhGQWlYQURYSlI2WUFnbDh4Ti84SjIxVWhD?=
 =?utf-8?B?ekdjdC9RYWQ3S0NCUXNrVGZHZ21XN0pZZHhIN0tUYmtvenAzd2NpNmVCTE1Z?=
 =?utf-8?B?dXdvald0djNZdnV5Nkx6Z0JhQ2IydFJaQWh2N2NUZVlBTm0rOUpDSGROQm51?=
 =?utf-8?B?MnYveTZhZGl3NVdTcmo1eWplVm1TeTYvVWF4M3REdVJTMllzVUNjWE92NHZs?=
 =?utf-8?B?eUozTkFSMHA3b0xxNkd2cHJsOHdPYnU5ay9Bc3BnWFZLaUU0dElMVjVGTFl2?=
 =?utf-8?B?K0ViMVl4UWM0QnVmRm5BZjE3cVBZZ3ljdEpDOU9nYUV3SVE2RTFPSmZneUxn?=
 =?utf-8?B?akJ4aVJtWVdsOHRaVjNQOGRBNnQ0ZVhWSUh0a1BHcDd2L3NVZEtsRTNBcmtY?=
 =?utf-8?B?cjM3eUNLd284MStMTHZEMm1FUGVnTCt4K044RTZVZUpsV2hDY3dHQ2lKNkZQ?=
 =?utf-8?B?VVVQa3VnQTUwWnFwaXlKZXYzQmp5clpUOGJjK3RoeFpkQWJLYkhHS3JDYTdV?=
 =?utf-8?B?RXVBWVRUZkIrZzhpQnRQVXQxYysvdzB1RERRanZ1MWRRaUNZNy8vWWFjNlZC?=
 =?utf-8?B?Qng4bUdkZEIrLzdxc2hLeVNaMkF2M0RmUysrdC9EZXkvaFdQRnBWMmlBeVVt?=
 =?utf-8?B?bjYycmhzN3M3b1NOKzB2OFBCVkRCNS9JN2hDam4yejA0T3FQOGpyVlhiNXM2?=
 =?utf-8?B?OThuNEZ6UlhTUVRIaVVkakRQOC9aU0o0OEtxYThJRG5yRGRvTnZZSktsZzJW?=
 =?utf-8?B?MmFCaVR2ZnEvN1llSnh0WXRncSt5WlJJNzFYVnpGZEhKRTdwMTAzSjBKSS8y?=
 =?utf-8?B?cUhoUXcvYjNWQmY1Qk1GUnhuZjdjaTliZ0haMlN2VXZXcjZ3S1NqQnNWQTli?=
 =?utf-8?B?eWhGNEdBUlNTdGVDcnlkWjVTQUZVLzlFZUV3TWZROWpQVGdVcEVJSnB0NENa?=
 =?utf-8?B?UlNycklMVm9SQUhvU3VvSDlYeHZtRDcrOTI5Y0k3cGtPb296blFlTXFldXdZ?=
 =?utf-8?B?R05PZWJxRUloMVVIWEZJLy9PNnpTRWpIbHNSbXpXL000YUtpL2IzMGpaRURv?=
 =?utf-8?B?N05jNzE5cDh0c3Ewd01BdDhEZHFTVDZFY2dpamJQSkFoQXZ1Y0lPQVVJc0xu?=
 =?utf-8?B?NHNCZVFXalZsR2ZSSXdWT1lRWHByNDAzN0VRWndtT0VuSGpqbTNNR21RTThK?=
 =?utf-8?B?eU13d2MwYU1QTDVNQWdJVWFteE10U1VESkNPR2FwYzFuVVJQZUVNQUFJZHpq?=
 =?utf-8?B?bkNUbHZ5aXRhbSs0cHluYzJYeVVJczRVaW1DaEdNSXpmY3lzNWtQMzNlNWFV?=
 =?utf-8?B?aHZ3dmI4ZDkyTytvUDZuVFUyZnNZTGwxS2hTUVVmd3VsYnU2NzNoT29uUjg3?=
 =?utf-8?B?c1FxSnROR093N2tTak1JZkV4YUM1YzdxdktKVTliTXhHM2ViU3o0WEVlcEl0?=
 =?utf-8?B?N1N1K0k2UFF0aWcyTkppVmFqQ1hHSkc4UkFpaWRsbktxOFZENjFQK1hrWmdR?=
 =?utf-8?B?clAwWU9hc3lOYXliWXc1aVJ1T3NSR29RcFQzZmRXSk04eURJMVQrclpkUWk4?=
 =?utf-8?B?UGo3Nk56c1Z3WHVwbHptUjRsc3hFczdKdXp0bkw1cjZJb1FjQ2NTTXFqbFNJ?=
 =?utf-8?B?U2hYMlN4S0c4cENacjQ1YnU1S2tOcEZJMDVKc0FKdHVoQTJyYS9qclZiZW9H?=
 =?utf-8?B?YVFkeGRiang5TUtrNGFuenEvcTB4ekhjWGI4Ykd4U2FobDhQOHRmRE90NXJi?=
 =?utf-8?B?eTdocTVpZGYxNVNyMnc4ckVvZk5oRDN6ZlcwcWNzQU56eGdrblZoenBHK2NV?=
 =?utf-8?B?d290b0lPd0V3eWRsWlo5VE5JZlRIUTkza0VNU3lwWGlmUEpvYXJvWU1CZ003?=
 =?utf-8?B?VnBDWmxuYytaZVRPbmVWbzVQM3V0VmhZNHFycEVtajZqcGtTTkVTTUhVelR4?=
 =?utf-8?Q?BXV1ZW/9KfrIvq5xkdao3FLXU45vx2dq2q13Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb1587-ba63-409a-a997-08df17c79dd0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:03:42.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygNIkCrCJOTjiBbAh+7rCVlhvsfaILBSwbJEIqSbZLxeVmDGaRTyr4yRDYrxDdjhn/MiUfztrF/wmOl9HdC46ujDDoZ+gMFdHSigRkmj2YJ2XSo33SnVX2KE+6r2ioQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
genpds, each serialized only by its own genpd lock, so their power_on and
power_off callbacks can run concurrently on SMP.

The sequences are not independent: they share the VPUMIX bus domain, the
VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
clk-en bit - so it just waits a fixed delay instead of polling hskack. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset does not take
effect, and its block registers read back all zeros: the decoder times
out or the encoder fails its format check.

Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
driver deliberately avoids a genpd hierarchy, so the genpd core gives no
cross-sibling serialization.

Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
Problem:
On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
concurrently rarely and non-deterministically leaves a VPU stuck in
reset: its block registers read back all zeros. A decoder then times out
or the encoder fails its format check.

Root cause:
The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
serialized only by the per-genpd lock, so on SMP their power_on/power_off
callbacks can run concurrently. The sequences share the VPUMIX bus
domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
not ack-verify the ADB400 handshake - the ack only completes once
blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset fails to take
effect, and its block is left in reset with registers reading zero.

Fix:
Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
sibling domain cannot run its sequence while another is inside its reset
window. The driver deliberately avoids a genpd hierarchy, so the genpd
core provides no cross-sibling serialization.

Test:
i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
this patch the failure reproduces within one to two hours. With it the
same test ran overnight, over 14 hours, without a single occurrence.
---
Changes in v3:
- Go back to guard(mutex) in power_on()/power_off(): the goto chain only
  jumps forward to do tear-down work, so it does not break scope-based
  cleanup (Frank Li).
- Link to v2: https://patch.msgid.link/20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com

Changes in v2:
- Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
  power_on() already unwinds errors with goto, and cleanup.h asks not to
  mix goto and scope-based cleanup in one function (sashiko-bot).
- Shorten the commit message to the essentials and move the detailed
  hardware analysis into this cover letter (Frank Li).
- Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com

To: Ulf Hansson <ulfh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..f8105e87ea3c 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
 	struct regmap *regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
+	/*
+	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
+	 * their transitions interact through the shared VPUMIX bus domain,
+	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
+	 */
+	struct mutex power_lock;
 };
 
 struct imx8m_blk_ctrl_domain_data {
@@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 	int ret;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* make sure bus domain is awake */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
@@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
 		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
@@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->dev = dev;
 
+	ret = devm_mutex_init(dev, &bc->power_lock);
+	if (ret)
+		return ret;
+
 	bc_data = of_device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);

---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260911-imx8mp-blk-ctrl-c46f26783073

