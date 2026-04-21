Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903B282F39;
	Tue, 21 Apr 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762890; cv=fail; b=uNEw52B5Y7s5jWltpmP3HsaQopVw2PTacg8jehL+yWLLbNnlmAAfKF8CW64fxFU4WsynDhoQVLB8S0RysHNWUiBgEUCVyzZYjiXQd9f3E1yuAJZTQz/ySHHM235+VXx2LDbLYWyoLLLI0smik/nrvR4uButGsSORsvJutkGHDeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762890; c=relaxed/simple;
	bh=LuHlDA5lOY4YxWrZy7+2pAw7hkN50ef3ZgRO4aMT8fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIG3W/Bsjz0OHi+FkfCxRTTEw6Nc8LOZair0DejcKRmElzaIqKK5sCNoK4zlzPfXbn+QP2gXK+aJ1uFxVMGavuHYZeW0qY/cGWtgnzpUkOsfwMs7mwxOveFOVpGOjAC5he9XLc2AzjpmZvZECcLYTYYndAa+7FLWttCnq+K9ADY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MEy/mcKH; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MEy/mcKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUTg/smy/gnI+ZlojpQ2Ri70TmunqOYksbq+EjDFpOj9mXQ8CoEF+Ul7NJbhywZHKSGXuwJQFnVy5N0W2liELTxABCM7Jnm9a2qnwZwj6nv2U7d0FiyuF77sKYBxKp8qvonSiERVmQhjnryhbmedklPyo30cBM80t1ZRvk3j5hQmj15kivzOZCQZokmUuxIgceVEANP2z3v6bcCa3nmd1q4OY3qFOYqTI5h65vGx/+HmTfPWf8Ie9e27feYw6NWOhO195GRCrPlTpxkxcgeGsawPLW/bx+w2gizqWastvx8QQB4JFG+d8u0qucji8nj/1x1U4OsLP2ebVp8HqkHs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0291rZxB/fZKrDJ7YELZLdzOoPInT0dvrseXMaylWQ=;
 b=TscKzf3O3WvwrMqCh9xXehhNihq9lJlJRI1D930BW6bth88sPhr3c6Z2OLELIOpv8i1zoooouKRvea8VZQG11qspvZoRzbhA3ldMr1UiE+6cKjrCtiXbnEP2zSkE3b6CxB1xqC187Lc8kC30Jl/Z+4YjTVTjc9aig49bE8hO7F8JQID4Q/dqjBvYwSt5HLFJVAee0sDwYmD9Prpszx+xgyND+OTEd+NMJ53Oyx2L6FvOf1GaGdkIscLy37RlRT764vpnDUdOQkPQhLcJCwJtGWdqY65nf/O5mJkXHtbESLg+umGJECu4YSRQU3rTxw7jC+5Hqj6Jl+OWebSUkLeKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0291rZxB/fZKrDJ7YELZLdzOoPInT0dvrseXMaylWQ=;
 b=MEy/mcKHwuPhPGMLhISBIco1k+NZzrpZULzvG+T1g7BM+Aej9VWcU2wC9NXXaAGsP8zRpfEF9ixoXU53UzSxqB/tUStExumKGn96YV9EDVOwdi51HOQ5h5oFgvQGyBLY3pTpb3LcOs4GqvJ8XAXmiSOkH0WCsmib4Jq14ubdT6Xj3fcQmWEwXo1BTBlnwvVJu+bRvHyj18m6MDnQFGFc/1hil2+QfRy3db57XNlRNTANzbxJtHR+uBH0RqVII0w94unprpIM0D3Y+/qrnXzB42L49fHiTwtdwMTZPq9+mvO1TXQ/ITBPNfFpNQ2G++8X0YpH7m34LJDUbztZQRNkXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 09:14:45 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9818.023; Tue, 21 Apr 2026
 09:14:44 +0000
