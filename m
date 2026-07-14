Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59544445AFA;
	Tue, 14 Jul 2026 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039411; cv=fail; b=bB+xDTNCaeR3YkpdtMD8TzerpUncewRPPD2VY8hg7iGv09hO7Z89cEmiIkL/Adlpa1WtNU+Tkyq+8LwlcafZtohyOioEBkIYqo4EQmv799iX6Cim1fn3evWQeLJNMmcqZby+Z8Uq5ABnC49UdGhydYagxbL1gnzWjCv1HUJFl4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039411; c=relaxed/simple;
	bh=bfaX/5mcxhz4zbKKPLVsTZGtnNkALf6AEAAqQysqISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWxpfsqu9yX5kxlUlWyrmfZD3pMDD5jKlTaKSw1JfWnvSp42DQxCf7lEXn7T4F6P5gFCQowaOm5rWfg1ujPoXDu8bbI4MjXntf9cScgCw/OvFdlSVao/1MDKBZ0uHX2zHBXAkVwYd/Do3nHaQx3oecOpKnFHuo0zqL9TVwM/wV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dL4qzYuk; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dL4qzYuk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veVwCDQHeIA9YekbB+yQdajdNpfJAtmeeAHNgnz3i4Qw1QIrAX/puu9QcqR1Aeeads3LzQtM5+qph4PmXe4clDm7+O3DuoIMvsK5bsNr9G0ALoUV6uT7seC5WPITrhmc+QMbVOg6VKtDAId4lKuL7kpzPN6rhTf+QIxIYETgCyTLKW4V4B8cYBMDSEkhkAoQaixjX7kPdnuvIjIEFwTkfAj9RFLJpcFA7j8R8ZC4djpmnyVzxjCyKeZpvEnFpLZb3nI9Wv8DDVlB7Bw9Qi04N9fFBrRnxmRfg4L1A/oxc4kClk5bC2ABbMnPpk+I5KS8KEvKojLy/j5JW7FxvI2bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVPunN/sc7tN/ea+d+QwiqqRjb7nh1U8N60Jz8k4knk=;
 b=NxC++EmbQbCDnR05ctllNHEdcdsjgBy8/+i7Twr4xCZjfpNc1MhJ946yUeebDfPRKEPN8xrzgRK7P2Gjxvrt75KDXkDtpCS9+GSS1Qu2yKWYraj4J75+ddG90cjey53uMU1NZM1E4/KKNmHUXoqxXh4yqOOcVduL9LjyTXL07cFOrrPujiQZWklFBTt83JspkQoqvxDDiJdISoSoJwV/cX4i10yvprHpBZ4P7nMAv1YMMcL/qUkSviNW/MvINc58qZpy96OK9pjkOHqDpYKoUrafcqoXbC210d19dCDgHdgPy3dlxfFYTwApPFWYpuCmVjjGTMRQ/iZYQJEYNXco/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVPunN/sc7tN/ea+d+QwiqqRjb7nh1U8N60Jz8k4knk=;
 b=dL4qzYukerGGt1EAyE12SNj6txUzV516Cu8FJFrgmLj5rk5gWREwz4LQzhLpSbOUu/Nz1nYB4C0UbX10KpjOL5qp8Q3YBISMqjfwzXRUjj3lcheFQonlo3wxsNuYClPffA7DngZJTzFpQt/uQX+XiXCdZ+d4HPkBes08tYUEK6BtXSXBF7EIRBlGgi8TFp504JD4R+aD+M3Cu7XDA/lGApY4H97cZ83gmpnmZ4MwlEbJEeFjHKVtvNinLpG2kKrv8w6n4b8U11rQUZmMinCe6nSQm9jYp71tfsWFChUHDj+Y/U+xPeUZY18b9cdoQfmQLC83NAcrWBKU0h1plsso5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 14:30:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:30:05 +0000
Date: Tue, 14 Jul 2026 09:29:51 -0500
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
Subject: Re: [PATCH v8 2/3] thermal/drivers/imx: Fix rounding and clamp for
 i.MX7D alarm
