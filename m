Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65842E013;
	Fri, 10 Jul 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697731; cv=fail; b=JCIKs2lNyUoOfGjAz2LiHHhYLozS3Ezk4VzsaxYi9IC6LO5232wgzUEu8yTtKcspeRgB/JC7Ky/2WoUaBLE3DWmaVeypNA1mIImmHf6gw+cYF3JvX1DBfC4K/DXM8Afbeh1ziVB3mVl5e3YK9p5p8c21kE2geIMmMdfDiDNr4jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697731; c=relaxed/simple;
	bh=f1nb+aO67CxcS5A5xXUdwQTOGO2F0fifZQ2n/NRp3QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvWBGVAEHFSgu1keryFOB2iis6RJas3tV7uhRmZlLr6CRKyfJPvK8nq45Wwu+1lB0RzEzrh7X/Szeaq/140znNK+/xMraUIJZmqYgMjlgDEdmyDwU9Ep9GfMgeaZqVvcsBdCSJH2NLDae3XFA/gI6Dibnn+bVqpPK3Trg6iSrTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t9Sm25VV reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t9Sm25VV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wujee76mpli7NN8paEk4j0iL8c1knVA1iM9DDy5Va6ruo470Shf/UgEnjwkxgblFqv/3km6A6C69cBm0fD3j35nvJFl5dEPsgUCNFaZeRnxKu4SvF5YxduY6ZoO9OAKs2WDMCR6zWu8n5l+yl8s7HHuLqlKxeTBiqqad5Po5oiae0gnjBYdCJUDPQXygN4lR2wwPUORes+52du4Mv/9UrxAAoPiFx7fweyHrkBqUhvYMp9isoK3ab/NTbRECxe7IB4/fAhqadj4BdJ1fuQnfnesifKHNT5itdlDJNZbeo/i11iCHLumNX/RqJmRWWtdEHoYaYvuoSpJSdiOiyJYK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so2f2fKlKjk3ANrztbOhN8D7t844H+npazzxeoFgRmQ=;
 b=l/uZliLo3+9GFbFjcPkvrUlFKhJqfU2ZkkprMyqunNl3XClsbkgQvUOXGtlqXuFDiz00DjUCdD/qrDWvJZdhCOXx4REAsRb3jWmxNxvx+3B46YSph/OZ6kIg13WKKAx0mE5XMV7aWf5BJgev9W76rbwBQUfaZm1+zMD1C8p4bu9odTV/x+PZXSnOHZYpAsYN2/LJqvbcFGQrccLZZMBT6BEorOz2HUtsTfxsg2rpXO1kZK8aK6OqlB4MXwQ8k7S/Yy9kJKzNhWo8JYWfEajuRSXLKfMACMBzMKvV8zrzk7HdVgk02S6l2Hm8bCJd5xWykzD1vzobL/Y9I3qabBECqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so2f2fKlKjk3ANrztbOhN8D7t844H+npazzxeoFgRmQ=;
 b=t9Sm25VVqppJLAvUe1qKAUc2aaVYiHug+j0TDq5GicLdhGnMy5HPHYK+eMtvgfrKr+pZAjeZup8slUBjfVcfoqfSa7C9v8VfvBmN6aXQg2Ai2r5h7Vkq6JTx8IgGkwIyiSEwGu/7MDG6CThUDNl9SN8+KRHAqi5CDImnU1NZFAQKOXB9EkYZVFX8yvWEq84+yo/LC4NbEr7Bmitbo1cRnOmXRxTH65fZXzpkCnV4Ozml+3OnjXq9D04XJ9kIzfXRdzUzatKR9B/X+XqLJ4/MY5a1fxfksP5zoDpmrqsW8ueu2CW/J0ANxjdECON0omoejP2VTjPpB3uy9ouG5UsskQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8635.eurprd04.prod.outlook.com (2603:10a6:20b:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 15:35:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:35:23 +0000
Date: Fri, 10 Jul 2026 10:35:12 -0500
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
Subject: Re: [PATCH v4 2/2] thermal/drivers/imx: Add calibration offset
 support
Message-ID: <alERMKAParbbrEAg@SMW015318>
References: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-0-1fef97d1c750@cn.bosch.com>
 <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-2-1fef97d1c750@cn.bosch.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-2-1fef97d1c750@cn.bosch.com>
X-ClientProxiedBy: PH1PEPF0001330C.namprd07.prod.outlook.com
 (2603:10b6:518:1::1b) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: df9e0783-64cb-4da5-ec6d-08dede98db96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|7416014|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8Yzags3bhZfwsa/Yp8q/zhwAx4IhQmH5racS3dZnmCJJ9wF+raLhqVzpoi9q3aHb7qBOCPxUR036AKCVz7EUe3134Z6DYPvtqi0RGhhi3kwexNsMIPg7raMo13WwxVQEZoZxNtk5tLN4K1ZHskZ4u9vM+CnE9oi/Yo/24O0zE4qvA55Hn//SmaGEYer2mha9bFV+0Lsl7w87P5Q8plTN0D+r3kw/C24QuRr/kYSZGiSCz9tGBkXcRhbEjdej5GwObctEm0UmZhidCPHx01hjrhIiNErplxx7Z5b2QYT3TKMbSx022zU2KYG/lmDnxAx2C6bLf571lGBop/3m4y0Jt9mItDlwS75ZHp76zlJVdkn0efyhQU4mjOEybc2fLUH6w9KCw1Mv/6+lbgJI+rFCkHyVl7IZZAGN4Smfr3qDPTrPXwJV7zjRH5dTBCnv4/uZIneokCcWBKnUtQ7nsWM1aXzGktsJOEx+GIlZx1NIGycsOhKjceJy1VEl/lC8vePETtTdRP6zg/QC5+Rv6Jp/S0cs5rWj0GoQd90Cvoo11spoO3qWvZcJ5q6zbpEq8HNXpMaRsG/4Vzwwz81yIWBC9LSWdxexou+mFHH+NAvm22BkzH9QOOd3yUH2nYq4Mc8XygXEhbi0xzfz6IrFO0x2eKriBvDEtpVUDcmV5HHdmAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Zg7+l9wHzxspKjuGAF34PFPvgCcInzww//Jx0HuiPrbo5AEZtToNE1f/oC?=
 =?iso-8859-1?Q?FNZjKFtqbY5gw/4YTz7kA6ntMDbvH32xF56X9Ze8wpyBhoAPlckbLoRTLd?=
 =?iso-8859-1?Q?w/R2aKm8uKdtDblKS5PA4Zd6WDVKuhJcJpvl91fukfgActHSMAqdokds4d?=
 =?iso-8859-1?Q?uqFyKoXqaulclO5m5Nlyf5Gptwr0ClfZrOrxyK2UonxKFWImHhv0+a5LnD?=
 =?iso-8859-1?Q?Y1PDQ/Narb3XfEPRXDxcHMClriue7A+1hB1m36ya6tEqSjYEsQJ/1bXF2L?=
 =?iso-8859-1?Q?zYbHiTgyvzfd57/vmnTxN+gozabKTQ0iHGAxk68aSdLA161j2El8/3WRFb?=
 =?iso-8859-1?Q?nDp1z5m6PKNtfpEneXWLJZkUk33o+jYagJrspS59IWbZx/zAkQXgUOE1GG?=
 =?iso-8859-1?Q?R3QzDp7yFugQlwJ3d8xJKdZr/VZTSPsxlBaRLklT97sZ+gsm/v8PD6SwnL?=
 =?iso-8859-1?Q?aw86a/hewn8JLuR32ySINc+j1CjgsK08WM1Qa7/GeVIXLoMBt3cG91DqLc?=
 =?iso-8859-1?Q?dYSvADWxqL1cMyowQ6FoiTnzlQiVOB2fGPmPBnPO/be6Kkw5fj53gDL6C4?=
 =?iso-8859-1?Q?PXhqPDFLmBJAeX9vNwghK9cJDt0xmmusrS9HCTt2CMtPanfZWyr8A0FEeM?=
 =?iso-8859-1?Q?TYB3XaYD5PaL4BI4cW0DQ0M/dp8vKql49LlD1rzq+QTapM06CqEVaIND35?=
 =?iso-8859-1?Q?mE5o4qZVmsl+j/UryGSS+bjUILZ/onKl+YXCb/JNbRbuVmlaeOppTjuM2t?=
 =?iso-8859-1?Q?Wt9svGYh7EAFgLzGTrCk66tVUOyzqvLCry2dvvkWltN+j8QYi4pSxg9aup?=
 =?iso-8859-1?Q?G7wSfdA9cbIhcmhIYbIvKjNKKJT8/8JLgy6sMOfKwbKlZeAygcfm2yt+i0?=
 =?iso-8859-1?Q?FfRYtzZSjGe3dDS5W29Y22h/FyyGYF5BePbv4K2a7OJMscZFupWH0/6G9X?=
 =?iso-8859-1?Q?ZimvPmRgto2MgRtgJ1+MwqdFaOyH9lRC/wRhbFPEGXQ9Bd9lc2NkrK3gGY?=
 =?iso-8859-1?Q?oVg8CLyf4VH1BKjh63PHIsYS3J+GGitwNVc8xbkbAe7M2kASmWHvbY4jvO?=
 =?iso-8859-1?Q?xbwWRSB7pWT7SOgGnrhx4jFdPfCQvv8DO+piqAilOHHkSnnml98oPRvdmt?=
 =?iso-8859-1?Q?Io0Mg6SoN79Pzb+uYhjRA74qOfYqDBKim3zoc/i0UEE/vQXqauIl/ILP0i?=
 =?iso-8859-1?Q?Z8mlh+YuRNQDwStaWoHWrdAvJY0zkcNR+UYZkLZpUbEmc6keZP7D1JGDb3?=
 =?iso-8859-1?Q?LJYKec+8BxnRb1KV5BAPPKNmJ52vIrKYmjbMLj+e2cj9SXPTKKiuIQCc27?=
 =?iso-8859-1?Q?aK3lTM3Lf8TwtP+dE4TRPFpVEJcf6prg4198wqGmxsnBgfhptng6s1252u?=
 =?iso-8859-1?Q?iOJPRwTAKqVIbUfXaVxwwp2a5w63+43MMqT8+FEKw0/9+861LeX8+Zgv0A?=
 =?iso-8859-1?Q?d/PZagxxjnf3xuMzx6dRtvJD+TrnG/wyxyIkW9qYdjXxn8rxLVZm2UC6QU?=
 =?iso-8859-1?Q?Q8GN4yqeNSVsofXl5t12PNH38KNfyRNq5A5Wv4OKao4aCl7zOwvuWrFSDM?=
 =?iso-8859-1?Q?Sa5aC7vDrAchViCRMSAcdoIf9FJ7PJjkH2RVhnLMb8q1zJN1NrU5LcNd9j?=
 =?iso-8859-1?Q?Tsj3HlDltI0mWfprs6l5avzfMO8N63ybPK2q+BH2bZKqqDKeG5FYBAHz2c?=
 =?iso-8859-1?Q?pt4RPTDJi8Qh8BkI+RT9cMmwexyrMuBfS+9P8ZvbN0RB3jMXCZwf5AVBXs?=
 =?iso-8859-1?Q?lc82tQYUHsZLjUIzxMJjlEcd753/vkW4DKGP5bIH4RFftj4WbxhLt2bUka?=
 =?iso-8859-1?Q?tuwzr2hh/D+l/EeIdTwCseN8msqfgeaEGwLkzwSsQbqb8YCFe0q5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e0783-64cb-4da5-ec6d-08dede98db96
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:35:23.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWkSbumEPOYqA10fmY3YWCxPnN5ptC7+ShoOLpVlp5/tuT1K5HjwlgszKfL4M7Obg5f/k2HveLI7af7ptTHhbIo8tbm/Fxh20bSOnaJmqw/Hb/NLmLaUSKTTFMMjQJkR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8635

On Fri, Jul 10, 2026 at 11:03:37AM +0800, HaoNing Cheng via B4 Relay wrote:
> [You don't often get email from devnull+haoning.cheng.cn.bosch.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
>
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
>
> Read the optional fsl,temp-calibration-offset-millicelsius property from
> DT and apply it to the i.MX6/6SX/7D calibration formulas. When the
> property is not present, the default offset remains 0, preserving the
> current behaviour.
>
> Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
> ---
>  drivers/thermal/imx_thermal.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..8062d34ffed8 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -207,6 +207,7 @@ struct imx_thermal_data {
>         struct regmap *tempmon;
>         u32 c1, c2; /* See formula in imx_init_calib() */
>         int temp_max;
> +       s32 calibration_offset;
>         int alarm_temp;
>         int last_temp;
>         bool irq_enabled;
> @@ -240,10 +241,13 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>
>         data->alarm_temp = alarm_temp;
>
> -       if (data->socdata->version == TEMPMON_IMX7D)
> -               alarm_value = alarm_temp / 1000 + data->c1 - 25;
> -       else
> +       if (data->socdata->version == TEMPMON_IMX7D) {
> +               alarm_value = DIV_ROUND_UP(alarm_temp - data->calibration_offset,
> +                                          1000) + data->c1 - 25;
> +               alarm_value = clamp(alarm_value, 0, 0x1ff);
> +       } else {
>                 alarm_value = (data->c2 - alarm_temp) / data->c1;
> +       }

you can direct change alarm_temp before if block

	alarm_temp -= data->calibration_offset;

which fix for all SoC, not only IMX7D

Frank

>
>         regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
>                      soc_data->high_alarm_mask);
> @@ -274,7 +278,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>
>         /* See imx_init_calib() for formula derivation */
>         if (data->socdata->version == TEMPMON_IMX7D)
> -               *temp = (n_meas - data->c1 + 25) * 1000;
> +               *temp = (n_meas - data->c1 + 25) * 1000 + data->calibration_offset;
>         else
>                 *temp = data->c2 - n_meas * data->c1;
>
> @@ -413,7 +417,7 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>         temp64 *= 1000; /* to get result in °mC */
>         do_div(temp64, 15423 * n1 - 4148468);
>         data->c1 = temp64;
> -       data->c2 = n1 * data->c1 + 28581;
> +       data->c2 = n1 * data->c1 + 28581 + data->calibration_offset;
>
>         return 0;
>  }
> @@ -629,6 +633,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, data);
>
> +       of_property_read_s32(dev->of_node,
> +                            "fsl,temp-calibration-offset-millicelsius",
> +                            &data->calibration_offset);
> +
>         if (of_property_present(dev->of_node, "nvmem-cells")) {
>                 ret = imx_init_from_nvmem_cells(pdev);
>                 if (ret)
>
> --
> 2.43.0
>
>
>
