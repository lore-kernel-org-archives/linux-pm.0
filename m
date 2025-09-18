Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749623E35B;
	Thu, 18 Sep 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196867; cv=fail; b=JG+8JYEQgPQMLo5b3LpgO6hjutjexLJB/5kjuvAVxpwiGtJ7zoOAvH2FSlOuj8SOr+S5g6on9SL5J+9Y35ahP7+r8MsOcBQCqlMTnIllLktUl3ArP5LZgXf6Cmaka6844PimlXh3Bl+19NR4llc91HwEqHX2AM5/YnuqTLRiAJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196867; c=relaxed/simple;
	bh=oswKukBx0BgobaAk8Wdguzxmyq4D5gQHQudpnoGGUL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cz6XzXsYUmdRR+4XIoF4h86XnHrdO5jI1iG4hIFAWBvGAl70P+1TUglxebEgkBojvvcokZjC9h/EEnGWOvgdK7Irt7twqKY4lATJ3EevUpe8+g0YNvV73QYmyWq+YyayWieGANEvdZ2H9c/rQnjPQd5MbDZSTAAP56RtJn6pbRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HPfhK71/; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HPfhK71/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXBUKRsmTwKpLRHECdw0vBU+30Kyj9iS3oelz1o3z+8WNqwwajyMHz/+RoH3zsgl8dXFKfKTAOMxGFOFF9UlnokugpUBVKQJWj6wl74qffF07gOmau2P0bUrWNbG5DM+0HlYLUahx8XmbHVSqoK8MGwZOSjQbrTuOvLXX1yDvHwLP+rdtI/6kiLBEbh8ERbx1bivXQdTYMo9a14RViJ32zL6fflJWmx+K3zS/UBSMHz8iTdeEGmQl7916Gcd1tskaWm9xg4RUdj+M2JsLvKgzWc228b65beE3nLdwvvIUHlBWR+muAClWtXfU7yckWxXFBF12vYIJ3wt+LgmXVEAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac0mCFyKpV2RKj/8Dy7fTHR9vKc1uE3yNVUs0KADz9I=;
 b=W16cbXUaWMAgYvD2sp7PFFLLg7cDZuYEG1protum/EuNn237tsO/BcW8VBN/OzJdtZiFuWaaQhs/zNS9TyJJOzp2dAC8AhrB0CgQhD+O9SalXgLYoWFsyXnfd6tikMR1+/zKeUM8pttvdsdfwnbhNMXtqaB8wgAUl7nhPwR3+dfwMNKQXsy4WJNvxTR30H4ra2p4rVt/SrnNVy6WN/a5OLzR5sKhJklQzqFWwRbBq5LxktKuUlvY6StHthB7l/9E4C7dWecCDSMHYoncJsCuxZnA8GZSvCv4Nd2WKQbaFvvaQHlT3lkfkVsRhpkuqWzSdIIQEFj8M4SDSgH2Mu5fWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac0mCFyKpV2RKj/8Dy7fTHR9vKc1uE3yNVUs0KADz9I=;
 b=HPfhK71/i0qNAHE2z2tkezBJNBQ43pzP5xUxTxg7jcfmP2KSI2sBvUgPtzZ/fzRhaDATKTIaaJZBqNt7e2BP99ieQ9TLGKFKWPCXGNFNPCM46sL6XYCImqij/AeXwna2FwLmX66TYqpPHfQcgEuPl7wjr3SAIJIoi5AWzZk8JlTEiCvL1hpgULlTixiiUpjTBB1n4LIHGGAXq+vkp1XUQtHNDAvAZiL6yieJZgxfoKdbsnqAwV+WzBLmB+Di70adTGdFKc7EdMt3TjsTPynNTZKgCLKmubsiec8S2oj5kZc78vjHBh/c/9lCnanptzfalWHDyrXO/+ZD/F0NLSQhPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:00:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:00:57 +0000
