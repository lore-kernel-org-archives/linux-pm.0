Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E7443C1C;
	Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392969; cv=fail; b=Q5A6uKGOcLVYNKF2oSQR4eRIol6L8oy0pm7jR+oDV9REXaIZbafX+42OVbX8eF5Klk4ydHK+iGqKo8EDug2xDEesnLv/ehiuow3cVCw9iapd65RZenKuoC9U9Loqq/rDDU2vi3NVzChNUu3/qgchU/2Hi4kgpcS64jdEf/VUs2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392969; c=relaxed/simple;
	bh=84N2Jdfq9UrdEzX+jR/eKcIszgRWofSSilmHtOBuo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d80WW7dznhnsdZU7zDSwkuluUMAI7p6euw1egw3xefyCXyXAFOnnwgbDviPe12T7YTUUT+gfcYcsPQBvU5C8nUZkNJyM03Hs4dWDBRHjJZRozZwAz8lMORIukxNKOd3xsM7+wvlymstJtaaGWpAZ4QzCYwStI1FYNwVyT94lnR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xxMKqHB+; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xxMKqHB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaxbQYNS8Cr22tJ1hNc6pXxqywvhsGIOPtnPew0E+OupLNJPMm7G11lsHMVCnJYdq7Yn8e4KEeXVZnLoJwSYnifqoRoaRF9bMZ5pLbY9B/wXK+nX27xjJLtERud06VP4RixhRbVb6HTE6X1RKVliSRygITwdMOyGOF0pBm6hTgiQX31lGyRZsJxr+VhFbsT6OvH1QHyVBZ43C0A4h2ZpDInUVx0k2PUGey4VUbgIQHftlYoZ8dOcv9oFWQY7VGiuU3IpsvDfLFxTY8ImZlpLb3BawRuQ6zx/xAjOmK+LIAXoyfE9QFgQUQ4WIizOJdT72tksXcwJl+ofon2LtOI2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h7ZY1zg9xGXVt6w5prHoUecfWf/gFfAhPGVDKJK2r4=;
 b=SteeztA8Ux3jWyxNJnHaubhufLL5awU4HndS1Vs6ObjYtbozKgA/6VsBagbto35b4nT1JcN0U5h7u8h78ESQyPA4KEdV6/Y+DbYRK/3slj3iXL4RcUjzj8x6HFWoUpQy2oy/22Ql35Lo5wrhsC9uW1Aq3m6tnPIQ4f1qT4u5wh720X4BI/IXwwZUE9wH8s/PgEDG9jNoO8oQHdNUkSGvCj+fCS1mAR571kYtvbwNd4y+1lNMu9zH7I6/vX5wetn1HSqJVO34hq7JV6s9Vhih8swH8ZsYBdGDdoZuxy+OmiNrASiZc6cfjfWjPTRYDUnC7chzQjOZyhSz09yxaK9Rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h7ZY1zg9xGXVt6w5prHoUecfWf/gFfAhPGVDKJK2r4=;
 b=xxMKqHB+XP3d3MAsnabK7pn0NNeXeVE9RFjcVEaMyzuuro9r+nYNCBRQUPAsUbQHAPN+3AzvZSL7KEMmALxHzLaMXX1/ychyU6GfM91I6/fGORsPGDBoAVDRWEEmgspVhkOC7KikOs/t/aXLLXXnNrjxpEYkaQxEjVGzF75ip82XxJQeZjPtpPnd/kxsgKMDcc0tB039+1tvsPFuoBuj6HGdiq8STIiUhTQ+IS4xmIhqxrPoU9PERcEOBKK5EC7B8sF7EMOLoL/3HUlFMDm1S+KKaTIR3D9XRD1NFfG4sdbWMVDLUEkOlI+g0bSXjUXyWrwy+Bnts09XXVxx6a1jOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB10014.eurprd04.prod.outlook.com (2603:10a6:10:4db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:36:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:36:03 +0000
Date: Mon, 14 Sep 2026 08:35:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 16/20] misc: sram: Enable runtime PM
Message-ID: <aqf4OEVpCX8XNQW1@SMW015318>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-16-9d0c17e1f816@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-16-9d0c17e1f816@kernel.org>
X-ClientProxiedBy: PH8PR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: afe2c339-6a89-46a8-0e0d-08df12651f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yfdYkpxbMe8JzEm2ETdhPpGcaTQnYcPCSVDCKFoBIV9TBDTMgs+XI3Gl8mPpZtzs2VHYuu0etIfQxGRt+hIL3V8Fou/HX3tUYQFj411CcEOT8qkX6wys/TLdk0UCAvdVBaeZ3iyfog7mU6diyN/beCgSSktGwRI+PMGqt4hyhgqn+KW/8ZLJN/fLHjQBCDgA0vX9GMltuGAnNOCDlZ8mlOHBnPo9By1xXB3/c/IF7ZH8MkvtjH/2/2GLysUWf/e0gHmYXx80tm9HYVaV59Kwu/OGDFkOjZle54WLYsWW+4ZWvD1ShdH40k23zDV/VFHFig1Ik4+1h3hYJUAZdcvnSYWTiwI0avUEuBNE+aOQiDIAjNZU+I54quBssLg+gknAkNn6qnxhQhDdYh34ZyH0XeSve7eJmhLpb3SAhrNTwxOQFraovYYWBeXJi0+Bo2Nbz27ZTyoPnlyU3R9qgHhT/6GMoS3h7/P/bpFi0YSHbJQUHIcpVk2uMw0qm0wnyy6uwYmLLnItpWYV4+QQLmfnsQxzXGj3edqFi7ms8jUXClIFI+3cpuXxaVQU6nyV2WmtGyqZDlqhluQ2CCNFZBbHKpOLm3cNJTapIAI5mnls1I7XTizWHhTEzwehksqSa7523PJq+oLyWOME6+XSK9ANwrsr3TVWjZ6DvEYNEmZYvNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuk05Acun4MONovCOO2keRTOl+6RvJmAJbg/Sqg5p7LExX3IlvanH+qZa6hA?=
 =?us-ascii?Q?dbtqN8Nl7scyFneM8DUnHMboYSzBfhlzxXH0Md+ZD5w8WTE80zZcxayiBm0C?=
 =?us-ascii?Q?Ty+qMj0iklotpZabcpnRHP+37tOrfgz44a45ViUm1nCmNMkjk7LB3AUCfxE9?=
 =?us-ascii?Q?zXts+pvkRpQII6k13/S/jtS0dY+mo4BbTx+h2PGYPab2e4Ch/4okmQ7HZYeq?=
 =?us-ascii?Q?7zYobclfFY+qtIMsOH62DKsgJ9QAhBK/yxBmpagzsheKJG+5bT9e4CXiROTi?=
 =?us-ascii?Q?sfcxYiE16R1Fu8WLLCqxQ8Qb4i6sA7EfM+84WNhVNUbviLnJ+rtXMAOIcW6Y?=
 =?us-ascii?Q?Fg9S//5FlUdm+OcRhGo58yXu4Ykw158B990CxkaM5Vd+XH5Cpayove4ikP5H?=
 =?us-ascii?Q?zre+WU3ixox0YYq/S1btAYvSL3FgGRB3UEY17jqSuTa6WD1N6bd3Qz+ku7ZC?=
 =?us-ascii?Q?MH3luFUGat7EIYLaiLmFlHhaL8k0Cf5MkHTTtzktdqkVSlfJKSaNv37kstiD?=
 =?us-ascii?Q?XoM0CzCp+7wOzu/YqUJEz0vm3446ljqAjxIGcBtke6fbUg9K6R7JtNLxluey?=
 =?us-ascii?Q?7JGriGawqkczECZjn4jnNl3SPkKabOHu7/L0JYQwbP8Vp/v9bkhS4kX2vJSY?=
 =?us-ascii?Q?F99SBkh+LF3eAyZFTX3SlIe0/8kVxXmgjgimVOpwg2Pjwl+RnRRZQ2ShdzO2?=
 =?us-ascii?Q?SI9UI7nNIbvHtx/cTl4Qxmn35QLU7BqtPdK91Bh4UlPsNw+OJa1s+P2O3nI9?=
 =?us-ascii?Q?c6Oe9AloJXKDjYjyAOvCRAQV/0YWCTUhhU0GKJEb4fUHY8DolA9SRi6AmASb?=
 =?us-ascii?Q?AOxmrlqdZVk2EfCO3xJ03nHFceNVvrHrXBGiXcVmtITVSioiWFimmob3hcBS?=
 =?us-ascii?Q?dlGEcj2GayZRNKPZOnBh0JDGFak8L3560bs3ERFHKB4q90ilzqeDULOuavzi?=
 =?us-ascii?Q?L03rB94qCv3JnnbNzNLXc8ZhKW61FpzEX7nyrOk38zwT/3tvlfdkTUXq8ATb?=
 =?us-ascii?Q?FaiKB3bNwuSxxwMqwCb7YeXsQ3U2qkTjhlfj93IOkhFczbFIJkCIVvs7cEdG?=
 =?us-ascii?Q?q6I/unYxKAM+crxVJJGK2uDMtJ3cjqy1Hn+pcMny7xFZ17Miaxx+pQ+qr4c+?=
 =?us-ascii?Q?7n03g8+hHGa/NIFw812S+TLAk3wEZNXRGNbrenbZBbuIHtZ5CCYJXZkpEf1Y?=
 =?us-ascii?Q?ooPsvV3pwFnj7QEdD21LPdJT1IE49E8toAVnPHBo5v1sk5f8Z+pk72tu41VM?=
 =?us-ascii?Q?hdU2UjSt77jINjBxZRkYznxaHOM+GIHT0asCBK5NWpuR4YoOYDCj1s7RmnCI?=
 =?us-ascii?Q?YP8klMv2+ACdFjeB357zYQG5rSSAq8F+RjXTMzwrEwSgXG7gTfWy6yli/fmK?=
 =?us-ascii?Q?ifcBnwk8f7hFSyre8ZBkNg6BJmbxfPd1YzT8RvJLu6G3jOwNkJROBn38998X?=
 =?us-ascii?Q?/7SoHFJoWvzHEFKZAD90E8Z3SCUtW/LuMYHY6HOILqmbpzaFjj68TW8fZZ1R?=
 =?us-ascii?Q?J5tSEdqxa4DetyBJBFVNQei6xUTVlTA0LhNgjqjx3B3/sHbpD7iucQAgIMKR?=
 =?us-ascii?Q?md41Kv6VbqYXFWGgHyVe2Zr2vreF2TzCnzy8Fpqc1JPzmwx+LpUVgdkvqKtH?=
 =?us-ascii?Q?OE83vaFNI8wFJsb8F0CmcfsPl+ki0WTe6Vzw0DxtaiqQ7UH+2UIdAnkcOOHa?=
 =?us-ascii?Q?F2tov/eUA/qefs9Phq49l1anFEMkSf0uQfrD6WJdJFLYxQWJ+eCPjEUMbNEU?=
 =?us-ascii?Q?EyRHHXHa7MlMy+wloZ7BQ7t3LW5w48xCnn3WNXOc7IeDSsHm5uLm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe2c339-6a89-46a8-0e0d-08df12651f34
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:36:03.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LuXGAk70EQ0heZy2wgUFKzwT5BSWSi2hUY4n00w1i6CRANLBjbKYtHp5icuepWx/cAgzpyV+CtWVkw9W2HGvT6M4yorAedfQGl610NWca3+a9Ug133lFeZE28epOA5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10014

On Mon, Sep 14, 2026 at 01:54:44PM +0200, Linus Walleij wrote:
> Enable runtime PM for generic SRAM devices after probe has initialized
> the SRAM mappings and partitions.
>
> This lets SRAM devices with attached power domains be managed through
> runtime PM references from their consumers.
>
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/misc/sram.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index c8990e83a65a..7f19dca7b818 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
> @@ -425,6 +426,10 @@ static int sram_probe(struct platform_device *pdev)
>  			goto err_free_partitions;
>  	}
>
> +	ret = devm_pm_runtime_set_active_enabled(&pdev->dev);
> +	if (ret)
> +		goto err_free_partitions;
> +
>  	if (sram->pool)
>  		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
>  			gen_pool_size(sram->pool) / 1024, sram->virt_base);
>
> --
> 2.55.0
>
