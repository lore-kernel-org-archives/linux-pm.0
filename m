Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7C39281D;
	Thu,  9 Jul 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568340; cv=fail; b=blyC1i8bzDydjGN+HXxANbhQftwfRjUfpax+i6uUOko7kfEBz8TkDVhKuaUnhFzFE28bqNMwIcIMq4yZQaZQALyAIg22eIAJgYir4k+71hsPgNlTTmzrxUs3J4i8uxyfWq7yeZQZH4P3jnk58qX42NL0WY8I4xRTuNBVgWTFtoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568340; c=relaxed/simple;
	bh=ENo9rGKuIQ+pMZlTsDYz26C+ASM8InjmDEZgZ1+k1EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i/94v2HtLpoU6Yi69j9KmwaVNb/kHUXLh7FBOaH/IWVtsgZoHLUKsdB8+j2ig+g1VseeDKhbLIttZIwsacuHw6oNXSww2lIwRIS9RsmXq3O7T3N/xgmUPQa6D3zsi494oxgSk9u6zqI9/soUSEFozLFcZ2gBQG3NwXAXp8UALy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CMTygxgs; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CMTygxgs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLqcV9Kq0rOUX2QidTROr7Qd0WvDpdreYNZxwBp6E3e9qbJrz8iWNDHld56c+LRc6i39jmr1qmnABTrimb9S3Lu80Jerp/G5cBIp0qwC+RfmDEstx5Aap68/gLNSC0YCzkW3NPWs13SWSmtDH1AOPQ3nbLTzXWQnoAAiCd1nMIOixR0uEUgiJqFwlqiOC0oPPOReAc94QYbLyAgw+jtUm+UQqdZn8AVn4qAdkqAR22rI4Tq1ldpzZNEZF2qoLfJxSHxanp9sRMs78/wxx3RU7WeIGCYVx7+9WEWESLIWZBfvCpv1ZehZb5jv6tObIF8jf+OQWDCoCdcZVDMnSHmU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1QctW4vTg/Fz2lQMwOn39LsDDOrTNEm/ZAPg8/P8N8=;
 b=lLB64aoGH1/gRk/Z1igz7h5wi7PcMb32DmiozfXMiVERnipyMZdFb66gnhfj/dGEh9dlVdwyE+vK8iDr95bdpNuKyq4j3ZmqQqSFoiJCR4rpM5yVGTQ8ze50PEov9+4RA6yp6TawCHlyYr+XfgFRcHl5QcUmrBf//rHc0ltIOragS5Gk4dEsxKF7z9YW/BY6SrMwGxm4GI9IJehu0w0QDZ/HQGLqeFWzoaX46qyab6Mj4RvrnONFStbrpnK5hkUqoZIZ3tt55xPqWg5rXfBUfT4eWTgH6c8Cd3G0ZHtiwYUJwhapLPvWI/rMKY+dMNUi40ApZffk3ntLddEjrCbDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1QctW4vTg/Fz2lQMwOn39LsDDOrTNEm/ZAPg8/P8N8=;
 b=CMTygxgstXs4TfRw3GiBQlbzPCaWANpEUoYbeoduQbWSFROiSNVmzNhCLAxUFRf9c3Amua+GAVhSsZ1yFhnxgiFvflyQdrmuOZRMEzpggnonVG+92QtRMJzSjefkuqg8lsAGKNLSa0qjLsbx9cv+cIoAt7Qq9fdq+S4nSK+0x+jx+vRib0NOV4fZCMjq8EyMKJjGTizk5PjH+LkBbv1aPFgoqcOoLqG+sFAIMZNyV8vqOL5j1dTSVRbC4wBjJjeRbskdzKQ+dQVc934ISbz/q8q627kGSfwjXFDjXVOEwTB6368RiYL3sHO5HUumR1sF9f94c6HnK71fB0TZxmorxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:38:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 03:38:56 +0000
Date: Wed, 8 Jul 2026 22:38:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/18] thermal/drivers/imx91: Remove redundant
 dev_err_probe()