Message-ID: <alZH33GsKgWdUDOi@SMW015318>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-2-d54d8690e16e@cn.bosch.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-2-d54d8690e16e@cn.bosch.com>
X-ClientProxiedBy: PH7P221CA0055.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbd95ac-d388-42c6-a986-08dee1b46583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	//whhQvAK9iW+mJxutbqMkkgSyYIDG+Zt6oDdadJWz7Ew3HUcFfEzaUcPSZA9uSWJHP9I1gAszyjC2sTQwBJfcuWq75f+15Y6t8pDtSTVoEwlXimIJKMB/dBVsFmPIrb24vWZttfDVfn4mpBCx19w0m/976+HJpmdUM+bwU2CIVFZXkujgo47DbRmi1PLMSHzmoEHTuk62WcHgZTfTvU7fgvOkbhLCebWutZhd6WV6JjG99sNB1AvAlaKBHGTeBVjNynlNjSJ+WSckerrylz35CCY5MWUJD8eReM2ccaBHSVT8sXqFSKeoa8iKv0MqoPmLEe4yo4ULb/5wxOKnMkAvhDTZPPfCSK6LZNe5HxuDWIY135+mnysSvtXYYSxMzABe//v6l+Gr9aEcvdwUcTCkpdC/HMRVAUmAbdoaVLaLbzf/d5JIzUrxK5+TQj+2wF1vLx1viSO6Hzf4bLXbf0hwCbDJYhgJxL7HOjmi5sZxNsPDkMh6eGEbfPCbZfGg5cxuEp9/i7sOd6xUeaAgTnRStzyMq13+Rn8ympjbRn/lh4tTBJrQY29pxxRDEP3MZzzs6GBg031e2Zwi5sM8sDry5k36xLDLUx1fiZQs3V+f+xawfSRFDZ6lUnOMPEwxKhljGFg/99IQ+RB31xqOt1PhDGjreuSlq/LV5go+oct0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KniaMN5ytJkC0jVLBFNwwbsh02c5m5L5DpuNnkBermy+WEFdf0rlCqN9Wh1z?=
 =?us-ascii?Q?eN8F/MLO/eT/ld9SPLnay9FGvsq8x2YK7yNeHcThtMeMX868kX4D4wg7PQQ9?=
 =?us-ascii?Q?3d7rPuRrC+Dd5ku++8jO3udyTEuJyhawUdvB3OxKfLcca87ufmDgsJ2f2Dsh?=
 =?us-ascii?Q?eWcPIuF2QRB6v4wRgC+YiEL208CXu3Z6L11/oyWy0QcETvvjgpNyy5yyWU1f?=
 =?us-ascii?Q?+LI6mhQOzy+/suIHIW0rdWtTrkP8aQvD1Vj8LU1FXlvk1B90f3jcaGMlUz0+?=
 =?us-ascii?Q?6+LaSROaW2ddDgFNtsr9Qsfg11dyTzkWFHaDHuAUQHQTFETquGQMyw4ypwP9?=
 =?us-ascii?Q?rywOWrbYZyIExCw6HXHOfN+y2iAEFaoHw3UVl7MOeLpNyxrEZU+HpybwAFyA?=
 =?us-ascii?Q?vF+yrmUA6Ix3WmUY12OLCKViF1mJCxZyvPkIop4JzeY/8IelqiohK98RSBm0?=
 =?us-ascii?Q?CrCUPsNZJBlu/GSDoGYsUfj7AiEzvdlHs4Zjg6ZL/U/SLHWlBjwE8wZvIjRJ?=
 =?us-ascii?Q?3oIkC7MqJI8JUnShN0FFNMTEJow/NZIjx2x4Wc3ay1wMjRGwA0eravvA09kz?=
 =?us-ascii?Q?EaMiW+ir06NTuCzexgTv0D7Qrcmz7Hm5O4cJXvpW+ta3Lmv2A3ztofxZYz+/?=
 =?us-ascii?Q?vHYzi2+NQIDTy6on3aVqf2M0aPfBGKaPnu005W2EcdfJuSSceaaqWLWBntAX?=
 =?us-ascii?Q?Y7PkTmAV2FHSG8uiSakB2lh2QPcy1OlwzneTuBqRn+SKt4w46Wno4hglEPEG?=
 =?us-ascii?Q?+71eia1g2t0tNz3j/hK37GZitmLWOqL5mfibjSv02xYDuuhIC11KJJM16dIe?=
 =?us-ascii?Q?gqOMjX1BvN/odM6B/JZuh/DDGaizCjL0onENOfw/PPsZQ9RWP0i+plvDIvqq?=
 =?us-ascii?Q?Sheh8L/p4WBb782qNnlq/Q+q91SowvxtBp3UjgMUREtfEm1HiG30Mlp9jAUB?=
 =?us-ascii?Q?mSdJxlYIs4U1H+2Vav5UOEL6emgEM+qNftS96HFh9FXEwj95WXgKOoEyWOcu?=
 =?us-ascii?Q?E9rfoeKqdRCpkxBzQ9bNFi9IuljYKQm9L+9oBzEBGRyyqXx/2yoagxdrY76m?=
 =?us-ascii?Q?tTJ47gNzT85sPqyvHbS7jd0dXPOt//9dWho7JtXtnWoDxVVQC25MgOvGpaBD?=
 =?us-ascii?Q?0VhKHcdTFKglON6wEqsaEsQrQzp6K9QjfxA+Q7UUkJ75Hif7/YehU0yWN+Dh?=
 =?us-ascii?Q?hj65sqciOZlD9d9NaS+8WavXUUPHlURgOZzrEVx9nSxyErV1kG5crnMpIGkm?=
 =?us-ascii?Q?UhDUdCGN0UKOBgKPCX3/h4CgIKs/eINA7dunLIdxgkQ7vcgom8ZYpcngVugU?=
 =?us-ascii?Q?Mg57m+EcghGbNlImDvcQHmCDKdxpl2prLEzebw0c+yQTkqloueRykQiDNc6D?=
 =?us-ascii?Q?rQt9RNqeGlxxgbCTg99rw78lsNwjaTRZuPZs8qrrmYRB+082+PkSc752T95g?=
 =?us-ascii?Q?88DxrrZjrAKHPYg0t9ACmrtcxeYF3aHjF9M0DkkfPMW1fS64O57qG9lT2NK5?=
 =?us-ascii?Q?qxcIpymb8BdpoVFOc/KA+uGH5n/oyDkIWdV9bkqslLeFhFeowEiLikUvGQZq?=
 =?us-ascii?Q?FdlXbkjjW5tNYF9uxnb/Jwz66VHf9X/jcEtr24PqQqNARFxROhWs5Rs0gOAf?=
 =?us-ascii?Q?TUwabjyX5Ap3Xp4PtD1G/rUVGXI5rEVB/nuE30US5R/zYwhMQ/H8RqXydo/4?=
 =?us-ascii?Q?ndlGqed7w0roZ8vVBiN0kZgV0lfXI529+DKsaSKUDR2CMy6iB+GGZIFCInqu?=
 =?us-ascii?Q?x3VHyzkP8zliD8OEOTEvx99IDh7xXR1JgwBQ46RFCwb7XHJGLB9U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbd95ac-d388-42c6-a986-08dee1b46583
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:30:05.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHlHuHh/CvDjgH15V7D2CJhu5axIh3XMhhYeOwzF8MisbRT5pmz7KBZSmOmXLKAUab2RPEeRDoPN5FEXBpNPF29uluqKOL3GYfPw2guoTIglaFIxaEftO5SdSjWjII3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

