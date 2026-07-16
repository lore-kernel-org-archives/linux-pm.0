Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187341F7CC;
	Thu, 16 Jul 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211099; cv=fail; b=GMUiZvNqBsGJez72Jmq7+tlS6PDshAuWF2pE3Hd0AL2hBILRVOP90De1DyByOPW6TYcDm7iQVbVqP+v7dIdUxOZe7NWY41xBAaK/6lxoj2svddthx7QbmIVwW7mFqY8OcuYijAPPyMAtbEm8y7qn39NsCHV19EckpuvMZz9Pgjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211099; c=relaxed/simple;
	bh=oO8ZrEX93k90FWC7h6zdA2M2JBBzyrRtLnTJWYChp54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bp3r7CLjwtkndFG12tz1yqeoQy93fk6Vc2tbAMKSACJIkH4QkGkZZ9i2/mtzuNImK0xZdH3GIvSDST3sXeqamT2vntGEfqDoILWqgA6dPPbzTgIu/tIRJQUBpMNdv7t3gQ1VRSd3hdehCGBfOJdL/HG+8z33Q6LkgD/AjH/Pqf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uWkmBW8u reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uWkmBW8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyK0P4r6LX+LPn0JfbCpzfwfiXmhEGvQC06vYNw/qEieb4yyeucljSTHTZ8+xcKdcodXMAWqRtQATEVJVgLRsU9GcQhoSyTpYADdpjDIGltYjegfAzN4NodHfjx3EqUsqmvjjSyj78VuMqgvo2M+xx6lsNHi33yngGpspYsyWtPpDosxfeLWLNF3oKQoopOFDJKgDZlNQumfQmbo03B+HzjnLd2/NNqGGQtGlB+pDW/+1UNRVzGtosQ31xoG5AiNL8/+FC2vpZ9gPxe8mAuszQOLzMtVrHBLQYrNjULI111gsiQ+n5igBlETzN1A2jzm9ELIydskG9csxlCVgoOVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzLSsOH9tQWd94OZAEJI1s5d32RAM4zheBnSGKawSU=;
 b=Sd9ezOaLXquwCpuy7IymHsPg2V7AkRRCSM0xOAAQx/+9A/73xSlwQFZa+G2EcQtIuMBvTFrmp+OTG397K02i3N9KYF3aik7X+Vvd+Q2UvPIksO63pi/S05rWxdhDZJQVA4OFLh3yJNs4FI6/j2xZfwysHU4fJ8qCWNSZiCRdO88v0q4IvjPsBvHwBZkUGJNrwnGCwJdjJ+N3BLV/QKwmzUEF6sVAVyhEsJwThR5W6Tjya0vXq5vGldnCX+7snNv4/dmVLbyMiYNgg9GJPmS3CrpW61QSFAhy9b0fGkgn6ZhVmV+1iwRYD4d2XkzHznPd71465/3ZJ8MGHzKTrQe9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzLSsOH9tQWd94OZAEJI1s5d32RAM4zheBnSGKawSU=;
 b=uWkmBW8uvJHyUkCUxPPfCarC4gOxx3pcj87oT0Kh75tog6pibDOs7bVMI5vjJ/k2uiH4YmdAMSPNQ5jDwFwR6tgKBqIoBFiLHCfR7U+f/GYT8CaSnzsM6Ytzdrrn9Ozd99xMAx7JAUts18F4UZSPaxiPj1gEnc2Ilpoh9sFN8/rXt1pCuwTokSRvWa44HLwd79aM0lmoeH5hhh39cBy0rbtncKYBPIJLZngwjcA4UTL1UJfUr52UPDuFQ2GuJmoeczT8umSIh8QP7vKrPqdDoGnNT2S7STFoZBEEV7ycgsKgi2eji7YBwKDJKAFW6Tn/R/0XDhA4nNp0jwA9e0Ycgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10689.eurprd04.prod.outlook.com (2603:10a6:800:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 14:11:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 14:11:33 +0000
Date: Thu, 16 Jul 2026 09:11:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx8m{p,}-blk-ctrl: Add MODULE_DESCRIPTION
Message-ID: <aljmjGXpbTOvdvvg@SMW015318>
References: <20260716132603.2327847-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716132603.2327847-2-u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: PH8P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aadd16c-7c63-49bc-0c11-08dee34423f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|56012099006|11063799006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dR2ARhXUe+fIeua4rNee1+bNhvJOoEujqH+8waj+BVaHzzAQ5MbXEK+FY20K4NrO3Sntj1HopY2VCMBiOBGZm0m8ouUtw4BbanJQErGZkiHK/twvKSIFngheQiGJuPDsWcGnerEtXg3Vft0JrISE5IQQHhNn8ZNppzaEyw7voKv82LGbP0d+AHXqu2O1bTGE3g3fOawZjtttOgjDd1WjJnMAeLCtILoZLrmftYXy+U1e8QZrw3NSEPS0HE8z0Way3h9fnVQzE+6+1v/ABXrqQXsNqWrRC9oMSeywzUOTmmpTHPrCJ5tYWnHu5pOoKX9lZKC2ghRhrkHPG1wp8WeN86U9ogOxqZL3n4em+6JlSaNdnv23FeqJnlBk33iZifCTnlehXIsOekb5VJLqsJRobMxSK3A0TkQ4JCTEuBCv30XgeQIwLUWQKDZ+Yr/fHX8OJNFazbbdEbdceK1i3xk+DweYg0UK0hKpIaRT1jx/DnIEnUQ3aNTgXbWqZgHcZlfr46l1pM3NSWtp2rH/Yv2EAiBqWjTA3iBNJs/otjw+40kaD3+FqOjC3qMTDH4O0sPBuCYPYn76wHNChL/W0YhZ23etdAaw740TgliPiDwhYB9TFeaG2K4lh9mR3Y0/tKIHW8th+TbZKTyQFrMRFK3dnrr34RG2LCC3IWAlReZbaB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+XRqxNhWFacUgw/kQpxofPiYv47MTBjDw9pEmF9iS72I7QepW8/Wb2UxHg?=
 =?iso-8859-1?Q?RLOjZLfMcTPC7ZYBs9WLaGm0L3dxum+jkmmDizws9/dR8helnuPzNahcbH?=
 =?iso-8859-1?Q?1caBwcpyVj3hNGCRKd/nfpHUW2VuxtTPrWNOGnVfvEXGySDfXOf6uS2U+G?=
 =?iso-8859-1?Q?BBbRA7WqS09KRrxIXscuJ9Nqyh8j4g9d7MBAg0HBkPgKX6lhuzsjT77h6A?=
 =?iso-8859-1?Q?DrsCjmiOmBCn0zI9/l1lVEu2A8f5AuCLOqKqfFPQn0dl1J8C+bQp2EL5mc?=
 =?iso-8859-1?Q?72W7tHPh3yxw8fJiAccv90dIYLuahBw4LnbyC0D9ZHvQ2mf4H1l5WQO33q?=
 =?iso-8859-1?Q?19T6afrzvyWGTVS0vDgsfk0WTUISpwtlbHyJkeH0KexQb5ZfdoLPQnOHox?=
 =?iso-8859-1?Q?1AoIWVJKUNF7iJrnmxTL9XJMvxPXI48cNtMwGmSv5pN1QlA7xelgeLvxRG?=
 =?iso-8859-1?Q?snC372dZpUSfFvKwS9HLP/vUn4WXiv5rZ0VM/mB3Edo9duIlC99Xa2RHGw?=
 =?iso-8859-1?Q?gYTqab1Q0+qD5KJfW8B2jkno65UpdAx2BriK2wKyRxxnLBCnarGTFiVn8e?=
 =?iso-8859-1?Q?XklagVCF75dvsUOkpfLw7Ag1q9UlilLpyFv10OQjIo7hEzGO/cZxa8HdPD?=
 =?iso-8859-1?Q?cijueA2CrozI+3JF/NblskCAMg2sXd6eUqUnDQ0SagxURJy58zsdcfM2Yx?=
 =?iso-8859-1?Q?zVZQmXIUAvVGhXKvL+s1Vs2e4H258R14wEie++6fQcWVMjph+Z4N+lD79o?=
 =?iso-8859-1?Q?dYzpnB/Ge5D5gyIj2APip0iLe9xVVuU6x8VmYD9JqiBa2haKbjmGZVn+H4?=
 =?iso-8859-1?Q?T/z3sUOyQY59vug2KtbMGei4GM9CROITmgMjzrY/gvvzC8GGqjDvEZLydd?=
 =?iso-8859-1?Q?2kj2HqbhfR/5ThbLZSyoaoISHi67ummoInCeI82lwGstwueLSytPY48WT+?=
 =?iso-8859-1?Q?lhpIPEwxMWygHRwkLxdRRJzkCXhkmG7sAdusbfXYRCTGF0CZSZMKxQToYl?=
 =?iso-8859-1?Q?QD6u+oBiCuUzgTmcUCIv9ne+QAniHeS8fpbQRKmxPemK5cw/tZbVmsxz7n?=
 =?iso-8859-1?Q?GzZnE7TTU204M6An4m5mwvAMYkcDzdb14d4qIS8Hd6SecD+rTkw1AscFaN?=
 =?iso-8859-1?Q?bFWX6I4hd7nimXElj7EMTEW630eaVPFV3bwSZ9+jO+5BuHZsTqAwnG+MFN?=
 =?iso-8859-1?Q?KLzwvam/C0QoyFv9w7T8FRKrRyvwoJHKIJMGoSstfg6T8NQ/u5pvUuWmGx?=
 =?iso-8859-1?Q?t8SLuF9KBLB4WdhR4b7iLExVqIfVeF84JEHJXXLqgdRyc7ZacEixha/o/G?=
 =?iso-8859-1?Q?NZ5cmoxHZ7cqvsKsO7Q4k467OYKGURTH8FqNDQ3RI730uWkc/pmFQZQY3z?=
 =?iso-8859-1?Q?Ajkk83Fx5ANzc8yLOakMX4gH67SiUwAlzp4FGB+KksW7sH8eR/B6rLgdvV?=
 =?iso-8859-1?Q?6Y0PqKoqDbWe1FGJ5zdnNbD6M03hSBy4mLYepmyYRHyQwf0pnpK/QAhG45?=
 =?iso-8859-1?Q?IfL4VE6UcNxFC/RrB59lMnq57ZSXWoV3UlRyIXRqcLsXJjBlLYxOQuQZDe?=
 =?iso-8859-1?Q?c/LxbYYfsh2nB9A8u7lR144Equy/17vuRLr8wjbc/ZQD6V/UyaXGKRKeRG?=
 =?iso-8859-1?Q?n6X6m2KZRFqudjpTYgIMDHTC+ZK4LTwsfAwCdZqNfkCUoOVl/sUxeRS1c7?=
 =?iso-8859-1?Q?pfNMVmTVwN8qGk3AcpzgaOUjZC+NJcT+HKZyOszBS3jS1widYgbm0hW4D2?=
 =?iso-8859-1?Q?qsX/MzpXryJm4JrkK0i9wfRZ90IJFM2IAdUqulQAhKF9zKwt0aIwXq338B?=
 =?iso-8859-1?Q?0rXEd3DDTmlT92ldkDQM9EzpiVYKatqfbAPiNPL9zk1UXYg2n8H8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aadd16c-7c63-49bc-0c11-08dee34423f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:11:33.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8/UYRfi40oAcJvXLUiwnJFPa6gqwteK0lVP6TT6ZQcJF53bhKSuF8Yc8A9PPJdbhL/NCwE4msGBJDqKk1xHJ9hlpB93eXRLwL8Fm1TpGDA8JRak9mmdPlLlTtOkEZ6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10689

On Thu, Jul 16, 2026 at 03:26:03PM +0200, Uwe Kleine-König wrote:
> Without a module description modpost emits a build warning:
>
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/imx/imx8m-blk-ctrl.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/imx/imx8mp-blk-ctrl.o
>
> So add the required string to these two drivers.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 99d100e1d923..479789009c7f 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -953,4 +953,5 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
>  	},
>  };
>  module_platform_driver(imx8m_blk_ctrl_driver);
> +MODULE_DESCRIPTION("NXP i.MX8M power domain driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index 3f5b9499d30a..d255c20f58e2 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -890,4 +890,5 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
>  	},
>  };
>  module_platform_driver(imx8mp_blk_ctrl_driver);
> +MODULE_DESCRIPTION("NXP i.MX8MP power domain driver");
>  MODULE_LICENSE("GPL");
>
> base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
> --
> 2.55.0.11.g153666a7d9bb
>
>