Message-ID: <2d1bbd53-1f03-4432-8681-939e0c638d37@oss.nxp.com>
Date: Tue, 21 Apr 2026 12:17:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] thermal: qoriq: add i.MX93 tmu support
To: Jacky Bai <ping.bai@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Alice Guo <alice.guo@nxp.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
 <20260421-imx93_tmu-v5-2-05ea1969bb9f@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260421-imx93_tmu-v5-2-05ea1969bb9f@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0158.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::25) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: d19c91be-4170-4a77-6081-08de9f866d93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TXRxwoa29C9QUbW9OXILQBjXyAeRAyMiuYkLX4lRQCtp2gJ+ruF1XjfQvGUmxVRrInNlr+iYADKcvjrmCZ1LX+mgBQDZ65gdp0bUHdltBZQ6v5wPkZyvdYlj4Dt2haEXbaXNJxuYjoTsSBxpnoNont+lAUDpKSSIkbN8FHHIxq0iN12QSBQym7g+pj8fb5HleJaM90QM8iDbUqj9s+qZAf91AZRup4pWwQdSNfbAmKIwFN6wnul0X1UbU7SX3AR4e9PcHTS9HdcPcslRnjDzdKkAl1kHNTs/RfxemfcRDf+s7xyZvTMYlxtB63RyNNuVsoOiT9/tvt2H+CGKdRHGl/r8MPIFAwo/wNB0TQp0Rl3FLbzt9GUvMj4wdSChO38AkKzPGAYa4vQyjOFYFwa/7N2oOB+YwTPcwXh9et2Njdk/4SX8b3jTC/8537aplKAh+r94TLSaa9MkdxS4areZDDWNBQytT827Jrlg23RpTjkD1ejQBqvRbB05+q5A/QcUd3ZxWu/zlINAa+LBsyMFQJ9Y60JOgF/ycbUGlki4kzFLbk1/hkmYAA+Uw69WnI+djGmR5EFQZSR1Z3TIewNwtrurvxaxvM5coek4jRjkeDUBiJ7XCPoFto1w2PGdIFexjgwWex8ICUjUcGlKirzFt5h7X+YIHAAiL2dUHui2dp+vNRWz0IF0/96e0PB1n9tj0msroV5LQVmc7gY214ybtlf4G24ULAMLSTax42z6ImVuI2KWKIiLkoalAzs6cKyxqQ6VPBiV/cPDKbTaCuGjyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2llTGgzNExFN1gwem5mZFBCc2F1ajFSdlR2ZTgrczlqRGhmTWFKQ21RMk9h?=
 =?utf-8?B?Z005MU5GSTkwVklmbjNaZUJxY2dKY1p0dGoydWRWUEJkSXBwVklHc3VBMGFp?=
 =?utf-8?B?MWZkT21MeVIrUDF2ckE2RTFUZkxvbDVBd0hpVVovc2xXYXZWMVNBcnVwMVBU?=
 =?utf-8?B?UUR2UFJabGRBcW1uTGxISG1TSURmNklRY2IzUlcyZjNmcW9nNm81MnFqVU12?=
 =?utf-8?B?WG1DR1M4WGhPY1diUmNINlk1RGptRXZOR043UnB3bWFYdnNNOWxjNEtMMklC?=
 =?utf-8?B?dGR4TlpXK01YRTVVc3RTL2w4eWJxbHRoVWpaQzZIWUQ3SzQyejJYK3R6U1ph?=
 =?utf-8?B?RENnTWpHMHd5UUVHeXd0L2JDVHljeHRlK2RvRUVDVmkvTzk0VWo3S1FvRi82?=
 =?utf-8?B?VmpIYW1xUmdaOTFObkprbHNHNjVuRXI2VjdsSlZCY1Y1NzZiSXVXYUdCZDJL?=
 =?utf-8?B?R0RTZUZ2WEJBc1VvMm1GcEdpY3VWbjNOeGJIaFVlS2pXNGNKZnNSSTRiY3Rn?=
 =?utf-8?B?MmEzTW5JWFFvbnZya3ZnTExBWTN2dlpFR292d3g2VUhKUHRMNzcyYnB4OFdu?=
 =?utf-8?B?MEpGMkFJbS9wNkdMUnFVWXprQ3gyTEZFdldDRkFZVEJIUjFsVXVCaVFuUThS?=
 =?utf-8?B?Z3FQT05RN0xrNDNoTjNJS3VOeTM5SmY3enJSRmlURnl5Sjc1eDVYNDZWWWV6?=
 =?utf-8?B?bWo4V1oyYlk3Nk5xNlFIaUo4UnJBQmJmYmM4UWlvTSt1SFRnWk5wdlpTeE1x?=
 =?utf-8?B?YmFRQUNaV2lxUzlSUTNYbDFLM0lhL0dWZDJNeDcxT0JMV1kwZ2hLejlHY3JF?=
 =?utf-8?B?dnBjWi9KUUFZV0RjSGhxVlJ4VDR4dVRjYzFZY0daVStnaGQ0ZjNscENoS3JU?=
 =?utf-8?B?elNxZU4xL25KUC9hanozcG1UL2xLaEFtU0ZlekdrazdibVdUSTNSeXd3T2JB?=
 =?utf-8?B?Y01kay8yUU1uUzZOYkhaL2QyUjVvOWs4M3ltTGwraWlhaHZBOFVkSFFDa3Nt?=
 =?utf-8?B?bmk4NDlaRGFzRVdPa1dTL1lUL0FzMjFrSGlPNWp0ZTV2ZktlVW9IdnB3OUY5?=
 =?utf-8?B?dkdQTzh4eE9LbUI2NEVXOXJjUThuUGF4NTBxVERQNmtMbTA3d3V2dmpYS2FK?=
 =?utf-8?B?dVRGajlXaUZTTytpc3VvZFlTTE5NcVYxbURZZCsrT1JUUk5QeEQ3clUwSFVL?=
 =?utf-8?B?NEZkbklsdXlQemdFUS9TKzgrZENxYmlKOHB1dURlODJ2cTNkWlg0c3ZmWTJB?=
 =?utf-8?B?d2ora0tSSmlwMlM3enpMdTFvNElpeFhKVjUwMnpnazZPQmh4d1JheXFVYzcv?=
 =?utf-8?B?SmxEVXZoS3lXbi9PNGlDVGVMa2U5ZEpxYzljMG5hK2EzWDVYR2VqdHUwTE53?=
 =?utf-8?B?UVVpMTFKcGJrNlM0NWYyU3VYWkpIRmRHZkJEMFhZY0JhRTB3M0Rja0xiWGdV?=
 =?utf-8?B?czE2bU5GTWtoS3J4ajhYOENMLysvZDJ2RzJzTHk3SlRRUWt5UnJRaE1rMGxq?=
 =?utf-8?B?UDdWYmRmaWJ4eUhRMm9kQUhnM0R2MmJZbUkvelhzdFdOaVJOWDlxYjBMM283?=
 =?utf-8?B?MGgxTEpEZm1NdzZqMkRRanlMbUNqcHU0cFFvUmQyQXpKQkt0d0ZId2cvTEM5?=
 =?utf-8?B?V3MwYjJQaFBSOVJiM1d3ZUU3TXU0VDFEVFFTSFBQbEwrL0VqUWlLemVBQi95?=
 =?utf-8?B?T1gwaUFtRTQ3QXlXSXFkT2hKRWYwaHNuekl4ZWR5dFJaTmJ6dWwvZnByYTZy?=
 =?utf-8?B?RVVTSVpxcEYvTnpySzJWUFhYQ0thSGpJQkppRXhhc3pkSUk3SzlZb1EzY016?=
 =?utf-8?B?OXBwVmhKWDB4N3BrQ083bU5MRkFRNSsyNVFvSGsraFRyZXJCLzQ1UmVVYUhC?=
 =?utf-8?B?SWNUWGQ1OXJzMXgzUWZmSDZrVEpFRE16ZFpwbEZpNkhIVEE5eWQ0WWhWbHBw?=
 =?utf-8?B?ZTgvejBqUW9jZnh2MHRJOGx0MjlSVWhhbXpIdEdMT2YrS1JzaUZ3M1RNdC84?=
 =?utf-8?B?dFdFbTRISlBIUnJ1N1QraEpNR2o4UVFnSXdaZndjVnZVUGVyQTBWbFhXYjlF?=
 =?utf-8?B?aGlvalQ2cWlsZjNkcnNpa3hESVRwdHhBdDdZeVZIQjNyM0VDN0dJekhONjN6?=
 =?utf-8?B?MGVHcmhUR3Y2RTZSNHNobHhCZXpjd3krVGhVS1BuVUs0UGN6cnBXdGxVaEhp?=
 =?utf-8?B?V0ZIUklzQ1dkcjNEVDQrNnM4bFZlaUNsNlFXKytZTE9DVjVHSk1YRXBpaXlq?=
 =?utf-8?B?dEpSVE1leTdOcTdCcUJEWXdQT00ybzVvcGQwVDllelV0emx3bHc1MXU4SFVB?=
 =?utf-8?B?WDRkbXZyWXNGZG9OYmJMbjBoOHdTaEphTmRocHZ5VXNyRDFmUEd6dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19c91be-4170-4a77-6081-08de9f866d93
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:14:44.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4QxiGnwv7JAv0KLDf2WUbG44ujBiVxXgb7ROHsXdQuFamWrJqIhiSp3Ef8GnMB/ZCmj2V5/zbgZxGu/0C1kAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056

