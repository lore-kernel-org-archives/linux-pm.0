Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455794;
	b=A2/U/vL2smIGwI7sVR442IqIgoBamg+CkIdhPE7kdSyuAb9oCz8IWEPssso2IGpfybgx
	 FN/DkoySXhq/ss+gt2wAz8HgJl8gDZ6Sc0OaA3csBF3ykJFTSx4ECrlB9tU51zxulOroO
	 FL/+vFQdCoHvuCwF1wDv4MSiO2L4AFYIweX0hUcTdo79sUSgWetKPR0AWvchGsABNQsyY
	 OfLvRSgdlaVE9a8iSwhGwauknwYGUxPM+VAbtLlppFGddDSvNwFWziNo2ayyj9cbLgygF
	 c3aHhHibtjv90JN5YmdKEImLdW7rvVKYD8BSLPWpnMgYNi1IbVUy3Q23UMrUosCaAkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455794;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8ylAHpMtng2B8Uq7sToFe56ldOXngVck65MbAnIvk+g=;
	b=e2OOBM80LcQJE+sCoBqTmzsBAPpJPZyQp4pbjjOAqh+hY5K/q3BtviqE+Z1YOVHW8VLj
	 UHaUw/YGgG2wQ+mAe5qv0xGB+PO4ZjT81yZRTbE0JkHnS62d3OvKUx2JYlMdHoMg1p2Bb
	 xMwC0EdOI/CxQoFsD+Shibt4LfAhlrPMRB9fCeukhcOcRzSxHuemH9yuxFDwkNDIdz8mZ
	 IbfzqQTcKOqsHOJlJPM98iqMVtGQAbD/um0nQQVTWW6m014FRV1sajW7qjvXgR0riXCem
	 rxULJ4DTotJP/1WXaX5kJaRxFOtDOXFi+Hbh/KVsoxJhqSUtvgc+9nu7I8KDLgsTI+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t+ObTVki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.51
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBA606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EBA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t+ObTVki
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm9XwdhjHHddLxIQIuPvoSectrwQLj5D+CecoSqcMfchq4lAiuZCYCaM/occVRpwwUP2pYJQpGsLcgkuFRrWBouf+M9NfUHLVlL61mwiq8KIceaCYEk4HxNKpwFsf882OY858On9Jd+qvhFWi+06ozVdHTG4uBoZteXKxZWL+KPqx1Z8rMzJWYZXEzqUUbXk8hLIVffrITCByqIjhrwFmwfsUgrbnzjFE2EIWdk9lkYT+UQdA7TO3XHbFGzj93SmFXYe+5hVKWPlKL19Z8Qqbh4kduPNn0pQ+4kEYdqM5Iu0xJ72myJ69d41noe6Waz6VSPqOopN6ynE1C2Rr+5frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ylAHpMtng2B8Uq7sToFe56ldOXngVck65MbAnIvk+g=;
 b=k6/6jAi2Rd426YJkY0GoL6PGWU0wmQ6kp0EZmYqhlSp1UnTDFnBC1fpJ0/eomswCsXOz9zsDUWfXoeLVriXnXEHr8uFOkg9Tp1uZwG9UykjNRH5SXDKYdyYehtJ3UkjTgS66klfEJckTYpXTm1LB3xYY298RLCa8Qk/CIYOtquo2/Gt0DurIMroIzAoltmVMIEzlIztGvnmC1JLjNIuxRrnuyH+KVtJQy4PTJuNtGYjWXHzSdMAP6eFlQwZw+LRRlVvSYf/+Z5va80HAyr5BBgMkvj9OESk2BJzCVgh6VwiWnw+b62G2ZN98LfeGRB2HUOmCHWZbiDWVZEF+U23p4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ylAHpMtng2B8Uq7sToFe56ldOXngVck65MbAnIvk+g=;
 b=t+ObTVki7Zbhv+o3IlDz0gZcf2eQgMcH2PuEQ2PNiPRcgJRWaBSc0rQj5Zp96Im+4SMc3lu0+vHK1ErVZlOak161EyymIsjFDDPsQc76BN8yXyA5bYDoYmkizlTmmNDFDTmyWB8LhDAKRYGpmi7MhRyyczLBphUPrn8FKmM6G4yTIs4tBfEz6yUGW/yXB2q7v249easRE/LMksrGC/nYCxY4sqnio3tTuIvjGV91MhykyD2v6Ey92vSfTyuclgvcJ6rxRFF/HzXnJlVcWxRCRnUwtBIp5vDpsDzBFAhhesczEiIWuWeaQHGMzCgVDSbllN8PArHu8agxx9fkb5twzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS5PR04MB9893.eurprd04.prod.outlook.com (2603:10a6:20b:653::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 17:43:10 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:43:10 +0000
Date: Mon, 23 Nov 2026 11:42:59 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>, Sashiko <sashiko-bot@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>, Marek Vasut <marex@denx.de>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	bui duc phuc <phucduc.bui@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] pmdomain: imx8m-blk-ctrl: Remove the power
 notifier on probe failure