Date: Thu, 18 Sep 2025 21:12:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <20250918131230.GD9196@nxa18884-linux.ap.freescale.net>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
 <20250918095950.h7wmz2qj5e6khtwr@lcpd911>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918095950.h7wmz2qj5e6khtwr@lcpd911>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MAXPR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 766b5fe5-475e-4fa8-3772-08ddf6ab0713
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2Uz2+0ozq9GE4b/crDhY/KVG/4B0JHNjiJdHmWTfom2Wp1cpj5kJjal81nI?=
 =?us-ascii?Q?2deEddtAD5WR3RYe9/MasYHtvVbA7+4aP0tKT0mUFZZ+zlhV4AiFjiJdnyGx?=
 =?us-ascii?Q?uvmN60c0z7/BQ3OUYaq4UD7EO9lfzPmYx7F1IrWQH73Vv1wr+VSaLviUhRC/?=
 =?us-ascii?Q?zagZysS8CxgF8jzrvCIml7+DAhh+6eo+N1mY+uxgsc6k56TQp2zuG6MPw4Lo?=
 =?us-ascii?Q?SjWAowE8vpg7RKr71s7/xQnkBhLTceG1bAqZ7UTPMFamLLSduux3ySscpIt0?=
 =?us-ascii?Q?a+Tyf+Gqeh6CtKi88VHOs0oLWLTc9g1HH5kTueD05iuvxpceCZEhEZzwt5s7?=
 =?us-ascii?Q?Iy/0gx9zSP6u0FCgYcSgaw41zjTwwYRxQ3oisRSrXFG3ykXU2hMNZF2V+hNd?=
 =?us-ascii?Q?Jh2fPXRH26rFfGcVuT2k67p+KiERGHXgC7iOGtNQo2yuRNAFwp8i9U4fECeQ?=
 =?us-ascii?Q?dP8JsSEtSa9Olba2QDhQ6HTbA9PQozsd/TYFSeeu/GpprNn6+SPEUXwsbPrZ?=
 =?us-ascii?Q?LHabJtU6FqDNQEAmjwCSeasfg4PJg5o7iJWzqsmpiR/0ADFx6kcIV3yteBEf?=
 =?us-ascii?Q?dPugjgbGWzNrCpvcpcIw24A4mb9r9FRzgcRmt/5oXnGqWNbAg3S4KZ/NsEOI?=
 =?us-ascii?Q?jqK4NXa6T/+8wMgi5VXTVfhsIsEIrEdz3GR9DCDzHBsynJu9w2Nh2aUBZUrU?=
 =?us-ascii?Q?gF3WcbbR8sl5V29uEzud/NMImtsW6xaE97JFqLF9B69WdTKQ8Ecta+qxxtMA?=
 =?us-ascii?Q?0IbMMZUztibaEsuNKPWkCl0xZ/rfEVC+fm40Goei+jpHIyhva1gQF0V8GuTV?=
 =?us-ascii?Q?u/v/V0oonxqqmpWPOvRnpqexD3cY9N6CQssLdGlxb6hsO3SO/CRE1zUuuvXK?=
 =?us-ascii?Q?ektkRfDHycAJKGluKRry0bbVaHw89GuR5LAAHzI61LQndmyG8KI4XV9VVHQM?=
 =?us-ascii?Q?9Pwi5qVqWVnoApZvezgrq7ars/PdDDddI6aM3fOyLzgK7BvyqksGcsCaRvXZ?=
 =?us-ascii?Q?kS7xMyUD9jrxcbr+DJyjDFES1ojB+h5UTG72b9ACJF7TywXmv8hH70DisKeC?=
 =?us-ascii?Q?ggr8aBJ1Gm09c++0FiCwo4pWuWDcdqjQxSMg1zFf4/D9jwrFJjWILD6BLpla?=
 =?us-ascii?Q?KteaS506TpnVbybUREJSGlkcJZjgDPlkKC9dNEjY6e+ImknlQW15fCI3tVGg?=
 =?us-ascii?Q?euxTxze8PGAu34DdbjWiNAXZt2/OdAjAaMr9e0/9xPrB9RgkHX1PJtyYgb7q?=
 =?us-ascii?Q?q5c2jNfjpv2zPmWVWV6sxSCeJ16I9f3zCwVK/BBoTOp6RdcZaYGbE90b7Ur5?=
 =?us-ascii?Q?a/8m6fHIf9Qr21uGAqMsj/Fxkif0+wy1FcKa1Zjb5f8u555dMRmDuPR/nfCn?=
 =?us-ascii?Q?nuHY96kH0pjkkRw/oTnpW4HwKa5+hkKDYSZQIvz8w+QBh+p5ZCny7Iildccn?=
 =?us-ascii?Q?PwAfVr+9gPoZwbbZ8pCKjl4QeQ4BOznT86SHJL+XmT7NngtHfl3uZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXxodyMRB85gHcvSijv3hROz0udSMto+Ncmk/L8bjU8Ri5Jq6RSyMkP4aPQ3?=
 =?us-ascii?Q?HD39KTBoJQZlvIKm95oFueyDvLAxYxjPVGFZSDnioZsgg5BMdJj/AmGEM3zP?=
 =?us-ascii?Q?BZJqhwyuDvIZxDF9pi24imaAf8heDnx4Ru+el5m/7DJWnaeMrDPyOtWESVcV?=
 =?us-ascii?Q?fn+IaGUZ6ls7UCWsPYWAxTWOGKg1VIp6lr2Rvwgq368Kwc8uooDJGe6cogZH?=
 =?us-ascii?Q?p6IurQyvOgxiuwRYJKws2EACehLvr8PozNQkDSDx+1QXWs11xsgNKfti68Yo?=
 =?us-ascii?Q?fV2WscmXsR0yzfnDvMH1ZZH2yGpDLvXxW6vvmbeGWp0M2tA5mbzpaxisDjlp?=
 =?us-ascii?Q?zD+4EnhEykr9b4OnV+zaeNSw5EIyy+xwttNubapNQQMuhgnjZowa5tdJv1aw?=
 =?us-ascii?Q?83tinIP5KgVLnf5EhgLz3opVw0gLug6eqwmjO4g5ksnPSITFa2gOKAaY/Fjx?=
 =?us-ascii?Q?QdAEesfo6LDAbt/mXcArniO3kWDgl49333L9bK/VjfoU0nrDrHcgtttHddFi?=
 =?us-ascii?Q?a/iZno0Qw9JdKLmWYWBBW6/s1nqtKqHI6+SDmhfii8vUO3WK7rIUopBR7Txi?=
 =?us-ascii?Q?r1VGTh7zqykpwXyPVi71JDph0SJE/g9VYWo9tyJhTwuJ4KIK6XaOk09lDmLi?=
 =?us-ascii?Q?whw5IigDQ/XNGG2lrhwJ909X7kgfoTICFiUxbC4cOEicLJfOBhRctRQ6mscp?=
 =?us-ascii?Q?IZ5aqzXvzLe4yOPwijPc7XXT7aVhakwXsjB316UCCTlk900wYE/vwCoFMp/g?=
 =?us-ascii?Q?e2H8CLrZ3QsLLVFsNWrI73UujM2ckQew9lDJ/Xu7+sozH3JWTjp1G2CDVN/V?=
 =?us-ascii?Q?ZbPyoS1P0xEGFbPZXagLcBDvvzZcN0dSTuzZQjk1WAteho9iVyiP9jjGecSb?=
 =?us-ascii?Q?jYBERrCw9KEaKKdr/QxmGCck8t3EQBSgCzrhxdrZyUagfdyeJNg/jEj81dxv?=
 =?us-ascii?Q?I/YdLx3sKcTJ30lX4MGSxuHIFeytnPitZv07/a5u5e5EI+yZbprtBVFcr9hG?=
 =?us-ascii?Q?StwiQiN+bFTwPAmn7bFtFBLhLjyLrJEXC7Bitj1ynGH4HKi62eKddnu59PfA?=
 =?us-ascii?Q?cPt6+xsipQUWgVFKsRhiP1C3v/GfRT2/t7q5HwflpKOnWQhCgjfmok3OxmZ6?=
 =?us-ascii?Q?jCxTZhPpwmIIGxYykZpcumZoTn4ShNlyTp/FjIT0NhwU5q4gYwfCLqWJtKoX?=
 =?us-ascii?Q?83hMsmxJ9tDx9vOcVFVXZZ64wjvbuP4+vyNOnIx9r7/n8njpyez0+J14+mkc?=
 =?us-ascii?Q?FWVxI5Uq2pFAz78P4EnnU8hEMOBCIKCwOB+G8vga/YUy8MPc5WBurGOC2Hbx?=
 =?us-ascii?Q?zawrXfg15vN+wlAnjohFtQ8wDsMl5OWYr45KLRatgDsm/gOX8j8agbho/6x0?=
 =?us-ascii?Q?8Ade8Oi0JnSFVir5iNMhWkfs/6gFDUVb9Ikua7eypSE2Gf2lX7EGQhM25eDR?=
 =?us-ascii?Q?IrocDe4dWHi6WEmLUe51mwojg4FwshJDJyHysMGq9wkUd4aVPkZyQQVjhGZV?=
 =?us-ascii?Q?dCN55mGLBCHpOViQ52jfPguBRHsy0lJKZlArYW06h/qD/DSzLwLjyqd7US9x?=
 =?us-ascii?Q?OcbuyttdWbAK0bHy0qm7ZSIHP4Kx1Oz4Bxg7Iui0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766b5fe5-475e-4fa8-3772-08ddf6ab0713
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:00:57.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQKU4wmAH6OCVb27WsjlUPF+y15bakFr0FbMQLlX9y5A4mac+ZlLQvNExpNGaUtkGPFPdwK+TrBi6DFaK4YUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028

