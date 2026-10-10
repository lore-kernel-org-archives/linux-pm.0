Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263F18C933;
	Sat, 10 Oct 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601758; cv=fail; b=G3tPgKxTvPrvwcgbrj6OJw3NTJXFR0nFBkd4Fcjr09lvc2wtAqIXgJfvSK6SXcZ4TPBtsEtXKCvaoSHjPdHBSR1nlUfitcgEVkF3KT7xnV5SG7/jQqLSKGehtYm1/jL51KEQfvtdfphA+O2oA6pB3RJk8hQOuwvNtTlZ/efNg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601758; c=relaxed/simple;
	bh=MwpkoXkbkEhRdn7W1SZSjSnCv7ZIvEcZiwugm0pZgFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPHpz0WJfWMM2zivEcZZbyTGoWg0qC+caZh6sJfQheiuijhAoQOSQTm8YByyrpvJUlOq/lwyeeH4WB6tf3rHeaMbgY6Y/ooHnhVo/CPSmRZ5WA4P7H/ctrk4sG7U0Qa3SPKlD6tdhMNxMMwGKtghSq4vtJu0p77ACzk80imBokI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w4RR1WQe; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w4RR1WQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4i8URGRb9AG4vcMj5DsjmXTCJuF0x9LWSF8YG2zY+p7f1Cg9fkqU8O5AXLegomVTmcDMhAruBB/atV5prRnRO9gp6CBNoxiXtEYm5UlvA1v6wr9R8rEjskIEwhIJ9cl7+18+Ae+wqrSK7pEKcJnXbufBxAXq+29zwT2Ug6UoWwdVi6Plt8lX0wIYJOzW1Vyv1STwT7KbqmuVY2cNMnD5RY3G4WJBpyTK+K0M8W9QA5vr7S1VIEBL8/pnlFVKl8lYlMwIhlPflKMarpbZAnguXASsQYSfsi0aC2c9o4JfGRsNfsRB2VjIyto8mJuSmUJWG8gCOpVsGOY0EauRQsPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qlyl+qy6Dg3JizeY+hP7zBqik5/fvfu1LhZVcG84GY=;
 b=uKFhdDEpDBeB8bkR2syX7VeQG+LKzQKkWmLuFQiXPqqdHYWBzHb965IfDkOfXbysurlmRrFvn5zObl6xLmJ2jaqyZqLGw0roFLZW6KYvnucV6zk0Q+M7v2XlhrN7ilueZMJ+15P6rVInzmkCml9LesaLiYQkFRtgM8sYH2raJjplHmNdgvoscHifGARi1bwD29isaWizzrVLgGSwB3MdqqRS2Dljgz4rlWtqO9muPwcD26f+LHXkICMlWCDyIYa09KKDgxIi8EuQSyRD18AiBrXMZjftHmyUp9+9ZUz3ruun27Skd3OmqGGk9nRTty3WjHkHf1GmUxh6uLZnc6vd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qlyl+qy6Dg3JizeY+hP7zBqik5/fvfu1LhZVcG84GY=;
 b=w4RR1WQeBRz0QG7gcgkC0KZ5w8pohPmscyDsj7UnwubXFldZTv66dmATAIXiXdirMVyM/SiEJbZWg+XfjB0J/8DgH2R1+bOVWq0sU3uT06ovUswy7RB2w5TIOr7Z1GcAzPqz6qntsxIxZu9sjKRitnYFSyqkr2u+NjNg8HVZKW02Kj/OdKoP6IFJlG4OCjwtmM82GKUrAkQCew6iKmD0AMdLbg5i0EpgJZMXSVUWmnYAPPxvWQkk47BFDrwEszetN0rorFFMlnuou66WedXBVikGIbWKTBnGlsCvFzkiFkKwJo2hm/hynrwPbQXpQxTpdR6k0ADm6dWF0VYQzFg0gA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU7PR04MB11092.eurprd04.prod.outlook.com (2603:10a6:10:5b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 03:09:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 03:09:12 +0000
Date: Fri, 9 Oct 2026 22:09:08 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 1/6] dmaengine: zynqmp_dma: Use PM guard for
 probe-time runtime PM reference
