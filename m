Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260492;
	b=jIigbZm185MnIvQb47J+Qj1G9aR57FRGtUPB6P+/RXNkuP6bSWcDxlO15H0qfeCDW9hP
	 KxFvbTrtMKBW2vx2KuEyiBMsknfCv/hr+HHI8wxt/+7qSRzaoTIRU6mCWCf8qFT1z80dE
	 8LSAZR7F/IgVhFU92sIi4O3oHJAzUHG9TENcdzDjEtjATQuqJu1POMW90GwMJa9tUpamj
	 YYfYkM95b1BVE/54ogNWG1ql3vq7qlKiJmKELgu4i/wSZSiykM43MNssK+IKFAmn+IIjf
	 NkEBmOgl7qAezC8/0gCvf1Q60VEX5HlpjF+/02QZBGTi01t1XEHGrYOUEJOXQTKcanw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260492;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=edA9r5GtZc1qRrZdiEsmsjx/nFvHA9eHOxb9J8WzxgM=;
	b=rH3sVGG7y1lxdoN0M4Hzw1Hfs8Kz6sCZhcfj1GdbNHtZsBnXM9Yxkc7duTHmkBwgLbVS
	 IuY3RHqphGBR61WAr9MBtG6EwZHbyWSSR4fQyrGw1yizAYASPK+IqyXoyG/8wmQQvMeS0
	 bMaxaCRSrhui9NtWBwoLWg2n6jKFBOv2VkNEO+fShusqdORFI2JR0Y61EStV/7ZHNhnMO
	 HtYS8HGRyLwsYFgoCio+74X70swF24Q1g05qBUa/0r4yz+ojeLx8XCuMT9VczDLIj2Z++
	 PSt2SoBOII/DxBUgshVLvOuXYqW2X7DoLNDVhjrfr3L+B2Oy0hvwbuBK6yoBJsw3NIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=nwUyxUU2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.68
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011068.outbound.protection.outlook.com [52.103.23.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6A606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 21:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=nwUyxUU2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgByJDc4+xmuAHUhaMxPV/gINqKleI79wSLKTGCAbkCEoxCAlOaUmoTAP3kzkQMiRtKsdzimJLAN6ysUlXmMNjWwDzs/AMzveB48YqUnWOhLdOFKwNGuQV+RJxGLfqFfUA5U53t1hXXx1sZJKjPxE23YD0e3hErFWLFcELiQlrgzwxTsjqWn1nIe0NbnB8SBgbe/GGunXFLcX1lr+BWlNpYyYE4fIfpNUVvSHKuAmAGEYxGcjRncHi+lkHsfbCAN4uj2b/oplKFDN6Fu+btpHYQcyR3I66qincqt+r9Rfh6amq6EXQPEoQiknc6JFpQpRruIf3BLbqNs2IoNLEzQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edA9r5GtZc1qRrZdiEsmsjx/nFvHA9eHOxb9J8WzxgM=;
 b=o4yNV03o4JiVntX43/mbTY9xFtCjPPSUABufddwNNPt4nZyxeMp6EHKJQFFOG9pI0X1e2ck4ilcwEW5s3IH8XXOM8TOIhdjaqXKZuewuKHW9CY7H+6J2I+T2UhVlBwXPn05og31k2MabpVNrfWDnSaLiQoOW49pPzlcHBkGaBtmmRll4o1DZf/i5NV1zg34mPjsMmTSv9hQ7SVIdLcpc3slqNuJox1Wi3g5exuOL/FVzVtdLZ6UCOkPUamwi/zP9b7Z5BvBFj0XhzPJIeddFqo5Pl9VJiQ1VLkInYi1eiAi0xYVHw/KUauOmic9+JaaQIZ37hDyzqoB2H08w0D54IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edA9r5GtZc1qRrZdiEsmsjx/nFvHA9eHOxb9J8WzxgM=;
 b=nwUyxUU2YXkC06+uY5XzEl2fRbJyeoLQcOVrf94ckjBG+Z6aYq3hiKXTFMN5z70mRuWjbK4dmX9nLhY68XkrK68Rz/1xpkVJHc0Sbx1YW+a+ObAo2yAzY/d0oYspycR4iVg7jXOajjZ8T/w0Cs/o3ztSp800s6SM1hyQGmmzCy/9A9Rfg3WylnFS1nb2yVcJNAUXlfsFAUPzNu1LbrDZyUR74Y4PNY+WxvM6ukCGv70/4qSt9ZXA1dnTdo95xSGT9daDBLllSOoO9zCuJyRBFmBrJnRzHFpi0mDZjDyODsS/u7coaqDqQUbQbxNEORrRPxUvhN8gPzlqQbYG4lB+5w==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by IA1PR19MB8867.namprd19.prod.outlook.com
 (2603:10b6:208:598::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Mon, 9 Nov 2026
 21:41:30 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 21:41:28 +0000
Date: Mon, 9 Nov 2026 15:41:24 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, mfd@lists.linux.dev,
	linux-pm@vger.kernel.org, maccraft123mc@gmail.com, heiko@sntech.de,
	lee@kernel.org, sre@kernel.org
Subject: Re: [PATCH V3 0/7] Fix Incorrect State of Charge for RK817
Message-ID:
 <PH0PR19MB9973381C1FDF341BA0DDB422E5A5732@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261109145833.1363319-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109145833.1363319-1-macroalpha82@gmail.com>
X-ClientProxiedBy: MN0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:208:52d::10) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <avI-BPUekgrVXFGV@wintermute.localhost.fail>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|IA1PR19MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d26885-be67-4343-836d-08df3eaa35d3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|16041099003|6090799003|37011999003|25010399006|15080799012|5072599009|23021999003|24021099003|25031999004|8060799015|4140399003|19110799012|10092599007|12121999013|55001999006|440099028|3412199025|53005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgJHW4P2tq2hcTswHlDDq96YH466oYZyfGnJ98UlBBhe1IFo7t51eSzz0NBX?=
 =?us-ascii?Q?aVJ8VfQJejS09TIPpoWKwslne33wkpRnXyeINduMPfUY0rUqLviEMx1+clYI?=
 =?us-ascii?Q?pzmTe0zmajYhxqF2qR9knt0i1YTyYjNbLqZdBrU+iB2l2OfxUhDf1FJ3Mrv7?=
 =?us-ascii?Q?HPxvKm2KJRLalNFAeZawf+xiXbZyiFj0UnY36s4fP+GRnGir8pW6ztFkvBV6?=
 =?us-ascii?Q?Z3FndCzmw4P0uj8XxGhhuIY32HcCqBBF0JICsSDRIlT81xAxI9JIwjzazEK9?=
 =?us-ascii?Q?c3NmCTdBtQ9vwS8v4ASZ/0dkY6Jpr1mZwAFknZq504QJuDsQ9/9oS2BtWtuT?=
 =?us-ascii?Q?r+do83Itg67nkkWnEiBbRGhjizSqN4yx1hxyu/IBr860YMtAcNuRRg/06GKU?=
 =?us-ascii?Q?wTvVHm03V9Rsx9n/lYhcusAkVVVaIgZy83wSd21WvaoRfZXRnm00Y7ZdGFs7?=
 =?us-ascii?Q?Ihg8mQ6Bco+yrbbbpd+2EifBMYpD/7YyCd5OdNMVS7FeC4o/MBXNjzGMFIRA?=
 =?us-ascii?Q?Vmc+KL8b08LxxRNkcPx0lW63tehHvj3XGD2g5d+u9GU9lR8/jmCCModNNTzy?=
 =?us-ascii?Q?bI9MkCG5LqfGZhIqQz7ojNc++KqP0BArzIyv9BPrTbM0TJz7+WUZVRDUOSf1?=
 =?us-ascii?Q?Z+cySVqUhmyNCe1jTHaqSpg3AEoSwMhK773GOTTE0bP3EXBnekw7iJNgVWqZ?=
 =?us-ascii?Q?mNyT+48eRGFBMSzaQXSbDqQlX5o/hH0gupQ1wJV+1FxKPMh7vn7G0l3SZAHj?=
 =?us-ascii?Q?pOwuKqPmtHzp9YO6nZ4FOfo5immCyQ1nOTZdbNUIuQ+/NRGrQhz3ZYNgB/gS?=
 =?us-ascii?Q?23O6rbWIL1Fq6kJXl5Hy1G/nOmUxk7RFJ143kOsy6RBnx9+tsSkZ2lT9bGPQ?=
 =?us-ascii?Q?wMDyg6hKGl2ZZFz2BiY7Z0xhq05+9K+tjO6uxYY45lCcHWuIRk+XdfefAcn6?=
 =?us-ascii?Q?4WXY7QQpzkXHXwB1pSAGboJJ1KtQkeobheMVrZj7sfHClnHM3pYE8rtK6Q48?=
 =?us-ascii?Q?EqqXuYJytM7e5eaAD7qwOv9Lu6KNwD1HYjE0sRHJ2nEo/yBEnANRPA9FO+Cj?=
 =?us-ascii?Q?Oc3TWx9EjYiPjVxOwsoK5Tkfl/2/rCe0pZ4HbIHLiRP2H+5f9jl+ADSMkBPO?=
 =?us-ascii?Q?o8D6h7VHTYwBUFt6ynYDsImegpeoDJy+kg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lPAjmxDTPiyFR0XLJvqxNETtNckOCjZlQ9dZq1vKWP0M4wPt2LL4AwSRxzbQ?=
 =?us-ascii?Q?MQ9XwtVyVyuAoA7zsjdmOskikXa1s9KF4NHfCYuCUCpI+nMz2FWXYclqsOCT?=
 =?us-ascii?Q?0z0F3DrCp8jdzrgsrqBiLPzgW3lE7Wryt8YJqenegDlGYWKdXEth8hUhmiQy?=
 =?us-ascii?Q?NpAe2yXKbcPWSp87wOMA3HmH1xTDOgp0RffJ1AOXF7/uLaSLipk8YC6wrqjb?=
 =?us-ascii?Q?bcv5XJFqe4cmY6btwiSQItD6YbYihTGuJoXOntsvLCH66QUg3dAzJGVezV7p?=
 =?us-ascii?Q?+HLvaoijzWoVMmTHLBv6XP6kzoWyfdY/ZkJ/+x5xfo2uYmh6mTjTZuSXHg7/?=
 =?us-ascii?Q?fDJ0w6taSFHcR5+U2vKtlM839oFWH1tludws8V/cPonRIZhkmmel6BKjP2re?=
 =?us-ascii?Q?NZoA5RPGwT0I1OS93aVQZvemypajKVbg0LoqKmXqIonfOBkehC8HvDzlo006?=
 =?us-ascii?Q?R+Kf5BZ1T0Q7bvFBMRV1SVgh3rta053WYH6N3JjtLwswfzKJ6YPS57IG1teB?=
 =?us-ascii?Q?u/Hi5OdgNYeT3m470/IRsO2UPnmQjuK6c/uIu52trdFLx3sCe41sdagG+tPR?=
 =?us-ascii?Q?vloEgyqHpNmGw1+L1jtfJVveX2gAbcC82XJkg+82eHjeHK5fHpxy/MTCvb0r?=
 =?us-ascii?Q?vw4+awrWDz1OIQlQIi2fRmjx5exjs4k3fbtKRsemOx8ZnjRYE7hZ0GUygww7?=
 =?us-ascii?Q?pP0Nvp3LW4yZlHtyovqL/uOUqf1YNtXY0fYbAIaWUp3cOikW/K8+On34yQIh?=
 =?us-ascii?Q?NtHGVfDlYXEijfHK6mNlLeA3u/GnWiuD953VEOUZVta8fE/DmmzE0L2NKo1C?=
 =?us-ascii?Q?S5gSe50nPnR00Emxg40hteApZXO3vVqsAo3RYk1r4j+ocYAPGFKM0aDoI2SM?=
 =?us-ascii?Q?jTxkDrSpJg6qWKT51EITdWIr4n7HTMM+xia3jzJBaIXnCFFUmhFZnCpRkgXY?=
 =?us-ascii?Q?dvcHO26cIqH2/a/iPE8j55kEXw5qnTe7sJ5hXSTt/XAmoaweeagPNUZBix8N?=
 =?us-ascii?Q?F+g5qvZCY5QrwUEn/r86RVjkjMUFsaf4L50RnhNcxIHrYsYPvTo/p7mYBPoK?=
 =?us-ascii?Q?B94dJhcXUfSzm0dCjeOmvNC1pYwh+zqJNMeXHJTaZdJ3CXmh9id7fiKzCD2z?=
 =?us-ascii?Q?Y3MRv9S1ChgSlMdcNTKVV3dmf4mU5tfNGkkPWs4WlvrKuym5/wlaHPfUCpVl?=
 =?us-ascii?Q?UaSUO4Aq+L9Bo5/vvXdJPQrdcnOlcKTVGbU+aEoLN4jE7YP6btrDRXHk08z6?=
 =?us-ascii?Q?dsoVblBthE+5DvY4jKcK3hnFOHeSCGtkYf/o/8sfA1TTXjfAJQ9XaMF2zsBL?=
 =?us-ascii?Q?JXfkS6f6makY8MdZ6/Dz8zWr1L4007Qhd8bJHlgOStMOhtgGgaF0ZhkqFxj/?=
 =?us-ascii?Q?bBhx/jMyL8GqzufaPPk9olZEqoDV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d26885-be67-4343-836d-08df3eaa35d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:41:28.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB8867

On Mon, Nov 09, 2026 at 08:58:26AM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Users of the popular firmware RockNIX had identified a few bugs with
> accurately displaying the correct state of charge for RK817 battery
> devices. With the help of one user analyzing the code with Claude
> they were able to identify a few potential bugs along with potential
> solutions which I was then able to verify. These bugs are as follows:
> 
> 1) Incorrectly clamping a value with a max of 10000 instead of 100000.
> This bug caused the state of charge to sometimes read as 10% instead
> of 100% as it should have.
> 
> 2) Using the boot_voltage value to calibrate the battery in scenarios
> where it could not be trusted. The boot_voltage register populates
> immediately at power-on, and the driver would check if this value
> was older than 30 minutes before using it. Unfortunately when combined
> with the default behavior of the bootloader to turn the device off
> when plugged in (requiring a user to explicitly power the device on)
> the boot_voltage and boot_timer values were wrong. The boot voltage
> would not account for any voltage added while the device was off,
> and the boot_counter that tracks the time the device was off would
> be reset. To fix this we changed the behavior to (outside of first-boot
> scenarios) use a value saved to NVRAM, the value from the coulomb
> counter directly, and an OCV lookup from the live battery voltage,
> and then using those values provide an initial "guess" of the state
> of charge and recalibrate with the OCV voltage once it is available.
> 
> Included in this series is another fix that would cause the battery
> to drain while the system was shut down. This patch replicates the
> Rockchip BSP driver to clear a shutdown register. Unlike the BSP there
> is no behavior to bypass this since no boards have yet been observed
> using the SYS_CAN_SD bypass on the BSP kernel.
> 
> Lastly, it has come to my attention that I misspelled "coulomb"
> throughout the driver, I have included a patch to fix that.
> 
> Changes Since V2:
>  - Added a patch to correct the spelling of "coulomb".
>  - Split off creating a new coulomb counter function into another
>    patch.
>  - Split off exposing the boot voltage and OCV values into another
>    patch.
>  - The code should be identical for series v3 as it was for series v2,
>    all that changed was the spelling of coulomb and splitting one patch
>    into 3. I'm keeping the ack from v2 since the code has not changed.
> 
> Changes Since V1:
>  - Dropped the sleep fixes, as I would like to test them a bit more
>    extensively first.
>  - Dropped the devicetree parameter, as since no boards have *yet*
>    needed to alter the default behavior there's no need for it.
>  - Changed the behavior of how we select the initial SOC and made
>    it its own function to ease in code readibility. This new method
>    was tested with various boot scenarios. The average error was less
>    than 5%, and in a worst case scenario where the device was
>    discharged to 0%, then left to charge at the bootloader the device
>    over-reported its state of charge by about 10%. When this occurred
>    the device reported its SOC as 100% but that it was charging, which
>    was corrected by the new OCV logic that kicked in once charging
>    completed.
>  - Scrapped the more complicated sleep fix in favor of simply telling
>    the battery to recalibrate at full after suspend, in case of a
>    counting anomaly.
> 
> Chris Morgan (7):
>   power: supply: rk817-charger: correct spelling of coulomb
>   power: supply: rk817-charger: Fix NVRAM SoC value
>   power: supply: rk817-charger: simplify re-initializing coulomb counter
>   power: supply: rk817-charger: Resolve boot state of charge from
>     coulomb counter
>   power: supply: rk817-charger: Expose boot voltage and OCV values
>   power: supply: rk817-charger: Clear SYS_CAN_SD reg by default
>   power: supply: rk817-charger: Clear full charge cal on resume
> 
>  drivers/power/supply/rk817_charger.c | 329 ++++++++++++++++++++-------
>  include/linux/mfd/rk808.h            |   3 +
>  2 files changed, 247 insertions(+), 85 deletions(-)
> 
> -- 
> 2.53.0
> 

Sashiko bot reports a few bugs that are worth fixing; I'll make the
changes and resubmit.

Thank you,
Chris
