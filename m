Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C3438012;
	Mon, 13 Jul 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953597; cv=fail; b=k8JeiP2jioUO05/LY3hs6Tq2MO4GcqhDDlX6/v6nFPvr6GccTEuUoHF/Wyaq9uJQsUuFaX8wP7XlD0phYEbTy3CNdw8eeU5rBvi8VYnPa4Q2Nqc0xxNES6sD9I1UqNxPlJx0BmjyVOXgf8pTSuBkla5OoGgLgerfGPdbuxFikXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953597; c=relaxed/simple;
	bh=IgpFAUNF07SqN/CnQX68/f6YD8S2Mf+9tcuFBje6Uhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pyMwOtEXb3L6EEAkHlxBG5XqWJ5p0KvQkkixQ+pCvIVJR0Qg4R9Q5yI9b2SKioGog7Awv5qRpflZLNzBy3XFzlcAr75yYfVNZWhhlLtgOPlQG55ZnD75gUtM3YJkDwkljAfvzI1h2BGG3G8aJAlylVXWwX2wvlaNsLUR8T7CAqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MOW+csc4; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MOW+csc4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIr/PrwezN1oSV1T0xkOAcL0AsDoKl3zgpsropvTH2g+xQWueJV5AYFKc27VK+o66TtOohs8v6E2+ue+AiNtM/rQ1a/IPwbobp8wY/QZ2X1D14QTs/d1ioC+raNJFDV66AUEwMEQZ5KE/5v5sEAFBq5kjI+DS33y6Eskk7/XGX7TMtBakkKTA/Azo3WY7VuYl29KBtQHRANtW6vR9gtEH10SXaSVN7nKLtFr9mdW8JVjXqUoD9KHGPopHNuTGjhskW7TqubAdvEbvVuHD7pD3FcvJfvEfDRJRXSB4Mh49oBtd50yUjRJwkbzKN7Ucbxbz8peS+zxU28uME9XY/6f3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acWiTlHTUZ1Oc+ZJejhLoxGSkNcfVduzEzE8f/nM0po=;
 b=SRjE3tuyQVW1nfvsz0j2z0xcE3DCh+XNJmavOsjt2a+JTNaMVJGWSHabF6EPGFBXRgqp8cCf/kEApGGXqhHrIZ2rV4RpPExYf89kEpzsbUIrbV7e2FoHQojrlMLuVnBIIVLVK4zbtvD3KoB3D4X+O/AellZH1DjuEV00kTwO1+WMlW8Za7ij39QAIyRQK7gn44PGig7AW+QIhEH83CWJr4RSspniv80BckDQI8vWEvJ2Q5X38QwFOhBpoVh9eYvOKNCVxYEhLIAR1HBwy54/b5ExEXdJwaCfIbTzFqMqDFRRIQsbF4ESuF6O4VhKYxwKNc+QrPcU1maoQ5F4KxVXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acWiTlHTUZ1Oc+ZJejhLoxGSkNcfVduzEzE8f/nM0po=;
 b=MOW+csc4QJ7VSC9NV36yop0yWX/5LR+kyJkL8nRoLba0kVzCAwdopuliBjLUtKeUw1OCDOmSnwxmX9fCbHS3HHgs/R9Xt4dIrHuy9PEg0X2CBj/sAQ+Z5/76aoHP0pQ5YWQ+RpMuD/yXnhqy7gHMItyLmQAU273PJT4NvncAMAgXeRVBf7D3RBccHfP+ttfC6s9b13A4/RzEvbb7WtsBqVTbUq8YWP9xdsOfPMIf6Ony7f7H07SOw09DBf9Y0c8EJT7OPXbIgDNbDrXQ5cKQQa3+Zk5zTnKJUbnM2/BdLClIziVPZxzrJ604CBAy4V5QXdGSMuT1zW7e/jPfQ/dVMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 14:39:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:39:52 +0000
Date: Mon, 13 Jul 2026 09:39:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Haoning.CHENG@cn.bosch.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] thermal/drivers/imx: Add calibration offset
 support
Message-ID: <alT4rTJTZSHjDoT4@SMW015318>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-0-09b6b7669be1@cn.bosch.com>
 <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-2-09b6b7669be1@cn.bosch.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-2-09b6b7669be1@cn.bosch.com>