On Tue, Jul 14, 2026 at 06:28:42PM +0800, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
>
> Convert the alarm temperature from millicelsius to degrees for i.MX7D
> using ceiling division instead of integer division, ensuring rounding
> errors do not cause the alarm to trigger below the intended threshold.
> Use DIV_ROUND_UP() for non-negative values and plain integer division
> for negative values, since C rounds toward zero which is equivalent to
> ceiling when the divisor is positive.
>
> Add clamp() to ensure the hardware register value stays within the 9-bit
> range (0..0x1ff) of the i.MX7D alarm field, preventing silent truncation
> if an out-of-range value is written.
>
> Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/imx_thermal.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..7f7d1116b9d6 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -240,10 +240,16 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>
>  	data->alarm_temp = alarm_temp;
>
> -	if (data->socdata->version == TEMPMON_IMX7D)
> -		alarm_value = alarm_temp / 1000 + data->c1 - 25;
> -	else
> +	if (data->socdata->version == TEMPMON_IMX7D) {
> +		if (alarm_temp >= 0)
> +			alarm_temp = DIV_ROUND_UP(alarm_temp, 1000);
> +		else
> +			alarm_temp /= 1000;
> +		alarm_value = alarm_temp + data->c1 - 25;
> +		alarm_value = clamp(alarm_value, 0, 0x1ff);
> +	} else {
>  		alarm_value = (data->c2 - alarm_temp) / data->c1;
> +	}
>
>  	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
>  		     soc_data->high_alarm_mask);
>
> --
> 2.43.0
>
>
>
