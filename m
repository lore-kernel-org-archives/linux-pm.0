Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078D3C3448;
	Tue, 11 Aug 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464823; cv=fail; b=NRP95vFdMsyWePwIpmpSHjVBMvLPE+x4JgfBFC7uzhAmzI0XEFEcIkoR1t9qRH3SnKzGoSUxV3+BPFTq2R9LEKkayWdpURnMnVSvx0JhEJYdNNTmYeTYpBDG6PcfQQ4WDdg43QMxI3viedaKDpr5DhwbJtul4ORyUYFdjD9/QT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464823; c=relaxed/simple;
	bh=i0+nwoo/5ibVd7O/5HfRx7aIp2xZ+oTl1gGVwj0EWsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y83D252zJQ4xlrXcGTP6J96/fvwRa8sxcHZgOzk0GG0jNA+dFTI5PN0SamKrlEwtblx/X0hTGIIwEdnEpcERa8TJr3LQw3OspD44sUlrWkOjZ6Iq3ABHbahqxstaLlDTFTsSRsCP8vG2F0F5Q1MJl4vKChaBTZA5Jvh6IvQE/a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nIZ6TutZ; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nIZ6TutZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhEClEkF/pOmor4lSnEFCODyQRvI17ZwXr0Z/f4JkvjD6t4LUESOmsL4lfct23AlCV1fW/lKmPmznHSU6F0/9n0dZmNzHRrMAw7H0dWV+Txo8FGApvfUoMKCEdW51Cs/fO/+35A5b2r/+6xD2ruFm7YX/ePdkElJkTIhnBc2811qe9YIJcQvAxXRfCCh8k0DuTUqIJpdsDs8UfYYPKb3y412EPsEKZjQ+W5m9nzA+CnCN2m738mXrnTO/do0rX69kZrR1cpFnOGNMEw8BjHmT54rmUO0FczoCcffBHV2+f7FyBwIa4H8PF7+6i8anNzLkZF2m4KC0DfscgGZdbjZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZhjMkeDz7mOhuixgdwZd1hEcRbu9kb7PN7i+AiKq5Y=;
 b=mdcp9P5FDWQb15FtFSGGHOsQWFA64MMM238vt5Rjs+3hShHxoVsfnaXLM+My3TeYyA0LtSnzXDJGLj2Occ1v6iuzPhIU9WS8SgQDgbdzvPj/wG58GGIvWKYJGgDuDQ0vb42CWSBPrzcbRvg/FBGp5bue0ENJSFH5slN3OzcIYWbNQRHQoNVavd2SOKLw2891CJHyOw4qT2s04TixhnU9rWBOctpwbH2swq+WxkCq+eylb/6kECE3ra40y0Am6zEHxG1yGkMxpUfAn8NXzR7E7Wc2NJt1ht97jgI1KMQkExbJfNBzdy8ekPhsf1pu8ra3+xPHaWhrIVsLXv+K2ML8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZhjMkeDz7mOhuixgdwZd1hEcRbu9kb7PN7i+AiKq5Y=;
 b=nIZ6TutZ96bxqL3RhdE0NR226tc29Ks80Uyaq0hZqii8frCFYhP0jBEAo5qm0s+aDTWSsIGxNFHlHa119cUfO++F1b7VhAxxIftpCi44Rr7sBvi3lW5Rdi5Hz1s+ks1Tn4I4rQch30Qj7izIykJK6gkeecC5wVCwY983FN7Ma0l8XNKV0Tu9oXDW2HqvtWAKJXLj4uyGJ6ROYW0dGiAlNwmn999r3Qk0Ci/mnYpBdP7akvTVIiP8x1HLbRnwvvnvSRYw8u+CW9qJdvuGLr4Hn+OnRqD4QUcV2blK9InFpp8um7i2XiKy3MMWVAkl9dxp2UQ6qJ2ubtBUOe0kraVehA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:13:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 16:13:37 +0000
Date: Tue, 11 Aug 2026 11:13:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, git@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 1/6] dmaengine: zynqmp_dma: Fix PM usage count
 handling in probe error path
