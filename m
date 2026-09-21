Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E54CA78F;
	Mon, 21 Sep 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007511; cv=fail; b=YlV3dQviaSQl02K7z2yb2yolzjtOLVcFesCo/ua+gsZDYfLgJbwgmkczwE5MpT5Kqo57mionmRypRcZBzMNRUocmwuC1IVa06GyV8XZKlSMH30LYdxFiV3ueSxtkq1kg2aNpBKEkl5chUb77sudYTCNHOnohaIUIs6+Kpgh8Aaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007511; c=relaxed/simple;
	bh=zI4mpo5wbkRD+aWr8mgr9wPZ8ynQOdTqjf3G63e4sbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKGkOH0xFo/QMf+D3+lUadbHoPxTTsuDb+KAhFLpMQO8qvxPMLnjoqwm1bhLUk7fSSRR7h/+ZyblUnM1irOX6yT1TUtuu6A8OQbOwHKlMkbRqlvGjU5lyZMMmwBD0Q+K1uVo1wqTfIscuRDl3isaZDYt9GF8X10aDJAvp7MGbtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=anduyiVz; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="anduyiVz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtWuhU/vPIDfSwP00wbQdjrc/3lIrizjAnp/XtAWCbsRMUbPOPs+089Zoocb/HJclmSG0/QLYGprKitYu+HFgj8s0iYysj28i9yQ+Zi2V0qjFHicEXIGrY/fFxrgAXY7ByB3tuyDY61fgscv4SaOj8VdBLlaRh8AXSDJt5lA8wPyhudQ0x3IMjC4mIGRa1nqEeqNbr3jziV3d70FZcth1hdjM0ukg7ksv4JCPCvm4Kht9K9CSAo7nN+vV151KgBKRe38uqVCgiFfaIdZrM5TgoCmXjNE6wwvBfKnCSLvVz+VwQnbTlfYCIpGjKhSYLjNWiKT7WIhCFThupjfTP5RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viQ8Pa7bxbar9OqjxUEGq6AWHmgpVP6SF83VGdMogDs=;
 b=v4RT9xnmCNG4K1livoyp9I85KWU63ehi082xEF683xeHwFq0qiIA5UuhRSJZF9RnJKCx0MLB8zhyJxIRUHHnC246mJnmGZP2ecYBvsXzENLJMEFJKhO7MbhqH7eaoK5WdXs/G3O5CO+2hL3ifV1u11J6rj6fowPdWfFhvfwFcYgbQUU+mHh639AegAnFY9sHDXMUYPTw66mWeZOaHNQxB64cPgn+pBuww7waTPuJgLIAh1ciwRUC4L2VNe1gZvVF4oCIBAaTfEF/AVY2JS5GA/8HLS7SCkh+w+ppOIM/k6sO0OED/cQnfnO7WcDvPnFgYMjVSYsYR5ucJXp8IvQi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viQ8Pa7bxbar9OqjxUEGq6AWHmgpVP6SF83VGdMogDs=;
 b=anduyiVzdWvp0xGARez7O7stfgzRm13U7dPNJtEMiIXz3eRdy2vtBnrFGiYUuWlsa+JUnI3AxLupafaRlUa86x8ENDdTVOGm6iyg7J3+Yi1EgW5t7ex33mp7QxjYW1+troJyuFBqAuTlJxvrJc58GZ/WLvefNuq84rdcUq3FWdGE1xPMT4BoV1frGmLukmD0BGShTGJeTRxp+rxJ2tl9ekLViYq5OWUZ+lVwAXIg/rfvRjJvVXWcFNeZDZF4i9hPiniY57IxMtXXXvKTfYIysGVAH5fkRedtbP6SZ5tkyRq4CPVhS9qb5M6ay4QHR48+rjc1/UIYcgA8V+RI4Uxc7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8647.eurprd04.prod.outlook.com (2603:10a6:10:2de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:18:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:18:25 +0000
Date: Mon, 21 Sep 2026 11:18:14 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>, u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: imx8m-blk-ctrl: Use
 pm_runtime_resume_and_get()
Message-ID: <arFYxkfN_WDpDtRb@SMW015318>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
 <20260921033708.14433-3-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921033708.14433-3-phucduc.bui@gmail.com>
X-ClientProxiedBy: PH8PR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc45745-29e6-47d0-9427-08df17fbf650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|19092799006|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/WilahWaOz6WqqTCPmi97hHZkd/9o2vHGryeJXc724yJKzKqIBWwH8zu/+MMcEkrnFO8F/lbh6dFSMbnHBxVLUcy24rMosHQnvxAOjSN3EyZZaN14CzvFlszQDd1PDFuw+CYxJ17jd4+V4l2pQNnzwhQQJfzAIhIgPi00LfREc/8T4+DwK4I4INJTTRCrnbmZ7/4+OAq9s4UboktHbsL8aLFxLJB+KQvfBjNsMJnJCf6o+CQSc0S0rZmHjGLzLajWMb7GZPEBxRHq+10rukj+FGqUnKwvPtN1rTn1raQRjQ4h3ZMCZoZEmcdrO3X3wEecthOlijfSi7BM+fOQH1Ta4FL4oTQCzHpJbIOCxshrnjN+rDDJZGyJOR09IEONUTyc6EICywh1VZKgQEGIK04szz7HnN580gOUkyWhs+MZyC01mn7g7eOG/2vERzERvRYy3NwYzywNY6LtKAHnL2kX191ThPjDzhf6M8Ly2EWFyB0C7xFrBokjjNOteI30tfVyFBDsGLWhlDubqP708zhHXE8LrfSCADD/KTSkZWg9kx1TlP8I4eFC8Hk88IG9TMDjomVMTxeSHs6O/LuOU9Wboafps0W+SMPxQ9fBuqWbCLKyvssTJbTNXjvYuZRwBChe1k1sSJQTbWnqlYvgBavy8z20bZRBMwYHq2zdKEcfRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNBp3JFO/nIi2EcdRPgZFtHVsUdJtXW6tHoJJmh5btYCgCX3nB/JcP6KEJGh?=
 =?us-ascii?Q?4fzzNbYW8GsOMl4Ym1BBRNGtPdO3aoMk+C4VXfOyfeP1/HtMy5xPOnLyrSC0?=
 =?us-ascii?Q?4ej+DIDwpMqbEyO6JwfAJzR+/OxLB/4JvKmYpguhS6RNse8Uo7PTqMMzHlN+?=
 =?us-ascii?Q?A3MdQxVKZvdECsxt6XPBpK7hVNf4nx8kcGipYRsaG2MemjSS3OGr8R7xKyf+?=
 =?us-ascii?Q?ojjnajXVG8dvFzdqPjz2qFSllkkxeiTI6SkNQ7hhpfsWXWp7+7byO4/mPHsJ?=
 =?us-ascii?Q?qGCn3XIdFnuFC4n9ijAEBJP+CfuwT4ggYv0EHmzTJ+mHTMBKcEQto5oXIhpj?=
 =?us-ascii?Q?I1LXBq79st5ENYdhRdNwUBZo9AV1YvjdKX7Nh1iwvGkvbeMMoUZqu+KhY5sz?=
 =?us-ascii?Q?u2v0xsiQcvFh90vlAbuW0WS9a9CZMbwYVEWqa4yZ5ksbFNM1AcK5kONCTAjX?=
 =?us-ascii?Q?f1IeAeGLvftXEefIYzYs84DRsKWcX7cIPqbJ8OQHXfxUk8e9V5nqzlRC2kU5?=
 =?us-ascii?Q?NgUUcOfPnmORudlIPQ2hk35T7cIHz2C96uv38tA+163aP0rRvmP1Y7nhZaSA?=
 =?us-ascii?Q?2yjcsf+2pnh+dUcYtY8bj97vtBRY4JC1FVlUeQ/zcIq1HW8b09/RjR2jE4kL?=
 =?us-ascii?Q?9wsi37dVy0OV/6jiHYry6j+6kbDMBuUmZUkDuUXetPf9s9q8OTpay+hDEAN8?=
 =?us-ascii?Q?V4SggbYk1i7s6eO1PvWLCs62ovsuRS65+2KKd57fO55fT9AiVAfMjy6ePY4M?=
 =?us-ascii?Q?PzFSsJ7qpCub2XtGW9u9g+pYqXPeNRhlYyD/hcnVk44ktqxM5XuaThkqb2bA?=
 =?us-ascii?Q?UjhUtPRSYDS3hbLljx1NSzjsAx78BclPn6rLQSfjekfRd/TGiP3VUV/aMEhd?=
 =?us-ascii?Q?ajbF99dvUihxiD3geOVx1njATkoDPrfdqwaTpTk+TxiN0eFa+S6AuHFPhPHa?=
 =?us-ascii?Q?y5J6JyEewtZTuGUJbqBRiaJWBPQDRo+CZ9vp655FHpBna+2lzUqjln1/SDqL?=
 =?us-ascii?Q?2oam5SitOf+zxmLjng3cRf3CRUy61UmJuPSyONAsIsqW/19Eu203Jcu9YMts?=
 =?us-ascii?Q?+U1SPVcjLE9x14LlObu0PT9Ju0N3zBgygwuPFwq406nRzt4lQu5gP51fQsxw?=
 =?us-ascii?Q?wPhkmsC3F77n0T+BsHc687bEsEpk/VHhk44jhwFrDwM5IoZmsDUs1wSnUdrW?=
 =?us-ascii?Q?BnG7pXOVf1aBpNUw+Hyapv83wi0hAR+Q+9fq3fWoewvGu9I2pRcqDgkyNL/B?=
 =?us-ascii?Q?nhEwsTX+y/A/g0bw8hj18KPRYU6qXFhUP9jE1a3zv0OnJlbg/DHJAZ8HoOd3?=
 =?us-ascii?Q?S1HmXHIxe2x7e4M1kTN3q+Kd1y7NAF8HRf0MHlxeVYRBoVyXnciPDRw+m53g?=
 =?us-ascii?Q?LWzZeC1w2yTCG9c8/3jrvaP4zaRy2KHHyg2ZmatbxG+8CIgfqt39kdUOSN3s?=
 =?us-ascii?Q?QlEpZNNbFQM5SWsCMk+8AXX1icuGEBhpDIehbbwp770Qz0b616S7Oi6HXofA?=
 =?us-ascii?Q?R6loZknem8cKG0RGtjMq8lFC75t027GTY8CR4pXN7xN8ucdYjtpSTc2utn7P?=
 =?us-ascii?Q?RyMZYMcrWcDqRnPsn5s3qQDJv4aVkn1BOsCj802S5T5nFW9i98syaUO2hw5t?=
 =?us-ascii?Q?wwR1MzokTX/28fmIYatfPNwB59ieJeheiFMMULrKN1ZQJ206PITR00VyyUmT?=
 =?us-ascii?Q?CdUvBUdyn1w44BYBfO4usO6VgchlcB1tVNZwBeEXFf0+JaXBw2jDbNui8B97?=
 =?us-ascii?Q?5wYiO6KOrlrFydRHI8h+IhQEp+EHFR0LL1msuyPRxQ/LZnEyYx3x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc45745-29e6-47d0-9427-08df17fbf650
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:18:24.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3cjY90bK7S27IAhC1Vr1QcrB3jZnJC9IqSTi9XOyeSkisqaGEoofO5S/uJa8NGzn0PAAkbxt4A9/8UTU2huZX4jLy4JZcGxXn66fY6L1IuYdNk+XvhVShnZVgwsRspS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8647

On Mon, Sep 21, 2026 at 10:37:07AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Replace the open-coded pm_runtime_get_sync() + pm_runtime_put_noidle()
> error handling pattern with pm_runtime_resume_and_get(), which already
> does this internally.
>
> No functional change.
>
> Found by manual code inspection.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 479789009c7f..fe083b1e7251 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -99,9 +99,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	int ret;
>
>  	/* make sure bus domain is awake */
> -	ret = pm_runtime_get_sync(bc->bus_power_dev);
> +	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
>  	if (ret < 0) {
> -		pm_runtime_put_noidle(bc->bus_power_dev);
>  		dev_err(bc->dev, "failed to power up bus domain\n");
>  		return ret;
>  	}
> @@ -382,20 +381,16 @@ static int imx8m_blk_ctrl_suspend(struct device *dev)
>  	 * in the system suspend/resume paths due to the device parent/child
>  	 * hierarchy.
>  	 */
> -	ret = pm_runtime_get_sync(bc->bus_power_dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(bc->bus_power_dev);
> +	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>
>  	for (i = 0; i < bc->onecell_data.num_domains; i++) {
>  		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
>
> -		ret = pm_runtime_get_sync(domain->power_dev);
> -		if (ret < 0) {
> -			pm_runtime_put_noidle(domain->power_dev);
> +		ret = pm_runtime_resume_and_get(domain->power_dev);
> +		if (ret < 0)
>  			goto out_fail;
> -		}
>  	}
>
>  	return 0;
> --
> 2.43.0
>
>