Message-ID: <awR7I-p0Ig-QpuP2@SMW015318>
References: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
 <20261122205136.138173-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122205136.138173-2-dario.binacchi@amarulasolutions.com>
X-ClientProxiedBy: PH7PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:510:325::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS5PR04MB9893:EE_
X-MS-Office365-Filtering-Correlation-Id: a7630e21-dd50-4445-c331-08df49893d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261009223027099003|4143699003|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uo0GSusw+J3ZYZrrUZVKF4GZzWNn0iMcOA3jYCOLpqTfkEa2h7zRYrTq4eCnXHRsEcCAJOpBfxXjl4p/Dw4NLfjwx6v5yuS4BiNfwE/8xhzhMUCa7maFi5cqPec90hU+/tFFdEX0fQveShArFX/nLnJOMwBdAvhU9VPHAfnUiMgEhkgHY73vAh26EnARdRWvywMlKLtzi7yRF1lSODsyA8DUSil+wYvjXm0J2N8WtN0qRNGFD4T1+5cvx9IDm/ODBLvCaEqOsiDSciFpiYabj4QJoiRcuoFlAbez1avw2BP2hTdYKo6QP2v3O5UqXwivFDWtwwlv+s/RfKS2BSVe024EfgkX/CjCPR4pQ0vN2PlzkreHhnc3XQurNLJC0avxlruwXjvDuSdbsVnBFz93N8iPDUlLbUFXwO2UR95xr6U+y2tOG3cWyW+ETa3I5RNgCG1m7nCeWuZ/64d2RWh2Up1uJWtVErajCqqFDTpP3DE+8MNsjoNC3Urm7oDs/2SmB4YOdyfIjahk8hbOjhA71vtNcbYRc2ySAnE2txMeIHpvz8OwXEQXEQJE3eDqjad5dvATaXnaH7hOhiPDvIMJJj2QU0HjcneaBJie+e4eUtp5J0WtC0bVJv8Y4nzkJ8Kh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KhYDX6+/Eva51ZjfF2jHJoxeoIxluK/yNJpm5h85lf5K5BWiMpLoQBEvLkA?=
 =?us-ascii?Q?RHw5u+lG0hixvoiyPvvXzwi2s3eNQLB0PXb3yh5ZqL+jlSwYshx3c6r+VMVg?=
 =?us-ascii?Q?1RZmuDvG1YpuFzFRXdaO9DiX4zGjcv0CqhKqbbZWlEa4UhgndbS2D1q0CKt7?=
 =?us-ascii?Q?S9UkAzXgDW2vyS/+40XGUOiX6UhD+t1cO8v7cF34jJJFa4vDb4I4PM3nyPEo?=
 =?us-ascii?Q?xaqDln4gRuH6y2iG27MbFvmaLO0OhYQeDb7U/a39DzLkWfZgt/W2UbZwL7JJ?=
 =?us-ascii?Q?Nco9Eif5JPYA0l7MgA5OrlythKwXkTPRuBZxTpZ4tY+wGvniYnVuFOf+Choq?=
 =?us-ascii?Q?mvh2N8ank2L7NoiSxLkpfbsZ0pUV4tqFXsHN0NAHXLFfDRdR47mwdOXO17GC?=
 =?us-ascii?Q?hM6q/zdpjjW9BcGi7W0D5J58ehMxqaCwX8c0e2rMgKoTRjQqTW6cc+7yEXR9?=
 =?us-ascii?Q?Xe5/AcEUhFysLh3iQa1cSpfRWoQPgWjVLrQv3u1aBXiCGn3pkCdPFWsxy393?=
 =?us-ascii?Q?WS4Zf79V8pcBAqRPfjElwkLX3GeMM5iBbuQyM7NWQon/hATOkXIkRqbyg4jz?=
 =?us-ascii?Q?SWiuRYvNGlePyaq7Ay1ozV3bMOA1nkR4rlp/wXrWGvnhK6gRDOshV//rHiDx?=
 =?us-ascii?Q?tzziBv9gHY3XuOaAeM6Q1sIsxmScis38ydoriL5EfDOMFlntnIocq1qGiYUX?=
 =?us-ascii?Q?RIvAfdBrAWD3Hdc30jBukBv4iWOQwmw0M0S2cyR6dafOU98/ydJMoI9lbaIs?=
 =?us-ascii?Q?VhTWndLsqbjW7C0QCNXYazz9qUhJwo/gHsVoGtfypeDvSaBrLquGThbLYQAn?=
 =?us-ascii?Q?NZWZgd3ebhBBgYirFm7gPzJ9yNcdg7Kh56Ocr7EdX8Abp2aK24c+Av14XA8o?=
 =?us-ascii?Q?e96Nfvh48me2YqBQkU7sgYliZCmPNv/XTNxMJXeCEVXwW9lAIAOjIexvwz4W?=
 =?us-ascii?Q?dPGFN2PwACaNk1/T6JxzqyzR/fwzV1IIe0MYxc/AotrfN7o22iSIs69yDCcw?=
 =?us-ascii?Q?TEhNr6FNbn/bEctg67Sl4OC+pMHHmRqQk6KNv4z6rNQrG5VKmrDhEGFhNjnI?=
 =?us-ascii?Q?H4oP6nUNFbT1F5t4ke7AAj/BAy0nEZbacxORlVDYiLLA1Obhx9BKXCXXA/6w?=
 =?us-ascii?Q?/ERb+/Y+xzPeEyRiEgGccfxxPmfF8Kwcd5wmDDo5ilVeK/6Ns2HVNxF9TIfP?=
 =?us-ascii?Q?hVXZudibzU9jVdMwyr5N6+DbAsiMei8pmJ3UdTFwyF4qOypLOCd4VZ0oyzlR?=
 =?us-ascii?Q?iSeQW2gLhPy4iDiRmM7HoeoqDvlWFYMywMXDNXlDniQfjuhhvl5j9Cr/jF92?=
 =?us-ascii?Q?7LHO7COiKTapTNHJZbRRrAy9Eb69qUnT2WGjAFkEQ4hCzPyMsjMZv07xyOAb?=
 =?us-ascii?Q?xJ4vEEQeca6mHTDtVTmrwiLrUhRUKJLiSqr7qmZzU7gAjY7x76SZXhKyPi/l?=
 =?us-ascii?Q?UGyd7uAWdsQX6qE+dR7BUY9XcYOrBbRAHdjjSUR54oMSfbngtzJeeOzx3R5+?=
 =?us-ascii?Q?brThTDS1NhvGxpYpnUXAz+BCyItvx0TZM0y/cHhB/u7cmnkMRw7ON9o9jKM/?=
 =?us-ascii?Q?wujXM0Nf7mUqYk/eDwh7AuGy/WBrQg62L8rDqc+iMzEG1GEL3clZPEkYuAL1?=
 =?us-ascii?Q?Qh7AO831O9TbF/LsY4ZWyS2Y4v9bLAs1iaVQF3MdXADbuzz1ABa8J2h/Dl2E?=
 =?us-ascii?Q?3RT3VZGnlJSOhjz8t6v7vAuGSsRRdFcVMhX37zcQuT1CCylnqNbaGpDfhSkH?=
 =?us-ascii?Q?dig6tIxYFzx5LEafrBJ6u+HRAIPeMiW+6Hi8fMtf2kK627jon+4Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7630e21-dd50-4445-c331-08df49893d74
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:43:10.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqK4tJN7E/Pijyd8b7vZ31LGTLckE71EIbEsMcau3T+Ujh+SPcniKXgImgvTpMqrSGyiZTsDSL0b8pQ3IsXAKO0GVdu9txe75Y6oPqvVcpAuCEPaJwJGTOJ3xLfXn2H4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9893

On Sun, Nov 22, 2026 at 09:51:10PM +0100, Dario Binacchi wrote:
> If devm_of_platform_populate() fails, the probe returns leaving the
> power notifier registered on the bus power domain, while the memory
> holding it is released. Remove it.
>
> Fixes: 9cb6d1b39a8f ("soc: imx: imx8m-blk-ctrl: Scan subnodes and bind drivers to them")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-227073@kernel.org
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> (no changes since v3)
>
> Changes in v3:
> - Add Reported-by and Closes tags
>
> Changes in v2:
> - New patch
>
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 9df933a7a238..7d6735728d8c 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -345,10 +345,12 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>
>  	ret = devm_of_platform_populate(dev);
>  	if (ret)
> -		goto cleanup_provider;
> +		goto cleanup_notifier;
>
>  	return 0;
>
> +cleanup_notifier:
> +	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
>  cleanup_provider:
>  	of_genpd_del_provider(dev->of_node);
>  cleanup_pds:
> --
> 2.43.0
>
>