X-ClientProxiedBy: SA9PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:21::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1631b809-c959-4e62-9298-08dee0ec9915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iWPRZtg4gtN6mzfkq5BaDgHYvxSyUy5SsvdFYZsWq4iCav3t/r+naDhHLzP6Las08ZNrdhM8IBal0kCBmbL10Ofn8rnksFTiAtZEsdq7wAGNBmBua7UrMPCfGf9eNWIXCtFkwTnUOAuww/xOFrba/5KONVnAmmOZSAYMRH7TyS4hmvudMQJp2vHl3aQGevY91o1Dn8hJC4qaytO7OlF33pZc2EYJdxFttJOFSsipnQ6Hjlq3FUkjOwVQt6fo9N65OopmzVQdTrKVwAW1FbIzoPTlH68DW3Sai2MeHOawbAR4QAZiSnFAzO1KKPO32gmv7zW38JWwXQFWWqpUht6twb/u4J1ygM66j8g6XN1Y5MmZL7DtNn9HXM3UJVzJx8gj3iGzdhWcapVlHfel9oksGU5xW3dFPpqhHNozmASeyhCeJgrwaY/91ZUg9Hn+UoB6DgH8sVoSB5iCs8+RdbL0NH3NJ5bKMjOm4tIKLGsQ6aKwN6uxE+S8eC/3Ln0LgpAHher+tbiJ5+7iQxNPifgI+iBG7BwuIOVYmnsACssjtVKPHv+D+qGv80ipKumtvlWXE504gMIVcoMUW4P5olcgy1eyY+mY2vs7Q/526poFzoriXpWp/WT6DfB2uK5i23zeD+SJ/ps+xSJFCfadNrieir0bwuC0j2bzO3zzzzf5txc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSciMzk5mUSGVcFC5V9jQIEdZOcv5YfePD3RzeP6uJABUQxFEsRdQAvmpG4x?=
 =?us-ascii?Q?sIGKql81Aqtx7DyohGcqnbwhYmqSj+AX5RW6Ht6Q4DL5SL7V60pEo+J306XN?=
 =?us-ascii?Q?j3RJt+0h/EdBj6JXnnFklpgIam44Toh6B0zECrn0PRAZD3Ob1B+TRNGzw8ii?=
 =?us-ascii?Q?5K5BXdP9PVFBQC2nnqO0ePd7uYCpI7xXDMJJ4orjd/x7hFvQXF6IcYB7cmJr?=
 =?us-ascii?Q?N1MK1ZHyNX8ATxe6NyHrw/1W7xjEjlTIyN/9mDyXMMn9LYpnJ60EXVxDUHW3?=
 =?us-ascii?Q?8McRdVO98bDUZx2/tr3ISprts4hSw0cbkAuM2YerCNSB5ZrXnpNed+KqNBU5?=
 =?us-ascii?Q?3xMsqKThxcLf02pVXeKMjPdsiv6S10GKruZfNegsiZ1ZoeTaLMlkLq9H/IW5?=
 =?us-ascii?Q?7B/ReVB7EvS6pCCWSKuyivViA9a26GXkxPccCXM087KNVtpFtwZxS+RSkbPP?=
 =?us-ascii?Q?ISItFmXWCMxkOAOKpLNp/Zp32iFXhhUK2O4wAGHuO0302WDb+n1LaJYTqpev?=
 =?us-ascii?Q?8mLgvMXQX8Tn+MV8X911PS+GtGZIq8Z2aHcIeEOwIDLlpmQD6brdIowTDSza?=
 =?us-ascii?Q?Kh2CPpBZ7y+hvqgdiJrswlPCOD1QCG/7QZy9LuU9u/kVbKB+5qnsHVsRWUPN?=
 =?us-ascii?Q?iXKRH0GOure8jj0vSKuRFnmEVgjjJ5uGzpVkqJe2Ygo5aeIF0uytIy1jHOjS?=
 =?us-ascii?Q?xmaDVXQv8U6e/4sznD71/+wLmSdDHp7mmHXO9gkO5ERlUT7889UFexDCy78B?=
 =?us-ascii?Q?vibGYaU11yx7MvkT/1yavD6c8k53ZIIQqBla9MzHgRt/w8BeiugvJFzSZW0c?=
 =?us-ascii?Q?wQyUAR8wODdDtE5Wt0YGgOhsftf0gzAvniRihj8NnROsTrvYXXGQ4NJ7DHDr?=
 =?us-ascii?Q?CeTinMjIPtnRcVBQwwxElnDxCaVThNRJ0vb0VoITsyIPePJ9AsJ251IFAC8v?=
 =?us-ascii?Q?qxCJIRWmg1IjhNRqmA4W0tMhr6rv5RyDR1/WqVhDrANBZiAEXMj6BA3U5bAK?=
 =?us-ascii?Q?IHqn5xqHsPRgwQ1r4fFo3IA68xZ55kHBH6+NVsCoSdD6OOR9s5ALInnezoJt?=
 =?us-ascii?Q?e84DeTXZEm9iFxogimeJ2Ss/dJBGHi+qnyW4Bl597MW+q+mmfbPlYE9E7LRl?=
 =?us-ascii?Q?aUi2yDyQF0v6LV12J0FZFU6FnV07ls9GZSm9eyRDDumm37z1yM2DMkjbjzVn?=
 =?us-ascii?Q?mUMXIeo31aCBx6KbnpF9iwwOAPWKCn79mpdHl66O/2eVqAgyyEjVNiGaWtxq?=
 =?us-ascii?Q?8QuOB6wLxt3lDlB0a8mbnQ1rA0OoKVENVAcSj7E8y7t16sk6PrdMsBu8/lDV?=
 =?us-ascii?Q?Ss2zH+5PuDTXuPE8AdPUrDadB2Lswyeo4dnARl2yXvDZbzY5bx2BkmMjcFML?=
 =?us-ascii?Q?LmxiPTkWLgWKF9QiPoeiwi112l/QkOj4aVwoZmcRTNplYTBa9C53m77bm1Zf?=
 =?us-ascii?Q?Xh/TTkkoI2MQ7YgttVk6BbkvW1wCuIfcke9uDrkQqbr8ED3Xy8hwiszc3ptV?=
 =?us-ascii?Q?XyL21hiaSU/MiAVjptR3J426iEOiRuvdnJ+77qmyF+lr7vuJWswaC6ZCt8Zo?=
 =?us-ascii?Q?byE0DLULfttNrSbG09omzSrsXAi3oOmQi4drD1lrniPFBnA22yo3d3nRrxaR?=
 =?us-ascii?Q?cSHDuJJmHXTLuiwrjkBsHkI/PdiMzfNfBzZZ0/q8GTTH1FIswgCAmM5mKfzL?=
 =?us-ascii?Q?GKzTJ5WL8v4UzRGI+FRlylowQXx0XUqcRz3I02Wmh1kSRPAcqbmJF0KheNVV?=
 =?us-ascii?Q?z0fXcm0pUPU7faQWqvrp8LXlp8g0+zFpKOCsmSwEnkQW4nzXq7ye?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1631b809-c959-4e62-9298-08dee0ec9915
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:39:52.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bCXj4LuLZkcNFx/qRRSn3DpChBMJ3MHl9cSfpL3Y8dRu8OSSewwlIyxdlBGS4ZIEz7cC+r9VQDEJ+ql97v5jIclmnzYRIHxaz9S+LXp68uYyNCcRmlvRjHqr+u8og3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