Message-ID: <asmsVD1RP6FoMN9l@SMW015318>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU7PR04MB11092:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c59ee9-25c1-4827-aa55-08df267bdbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261009220027099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info:
	PZVjMPV4ZFhZEkKwhTPTM5oyA3u9zbju0As+5BhhX7RPsrBFvpllXm1Y+bCtTwwmvqmIWmRNNUURdVW4I+WZ7T/xHHalTKqW003pLBQAg/jmy/v3K+UcQtB6zrr6zRQ6zWQ5Xw9cB5GFOsZbdl3y8T/bAZQo8wURw3n+e0o5s6WqL7QscwxLfs8YWCgV+nUxIoqVBQ7K3VhzEkzhRnWHr6uUu4cHSf7K2MnJaaSVzp2KpFskTs0QrAlYwQyb2FbPw/0i4IenwV8hTOS+xN/iF9CiUONZyQ/mYPF4Pe7EMDvONWdtTI68vxx5JaaIg+qZZrzyLNPIx1mhOpc7q/OoVg6tdnV2DRlEPUyctvDJ6bADr67GTPyoi+bluopaOhmTAr+9bWOMYJtUCqHJKHS6kA1YQtYRFcAfbAzJhfgpw1YlXWRNLlFovHibEw3qw3/AuMLXwsDElQ8hmsrVPkKa5pndaTGnwujW+CtFpKYuQPed96q1iu61FLUDNohz5u3roL/vqPwrm/4peQxk6dKjXcdLLDiuVspfGy7oCiLA383FTSl5tHeFxUG/EgmFTtUR3eQEClFnwvd0EbPj/OvbJaeD80vo3cdh+MmagMvU2rvA8Diljr4Begw9Yp0iGDZPyOXF/bH+1zD3jTsVHuVtAgqQwoKKstvqMohTar0luAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261009220027099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVHmeRNzeq/Wkr0SnjUTkRCQxJM4kvoPZ8vpKQhEKugGB8OhqAtr2EXQCt9e?=
 =?us-ascii?Q?xM0f7cND2s0GaWOpeKnXNs56rYRC6nXuDAW6+hGwfEyn3kuz1n2cJ96hj1tE?=
 =?us-ascii?Q?83FcuSOau2T4NSv/9U7d6PgBD6Db9GbpYotBwway7Jnlq+W5FfXzAoQcR/Sp?=
 =?us-ascii?Q?KWTbJnbP2VfFmNtsgOYuP1swVN3GUtcJI7d/IVQIzyGawqBl+JrBoOCzoZyS?=
 =?us-ascii?Q?9/qx0iTDgPpxTfYxLaae40RofYzZNMZbXonPD2iD7Y47RGaFoBYg8b+H65vy?=
 =?us-ascii?Q?Yj/FLjybED8Qi3r7khgNGDNDCdl6s63IREToRTnn8Hne6Sn57ibpmVAPlddy?=
 =?us-ascii?Q?BsM8W+wrRF0SoeOL7jgFfOOhoGw5vgoAYCDOk1zU0tytbEP+EiCrDxVhcYDu?=
 =?us-ascii?Q?Zkc/UZuTsc1JHBjvZS9X5qjRx72WcYfmKxwsnetv9rc8KtAg+MUXRWxWF3BC?=
 =?us-ascii?Q?am9VhO8XlqOJX1pcyLBEN+3lYmhArawfkChHcgyqOGeEd7rAFPDw3n+LuAXs?=
 =?us-ascii?Q?U6mwl+2OFpZvjpFUfykGWy1aNSWE24OtdGUun4mC4mDVOqxxdDXZzA79GRNx?=
 =?us-ascii?Q?aTaoSZJuHXesrhNEqAWT6TM/nYb88VR3nB+YdyJXuhOCf0xC1Z3ENaDzwZ8p?=
 =?us-ascii?Q?nUKndXUBnLTLaCo6FavlDzRGbuiNFKYdFXlSSjOkNgvIIqkNjkT1/EzYQRBa?=
 =?us-ascii?Q?Jx/ZX4ECiWu98snHSRA7626rrI+j+Mo8FgGFnVDyNmiUK1xLLl9g53xWI4/H?=
 =?us-ascii?Q?9afxvigA+N9BjgbGNY7vLBkfJxN498vI/2EcOuYmzLOZqMELWQFTyRw/W3g1?=
 =?us-ascii?Q?0A3B29sCEV/tLxXASxUfUnZvSPmNMRY+ZcQioVn5sPcSgmrBdtb3y1wYYkdJ?=
 =?us-ascii?Q?kvGyBHyfG0rNK2dImxRa6MdPj/z2oUFyFRha0CD3CjvjXt+h+pyEod5FC6Lu?=
 =?us-ascii?Q?YpdxoSDtaVo3MzwzdbPHjhof1aITKXOd0s4/X+Fiem+TCiINSy0udIPg/Nu9?=
 =?us-ascii?Q?JjSH4pOs+CKDHeBiL1kDZa6QI/i4Ik1DPhVdcSPT1Pu6SSjGBC+EAo2QDRaS?=
 =?us-ascii?Q?ulm/tEZbhimdZHuDlsCapi+8wq+ui9sPTZdVEcup5Zj3Y166pYew/MvG/F2K?=
 =?us-ascii?Q?ZpH0ejNtBVnz31oivMr4LMptjbQG95/61PwTP6L+OT3H3gSM9U3g6QsdaSQZ?=
 =?us-ascii?Q?16YLbDJbGd0do3/RRBxTrd8VJ9QJjfuL+WmNZiCWzrQXKc0sF/00Wi7D1VxP?=
 =?us-ascii?Q?25VUC84HsiwALCwOt7i8S+DcvLKhPhtvcThRYQDyFyjKrRkQxLCIvwuVVKMD?=
 =?us-ascii?Q?5QpHHx92UmY4CUpK7QZPIq0M52hRpsKG03fHN2n6P5OIleyFOKNmMTQQhArE?=
 =?us-ascii?Q?8Z+rNNMn9WL67DKArcfbE75O++3PP5rWoxd0Tam/SGYa8X94JPg8LlansMNu?=
 =?us-ascii?Q?34tiPVXDwjV6pbBz9CI2h1OO6PzzJcJo3BnrpoVjNAzpJrNDB8FdQA2niwsV?=
 =?us-ascii?Q?ZMySJfRf8kOYcDwCXPfG1NOR1Vr/s+1oh9SRQLUKpEkEkaYi0w9QcrmNY0Mu?=
 =?us-ascii?Q?01wgd38IrJsmRQXiEqyQs+TiFaBj6nEYjltSBPb/z07sn0j3V9TX+XrtbsyN?=
 =?us-ascii?Q?MSG82oLgXzIA4Depux8QtbDIVOod0CHmkzYRHNf232lQaVqnlhbB4eklDxPb?=
 =?us-ascii?Q?6OFLNfZw7CE+6I2EBb02813jqs1Xe3Jt3PYN6IdX03Ggn2Sq1DIH6ZinVkNp?=
 =?us-ascii?Q?SBGH2CoEeVEY0ayoXeILTi0OMFgAWXghQyxtEq9zqlxfkKFWoZhh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c59ee9-25c1-4827-aa55-08df267bdbd0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 03:09:12.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCN1iBUQ0g0XGMMyYQDUpDGKK4N00hVoS/+z24/MFlsZP35DuLrF+qOSVBuWD/SiaDr0kJ0K9mehe0WAZNsBge8lwdxyCgVEmN+pcPxeaJHmtqxPbtK6ASrbf9UyiAdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11092

