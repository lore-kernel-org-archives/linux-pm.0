Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A80331A53;
	Wed, 15 Apr 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236354; cv=fail; b=i4gci5L53swPTqbyvs2Sb1tY8mNBb+rNqcChBDXGRA83+xgUYLtiSifQjTOIFppt4MauGX89AL7wmvLJddxk19VB52BTAv0omvRSs3rbufNVsDr4iRZcD1eUgGRZXjcR3GvzYOWYd/YpE2TjKnKWZNQqjg01q0PH2V7N59fh/J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236354; c=relaxed/simple;
	bh=KLeOPNgevm+/H0+pb3Ddeju3bJYZPVE+K/qgjrmrJCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bSSHiQIU3Sh3OKIYc4GInZnIXylN30ElcQSCP9QviCNAt4NvRc8IyEYp1yfojWtR84Lw7iE0akARWLUNG8UeqXJJZEMwB5+jbLULNMdL5kklt7HMbsHx+FPJbW2oaveeeUF1NEVYOt1rqIJbyS7UQ9rEfhNCKbCO+d+z4Tx1Cqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ctTb8i1z; arc=fail smtp.client-ip=52.101.84.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctTb8i1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsVyLolHTBYWPk9SJ8dXJJ4um3GCA/KQvj/qG4eVS4Z2frCMX+crYs0WXL7LDHZDqznFz5htz4GMBGao7EGxAtw0p6TIAHK+Y+Ay+8MLdgdNST9PUwqhnS9vSHfaawZ7e2plWA/1WqqB1VCrjO4otAdXVB9oE3/C1eWI322S8y03uCGaNkCUAqUWewY0Xu1tGu1y+jNa8GJDWaTJQdrBHESj6RtuvFBjCk2I04YBTHmc+4H3WHlDg+RvucuOPGfNkKpXlEspX4tp+nVIFyMOnTRBHHNIweCXc/yohL9847daHJiQGlJNhfxoKeHcgnXaZ/X6SdNEXvPP30QQ+Sji+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkrvo4msqImWXx0raR7KuUOEjEB2XVAjuCZBfPTkpRk=;
 b=XD9XTJk4zSk9zN0csBtn+czDQSybRkq8ysvbY19Y7wPEFwiMKeBwusfP42FQ14O8W8xF/80Uzq/ZfdK5/scbmj/5Z4SGN+fn27vB73PphtIJMA6A3Rj1u/MmjzIUjT+F/Ho8zX2F3XatnHdzVDuNgOd+f5jAb+rjbyAXOYWtPG/I1X8i5efdhFAwaVzVF2D3vbVkwIWADpTqQgYKZ+kW65xsRgf28DuydtstGAhKgryZ8qJa9Ilp4lu8GchpCTTJg1wYazpYfcxbz1F6IosZBcgptR7OiL2n4bSkIhiGANjcCRErszzaLed3tO9+xLdUnr5GODvWBsDQLUX4IAmwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkrvo4msqImWXx0raR7KuUOEjEB2XVAjuCZBfPTkpRk=;
 b=ctTb8i1zUEjP3hJ6s6PzwX/yN6L5jYTW4gqNHuz67lfz8XElJrTjFlfnzHY+EIqefGLj277csjCXzQKG0uMOuTI3UxwXROcsSBO7hqOwuPBZQe9Bjb9fhE3ChCcAi8wR33BAUuKc6jwwUro4fQL3Vhd8hG7Vxgjb43tJL+OAd49Z9bgKdX5gdXmKFwT/bPNvZ65puw3XZj3FKGzu+iLzzbusPOFxQ9ek729tuh/qy423Rft4V6p8vWKT83tV75v1N12EAYxgvHKeLoBgiUim8yL01C8HDM8/y7ADYet9WbuurW35s9B2ChkOdvemH6CUPWRX+z72x3FaZyDgAC5dug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GVXPR04MB12344.eurprd04.prod.outlook.com (2603:10a6:150:318::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:59:08 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 06:59:07 +0000
Date: Wed, 15 Apr 2026 02:58:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc: ulfh@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xuegang.liu@nxp.com, jindong.yue@nxp.com
Subject: Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Message-ID: <ad83MtdMP4rci3Ya@lizhi-Precision-Tower-5810>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
X-ClientProxiedBy: PH8P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::17) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GVXPR04MB12344:EE_
X-MS-Office365-Filtering-Correlation-Id: d39913c9-d2b0-4025-cb92-08de9abc7d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|18002099003|38350700014|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/+FHCIkFZPyyUzEWgFm42OORIzdGuPwAkbZp537jtY5DPmVy6A8fpYlM/xoWpnLsmyQGuXtPfvzhe7tHDYaNxqgLvWj+a1VU6lSDNj6X677RUdnOdU3/D8CBS5nHrwasFAZKuf/PoKYYI1hTLt2GeglL6/r7qRALBa5lkqb2kpLrBROEh5fNa1Z0Z7Pqo26IojF8XupXmkEz77IVa2eP6/eFXcc0tL1pLVmE2SOTZHR0GxbVR6emjqQu/GYCvE0Z3HVdWhEdh3TIiZhg73Q3Xx0qVV25omfsn6L7zlHqM24k44RLCFfhGQOdDUV5Xx0Kf9LHkFjxj6MPe5vH0lT/Fj+cOY1UB6yHmbRyq910LaQHqBpNZMYZPff8q5KU0bUoV+tbYaKaaQEKtZL6gjM+DaRFTMU3uX6VUhKHGjBZsUwx5hwrqMF64eOd+f2Vy33WwJGo5101QhcksJ36pInGj5yLa9iHpFeRODUInl1APSs8aHBTqtWLYUxJ9/pLREF65fb255ACce9HNfNVgqmLPuiRz/dQZByaSWPwDPYWkMfnlo0veon74HeKzQH0k+oxHVAU0+Ww+uG/6gZ4mLZfPGdrwQmsAUpLM/ka2OiALaBjvjJYP8dLH4TEbHR2ky14+NVvpnLzVSYDeuUhCotmAMiqW8Djw2FdWaKIQyOJPd5Pl+N4DB6ZlS9wY3vitfXpBfxs0tU25OovAyaL4csC6StJiGYMcu+J6sPNbHZzaBInn5+S8hpZDgiVuVuYm9JY8mOsLj0BodAUeRo7TiUYfvhVSgtJ4rufkf1ef4zMCN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(18002099003)(38350700014)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z8nJb6VC0AOf1bcBWJkrSXJRTXEZpr4bscqv6+8AXttdBd0k97GY8rTYgv8n?=
 =?us-ascii?Q?6vMl11tSInHCWwUm5hvOsfkl09w1fmOFstDsllFfVKgYtMnihYXQR3C03aKF?=
 =?us-ascii?Q?PPddFZyZ5CBnhqYJgv5yV3CrIt/ZeNu4a54aN4jpeBvPMGf01I5JpvNlOMfi?=
 =?us-ascii?Q?xJ3LVQQkRAbRYH8yxS0+xZ9iN+3T4bX2viohm1ANUji8CPIQFhc0Osai/2Gu?=
 =?us-ascii?Q?Pkw6rRrZLE0mGFBTMdyPOnDA9enaPpiFaMrLi94FHOzdGokf/G9YgAtr4CFt?=
 =?us-ascii?Q?+4SEDP9h/0MKab53G4FUG/iyYO8+w4wx+8Gi39fPrQNjM01yimArOHtMFgz9?=
 =?us-ascii?Q?i7jZS7eUgjdocwWbJsSbzthU4waTzM/trdq/6p1rpHpjR3GBcfG5i7z1DAD0?=
 =?us-ascii?Q?3F/bAEr/4YJ1Gp80jr1tokLYba/YUREtmW2ghqb9Pvc7aDDPTVnxRubfDDSr?=
 =?us-ascii?Q?M/hizZ55X2GoID6CNDhuIQl7Gsbg4xH7ohcqiSZgb3Hv1k8qHCVFq10RtSLl?=
 =?us-ascii?Q?Q2wV3Q6kLSVYzJmZNSacmmnd9Rlt4xNF4Kpg/jubx6GedNrmPUJKHibmYlQ7?=
 =?us-ascii?Q?7nr3N8POQQMbSsRN429bZIDSBRBg9Bddf0qcv8dkEJ1KJmiKC/6Qj4tBFhoD?=
 =?us-ascii?Q?Q4BByBfBgvS8CEip1drH2zHD3QKQQqqhYcLa7Ica8gDEHrdlvuDCwW6mC0nO?=
 =?us-ascii?Q?uIHZg1PWqWvO3qEQrNJ3v+qo1ESSAsjk57QBoRKoAeiY0PKdLg6V4UkUszsj?=
 =?us-ascii?Q?CA8y+/VDVWzrI8/mlDbWxOehPOqQz2NlQpe02rMLziUlAiTABau6rF5DaZLy?=
 =?us-ascii?Q?czWwE1STc9zGyHy7/kOHg2hMg1GhzrxJ5eqHZYlkM/96qpXkWqktrdboHZhq?=
 =?us-ascii?Q?jRjZzY8SD17YD3X1vMnVt5hwGLN1QXoe8I9hzUclt/A7e0khpNNKY1ZKSJUY?=
 =?us-ascii?Q?7s3j2XuxIHZvYaPS3TW0hkojMjdd4sdItvXwXSUkoRefaY8pJTIDM4gUrm/j?=
 =?us-ascii?Q?TopBas2q+B9iJxvie+t4Unx5ZUreau0Tss+NzjBp8T5JHPBOlLJA6KcB3Sht?=
 =?us-ascii?Q?Kzmf2PPJRheRSoU8mU+Bmtp6/mZ+Y75RLYfQA1haajy+0Cs6JrjVw/0sWjJo?=
 =?us-ascii?Q?sJg/IeyPkkmqOoTWmXLPDR7s8cd48/vezlWrN9ooRmMj4xEIYb12MhS2f/9Y?=
 =?us-ascii?Q?UrSAyazdT/bgftfh/lj80I1+hyo4rEN1cDZkn2BRmgObNBN1o7kuWnyKdUKQ?=
 =?us-ascii?Q?cc9rm1GtXoVu+HFwWjclyG9qLcXLkdO6XXaKFm8zXk89jxH5C2Pk5FHvaCGt?=
 =?us-ascii?Q?zkbFldwCXkHHTpLITlVUp9wshafb3tPXGLL3lJjOT5CUJZKhbx9VG1iFWa18?=
 =?us-ascii?Q?OcZN8zv/pk61CZoxcCHeLBjwwm7JTsOLDN+dHMtCMASUPXur5IZodLhWMhBr?=
 =?us-ascii?Q?X09PrAlJAdfdj6/mAqpZ1Y2M3mX67s9xmrgPy2kuVf0jE15FkpP37eFR9FhP?=
 =?us-ascii?Q?2yfFyId+FGeGrfDXQqtISzyd0k/Cm/QyYoo61r7PGqbYc8BmVrN/+GAyWTGP?=
 =?us-ascii?Q?DC4IR9jdORLR4FWCilDMPH9N4PjN+hECgARKT+bxbSGaqQdTQo9oMN/iishr?=
 =?us-ascii?Q?Xaiv0+nERreQgRRlrthlqogORukoEyzuiqp3D6ahBMam/lHgg8LF5X2P27bs?=
 =?us-ascii?Q?NKGDqRuPe5W6fwFx4r1/s3SqVqJ+9miKTw4sj5Mj8aofGdIf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39913c9-d2b0-4025-cb92-08de9abc7d20
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:59:07.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq1Sy44jF/eKS39Fa56XlMP5YFDmzZkRq8W2uwDK53sfvidNsdRbgsfx1kt1OPV6Em+NAJP4z7vvC/RMEN19sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12344

On Mon, Apr 13, 2026 at 02:30:49PM +0900, Zhipeng Wang wrote:
> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
> to allow building as loadable modules.
>
> Add prompt strings to make these options visible and configurable
> in menuconfig, keeping them enabled by default on appropriate platforms.
>
> Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
> This dependency was incorrect from the beginning - i.MX93 uses a

s/-/because

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> different power domain architecture compared to i.MX8M series:
>
> - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
>   management, hence IMX8M_BLK_CTRL correctly depends on it.
>
> - i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
>   have GPCv2 at all.
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