On Mon, Jul 13, 2026 at 06:22:57PM +0800, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
>
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
>
> Read the optional fsl,temp-calibration-offset-millicelsius property from
> DT and apply it to the i.MX6/6SX/7D calibration formulas. When the
> property is not present, the default offset remains 0, preserving the
> current behaviour.
>
> Signed-off-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
> ---
>  drivers/thermal/imx_thermal.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..0a443e608957 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -207,6 +207,7 @@ struct imx_thermal_data {
>  	struct regmap *tempmon;
>  	u32 c1, c2; /* See formula in imx_init_calib() */
>  	int temp_max;
> +	s32 calibration_offset;
>  	int alarm_temp;
>  	int last_temp;
>  	bool irq_enabled;
> @@ -223,6 +224,7 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
>  	struct regmap *map = data->tempmon;
>  	int critical_value;
>
> +	panic_temp -= data->calibration_offset;
>  	critical_value = (data->c2 - panic_temp) / data->c1;
>
>  	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
> @@ -239,11 +241,14 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>  	int alarm_value;
>
>  	data->alarm_temp = alarm_temp;
> +	alarm_temp -= data->calibration_offset;
>
> -	if (data->socdata->version == TEMPMON_IMX7D)
> -		alarm_value = alarm_temp / 1000 + data->c1 - 25;
> -	else
> +	if (data->socdata->version == TEMPMON_IMX7D) {
> +		alarm_value = DIV_ROUND_UP(alarm_temp, 1000) + data->c1 - 25;
> +		alarm_value = clamp(alarm_value, 0, 0x1ff);

Please use new patch update alarm_temp / 1000 to DIV_DOUND_UP() and clamp()
only and show reason why change this.

Frank

> +	} else {
>  		alarm_value = (data->c2 - alarm_temp) / data->c1;
> +	}
>
>  	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
>  		     soc_data->high_alarm_mask);
> @@ -277,6 +282,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  		*temp = (n_meas - data->c1 + 25) * 1000;
>  	else
>  		*temp = data->c2 - n_meas * data->c1;
> +	*temp += data->calibration_offset;
>
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>  	if (data->socdata->version == TEMPMON_IMX6Q) {
> @@ -629,6 +635,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, data);
>
> +	of_property_read_s32(dev->of_node,
> +			     "fsl,temp-calibration-offset-millicelsius",
> +			     &data->calibration_offset);
> +
>  	if (of_property_present(dev->of_node, "nvmem-cells")) {
>  		ret = imx_init_from_nvmem_cells(pdev);
>  		if (ret)
>
> --
> 2.43.0
>
>
>