Hi Dhruva,

On Thu, Sep 18, 2025 at 03:29:50PM +0530, Dhruva Gole wrote:
>On Sep 02, 2025 at 11:33:00 +0800, Peng Fan wrote:
>> For some cases, a device could still wakeup the system even if its power
>> domain is in off state, because the device's wakeup hardware logic is
>> in an always-on domain.
>> 
>> To support this case, introduce device_set/get_out_band_wakeup() to
>> allow device drivers to control the behaviour in genpd for a device
>> that is attached to it.
>> 
>
>Thinking more into it, to me it seems like if the intent here is to only
>allow the device drivers to figure out whether they should be or not be
>executing the suspend/resume_noirqs then that can still be checked by
>wisely using the device set_wakeup APIs in the driver itself.
>
>Not sure why this patch should be necessary for a
>driver to execute the suspend_noirq or not. That decision can very well
>be taken inside the driver's suspend resume_noirq hooks based on wakeup
>capability and wake_enabled statuses.

I should join today's SCMI meeting, but something else caught me (:

Thanks for looking into this. 

In genpd_suspend_finish, genpd_sync_power_off will be called if
"(device_awake_path(dev) && genpd_is_active_wakeup(genpd))" is false.
So if the device is enabled wakeup, the genpd will not be turned off because
the check return true.

But to i.MX, if the device is configured as wakeup source, we still need to
power off the power domain, because the device has out-of-band wakeup logic.

This patch is to make sure the power domain could be powered off in
suspend flow and powered up in resume flow.

Thanks,
Peng

>
>Just a pseudo code:
>```
>driver_suspend_noirq () {
>	if (device_may_wakeup()) {
>		// do the sequence where the power domain might get turned off
>		// but like you say device can do some out band wakeup
>		return XXX;
>	}
>	// regular suspend sequence here... maybe inband wakeup config / clk
>	// disable etc...
>}
> ```
>
>And something similar in resume_noirq?
>
>Just need to make sure that the probe func does the
>device_set_wakeup_enable or capable stuff correctly as per your H/w and
>wakeup requirements...
>
>
>-- 
>Best regards,
>Dhruva Gole
>Texas Instruments Incorporated
