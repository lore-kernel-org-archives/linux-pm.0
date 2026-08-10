Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86043B3C5;
	Mon, 10 Aug 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388997; cv=fail; b=t7RP2KI84bhnc/rJ+7X7rpKk4NzO8dzwoe81kAyOZRc7ShbVxjdpUU6t9PzvLl71Q3Y9MI+5RITa8MD4jg52hssLl7vn8VpzuZkJKqlni7wQWz559mJmHgfB1SaEfPagWd04CoH+7vb+/dsJnh3yDAeyJyL22x7m04H1GWhO7A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388997; c=relaxed/simple;
	bh=29blRmyJTctHX+9d3Qmgp4U7gA4RpVkEdhgfogppDqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JiG+VSePjCwX1taAt6szMtTe05hBS3H7BAjrrFNvyQ13HOzqAo0RBOpM3nURjKs6WdSdKUiT9OdVOccpORaUHEbo9U7jJ25pWGGnQ6aRqX5e6g7QqrsoV7ulTrqPnURIhIFTGhAnlcRWjeFS1sSEeTF47sb7bEUmncx7RYwqkRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mdrJ+KnJ; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mdrJ+KnJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYmWZaimcaB4B3s+w3koQIdlSGLq+eEP2F3DzISn9XWLjZ52Ff6ukKw0v4AOgDMRMOVZwxl5gxl48GbsFHuOwxkZ63Bw5qRTAkIy/Rx0cqLHREzeDEO4bY0hUM2qtob8RSRNMC2JEWj/pp0oaOLc7aZRx1N+WZuZvW3g+enT3knyqd12Wu5/YpEnyLdHWHs7uD0Go5v3ZDpGI83bgo9AbuJsivrr/0sn563lSFySBK6fkFYsTAor/3/WfBtr/6cVGeqEBC2kJPXufj6VJ6pzaJJgt6ez/02zp00srsIsp+9mlDROXtNG60JwI53V5Ad6z0qLlMOxdqLtAZY6g1eQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiaUOwpA/oii5hbppLKigwy3gfUsFrped7pqyuMw6s0=;
 b=KHrb5Xz1xTe1iugvS/OT+h+RLWB2QRBnOLgIBBosaLcIqK7q9KqoEoclKTdTriyJ/QlZOMhNLAnmz8fNq8ogjz3/HEudxqk4VLCQCOz63oGFqrI2bbVzsOnvMA9iitgKD0ZQ/9EgL/3fXBxPc5yn64FHlnGaGWGgpzIB//oyTErJ3cLLxPAZRWQU46x1HaxVkZLpP6uYrZOOaIECyd831/+hznKS2fBlRXG7MSe8flG4qpZDBr8swdL9hOjFxRHBUzj+yWUf6XiA07mB9FouhrB+C6yyYa3j4pitqvtyT7xgrlPaeX9E8ctZPOxRzDbn15VGPpwb6NggfroYEL5h1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiaUOwpA/oii5hbppLKigwy3gfUsFrped7pqyuMw6s0=;
 b=mdrJ+KnJRSRkrV8/t6MESEQOtY+sEbPgglwlDy5FOUSHl5BJjQmJXpuyiQPGj4s0GsYKvJgOnpvC/c59Snw4lGYOlUqH0d/i0e6UE608c6OLiVdy3h9PGObdA3TLwFkN9r9kmB53rmUFdrxistrCcdsJKI3LHEu2UhdtNlFsduMqpOKstEEbTnseTqVuuGGt8s3MowUWyiMXfzHbbtQZLsXszODVR1JYCT1cZUNGtWAxg/92FG0C8E6x2AWZ/aGY6NJHolVXZRCAgSX470JFvOtY5MVhzQrUit287cm57j1A0tmRDfOY/I9ZPELxcgS6thLDu/3JiIl7SCx3SPn4wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:09:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:09:52 +0000
Date: Mon, 10 Aug 2026 14:09:42 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/imx9: Constify struct
 thermal_zone_device_ops