Message-ID: <antKJr1N3A111W_V@SMW015318>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-2-nagendra.golla@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810100452.426320-2-nagendra.golla@amd.com>
X-ClientProxiedBy: SN7P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 258068a6-1bff-4c01-feac-08def7c37fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Mxz/iU6k62nWW/wLM46f6y1QeicpqsfMBDOMH4YK4VMad9ZzEqcqyyuywXvOQBprLMec7jI00+HmSBEpIyG0f42o9eSnLBGQE1ji5MBQL65K7KO/qoBVC9fK+gPxEHYY+0ahluhI9Gyu9QCV+0PkQVmasy6g841pe7ZFgGK/dpfCDOFmZl2Os5jXfu4MvHlHT6dKFTU/t7aa9UL7m1cXstCZousWqCEG7955saKJZacmkl8aMP+p8CS3t8TsKOOy/Cz9meCdCsCYTwh/8xXvnVyvk8fy4U7aid1hG2k2KvAShoylfnWxBOmLRLxN6hIT+RXvNJUzy7TBv3agjZefMkL9HbO2KCOUWG1jPMw0PwjNyPW5UdqQRM95qwmBKvupsTx8dBaw/oS0iv3crW12j5Y27a/Nc0GRolU6HeCxgvDqPw0i63f3WSEBKHmGghO9wB4vTPMTav7+5fAa6akD/EAh74LFeznwZMJJbz8PsSAO+Ft4nqIzqy0lAVr2TKbeNmEnki4V+siZLpFsJWZ1p1C3cSOa5PaNI1+Rs9d06ZyEdZj+8FIUxWJx2GNf9Ken0Yh+sLssF4nM4Jt5h5abmQ1xnCATxQmuFB1ohXACsAQ9Bn3WTo+9IxZECl9AdbVpigFFa55svRph13JfpAOCfvgUh5jdi7DFRH+Pde9hRo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxGsrSGmYvBwdbhouH6G9x9PwF7QtaE8IjL9rYaTZsa6S0uK4IjmzXvFQ8gg?=
 =?us-ascii?Q?yMlP1t9KhbwapkpDKnFC9SJSCaHpjlC4s9pfmvG1YFz4C/1doWqMhOf6D3uy?=
 =?us-ascii?Q?COSq068KD4Dh4Ggryt92hheO1Af4ZD7eyAMu6hpgN53it6YD65JPAjIOkPkv?=
 =?us-ascii?Q?4qNnbHDGDG5K9CDv0aSPJYdvzSyQPKEFgFeC+zr2Bi0RHNg2eE+IrJV5bYPa?=
 =?us-ascii?Q?qZ7gH+xNpL707z9Dp3MikuXg3KRauvioSi1Qg3ZZNKOgfW9inIQS+1TE91Uz?=
 =?us-ascii?Q?KFrObPw86jkRGBTzn7vwz4qMUHHGpw7aMQCL7oHDvfROJYk0nWelIC/L8WRF?=
 =?us-ascii?Q?l8s7UJHdTPA3fr3qBrg642vyXbVxbOmLl4NNBoNQJI8glcuQWu3e4B6Oi0HR?=
 =?us-ascii?Q?RfTQcx+P8ESNNablXNvzqCLHO/j6vdDgECyMdlmyi5+QFirZz16Aaeab/b1o?=
 =?us-ascii?Q?yYRBkgbkGiZ7B+Ufqy0BRwqXWmLyf/lqrVLCGa+roADDqNB+tcOwDuTAMsJ6?=
 =?us-ascii?Q?H7i3zRogTe5XfXsWKYFmFe1VPWOf5t+Ehtj2WJqlROR485LLcgRktadFLLdE?=
 =?us-ascii?Q?U3QutoMmIbD9tj2ssEc3bc71JKfR1IO8aZqOYhQooqmGe9LeyNGiRDtroy/y?=
 =?us-ascii?Q?J/3+Fv9kL2L0eY1Yk8hWDcZbwkWUAZsp5Fto0EV8Ip4dmKPSwf475rfmW8os?=
 =?us-ascii?Q?lrhjxIPi1QIZdXgZ8oU+z0C+oKOmmB52YgrzB2w52TFtQ7mHklz8WfHroJ8h?=
 =?us-ascii?Q?DNyquQa1WQQiYy0AwCZSIrkAq07W+PkGh8bhBbibNwgrB92/HCQyw6UsoFa7?=
 =?us-ascii?Q?gq8zAUr14BI3M/buPzGtxS8IDUWt8jkDBUy2lkQoocsLJRh0EyvJQlCdXb4r?=
 =?us-ascii?Q?56G6Ih8xeNunqxbILcB4dzEV0kcmjAPP1+jwrX8SQBratcy+bAFkh+UVjFYE?=
 =?us-ascii?Q?Sj5OkVx9hRcSdu1WcSTxSFtezuKHLGSPTzMxUvHR8tZLHwhaGKF4XSEyqvi/?=
 =?us-ascii?Q?VaP/EKNbMcTo85Mu+vlKNiCqpXIM6vp7Vh3ERm5a4TvFZqH2kSU8ktMBRGpf?=
 =?us-ascii?Q?EMZF4Dzz3fDqNBVOYGLJ+Qj8J85CK+NXUTdkA4g1TwXLG/aquQ0agnfyL6ZT?=
 =?us-ascii?Q?r4BCMJbLCC6QOyplriOjt/daXZJB1zdKk2nBuYWu5e3IEQn3dZz3rpL3c6L2?=
 =?us-ascii?Q?e3r6lufe8YV3xbmnRtBcbSPrnLyYGJxZf69XMrHopluKl3tdTaTp+6S/MnP6?=
 =?us-ascii?Q?5JgRFvHgULYmsq3jrPRnDX3/OZxj+zIftrz0ZC1vM0L7d9BM9vKHqWUBVVG9?=
 =?us-ascii?Q?3vT8wOanBFUtXalmIop2P1MmjpOFL6FIdt6fqAINPZugwMVctRKjyY7cMjX5?=
 =?us-ascii?Q?v7BZnISjC7yyv0KMbIPSOEZsbiCMMVoawOE/kN90NGFPlMMU3gPJkjboTCr0?=
 =?us-ascii?Q?wHcDJdsI+JFUiJauq6w533KIngHdvLgR/NfOzBT6HeFQmfW0LXUqUtU1Y6Ao?=
 =?us-ascii?Q?ATfkTxeEzyllpAP3iikaUftuUnS7oHdC0uoVIyd4ygi/PTAljsOjUNIRcPM/?=
 =?us-ascii?Q?rtU1BQp+qUEtjt0rk8rtM9SMECWYVXlvKNbYt02wEhct/1y9YLr8lQ6WdHPa?=
 =?us-ascii?Q?DEDgq4RXUgl9XJPqZEWJtIDo1vvoHC/mv+NeS5B68pX269KXa3KspIiQwR2D?=
 =?us-ascii?Q?5+EMvAB4TXhtKIOk+FOFb7TM6VKCE0efCejH6Kf62Xxv8kQ06bC9cBqwx5Ch?=
 =?us-ascii?Q?BS3/n76viUwPc/xb74nJ7UC7NwsKkVktgXpENZ1NuIcbJbyM3HX7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258068a6-1bff-4c01-feac-08def7c37fc3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:13:37.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwhkaQtAJnc6vvuLNJGFkNIy+On61xpsZHBg4XjbfgWPxx2tmtZcFtpPQ8wzA/BzJaegNFclhHbQjNVfHTM1UmDQUUA2NgdI3TGcQT2+uH/REBvWNUqnMCDmuRpUxdXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