Message-ID: <ak8Xxby0y6hFr1wq@SMW015318>
References: <20260709023048.599150-1-panchuang@vivo.com>
 <20260709023048.599150-19-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709023048.599150-19-panchuang@vivo.com>
X-ClientProxiedBy: SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ad6168-2dec-436f-d5fd-08dedd6b9b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PNIPzqZ0uYGwIXwzHy+OPj89NUAWYmSVKxaoUl49FJD/Fivyptr0qzpeGa+Wceu/GSMASrf3N4qpaQe2LAZbDw354eXmzK5DbgTipAhOlB5ufwupXz0WSy8TnNCcG85r3zH9LEELYPJsX1m0em/+hgqgsYqXH7XwJFq+HL1ECETuji/dADUXK2xnGWGUoAqw7Gy9s7IrMO6jFo5C7+w2RPjS4oqXUCrWa5OW4NaryYuGhzz2qfVYdzfyLoSB2VSK4mJ5JGbLDFcNz+mejrnHgFd7TDO7+bye8uq9NHiazgZpRrtZftRoFf55N2ziln41NjwS7k0g+CQ6W/QzYrcDJbkkVncBxglHtWwafu/0AezDIUJIXFbdA1rgr2TeGKuxOnnn1YVpFKwR8w0+ETsEmsONDkBOkF7FxUAjuKSVy95u5LpZZAYv9RuVh09i06SynfgYVo3vbZmfoYjmoFgbnwC+rV0kPVz4qkOqj7qWduyc4rTWqNm4oxCsvonlg1QfQttvXm9cTLV5g1ZePSI1MFTQpD2bcLj21iMBfNbtMyF9OpZPZ3/2m9IN7Vlf6X0r2Ptc1WEWlEkz58oZCQrmt37tVXddk3PQuIntkNHCyEWBfVW+To2wYeVO39CK8w0NWwM6t0/oyP7lHVtyLBiCBW5j7dYMmLr5hADaaH4IOIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/yspRKxaHTJTP3Jy/GY1IEAkdlhdB2/4xAXPsOxljkTJmffiMw5z4DYSHmY?=
 =?us-ascii?Q?+UMKyVtIplGj3zranyLCZ6Qnft1jCzsei5nNqHW3EmN/0o2P/0ARoAJiPx/Q?=
 =?us-ascii?Q?UT8p6nbfcy7UU2LkZkwmNKTaNI0Fk55KHZd74GJlH3UD9MxQyKqzKKmx5b1H?=
 =?us-ascii?Q?ypcyl1jKACUGcKAi0UR2OJeParGacdJ6IznXaRveAhalFTb0RzDPmCWoRmeb?=
 =?us-ascii?Q?O28xYIwO1olaSzS+GHEfH6teZgRQ3RNdf0LTaUGV83EpKmxiUakl8YGyv9WF?=
 =?us-ascii?Q?6pd7IjK+vFLAn4/cBFNua5iygPq/SG8bhiKhXZA3qkY5cu5sHb1usQPrAOQX?=
 =?us-ascii?Q?D4uE1uPgRmwljKZ12fhITw+aRWprh6i9V08t9Bcf2ynR2sE2ZW7hjxhzccj3?=
 =?us-ascii?Q?RPaghfTGdR/cpG2GVFcTaIsrdi1VZddi0muSncUxpfbxTfRHm8kAD4jmgh8b?=
 =?us-ascii?Q?YkI8oIG3K/So29FPdKBn0jaXYk072k1FUOGrK88KAe9K3vUbwxz0e4GLJBHS?=
 =?us-ascii?Q?y74OEBaCZMbRciZpYLK0t2SHrWmYpbAQyin9m9QyBUAmJlFT/OBPOFuaaOOj?=
 =?us-ascii?Q?mUJFs+NH2j/j1neTH7yCtFMOxKUOVND00ABWPbkoGVH3QMw6AjlzBs5ldu9A?=
 =?us-ascii?Q?QxoGmmresIwsNroF0UcHCvOEN55WG+2AWAgHfSXQZ/8iuuZwMyk32pIuBjSa?=
 =?us-ascii?Q?GullJKck0NR4BjdV1c3SqTwIG/9iet5E9d2xlhlBGfKIhdhsAa1SmFxNdDo2?=
 =?us-ascii?Q?8QWl19YLWkOYa12N2j1eC0RFhmRmlBxz3NbEYTBng99PkQw1QVR3Iwz0W3T5?=
 =?us-ascii?Q?C6pGOT9o01UhPImNNgvBm90AlF5uWYJ0r37lJuOKZ+Ncul8xsedJ4OiJGXJ8?=
 =?us-ascii?Q?thQ94RkAUj9879v2ZlIeSsgND6aMrkMAa86CltrjOMHKqVHor2N6Tndy2iVt?=
 =?us-ascii?Q?lQlInvlqiDvbY9M6b1GSym43XJhhadzL8tm3oEArWv1zTj4mirRKWs/pOXb8?=
 =?us-ascii?Q?yaFHvr/pzvT5LSilXhl0ReL6ZifkU/azY8Znix0zFQ03UsPOkDU6HDW1NyQG?=
 =?us-ascii?Q?Af0wTcD/lFErjrZhBlJHBJSQMbb83dv7RQPCqJd3XDumjGWMWJsFfOk8pW+7?=
 =?us-ascii?Q?4TzcVJR7JbvF2xunNzzH0iOiL3Eo77/Q4LVsCw6oSH9mtNTaFcQXPF35mp4A?=
 =?us-ascii?Q?gQS2HE4ot/rVhH//hQh97x3kR38+h9PKXvtID+TNe5IqoR9aHdcpoOXmq6IW?=
 =?us-ascii?Q?1HicbqqbyhKJT9OP6EpEmlnpVkeQKG3AG1X6YX8df9kenaBrKpKuygK8hkrf?=
 =?us-ascii?Q?AUuFPJno+Q4Wdj9xR+pJqEqHvHD9ijUcCSyux4LyXvoZMEHqIimlsaq6obMm?=
 =?us-ascii?Q?bNm4UxELNu/g3dQqLT3iHuX5vtMjG1cTo6013Mm89Iln7rdY/D8wvPerb/v3?=
 =?us-ascii?Q?RR9ob++AWhm2prpHVPzBCQQZ1hJZqQEmb5C+vOp94yfEQ3cOIUThmkBJeVu+?=
 =?us-ascii?Q?z+esdzDw5tYO2UEBuv/tofRO4E1fxAivpAB2kh02l1g75aCJBn9EwhRz3Zcg?=
 =?us-ascii?Q?yintyPn7KNr5+MtaJ8VCRlVULTFnQ2hcxoTl7yiuAFt7d1jWMfHXxxL0nZVs?=
 =?us-ascii?Q?NbS7vXmRxvMSfSooh6QMlxLq+2cDNkOHpIeSSUgoMXHN4PRrc91JxKYY+wQJ?=
 =?us-ascii?Q?hPgy2t/HpwiqM1fQESnmq2dIc7/Q6dj/hXj7cs+bkf2ieLhlfF/9VJd1pJ9b?=
 =?us-ascii?Q?eU1ncOBcRo/l6pQTQVPJqfca25HgWr3klnBG18kBwXrpJ3egYTvD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ad6168-2dec-436f-d5fd-08dedd6b9b22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:38:56.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98vMTVtXRtGOSFY6O4kOxE4lckjQsjo0pBtLzfrGSZogZfnlN7CWsxsMTQsQ66rslVurcgXC5jDopabJY95vzELMg09gGTvpfC37tLau02LmmQwV8mf1vQ+y2hfORnHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093

On Thu, Jul 09, 2026 at 10:30:21AM +0800, Pan Chuang wrote:
>
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err_probe() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/imx91_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> index 25915bb702be..274eee303142 100644
> --- a/drivers/thermal/imx91_thermal.c
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -331,7 +331,7 @@ static int imx91_tmu_probe(struct platform_device *pdev)
>                                         IRQF_ONESHOT, "imx91_thermal", tmu);
>
>         if (ret < 0)
> -               return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> +               return ret;
>
>         pm_runtime_put(dev);
>
> --
> 2.34.1
>
>
