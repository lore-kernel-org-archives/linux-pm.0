Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAC35B64B;
	Tue, 21 Apr 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762717; cv=fail; b=LWhOV37HVW4sH07Cbnit2u3MYbgtQH3ijDmxmyxUdNHh2o3vm/L9k/tRS4onZhwkCohAugpl+fZ00zrCX/ytUNOndH3TKhYSHlPzRJ9iASg9OFYvuTyosQWDu5aM63J3oHfY1dtI73A+a3HaeL+FcU3pDd9n2Vktf3OXmy2dZgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762717; c=relaxed/simple;
	bh=4kXm+uBQrfMrFV/BrvI2rx2UNQuP7Lcf8R5xVgrHWJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGk7tNPg2P3SCa/dtEgOsn42/x6MTUoNop/pZUk/BUqCA7la+nAScsXJV7w53LQ8xApx/Maw+e2Cl8fs4bkbNTaVxiC+7rD3CK2Df3FriC07orBqy/EhmyEdlY/ojt2CgEzUnfBUnE4bXEGk2vs/4KHKispv97ww5WUShcVeKTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YcKYsKTG; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcKYsKTG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCqdXWnLPBMfg5sSrBykMEEMH4RilER2Ou3Jx0TU06I2JeCStbUedwfcMWZE5UcMV2l5C7JBMDjyJqYIwrAyzHoOedhIOxVovV2hawcv8OfanCKg2gqM2/OZnxYsJmjOyLa8Aj5oYN1/jzvADKM67OB6n5qGrlCgZ7XXjjz2JCzs0JX7qfSSf4byl1j9bnVIxEXnYSvBUvQirmf6qEThHUHyhmoTQrnR2G2Y1RDf+N7u//vyLv12oB0HELRn0aK0gIpYnCNvKLdW5yabRZzT324u4RMo67MkMJMjN8rm9esb9fxNTVkBZYXW58koPataQ+fViWE3IgHwb/De5dAZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvQZ2Y2t957nio4pHJ0ZVhr3Vyne7/e9WehDck89WTU=;
 b=Ol5DsyVPV4ODXO9vlfnc8YCrmeh0fwhJo0bvdI5Q6Q8TOsbpf4KiatvD1asR9HzDbQi1zozO6ga1LNwh31aGRJJ1K6oAPSQFXt61XgPPl5n25VC/16zE6THbcoXAvley+vDEDgioPiBp/fBV1Ei3gHzXOfT4KGq+LBXrQ1cLwNOOEe1JO2dxmF/Qc4BMK9mPqvMIkr6aUzmMlOFVhSXiFQNJrqJg9L/P2SKKACl36Zui69cfSxSPNW4htsEeVVaii/3OBzqhQK+qlSQtBhX5p37n+S1bS+cV7DaoSQw+dFIcL691n/kfqteK/y7Ai3REc32U9zi5WF7ZL1i2a9Bw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvQZ2Y2t957nio4pHJ0ZVhr3Vyne7/e9WehDck89WTU=;
 b=YcKYsKTGcdXrEv+eTgy1QutHa4koNu22bSr3+7zzhCJ9gB6guHJ/CDn7Je4cr0fCdvw4lCONrnfbHpW9C5ltWY/ZRukemFOa1EwBMpPjYdUzoWxyBThM7SadbHj18YMpJ2lJbsbUjWPgwSl1GMSfjerb0sCwdfJ+3g2UT1hKj7SbqqFr8M8uS+Q/RSks8sRFdmusNRlhL5pjl9hiUevqAtgn42MCWocEulmiksgc6GXEh9xvBzxWAntH6C+Yqvqih+2qglKJhVX1CIGVdgcu8RLEU4tcu3KrMwVVzMLMB86W87GRf+YhCJY4qrjlYUHgPxgPkf3LTrnXZGr4I1rB4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 09:11:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 09:11:51 +0000
Date: Tue, 21 Apr 2026 05:11:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Message-ID: <aec_TlguJkc4A1qN@lizhi-Precision-Tower-5810>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
 <20260421-imx93_tmu-v5-3-05ea1969bb9f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-imx93_tmu-v5-3-05ea1969bb9f@nxp.com>