On Mon, Aug 10, 2026 at 03:34:47PM +0530, Golla Nagendra wrote:
> When pm_runtime_resume_and_get() succeeds during probe, it increments
> the usage count and enables clocks. If a later step (e.g., channel
> probe) fails, the error path only called pm_runtime_disable() without
> a matching pm_runtime_put_sync(), leaking the reference and the clock
> enable.
>
> Add an else branch to drop the usage count acquired by
> pm_runtime_resume_and_get() when runtime PM is still enabled, letting
> the PM core suspend/disable clocks on the success-then-later-failure
> path.
>
> Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
> Changes in V3:
> - New patch: split from V2 2/3 per Frank Li's review to keep the PM usage
>   count fix separate from the per-channel reset changes
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f6a812e49ddc..87986f65d24c 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1152,6 +1152,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  err_disable_pm:
>  	if (!pm_runtime_enabled(zdev->dev))

You just enable runtime pm above few lines.  Is it for CONFIG_PM?

You should check return value of pm_runtime_enable(), or change to use

devm_pm_runtime_enable().

if devm_runtime_enable() failure, you can direct return. Need check
pm_runtime_enabled() here again.

>  		zynqmp_dma_runtime_suspend(zdev->dev);
> +	else
> +		pm_runtime_put_sync(zdev->dev);

This one suggest use PM acquire to fix this.

Frank

>  	pm_runtime_disable(zdev->dev);
>  	return ret;
>  }
> --
> 2.43.7
>