On Fri, Oct 09, 2026 at 09:30:10AM +0530, Golla Nagendra wrote:
> Replace pm_runtime_resume_and_get() with the PM_RUNTIME_ACQUIRE_AUTOSUSPEND
> guard to manage the probe-time runtime PM reference lifecycle. If the guard
> acquire fails, fail probe immediately so a broken device is never
> registered.
>
> When runtime PM is not enabled for the device, call
> zynqmp_dma_runtime_resume() directly after pm_runtime_enable() to bring the
> clocks up for probe.
>
> On probe failure after a successful guard acquire, drop the reference with
> zynqmp_dma_probe_pm_put(), inhibit the guard destructor with
> retain_and_null_ptr(), and gate the clocks through
> zynqmp_dma_probe_fail(). When runtime PM is enabled,
> zynqmp_dma_probe_pm_put() uses pm_runtime_put_sync_suspend(). When runtime
> PM is not enabled for the device, balance the guard usage counter with
> pm_runtime_put_noidle() and gate the clocks with
> zynqmp_dma_runtime_suspend(). Runtime PM does not suspend a device that
> is already disabled, so pair every direct zynqmp_dma_runtime_suspend()
> call with pm_runtime_set_suspended() to keep the runtime PM status in
> sync with the clocks.
>
> On probe success, release the probe-time reference with
> pm_runtime_put_sync_autosuspend() when runtime PM is enabled for the
> device. When runtime PM is not enabled for the device, balance the guard
> usage counter with pm_runtime_put_noidle() only and leave the clocks
> enabled so that later channel allocation can use the hardware. Inhibit the
> guard destructor with retain_and_null_ptr(pm).
>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 68 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 3b7dfa53f972..a48106e404e7 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/cleanup.h>
>  #include <linux/pm_runtime.h>
>
>  #include "../dmaengine.h"
> @@ -1077,6 +1078,29 @@ static const struct dev_pm_ops zynqmp_dma_dev_pm_ops = {
>  			   zynqmp_dma_runtime_resume, NULL)
>  };
>
> +static void zynqmp_dma_probe_pm_put(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		pm_runtime_put_sync_suspend(dev);
> +	else
> +		pm_runtime_put_noidle(dev);
> +}
> +
> +static int zynqmp_dma_probe_fail(struct zynqmp_dma_device *zdev, int ret)
> +{
> +	bool rpm_disabled = !pm_runtime_enabled(zdev->dev);
> +
> +	zynqmp_dma_chan_remove(zdev->chan);
> +	zynqmp_dma_probe_pm_put(zdev->dev);
> +	pm_runtime_disable(zdev->dev);
> +	if (rpm_disabled || !pm_runtime_status_suspended(zdev->dev)) {
> +		zynqmp_dma_runtime_suspend(zdev->dev);
> +		pm_runtime_set_suspended(zdev->dev);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * zynqmp_dma_probe - Driver probe function
>   * @pdev: Pointer to the platform_device structure
> @@ -1087,7 +1111,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  {
>  	struct zynqmp_dma_device *zdev;
>  	struct dma_device *p;
> -	int ret;
> +	int ret, pm_err;
>
>  	zdev = devm_kzalloc(&pdev->dev, sizeof(*zdev), GFP_KERNEL);
>  	if (!zdev)
> @@ -1128,21 +1152,30 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(zdev->dev);
>  	pm_runtime_enable(zdev->dev);
> -	ret = pm_runtime_resume_and_get(zdev->dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "device wakeup failed.\n");
> -		pm_runtime_disable(zdev->dev);
> -	}
>  	if (!pm_runtime_enabled(zdev->dev)) {
>  		ret = zynqmp_dma_runtime_resume(zdev->dev);
> -		if (ret)
> +		if (ret) {
> +			pm_runtime_disable(zdev->dev);
>  			return ret;
> +		}
> +	}
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(zdev->dev, pm);
> +	pm_err = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (pm_err) {
> +		retain_and_null_ptr(pm);

Not sure why need call retain_and_null_ptr() here, generally only need
call retain_and_null_ptr() at success pass if you use want to keep
runtime_pm active. at fail case, needn't do that.

> +		pm_runtime_disable(zdev->dev);

If use devm_pm_runtime_enable(), needn't this one.

> +		if (!pm_runtime_status_suspended(zdev->dev)) {
> +			zynqmp_dma_runtime_suspend(zdev->dev);
> +			pm_runtime_set_suspended(zdev->dev);
> +		}
> +		return dev_err_probe(&pdev->dev, pm_err, "device wakeup failed\n");
>  	}
>
>  	ret = zynqmp_dma_chan_probe(zdev, pdev);
>  	if (ret) {
>  		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
> -		goto free_chan_resources;
> +		retain_and_null_ptr(pm);
> +		return zynqmp_dma_probe_fail(zdev, ret);
>  	}
>
>  	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
> @@ -1151,7 +1184,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&zdev->common);
>  	if (ret) {
>  		dev_err(zdev->dev, "failed to register the dma device\n");
> -		goto free_chan_resources;
> +		retain_and_null_ptr(pm);
> +		return zynqmp_dma_probe_fail(zdev, ret);
>  	}
>
>  	ret = of_dma_controller_register(pdev->dev.of_node,
> @@ -1159,19 +1193,17 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
>  		dma_async_device_unregister(&zdev->common);
> -		goto free_chan_resources;
> +		retain_and_null_ptr(pm);
> +		return zynqmp_dma_probe_fail(zdev, ret);
>  	}
>
> -	pm_runtime_put_sync_autosuspend(zdev->dev);
> +	if (pm_runtime_enabled(zdev->dev))
> +		pm_runtime_put_sync_autosuspend(zdev->dev);
> +	else
> +		pm_runtime_put_noidle(zdev->dev);
> +	retain_and_null_ptr(pm);

You mix use auto cleanup and pm_runtime_put_sync_autosuspen() and
pm_runtime_put_noidle() to make code mess up.

Frank
>
>  	return 0;
> -
> -free_chan_resources:
> -	zynqmp_dma_chan_remove(zdev->chan);
> -	if (!pm_runtime_enabled(zdev->dev))
> -		zynqmp_dma_runtime_suspend(zdev->dev);
> -	pm_runtime_disable(zdev->dev);
> -	return ret;
>  }
>
>  /**
>
> --
> 2.43.7
>
