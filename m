Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230294B7A24;
	Mon, 21 Sep 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007429; cv=fail; b=N4/KfqxyvpdUkUY6bhYWbASq8nrkeDmfqNzZx2mZpPD15QOfQL+WW4pzR5TqBFWDnN1uaBSHEzh7UPgrqt+i7pPXt3xPO74nGulZEWNRaJ5ef8bQCha+hQhNJ+/RjRjeysI+bGUKAxEAp7gaxkzRFfyJ4vURBd01JDL9DtJN1cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007429; c=relaxed/simple;
	bh=t6JNfdo9fk0P6KSnhx6GtYo1bRyDW83qcu4fPo7WNLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZc40H+nfqIuZmQ+E5KkS4quh1BexErNbtNHfS+fyGAJKgEZ8m55vX/800GyrUw96O2bBS6DAVolEBUESSe0+v/swcUDs4WVKBw8TS29jHmoaNABhD2B1NrePcYnd5A/npLtwohuKbQboSyZSM+rlc0H9ZBAku6h2dqAaL/V0P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xMreZRPo; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xMreZRPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSA3nPtdcJ9a0z73+54J/d9R3xTe1y5rMxIEr01L8Odd7z5lFyl7LbdjUNIVqtDTYKzAovH9Jd8eAm9S2iN9GNkffQQBLGLfa2Kx9TY4zIA9Krp2+HKSVFWL+OISqPbGyrfYR7s9PgEjzt3+34nD6H1bgYGucoXz80coEiHDl6k36bfHXqDWV55XXP1WTxop6hMt3vWVGE2LaymDCtHjRHS7g6JtmmaAjwXGlWscQyAZLlEMGr9OKU4Y6OxhQMr1cRjkPgGMpOXzW/2ysIrbKSc8SgFerdZNnIAnKAI+bKQ9vYOQkkjUQhfriHFHLdorRbN2lqa8JfE3AfcMVN9NAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpdPH7D04A/0O1gXzg3GvS9iMAsAWzmQKwO12bgLfpo=;
 b=Ut76oLf9qGNLZ+XgxvlNgnwtaCuTUWyVcO3Jt3A3yJE3AQqMC0oniMd4TFlN0+6rtOEA0YHqRHupatVoQFcR8dsOmP5p+7bc9KIUBQKSRaMbIGN1vwsn8VfXLFW9uh5ewWIXeJXGLgAMAGPCaDNQ4iDT0vB2lmHyvKXNcNs0JRfqOFLvE7DiSA+ld57O6pPbp3zugBrUqUjVUyOXBgl5jphgUZfBZLRDCRSVo71VwE5nttS0DFUfpnOq3vrI/PpEH+yKnZc/mmDGlv+ErJzt7Iuumdla2FogOv0XQDM+YuKDD1M3+8rYI3dwYG0I8mhfo/FvEUPg27zZKcQOyTfa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpdPH7D04A/0O1gXzg3GvS9iMAsAWzmQKwO12bgLfpo=;
 b=xMreZRPoeRs3/Lcgg3sQN5WAEM9cdz85pEXMVwHIE+nl5IR1z9Za3HgTH5RRfqnqoe0cj6ylvTSY+dJEx1kOqap7ScwwSHDFTnZUOryQ4/4kUcklMPSeCjRcnDq+aTOQ4jUMGUZsX5YMmUqmOm4sQUchMIWW7aHvWtrnOSY8TFKTjIoVWoA5xO5fibhANL9tuhurolyilpgIbzTfaFP7EOju89jDPwXJXjHXJk/0igfdxgAO59GHBor8e7mbZNzkHkO+fHKJfrFvaYXFOqx1lebZjlMjYDI5XbdYcNG/uHtkRkSrpbFiEzdf2z12nCOIEffLZQmZEbCZ2WR1anstWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 16:17:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:17:03 +0000
Date: Mon, 21 Sep 2026 11:16:52 -0500
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
Subject: Re: [PATCH 1/3] pmdomain: imx: gpcv2: Use pm_runtime_resume_and_get()
Message-ID: <arFYdKNeD6c9v9yj@SMW015318>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
 <20260921033708.14433-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921033708.14433-2-phucduc.bui@gmail.com>