Message-ID: <anoh9t4oqR7XhS74@SMW015318>
References: <5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.1786220585.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.1786220585.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: SN7PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:806:f3::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b3b593-8348-44d4-4fe5-08def712f484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C4Idyw6SzJk2SruzYuAsv5geVOIPaEuwsgFW5rzEnK01298uCYlY26iIsY6+pdm17H23EkbzuHhsOuCnFtH+0Nzv3ZxXpaePwwwIIFtQv05O46YGx1XgUJ54q8NMilL7OB8bGHafQlwLmxeuCBotV1b8ppEdsE19lU8dcQf7CH5k7kdFp7Jxx2is1ViH1b6V9EusMkNeZusht4NQy+AZDfIxq/8XzTkPDYqLGB1k+a59L4HL/m4gLoFw5Tyb0EtQs9MDyfFSDMlXhtx2GCcXqp5JV2gBSna3NslImNXRn9qJfFm1w6U9wws0w2C9Njw+EZSgGwJLzyo3kfNScSYpTANwWA2SwKLPL1QXhYb7FjkccTVj/3Z5iu87fbVBNrlcHLyqcViSp4m1UgKEy6lwi3iw9/2NvL8n3vrwOWvZI/ddkuH22lC4S73/LHUs3lGnaGOZBuTu9E5KGotZjaeW9TfFuxr+eX/ZLPdPrnMQmX3FOeM0TMLKZ8zxbjHGp8Dp85+8AUStKV8kYm8jXJlrWgIRMCwDVRYHyxRPM6uOgcBvG3+mzmVEch6S/zg+RSan5ufXfwDc8jeNuSyfGF50j0ctOYSwPVsXVhi5XKnn22jUIe6N3y38zL5HoA0hnNvbgwrxDkbUZsYZZzHA8UXO63llPIdoKVM2loj13kDMj5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YF3HCMLFpgoTMce8NTuOey7sZCa8aNE9NR/KCpyAQ0/D3fBT6wcKmM5TCaT/?=
 =?us-ascii?Q?B3RDHL8+2FbiQuNMHT9dA9KFd+/XQu2xDw2F/YktmGriOtBmULXNZPh3gDdG?=
 =?us-ascii?Q?QVkw3968cSS1RBCAqUv+gq+17Eua+OiwSlGEbozrvysmW4fuap2IZpn7f9if?=
 =?us-ascii?Q?70RdClkA2fiTpX+5xBcqXWFAFjGz+m6n5wjbpiy3hsN15Vo/sHStSC/1Te3z?=
 =?us-ascii?Q?J6+hUuxhGYQ+OH+DdHPwEX979hJIfO0xvUveJyPr89Hxjg10OmcHUCJIYOMX?=
 =?us-ascii?Q?HG+HOhpNGmzQL7S8z5FF+x7OGk9dWR6Bhaee9p7cVseSe4gvKEZlxW1TGV7W?=
 =?us-ascii?Q?4U67z67bXWcHMYOal34x0XWz8GRIe8oUFn4WgK5DOI/jaO+Y18t0VsxGqYug?=
 =?us-ascii?Q?7MdL2ivnEa7MItrkMx4xDfiziQdyr/qFPe7kNYib/ymTq1Z9tk4f8SZT3JVi?=
 =?us-ascii?Q?Dsz86ZAHs2LwL2plIVPnEJLdPruUipFMTMdI6OW0j5NXP2x+8z5XTiVuwvVB?=
 =?us-ascii?Q?3f5+H9eKdwUsNDm3Z4cA4oNPCQlSqv+jkS1yDrIP2aFjncTD5qq45dM7D4hd?=
 =?us-ascii?Q?ukVwV1rQSV3N5ArlIlNrOuIcvfU40uPKAM36ey10bXYEoN3D8yY65E4wTzfT?=
 =?us-ascii?Q?H9d0E04gz8lxGZV/Hx+rxEmxUphcPxqRG2nrBEAINPsmWrwaCnXzxqSFp2vS?=
 =?us-ascii?Q?a0t/iZyKVU/vOJxPy7mXJ7ago63apsJJpFepK/KBuwzEFQGKkjxw93qbMY9A?=
 =?us-ascii?Q?a/0EzTFC/6Y1KPyjCi+aIeug6B9NZrLOCp+NpTCqH+5GDsb2mumwCZZM5+Fy?=
 =?us-ascii?Q?6gIazEW/fMd6RMUiqxL5yYFvN+qWSlA7Gq5/0rDbUNUkJUaCbFoRwrhTEq6E?=
 =?us-ascii?Q?h6cxuGqiPGUP1iyc6DqO9jAqE57T3IsJmqFIxkhV6b6zz1J255JrbeCwFWxR?=
 =?us-ascii?Q?7rKMRiIvcXPItGIJhkGwIpGO3B8OIRXRnB8p0gDBz02P34mMO640nZYdNTdU?=
 =?us-ascii?Q?lxLg33nIsuwgsmpWw70Ho1hvlVphiTbV4/lsQi5cfCJqsZtYe+uIgMdCNdpa?=
 =?us-ascii?Q?WUJjZzRLQJJeTTBrB8Ez9J7QUj+0N8vKAQCrAvbL1J3F1q926KNL3MZkWkzJ?=
 =?us-ascii?Q?T5NqCNNwRE+re+QqXjk2KqACGzHlhGI6z211PNn9PNULz1qH90twc0Z8qAR+?=
 =?us-ascii?Q?SWFG1flTBSqfCGwJheUhvogACkxS/OlCP075x9mSHU7gUYZlrL54WVXucLYQ?=
 =?us-ascii?Q?goj095t5L9Lj+VUCDmA2gkV8dj3XrqlHJEJooa2FUMD3bWMf8S8CROFYDsPI?=
 =?us-ascii?Q?902qS0epwkxx4uLYfVHT/rqX/m02WsFxUiNfcNRaFcaV7QdRW5HRffoD5WW3?=
 =?us-ascii?Q?5ArWHbft5P0RQ+dAfzTEJWbr0anLfDASFkXJFwOwncFLx9iuupSGPOP6n0y9?=
 =?us-ascii?Q?XIczZK47nE/RvaOsY0ugXEHRU51aLp1JRby1okX23V+QC3Q2G03bQeIkaz7Z?=
 =?us-ascii?Q?gSGfR7A5BgVpBA5klO+eAtV0UgiVdktMzBx01YLEWLanPyqeduh9roVieEtk?=
 =?us-ascii?Q?FEJJv43lPzYajbMU3IyYxaSIsbGEoUA/fVPAZwM8NGT6AxfwFBgAyRvq80ub?=
 =?us-ascii?Q?wXvooT/bwBi+Cn1pSURwTfgEdKkagXpoMd5d9hllj3As0uV1uQcPW3TOzp9X?=
 =?us-ascii?Q?W3vu+1h9jj5Ot4FIbQLENSyAUpAxAR3pv8iXtG7wyqT1oOs8pa3PSlEAE1gW?=
 =?us-ascii?Q?V69BEQTd2uTITeMGIkQxvnTElVRE5AgZQa6B2/apnjRKksfEs7pj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b3b593-8348-44d4-4fe5-08def712f484
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:09:51.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEMy07HyODPJUW8IH5pgAdDTLXi+jE2isf0WQtmCeqved730ugbuWaNbi+FFMaz/4bar/t9hLHnvQI/G5jvXskS+zNPKamN9rzOYEwODdam4lkS9qLXKsXmMBXmGL4oB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508

On Sat, Aug 08, 2026 at 10:23:33PM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    8567	   2144	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o
>
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    8695	   2016	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Compile tested only.
> ---
>  drivers/thermal/imx91_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> index 25915bb702be..892a25440e06 100644
> --- a/drivers/thermal/imx91_thermal.c
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -225,7 +225,7 @@ static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_de
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops tmu_tz_ops = {
> +static const struct thermal_zone_device_ops tmu_tz_ops = {
>  	.get_temp = imx91_tmu_get_temp,
>  	.change_mode = imx91_tmu_change_mode,
>  	.set_trips = imx91_tmu_set_trips,
> --
> 2.55.0
>
>