On 4/21/26 10:42, Jacky Bai wrote:
> For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
> from the ID register is the same the one used on some of the QorIQ
> platform, but the config has some slight differance. Add i.MX93 compatible
> string and corresponding code for it.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v5 changes:
>   - drop the unnecessary GET_TEUMR0 helper macro
>   - add drvdata for each of the platforms
> 
>  - v4 changes:
>   - no
> 
>  - v3 changes:
>   - use the drv data struct for match data and refine the code
>   - update the copyright
> 
>  - v2 changes:
>   - use the compatible match data to identify the i.MX93 TMU variant
> ---
>  drivers/thermal/qoriq_thermal.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..297a855311f3d6a8d527794abe17ac86c47bf152 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  //
>  // Copyright 2016 Freescale Semiconductor, Inc.
> +// Copyright 2025 NXP
>  
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -24,6 +25,7 @@
>  #define TMTMIR_DEFAULT	0x0000000f
>  #define TIER_DISABLE	0x0
>  #define TEUMR0_V2		0x51009c00
> +#define TEUMR0_V21		0x55000c00
>  #define TMSARA_V2		0xe
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
> @@ -73,12 +75,17 @@ struct qoriq_sensor {
>  	int				id;
>  };
>  
> +struct tmu_drvdata {
> +	u32 teumr0;
> +};
> +
>  struct qoriq_tmu_data {
>  	int ver;
>  	u32 ttrcr[NUM_TTRCR_MAX];
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	struct qoriq_sensor	sensor[SITES_MAX];
> +	const struct tmu_drvdata *drvdata;
>  };
>  
>  static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> @@ -225,6 +232,8 @@ static int qoriq_tmu_calibration(struct device *dev,
>  
>  static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  {
> +	u32 teumr0_val;

No need for this here you can just use directly: data->drvdata->teumr0

> +
>  	/* Disable interrupt, using polling instead */
>  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
>  
> @@ -234,7 +243,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
> -		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> +		teumr0_val = data->drvdata->teumr0;
> +		regmap_write(data->regmap, REGS_V2_TEUMR(0), teumr0_val);
>  	}