X-ClientProxiedBy: PH7P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 898c834c-495e-4b1a-f75e-08df17fbc55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|19092799006|366016|23010399003|11063799006|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DnBtURiBWOdSpG9rcc6fIXxExicMdm9lT9xEcU8xuOA/1fk5ssyZ+1pAWJQkIDNbDqRk9uhFU1chiKIYO826gYbKVVeLkK4RQiUr9Nk4AC5W6G/RV6FUgp4rrKoNvH1ui3rgA1ricZo0NMDb0nNzVUlH3UfpeIZ1PVfO+RoNg7655pP1l8GG/qS3Uc2nOCqhn5A9QNfhWq+l7lX7yL34FYjK8NtQ+QfYTPz7tjnOsvdcxnf/cnbmb+TcPAdu9s5XTH6J4a+fiyAY2+MwoguIGEbuWYLBCFfzr+EqaupuNy+iuBbdRnODmVLxf5JpsAc7+IqvlOyRTmnw0sL9JEGxcKr40D5JailoSr31p7HvoFA3BGRdIelrJG8k2ZKuR0TfsTppd7APpZGpcsiSZvBzERlf/8qkXkE1tsPIdSOkS7Jawdmdv1HxWwxJDiRFE40iu+y7xSEI0YrM+Dk2mosKXXa514RgFJF5DcQwMn9llWooMqqVsqipDKgDWyE0z9dRSSuPZqvtMyIUmbFAsZEKAw+f2uqEgRtk6hEHdY1O/TzlrI0L6nlEE338IbYIyq8fGdPVam+0Dj0rJC7Ri2zmJ9R/yR0lS8LMHanojCzJKR1PMMEhzfy5UdCciWXXFWRVBILxMjMa+FczHkOXolJ9/zXNl1Vp9DUSbElHdsI7Ns0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(19092799006)(366016)(23010399003)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjsblcYImN9Kt1RBoUEZoFfoACl77DhbaZfaYhpySn5IfQdilr4x/uA20V9T?=
 =?us-ascii?Q?4MsCkJ4k21hJThuxCXhW3/mbNJwOBGgCLTmC0iyUDECbwfa618TLx9jYCCo+?=
 =?us-ascii?Q?wiwBqLhlOC48wmbMiq7XLTWz7+18hf1HE/V6vNz7R++y0Punt9sIaICVRcor?=
 =?us-ascii?Q?9oncqkGEHoVp0HD3RRK4LFPBmuA6mJKksXDmahw7Z7FZTJKyLXnovyOsu1FD?=
 =?us-ascii?Q?5YZhxY5iqAcyNlTaPIfJjY+VG054wlElhkbfxmI94RtXs7ViIk3mcnHihK4G?=
 =?us-ascii?Q?CTYDwS3vW3HfJS+VQZdrfAIn+MaAPMTz79/vMpFUfdUEKxOp+JNkzPUl/ESf?=
 =?us-ascii?Q?e6TNB818QLN+GUzUQPyT8D9155Vq1m4MO0hMhxiRLrTmjld2BuvGu0Jq5HOK?=
 =?us-ascii?Q?TdNrn25dkQzJj2cVjZBEsUja+YmppZkqkndr2gG+Er2A3WLA8VJKOyJrr3gO?=
 =?us-ascii?Q?F7l54ymYMJt3zGffIiVGVbaNeNlwVw1OrBxdCOPR8J5ZaoIMy5RQeKRnrXuM?=
 =?us-ascii?Q?ffokwcfIlPBrDlX49UXe/VDXh9Lp9xGXCxM0K1q+FgKhkHzFNWeYlIiYJ0AC?=
 =?us-ascii?Q?BOXerC4/yFh2SMr/N7Lcw8ZAxYPXLQg9DbYFNhD8jykX771iZAGX/krkejpl?=
 =?us-ascii?Q?DGxdphVXxGiKgzO2hkNCHPkGQS+8rzSKbfPwf5tepBKPfxvPu3tIHbMu6mtD?=
 =?us-ascii?Q?AjuMhi0StgUpRtCtDQYb0QnchlBLFqZHWDjh/QdCdzyD+wB3PFWkfUVqfTbc?=
 =?us-ascii?Q?98ACyRrJ7tHkinwN6uwE4j83Pje5z8BVsU3O+2vQOiCOHutDyTdwQR8CQR4I?=
 =?us-ascii?Q?cvt+4rGsFGxxrzMw8gwV7e3UH7n0kI2pE9FQNeL9ruXl06UG6vI7/bt0B5qc?=
 =?us-ascii?Q?Pc6S3nrTE7zD9XtvE1xIS2eJ425La2gcDGAmsT0d05E5Zk7nUcKtn6aY0eLj?=
 =?us-ascii?Q?noh+Iw69Obx9FhPGJW0FdktaKjkxOB/29eVhdXWVYstRGQSpl5SHbijG/r1N?=
 =?us-ascii?Q?Qm4k11TYFX63tDxobVJmcZ9jJ/kPaU5XsO//k5yX8dLeN4XQaj4h9yEi9tPg?=
 =?us-ascii?Q?CvluB/KTJ/MUl9/3y+4bsYSWoylUy2KCqRjOquAf4cetdXMYzwILKTH/40u2?=
 =?us-ascii?Q?DaERHQxOCWsT09VPZiuiD/r2J4hxivunylA3yyKr4x51xOW8fu5cdiXLIP7Q?=
 =?us-ascii?Q?avX6ecIS+agxkwNZ5k35P0b3A5XYlh3rpusP2c2hRT2FkvcSr2L+kcftCXdJ?=
 =?us-ascii?Q?YLHRVecHaD6r9z5kyipueQ5HC+nXvlWFdB9UqItnKn28vthxn8kWzI95+ELy?=
 =?us-ascii?Q?lj1daJA88NRr7MglnGPEA32Zl8ExzEULZagJsnrpk3fRo+5kRReGFYNV/3gJ?=
 =?us-ascii?Q?X5rSEZyYZ6cv1yrxJtqKtj2yQmeI2VrtLtS8iNsZrf6PJ+yfJL6WGtompNZV?=
 =?us-ascii?Q?WQb4D2yQ/qhtWGZnYL+7EjW58DNd1XFbzeIPrvBMFxfzxVyOF98CmmYKfsFz?=
 =?us-ascii?Q?bqSUYLP3dQFBZ+JKP6tV6l9R8+zKDBr9QCsZNEPHbh13efF/lo1ZhoKWbJUY?=
 =?us-ascii?Q?njCOSTDam+FVDg3ca/prvAM8U409Ran3ojpQyzFke4zH5HAJZ2OHeBVCeSby?=
 =?us-ascii?Q?dd/eYrrJe6a+ZMIsJtDpthIR3qYEbF/3MxnV4SKqVOZJAGDI9lwmo1WoVtmQ?=
 =?us-ascii?Q?jD5VUtpLV6KK0HvvlZl1Vmz9P8Uw+FJFPT1Gfho6LLpHFklJp3vEVs335OlI?=
 =?us-ascii?Q?KyigZr361OH2wR8n5yzBoMNF0yU8gHOrMEuXlPdJG5rAA590om8Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898c834c-495e-4b1a-f75e-08df17fbc55e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:17:02.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2blgMI0NZvLT+LFR5MsEtQckO/jUh4/5BgFAycT4CtkxRPpCqERxregaHFtWlfpW7dF7p1g7bPCfz9N9SGO+keKpnXqUNBxi6ou8GKGAb4sDhTiHoKGdhyT5k5z7Rfom
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465

On Mon, Sep 21, 2026 at 10:37:06AM +0700, phucduc.bui@gmail.com wrote:
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

>  drivers/pmdomain/imx/gpcv2.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index a829f8da5be7..6a54ee734514 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -317,11 +317,9 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  	u32 reg_val, pgc;
>  	int ret;
>
> -	ret = pm_runtime_get_sync(domain->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(domain->dev);
> +	ret = pm_runtime_resume_and_get(domain->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>
>  	if (!IS_ERR(domain->regulator)) {
>  		ret = regulator_enable(domain->regulator);
> @@ -1397,21 +1395,13 @@ static void imx_pgc_domain_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int imx_pgc_domain_suspend(struct device *dev)
>  {
> -	int ret;
> -
>  	/*
>  	 * This may look strange, but is done so the generic PM_SLEEP code
>  	 * can power down our domain and more importantly power it up again
>  	 * after resume, without tripping over our usage of runtime PM to
>  	 * power up/down the nested domains.
>  	 */
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return pm_runtime_resume_and_get(dev);
>  }
>
>  static int imx_pgc_domain_resume(struct device *dev)
> --
> 2.43.0
>
>
