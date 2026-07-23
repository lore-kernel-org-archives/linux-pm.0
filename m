Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020132.outbound.protection.outlook.com [52.101.84.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF0265629;
	Thu, 23 Jul 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810988; cv=fail; b=G7CRw/WurdL+u5V1rlRx/3DK7pPowUEmk5P57LOnX60x3LdDOJpSP4hD1WUgaYTYwwAAvDgCVeqR8uATA+7OJvncIuVS3HckjRoSKQY/yOaUZ1yd/H7cBVTvqHfMUdqZGEnnVK53j+ovJyDqHdM9vQB1W7UdQ01rQtrLVzaFmrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810988; c=relaxed/simple;
	bh=078hhzZDbKLwjmDsNdM7uP0zPWVHA57eKQmk0SZKXJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnM2+ecYIWlNosbkgWzcX+Ky7IK8kF5eMmg6N8TQqgCB0ruWd1TObzPC/m5XwZxOHfZ6Eks7b7ivH3P0S8IuKdR0Px62itT2QUB4jghhUGEjsBIujtCnj4Dw8GMDLoueIq9pRne9kCQW6+AYilu24EzvWMzzI4ePLRlTBo/0lBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=PWnUO+KN; arc=fail smtp.client-ip=52.101.84.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="PWnUO+KN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQDx0K/W2UjM19cjBVJ625EpOM5SHAb0a1TNTWvaNwSaSR5656fVjvkcqif4ejobMVqFQEh+NcK9uQz81xK3ILKf7TO30GkMWvR2iQKPJPRiYeMMZNQp+lkWhrvBDUtLe8BWc0FnOO2gMApNsY77K4xtZHQ4EjiFQULNcs/XTW4i6QOWuTJ8AKoLc0EoeuCVu1c6n/SiAB1R9W0A1MbCxirdGmnOwnjKVSP7mwc3KBEYX+mSDFdPXQiuTHBFafM/kKC+kG+bgarxa/YIS+4hUB3sd6RMyi+wfp3pFsXJ+CF2wQld8j6fMpT7U1WSTSNB++nJq6em7qjwMC6k0JHLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6+vnyR5eXlKJkZ7Bh5V3t9UMJkUM5dQwItaDud5ea8=;
 b=fgpPJG+l75cxKHjFNQgqmjVznyYxTj1Pf7thEkkSlH7E6VpArd7QJZTIb1TvWU/sixvhc35V+CP03e90u0y/ti0wUGo0O50B6rxy431MxfZis/UzbLRPgV6LUIW/TLVvPNrStrHRUA2UoAWSMRiJqtw0/nSp+DgMJBTrf2puG3JGpWztIJOf9M/ZwqIHldzWeZRGBKsLST4K6VIe7NrjVkjhaBmE6baNz/Ee+VQ23F6S6oBY5Sr6nXQI7nlmlx+HstDb/0xWNyA5YwtXejQkZc5dgmVxu8PziynOm9VxwWRLEdWIbARrZ/ZdThSfmJtJjgJ8zqJlrQrStbjDnRF5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6+vnyR5eXlKJkZ7Bh5V3t9UMJkUM5dQwItaDud5ea8=;
 b=PWnUO+KNBfZMQSU8ZY783VCC9JVAMvhI+dT7/vx0xbo4PSwsDvNwlymu5oJ9Mttn4+FaHCcsm9XQd5n+PGOufYXJswqoOKizX5sa6JagBw+z4aG7XshdOe1Ssmcn8lDgr6w4VgEn4rIFdFKv0mBgnB6SelG3oy0KJpDbpef9S5IJtEfU12cemeoenc0Y3Juf0nmOeBRzoOAX8zuqSOvF8/6u6Nb5Ca5ObL0Tw/jkK9EZv9mV2BV7ZO+iAqI2eI+0xq8z88/xVoScKeKEXgYo4cDRBt/4z/jD4xvTcyOsVaERj0LaX+HFZLVTuYsBmDB28fXQA64VJP22swD2yTmopA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB8507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:49:38 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 12:49:37 +0000
Message-ID: <fd6268c7-18e2-40bf-9d78-5f3a45ba319d@kontron.de>
Date: Thu, 23 Jul 2026 14:49:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pmdomain: imx8mp-blk-ctrl: keep gpc power domain
 on if blk-ctrl pd is on during system pm
To: Xu Yang <xu.yang_2@nxp.com>, ulf.hansson@linaro.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 peng.fan@nxp.com, jun.li@nxp.com, rafael.j.wysocki@intel.com,
 a.fatoum@pengutronix.de, ping.bai@nxp.com, shawnguo@kernel.org,
 l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260204111142.2147646-1-xu.yang_2@nxp.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260204111142.2147646-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0884bedc-5863-4e86-4fb1-08dee8b8da67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w7Ciw1vzH4/Ftf5Z+70mPxg9HmuSfb1oxnssygcHE4xsu4UkmGvG7KIZ6H/RWaFlP5hXl9U64Cl1jPYB5VBdybSTeFufPRJ9BLVaFzgsLUBGvqI1ECEk68sX2CvzJlktaqeaqQudLlp1SuDgEuAnqbxmJfDeegj2oAF9MztSHDKmszx70JVRwCdlzpfFy7GrMf5GDXSINc700gbjOrpyIdFLoTCcMSXaaiFLHEF7Bv7feqTpFyMLgtepDj1KMgAvCnQSH5lzYHL/WaH2xDYUokWlkjaWYA+x+r3Yqhq7+yIr8aBqeVU/cB64Zz5K7bHvJWq4o7ImJDxx9Gv2UVxG+WDYHRhZOjyUVLTSuvAhz6XuI/nXV+UrC2kykvIYUv1FGSyobbSBQaL5I0R4u9T5WRC5LzHfluq/kBIwRZxdj1iaI+dhGYNEroJnIr9qve+PjpwvIrisEsr2ermhWFitYZcYxljvyoEqaqORx2mF644s7JH8gSm4omknlbRBxKI7gVvjN2YxqtQQvNkbiRMWVZeTcD+YYY4BNPkYItP4cbI0pWeYRBegGVkXfOHZGbUFE3EQTC0w6Luz1dlZpFnwoYBIR4kPj98fpFKKzjxpWprlucDS4boNAUkdQLTN0YjjW4SOaQx7fQFjBK4prKt/JNx96gIZysivNSM4mFFyKXtW97CZfWMoc+HIpLHnS85lLbcHtTkg5FnuZxtaCTn0HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBQd2M2cHQwWE1YRmNlMkZJdjg5eWZkcUJLTG4vK0RZS29tdmpya1Q3STZU?=
 =?utf-8?B?TXp6UUxrcWlkMmJLalZHWUVGUnh5R3B2WktRRFZOWWllUjV3aWVIaGIzcllC?=
 =?utf-8?B?Qm85ZGF5TGc0c1BnZHo1YTRxZzJ5NXlRa28xQTVZK2IwZzBVV2NlclRQTWRr?=
 =?utf-8?B?Rmo2NUI0MWNXdXoxWmppMkVZaDVtenFkeGxwMGpWN21oQ1hhOGcwdDNrMnE3?=
 =?utf-8?B?aXdIZGdqejlXVEVPa1psMFdVY2NMRkJKcXQxajNudnBHVmxoanhZZGw1RFo3?=
 =?utf-8?B?RFZaN0JONVhYTHlLUkJ1TlJIM3M5R0V6TzRnK251T1pBY3lYS1BVOFJBU3BL?=
 =?utf-8?B?elVvVDFPeTA1MXVpU2xYZVMyNjZubFIyNDY2N0Zoa1NMSDJNUTdwUlFQM3Bx?=
 =?utf-8?B?NVlkdWh3SWdPLzRSM3VtUEtKYUlXdmE2NUhmR01lT004Q0RKcXNjV2VKR1RC?=
 =?utf-8?B?WEhmeW1MVGpBRVRYZml1Ky9TL3hYWkw3REs1a21jRjdZMzd5TlVCRzdnWlZ5?=
 =?utf-8?B?Q2NvOHc2RXhtM0R2Kzk0eWxabmw4Z0RvT0J0KzFqT1ZzQ3A0dElrbm5NbmFY?=
 =?utf-8?B?ZTZwdTB0NzFhSy9nc3RNc2JZYWpJTzZDMnYyNkR1alZOcWZSdkl6N1hWNTdp?=
 =?utf-8?B?YWFZck1vVHpTMklzT2liTXJUbmx5cVNsZWVMZjdpcm4wbDBhbFJPSjRteTZU?=
 =?utf-8?B?R0tscVIrZzhVcUduV3h6Ym1oRGtDSU9rUkJHRUdzQU82VjVySnlHcHZMUkkv?=
 =?utf-8?B?Y2VHcUlxNmdwRlhSK1o2ZWJEUXNPYmFRY1FZZUFKUGZEUytJTHphWm44Tzcz?=
 =?utf-8?B?emtoMlVpc1NZVUtzUExqT3F3TVFZdjFjTGpsMkFpOFRrLytmNTJkdGVMZmFP?=
 =?utf-8?B?VjZBMTRzZkxJaWtyenB3bTkrM0lkdms4NitkamhEazdPeXdhM2NzK1AyRGl1?=
 =?utf-8?B?cEUrQ3lSbExpR2pSYVJ4aC9tUXpRY01uNjVTNG01TVRUdnFpR241ZzRRWHBt?=
 =?utf-8?B?RzBUbXN0eUdvSFlBcW12LzR3WVRwL0tGNDRJbm95VlNMSytBRUYwS1lWeFl4?=
 =?utf-8?B?TnRuci83N0pJMHNjanl2YUsxQlNCNXhEdytQcUhoSUNodVgwSUJVejZmVzRT?=
 =?utf-8?B?ZkZzVFp6eUUrV0h4dzRZQUxybThVdmVTZ1ZwdnBhL2NNSTFPdU1JOWhWN0du?=
 =?utf-8?B?cDlCVXNFbjhIQzRVUUNhbDJtNjFiL056eER1aGtGZVR2V2JyaDc4dWRGanFp?=
 =?utf-8?B?SjRGbnVmdzVrZTBHRkpmYng4OUtKdUtiUVJhbE5XY3ByRFQ2cjIxZXNEVlNS?=
 =?utf-8?B?UERLcWtmNEQvTVM1Q085blA0MlB2WFFjYmJHNWZGK0JNNzNFNnprRVowdHEv?=
 =?utf-8?B?UXlES2gxNUpMZHNzK3pVTlIxVXNCSzJLM1lSb2ltTjhvNTczRm1wbjZPSWVF?=
 =?utf-8?B?YklScWFlaDFKV1p5anMyQWFHVEcyWlAwNmpNRHI4QzdGRkVaVjl5NlRFbmJt?=
 =?utf-8?B?TFVSVXBIRWVJUkgrMFdVMkN6K3JpZmhQSlpwVmVPL1B0cCsvZEQrTkJsck54?=
 =?utf-8?B?N2FPTEQwS3k5YWZmOFoybkNNa2ZjMlAzK2R2aEVvMk9CTmNtVW53MWQ5K3ZT?=
 =?utf-8?B?c21KVGFwUEtJMDhyZjh3MlpHcWxtYWVmdjlXWU0xdlMxcXZZeGZXTHZsL1F1?=
 =?utf-8?B?SFpYdkNvOUZROHdkQVpEYnc4a2wwczdheTBydUVFbUVNdU1GK29NVFFTTzA3?=
 =?utf-8?B?c0U5RytDTkpGR291bjAyckpFRXhkVTRWRnduNXpPeHVvSzNiUU1mM1M1dzRx?=
 =?utf-8?B?V042TFNJSUNkWnBvOEF0amVSSXhUazIveEc4TXJTSGZXMEpmNHVRTHJMS1pu?=
 =?utf-8?B?NVNWcUYvSjhSU2U5MGxkSXg5V1ZMcDNWQkVNMG5GblFoYWduSFlRWmR6RzdK?=
 =?utf-8?B?L0NOLzhFZHJoWEZTdkRLMGZjNCtLeW9zT21OeThQRXgwNGphdkEwT2tIV2Q0?=
 =?utf-8?B?cmR4THJTK1g5dE9XRDdsM0RIS1B5aWhXN0d4M0lyRDU0RnlSeWFKQk9UVFhr?=
 =?utf-8?B?TVhJL2x3d0FyeTBwQ1ZJVXlUWm43TEp5ZG1TUlhXSHIzMjdTOHVsVFJQU3hX?=
 =?utf-8?B?ZFNmSGZGRGhYNXdiOUFuZGJtS1dKd2pPcWRFSnlOZkJ2N1ZEU2FwYWkzYTJq?=
 =?utf-8?B?TkRIaGY5a1k0SHVDV0FnU3h3ck1MQ3NYd0FJTm5Kamx4dnNYYjREVzcvTGJG?=
 =?utf-8?B?ekl2MkxRaFJzQzE5YTZDZnQ4alJ4OFczYmhjL3owazBqODR4RXZYcUxXVmhU?=
 =?utf-8?B?UDlWbmdtazJMZDlRbUFkNWlZUXRubnJjMEhUTGhEZnJ5NmN5M1RNbXRDc0lL?=
 =?utf-8?Q?/11isXLWPGybcoSI=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0884bedc-5863-4e86-4fb1-08dee8b8da67
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:49:37.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1MJsXmSrLDb7+phSNlgXtRIvS1f4Ut2HAdVuQpotNf2dsXhUsdLcJf3ihhK+SrS0CdnaARKKThKbpqZFx2a7tvdbvHDjxCYSNEFVOX1S3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8507

Hi,

On 04.02.26 12:11, Xu Yang wrote:
> Current design will power off all dependent GPC power domains in
> imx8mp_blk_ctrl_suspend(), even though the user device has enabled
> wakeup capability. The result is that wakeup function never works
> for such device.
> 
> An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
> is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
> block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
> is created to build connection with 'hsioblk-usb-phy2' and it depends on
> GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
> only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
> power domain 'usb-otg2' is off all the time. So the wakeup event can't
> happen.
> 
> In order to further establish a connection between the power domains
> related to GPC and block control during system pm, register a notifier
> to power_dev, so that GPC power domain will know that block control power
> domain is on and will not power off itself.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Cc: stable@kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
This patch got backported to v6.1.y and for me it breaks the boot on
i.MX8MP with the log below (tested with 6.1.175).

Reverting the two patches of this series fixes the issue. What is the
correct way to fix this for the 6.1 stable branch? Should the patches be
reverted?

Thanks
Frieder

[    1.164011] imx8mp-blk-ctrl 32fc0000.blk-ctrl: error -ENODEV: failed
to add power notifier
[    1.171108] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000210
[    1.179932] Mem abort info:
[    1.182731]   ESR = 0x0000000096000004
[    1.186492]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.191833]   SET = 0, FnV = 0
[    1.194891]   EA = 0, S1PTW = 0
[    1.198041]   FSC = 0x04: level 0 translation fault
[    1.202960] Data abort info:
[    1.205836]   ISV = 0, ISS = 0x00000004
[    1.209676]   CM = 0, WnR = 0
[    1.212662] [0000000000000210] user address but active_mm is swapper
[    1.219044] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.225340] Modules linked in:
[    1.228403] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
6.1.175-ktn-ked-0.0.0 #1
[    1.235663] Hardware name: Kontron BL i.MX8MP OSM-S (DT)
[    1.241001] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[    1.247999] pc : dev_pm_domain_detach+0x0/0x40
[    1.252461] lr : imx8mp_blk_ctrl_probe+0x494/0x580
[    1.257276] sp : ffff80000997ba00
[    1.260601] x29: ffff80000997bb70 x28: ffff0000c0aaa9a0 x27:
00000000ffffffed
[    1.267774] x26: ffff800008e37c78 x25: ffff800008e37ab8 x24:
ffff800008e37af0
[    1.274949] x23: 0000000000000007 x22: ffff0000c0945010 x21:
0000000000000038
[    1.282124] x20: 0000000000000188 x19: ffff0000c0fa6580 x18:
ffffffffffffffff
[    1.289299] x17: 20646461206f7420 x16: 64656c696166203a x15:
5645444f4e452d20
[    1.296474] x14: 726f727265203a6c x13: 7265696669746f6e x12:
ffff80000962c280
[    1.303649] x11: 00000000000000dd x10: ffff80000962c280 x9 :
00000000ffffdfff
[    1.310824] x8 : ffff8000096dc280 x7 : 000000000002ffe8 x6 :
0000000000000000
[    1.318001] x5 : 80000000ffffe000 x4 : 0000000000000000 x3 :
0000000000000000
[    1.325174] x2 : 0000000000000000 x1 : 0000000000000001 x0 :
0000000000000000
[    1.332351] Call trace:
[    1.334801]  dev_pm_domain_detach+0x0/0x40
[    1.338913]  platform_probe+0x68/0xe0
[    1.342586]  really_probe+0xc0/0x3e0
[    1.346174]  __driver_probe_device+0x84/0x190
[    1.350549]  driver_probe_device+0x3c/0x110
[    1.354751]  __driver_attach+0xf4/0x200
[    1.358599]  bus_for_each_dev+0x74/0xe0
[    1.362451]  driver_attach+0x24/0x30
[    1.366038]  bus_add_driver+0x17c/0x240
[    1.369886]  driver_register+0x78/0x130
[    1.373736]  __platform_driver_register+0x24/0x30
[    1.378463]  imx8mp_blk_ctrl_driver_init+0x1c/0x28
[    1.383274]  do_one_initcall+0x48/0x2b0
[    1.387126]  kernel_init_freeable+0x22c/0x29c
[    1.391499]  kernel_init+0x24/0x134
[    1.395001]  ret_from_fork+0x10/0x20
[    1.398592] Code: d65f03c0 d65f03c0 00000000 00000000 (f9410802)
[    1.404715] ---[ end trace 0000000000000000 ]---