X-ClientProxiedBy: PH8PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:510:23c::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4373b471-1e0b-4dcc-71c9-08de9f860658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0uDkZFnmsv1/KHqHZVI5KpclAakfEV7+bJwRRr75xo8fFJT90u63T2z3cvjnL9xMNM+NYNTbTrMSftVAA3QBXbLg1jPDA+pisQ8vVZdfobX2AXM5E3bjSCgVgn8ECIrrwUIzTR7zZX+t8xErIB/tEri8u39e7vW/z88ApgfHuXEkkauiO7X9+1TlJTwgQFzxnzt5OvtCVD6AdbvOgEDX/d9gq/CnszNI49A6eldGX7bkG2ee16rDBEEYG9lyZtTZiloXKA/KnyjGuQxaTeDWFBcptPELppQuVdUKWh4C02UJF9BonWWSwEVWBk6hBiHnIqJV+MPDhAzd4+4LRmU6rL9gYAj6vMnQ+GwSvOlaAgcFej0z2XYS1aIbTyVidccctg5aG9aTTmcinpVn+phyShFfz7k4jkotXledleUVqA1NZwo26TPRblI1C2Lg7Nz1F/O5lKiSk/7+92bWbOZVlhqXOaRt3uupV4uHR3gcLvLM/C1Eiqk6pcKjwHL6LqtBr+DGo4K/KJvT+vdsPkUrNeF49tFlOBbZTyQP3Qw+ElRJVguWYxSSCVcgoZJb2XIl1qKRDMPHUfRM0GGwDf+sM0NCiRuTrCA0N/tQVlQq839nSv70wf8OhsWy6wYK2UiEKBtqfPQ/OiXvzh6pMvdnHrxngM3jP+3gavlopExEwIRli3iAgtl3Euk6KWi4S94rKe+CZ0N4MMFBfFbX4pHpKDRIX1qX1nohWc13VgeJVZ+91JtGodJVv1tXLhFuNGGaYnOXoJCOAq84Qw3k2wAnqsChDDxFED57ahd2MRUPNz4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wiK7GoDUWzsmGRgr9JhIbnuF4SZO+QTFUz4Pfyo2SWajpXf2e08VfPK4hij4?=
 =?us-ascii?Q?hMf907n5DkjL9+nduUS7aM7jg5mQdcYgaVLo1jRtE0fJW+to+a9cymtfVnyW?=
 =?us-ascii?Q?CgIWvBDYIf/iuemji41UcjsR4MlUtfAa4AwDDRg55PVrUYA9BzwR8L6Op8t+?=
 =?us-ascii?Q?gLAJQ5ElAr3Y5agmTBkPuG9q13t+Dc07ZJ+T85VDQX3L0Os88jE++C8m0BcI?=
 =?us-ascii?Q?cbsiIuti/faje5N2Q0sWw1spLlsjvctd2AkD3EkKq3aNvUiI24ovBUpLksn3?=
 =?us-ascii?Q?bcaPI0Izpu5hbSrF7mWHz8V1GGjiTu427OaJTXlybps/hkPOLyKEO9c7l3VX?=
 =?us-ascii?Q?xJCRvzwWcqAYfk5iPx+tuZGTBPdQoY1qJ6zXexZMZoYp+YZXwQpHMsH1DJ7I?=
 =?us-ascii?Q?hhXIBbFFmC0mKNNNU9fIQHFekm6niBQRiHSmNaYYMy8anIL78Ej9JcblsQJn?=
 =?us-ascii?Q?I0El9ETfAIkTvN4UGeONQFhGu5YTKZcGHmV9Q59JemRTczI+ILQ90fSxXafJ?=
 =?us-ascii?Q?6izuxtgI3Uoyf84txcOT6Lk5kFtIJGKO7lt4nPBdP/pcTpF6GOTpgZcAsCrW?=
 =?us-ascii?Q?A/fl3LPrWt6NdUs5zsVcKTVR/apeGwgrAQP+i2O6dtk7iC97MUntsiRU05g5?=
 =?us-ascii?Q?d7BGag6Ps05dAEVK76YdXasx63nnVig6rxK/12FqcZ0pCKZpEvrmdpVyfMKc?=
 =?us-ascii?Q?L/XZzUiLp5OY+9/PgUb5FmHrXUzLoukPc2SpsYyd3SeXtQwAzFHdxAJ3Lv2j?=
 =?us-ascii?Q?Q4BUfX+H23YdWWBUe3PwLSjr5Vh/w67prtNhGFboNPW5uqwmwX226/7gGOOi?=
 =?us-ascii?Q?t7yBJ5n5pQbBIcxwa3js6+IWVvvTDYnB3dO20B837YIUkbd6lzFRnGTRLJ4X?=
 =?us-ascii?Q?dZnxSD4OfOW/KLoylJOy12TNaTsUKNLbkrMHURcwj4wqcPvPCgFleRECFZxL?=
 =?us-ascii?Q?nKX13atoMoYj3m1NhIyPOzhwuoIemK58C/XCW5eoeb2Wmd/9S6/PrMk2vVJR?=
 =?us-ascii?Q?PPMaLTbW3feZ9KGjtroHhhdu263xUoRS70FCC/rTdhHTdzgnNCfgirJn4hI1?=
 =?us-ascii?Q?AC/RJUjxRrEWa+zY1CsmORVs0ZzMPTKTDBAVZ3+0RtKVrY0c3TGF2Qj1nXmH?=
 =?us-ascii?Q?FaJ2ZKhow/alw+7AMMWtHmOBsju7Fu1Rc6FfkzcN68rqo+5L3VKwj+ItNTwC?=
 =?us-ascii?Q?8FRRO5P8EqOoeRyHdrqfAqkYqD4qZa/zBhYctPH2OvDIRWmbAA+Gg4eIhqjB?=
 =?us-ascii?Q?PazMEKBwQtilahMCKXlol8pRZix1PocG9WgrUR6IU/3hsEs8uMtj4F40SyQb?=
 =?us-ascii?Q?5LaaDvggpJMUs1v9I0ndakD2W0+WmHx3TrQTJrAR2CH0utEbjmgg6y7AxVZI?=
 =?us-ascii?Q?kzhNvv27q5jyfT9N3iJXTP1w8Dvpc0ci5YHdmBsYk0CPE+Im3cVAMa2cpiIN?=
 =?us-ascii?Q?Ns74NLsfP1GRlfc4yW0fjKmfRWWS4tRBG2WQ35sfY1vrs5oL06vUBp5dVDhy?=
 =?us-ascii?Q?7zfVq03Si2C/nT+GWxz9aAhTgIQSpOb4fphC41wmaJteLxatXz/tRPmQN4Zl?=
 =?us-ascii?Q?S5a1oGiXxXxoy6xnGs3OJm0O4wiq4tG8XGMYBz7ArNpZwKmbHf/uKKxnxMG+?=
 =?us-ascii?Q?+0tU/QpupM/8A/gGDskqHlHhERGLSg6Qb+blJh9QPWIoty7ugI690mnhMema?=
 =?us-ascii?Q?aH8j0OPtVTNXJvZQf4k2pmBkL4pqIh9gbwdm5AiJV7srLiugzhbWGrZURMIJ?=
 =?us-ascii?Q?K2iD+IXwHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4373b471-1e0b-4dcc-71c9-08de9f860658
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:11:51.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KSTztjDOTqoveowUSd4TfNh0k4ywyBnU9EmwS5Dj0Rc1YOXDBcAeNvMfSMxscTAzCb5oex+hZmPnp4jImAQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Tue, Apr 21, 2026 at 03:42:24PM +0800, Jacky Bai wrote:
> Invalid temperature measurements may be observed across the temperature
> range specified in the device data sheet. The invalid temperature can
> be read from any remote site and from any capture or report registers.
> The invalid change in temperature can be positive or negative and the
> resulting temperature can be outside the calibrated range, in which
> case the TSR[ORL] or TSR[ORH] bit will be set.
>
> Workaround:
> Use the raising/falling edge threshold to filter out the invalid temp.
> Check the TIDR register to make sure no jump happens When reading the temp.
>
> i.MX93 ERR052243:
> (https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v5 changes:
>   - replace the check errata macro with inline function
>
>  - v4 changes:
>   - include bitfield.h to fix compilation errors for RISC-V
>   - use macro define for temp rate related setting
>
>  - v3 changes:
>   - refine the code with FIELD_PREP macro
>   - add errata doc url link and refine the commit log
>
>  - v2 changes:
>   - no
> ---
>  drivers/thermal/qoriq_thermal.c | 49 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 297a855311f3d6a8d527794abe17ac86c47bf152..57c712b9b359d713f2ff4926eb890a0641aa96bd 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -3,6 +3,7 @@
>  // Copyright 2016 Freescale Semiconductor, Inc.
>  // Copyright 2025 NXP
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -30,6 +31,9 @@
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
>
> +/* errata ID info define */
> +#define TMU_ERR052243	BIT(0)
> +
>  #define REGS_TMR	0x000	/* Mode Register */
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
> @@ -45,6 +49,15 @@
>  #define REGS_TIER	0x020	/* Interrupt Enable Register */
>  #define TIER_DISABLE	0x0
>
> +#define REGS_TIDR	0x24
> +#define TEMP_RATE_IRQ_MASK	GENMASK(25, 24)
> +#define TMRTRCTR	0x70
> +#define TMRTRCTR_EN	BIT(31)
> +#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
> +#define TMFTRCTR	0x74
> +#define TMFTRCTR_EN	BIT(31)
> +#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
> +#define TEMP_RATE_THR_LVL	0x7
>
>  #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
>  #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
> @@ -77,6 +90,7 @@ struct qoriq_sensor {
>
>  struct tmu_drvdata {
>  	u32 teumr0;
> +	u32 tmu_errata;
>  };
>
>  struct qoriq_tmu_data {
> @@ -88,6 +102,12 @@ struct qoriq_tmu_data {
>  	const struct tmu_drvdata *drvdata;
>  };
>
> +static inline bool qoriq_tmu_has_errata(const struct tmu_drvdata *drvdata,
> +					u32 flag)
> +{
> +	return drvdata->tmu_errata & flag;
> +}
> +
>  static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
>  {
>  	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
> @@ -97,7 +117,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
>  	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
> -	u32 val;
> +	u32 val, tidr;
>  	/*
>  	 * REGS_TRITSR(id) has the following layout:
>  	 *
> @@ -122,6 +142,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (!(val & TMR_ME))
>  		return -EAGAIN;
>
> +	/* ERR052243: If a raising or falling edge happens, try later */
> +	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & TEMP_RATE_IRQ_MASK) {
> +			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (regmap_read_poll_timeout(qdata->regmap,
>  				     REGS_TRITSR(qsensor->id),
>  				     val,
> @@ -130,6 +159,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  				     10 * USEC_PER_MSEC))
>  		return -ENODATA;
>
> +	/*ERR052243: If a raising or falling edge happens, try later */
> +	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & TEMP_RATE_IRQ_MASK) {
> +			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
> +			return -EAGAIN;
> +		}
> +	}
> +

The above two code blocks are the same. Use helper function to avoid
duplicat code. And why need check twice?

	ret = qoriq_tmu_err052243()
	if (ret)
		return ret;

Frank

>  	if (qdata->ver == TMU_VER1) {
>  		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
>  	} else {
> @@ -247,6 +285,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), teumr0_val);
>  	}
>
> +	/* ERR052243: Set the raising & falling edge monitor */
> +	if (qoriq_tmu_has_errata(data->drvdata, TMU_ERR052243)) {
> +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> +			     FIELD_PREP(TMRTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
> +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> +			     FIELD_PREP(TMFTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
> +
> +	}
>  	/* Disable monitoring */
>  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>  }
> @@ -400,6 +446,7 @@ static const struct tmu_drvdata imx8mq_tmu_data = {
>
>  static const struct tmu_drvdata imx93_data = {
>  	.teumr0 = TEUMR0_V21,
> +	.tmu_errata = TMU_ERR052243,
>  };
>
>  static const struct of_device_id qoriq_tmu_match[] = {
>
> --
> 2.34.1
>
