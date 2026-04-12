Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D257844;
	Sun, 12 Apr 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956038; cv=fail; b=oJ9DpXDbsl8EOjmtVyK6oHRwiYTJ4hQPIzGV97ibXYjWB+aQZrkqP4nASXES5xg/5JpOWjkhgmqjPX9c1G3FvaKWBcTv1b49GCSGn95vv+E2TwqXJQoM3n+Z8075FWK6tpDby8GLstHnrsaG67TepZkZWx55xK3ipi1fm71apnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956038; c=relaxed/simple;
	bh=SHN42lSCbU1dw4fRjs2YrHtiOzlVpMXp5CtIZT+NDt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UimoiZ9mS8MeMMcCArJLznWiRPR1yMjVdyqnL1nzpIT1tiBBv0GaNcLKhJ3GHWMVKXubAanHhC5SDU9TRd+K5zYf9zso0dcnD2oOwdB0yK9S+hZPVKKYvE8tzJBWyojJpdQf5PQVJ6LqLiQt1xRHYUkUirbEcXU6owodP2DrR44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SqHVQERG; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SqHVQERG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkQcDoIDP3EOg2hbuiZFkIDCNFvewm0U8FiEbce6Wwt1My8WeZivb4vBcsM4ef6rcWx1IT4OduE+7Dk7LIMVXJpSweAhtZERLLmQml66ERAZVLMvveimzfhHaYZ7+rf7pUIlhKJQ81OIVEryEEp3GkhsvO1+uepmKMW9eA18IBK55PEvNb8Wig4oTRvUrAK8v7fHYmbOuUgy0CEloq2xzXQvKZWjcNq4FHxIazxJKd7N3CiHoNn0nQvp9qibxjV/+uaMRTXut6MG9vEYV/SL/6wj3Oh7AqOzQ6SaRBYmWwrR07neMXOjaDMVE/Ur8XGxAzzvOUoI3bbRX497Bcmhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyxagNLdoVkeACDw/UcKtII3yYEV3TqFWUDO6CUTHsE=;
 b=WY3kxBmDDm/TBvfbYdMaYyBtHChxLfdIYmndMxeuEt1AGEAsoPNDKXdlyUichozaZmDJ81TzigmPQWVsEcNtd1Kx49PNcNdMM1LL24km7SELom6x3H4vMxNeUO4Y7vNVjT4nULTCxV5ak4M/tgy430tNfuOfAmQmyThRvjf7K5tp2cBXpIyhwrMrEyZByLvvhRThpCK/WWDqMpA5QJF/YYtv3IGTocdYLHULpe2L5rd7cqw7ZtzCvULHOQtvRMvlz3oJqYbsi4CxGhvjhvTk0b2/miiJOesgWBP0a0+iSVzevkQSZlC5vOMIrmwoeYPF9fDbawms6p5YnINdUWySLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyxagNLdoVkeACDw/UcKtII3yYEV3TqFWUDO6CUTHsE=;
 b=SqHVQERGsZHrYPGJa0nkd77O3QEbu2Kf/+cUZUxgMrH3QLHjn++pAwWQIsoi1dhHnJBPkAGC43mW+eGtFgIDOyReU3/3iBMD/RyNkv6lPMuPNTBnxfPeyofSC9zSOcOHspcreXKdbiuoaX1uJMPisVp0CayDTvQT3IRB2W9/K9Ffvs9/BPM11pmdoyStyLFbr5/k81mhXV7kZG7+mu/5kk4xEdsXJtzvf/xtluOq9YvgiqVND6KHNH146VxonWO+JJrnuelbI6lni6rRWJ+AQfj37ixeOtL4DCh9rHwHwOQ9A//oyrfImcxv/ZhlD+nLdweXSP15siPBHrfWlx0j7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAWPR04MB10032.eurprd04.prod.outlook.com (2603:10a6:102:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Sun, 12 Apr
 2026 01:07:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.044; Sun, 12 Apr 2026
 01:07:14 +0000
Date: Sat, 11 Apr 2026 21:07:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc: ulfh@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xuegang.liu@nxp.com, jindong.yue@nxp.com
Subject: Re: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Message-ID: <adrwO8HdZ7d85mEy@lizhi-Precision-Tower-5810>
References: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAWPR04MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: 992d799a-c860-4e20-e902-08de982fd50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	uVUssfZ/P+IVO16eLFOcV4aOh2YCRCZD9SUGdnniZKtzgpmsIW6kxXixhvJ8OmX7476Pmy8fBbTRXNL1nqck5HAvoGTWSRQrR+xHlloDLbtT1GFcVn7wXz9dSUoiVyYJg1TDTNOX6H/9cgSvFpya57PxsEo1S3MISGNVOqjMZ8KnV+sZV2AClhY3Addi3SGWAorF72X3YFTV+f8D/rKspacFOeDrUayiqqEOm4BYQmVK5pvEw1c+lWaNpNRtuxJ0KgBQD8LJAhUcZd0JZ/QkK1O5eeJdWi+DE9g32yHSuLs5uc4mgKpoluXuoeWXfd5C8bJORSlTFzyXuzAbnNwAZSj6XkyxhDol74NoMrqXjbTkmXVsZryiKTRmi33RLOSfw+tuxpzBXkiuAER6aCJM9OfIZFgyaD4qfYtU9kf25RiB8gwwsB93igZqD2q65QZA0AXy5n9doPVRY8iy/trZS3Se9EVVKZdkNM3GiFVoRNYYpQTxXzVuwlQCwW/jT+Ja3nls3DhQjKGym1M2usmA8qORg4HOZ2hsVtIUCgSzjOslAS1xRRjvwbtyE84XfkhcDdzyD0VXmaOG9BqKjbrH1wlysdXDIJamdaP18NFCVyylwvPAFGQ0kNG7572fjAO7VFLNEj8a4tr/SUYpkPJQWdNeOoy4n4rHzGwiZdQHRIJO1Ugj2xHL4xAJaR3N7QTN4mF9uZaGms1gdyTbqNynxfvKTHDBxbqHeuPYJrHypm+IZF8iuu1BAiutA7kBEZkGMw1mKgOWi0Jxu8sBUKFtcOd/clFmJZVDirMIhCV7W68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NIJI+qm9Ra4J3HswFOXHq4/hxLwxIygEWZqfYJr/n7ePyRJxCQKKZKfnZh8T?=
 =?us-ascii?Q?XE6osbbWaNG9Zh8h1tDXEslvn27UvBWfdS3dxNyqu+GS++lju5/5oqPG0zlH?=
 =?us-ascii?Q?WOPCNqRb5rVvzIltefvvEAykPoKXdnEFEuWnXErzkgTIknP83f+lzw4dO4nQ?=
 =?us-ascii?Q?mVWpUyB6UD4P1i8asqL2BLv+C2sOvH732Ux7YAdtO78GjtehYsHlKspTP45w?=
 =?us-ascii?Q?gwuZcnZS30UcEzgh3bmpwpYJj1wTMjunmLtsoJdNaH9HJ4nTYQry91ng68OC?=
 =?us-ascii?Q?YDVkHgd0vf8neot1G732e8Zj0/Lef024U6AjiXoI3CXqnAgjfUBHZPnMQPJm?=
 =?us-ascii?Q?HWc6f11fmoGEOmjsPWMtOc8kHDf+b6dyjHZlILmWFed3Sv7xWkAcTjRHVVzY?=
 =?us-ascii?Q?zTkFaQXNmiNvWKutL7mmOT/Uxc5wMwMIVvZZ5glVGLEa1Z5wSyFAKN1TFbcl?=
 =?us-ascii?Q?6LbuGk/FgdKII0JNyHqWlcP5Jtn/KusTC/GDKl4QsVEitORHOmxOteTzZGj4?=
 =?us-ascii?Q?tM7xXgybQdr0TWztyTGVjJavyI9MJ5GdevQKlSyFP7AF808FFG+IwKk7+Ijc?=
 =?us-ascii?Q?JC9eQfkU/aMLNDrUfE7Ou88xtg+vOLxP0JC8MrI95Gw3jDnwSUCTpr/XrqIz?=
 =?us-ascii?Q?w5zjRFqRAzcr29QSRAcZ8Urhbm8uOwZQgH4B4R9FS53eWt3CK06xIcWA86m5?=
 =?us-ascii?Q?oOp1YOUjkAk3X2QbPwolJ7Dh2D4aGm1gcxcrLC46uFltEBnXUgIQXHLzH5RA?=
 =?us-ascii?Q?mFEGy49VET03WCxVirMXWYP4hf42K1gLfL6B3GDZrIAR6sdj61Z85a3upybG?=
 =?us-ascii?Q?hU2QnQS6cQccCx1vbBcBc5R4tmFTkUT2UzzAPpDj7GRVnqf56FC0CUS1ufB7?=
 =?us-ascii?Q?ZXXs1jmYST56yiPOeVBR5JZik+HYB/6ejYiiK3UXy3Nw7AP1SydpFino2YAI?=
 =?us-ascii?Q?4WT69jyNsm8qFZZkCW3agCUZgQJjpo6lUs7OTC9zI6nsxcSnepqIxfVBSHFn?=
 =?us-ascii?Q?tG1jHsYnfdH4JZ1ELhe3Fl/fGOSCkWhF216baAWgkGVS5T4fuyZTRfrPc3TR?=
 =?us-ascii?Q?xi633ndr+ZSSs98vPIh9hXsdlAshKoo3szwwUYVKJYGqjjBwD90Jh1zzJyCE?=
 =?us-ascii?Q?dA9bsPjG31i0a8fuXRXGAW+ePZMcNUNmtWOlWK5Kj+5GoczouAXev1CyF/mP?=
 =?us-ascii?Q?m/1uaojIAtxxNrMT1hKi3+PigQjYJRGZvGWY3wPBgrJyiw6Toh3CRLPq1sJj?=
 =?us-ascii?Q?Ikt71dEOThNFOEGY7YcuM5b5p1hGSwwZQp7nzQ7cNFdCwOztQoWMyAhwRNLO?=
 =?us-ascii?Q?A1C0X3htCopynNwSmgQlSiq4W9+kRj5YavPPSH2izXGmdG6W5w3biV3KrY/y?=
 =?us-ascii?Q?av0htCO8Glxs4Kqr9WKwz/Fa2WzYqhVJptnvenTm+BbxhJ92QC6vX2AwAR5g?=
 =?us-ascii?Q?o5ukCmoloJBP4rskgCwnfyJKRvrIes8UhtzYIar2Mrx3nABNvMSQJIamWt4l?=
 =?us-ascii?Q?pOzd4p79kNP9sLasz2qpsdIwUVqg6G8qhopTh2uR72ZH11VLOtgmTx9sYmgn?=
 =?us-ascii?Q?qcC2rqok5uC4RQdBZMAr6YuKYUdw5kGb/iInbvl3UiFXdGXP2N75wVYOJ8gF?=
 =?us-ascii?Q?VT2Y/Gd1YVV7XvTOllhxjbQnVywYYcGdef6ouUnk6WwSPlPNqGaHHhE3YNVk?=
 =?us-ascii?Q?k3MJTQhFZo7j+7pdHo4UF5LPyM86g9EmBi92/aiOLoEcx69j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992d799a-c860-4e20-e902-08de982fd50b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 01:07:14.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvPXfNDEJ0WE5fDQH0Loygt8VigDZ0wY28146dVNCffNZ99jnKZXV4og+hpKsJ2t/gPJl2T12dxoq7FSTaO5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10032

On Fri, Apr 10, 2026 at 06:27:35PM +0900, Zhipeng Wang wrote:
> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
> to allow building as loadable modules.
>
> Add prompt strings to make these options visible and configurable
> in menuconfig, keeping them enabled by default on appropriate platforms.
>
> Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL
> since i.MX93 doesn't use GPCv2 power domains.

Does it cause build failure at GPCv2 platform? Or previous dependency
actually wrong.

Frank
>
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/pmdomain/imx/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
> index 00203615c65e..9168d183b0c5 100644
> --- a/drivers/pmdomain/imx/Kconfig
> +++ b/drivers/pmdomain/imx/Kconfig
> @@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
>  	default y if SOC_IMX7D
>
>  config IMX8M_BLK_CTRL
> -	bool
> -	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> +	tristate "i.MX8M BLK CTRL driver"
> +	depends on SOC_IMX8M
> +	depends on IMX_GPCV2_PM_DOMAINS
>  	depends on PM_GENERIC_DOMAINS
>  	depends on COMMON_CLK
> +	default y
>
>  config IMX9_BLK_CTRL
> -	bool
> -	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> +	tristate "i.MX93 BLK CTRL driver"
> +	depends on SOC_IMX9
>  	depends on PM_GENERIC_DOMAINS
> +	default y
>
>  config IMX_SCU_PD
>  	bool "IMX SCU Power Domain driver"
> --
> 2.34.1
>
