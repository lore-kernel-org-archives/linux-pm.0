Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023114.outbound.protection.outlook.com [52.101.72.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E4A13AE;
	Thu, 23 Jul 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811681; cv=fail; b=k2nrmDcKQLect8Bk7/BBxi7qfhDhIrcfiIhDf5ATq8XG/kjhxH5Al6LRnAB/S16c7ZjwnsZpaAL4w1F6FjHvqqO07bifE/Fxr2srZ18bAi9GbCfVPHt8/iONw0NDNHCYDdNqNWSSo/eQKNOPzxAb6QRR8/he+rRdc1YreeGr1OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811681; c=relaxed/simple;
	bh=iywA4RNK5Tdrt+nGPqh6aEY1BNq9JDzajy+6X9f61F4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2NxtWpQoVS5ai5wxHtoUMVVMzA1tz/rP2s4k9eNuNLsdH82ZpEQeCBg6zjpcL3hHr8rk6Gdv1rFVLfa/4kGrKgDy+uVNLNDBrad2+txRUPKpjMoUGqashq6u2ZDStki9TbP9BevyaKH3I+boag+syayTXsG6KsQoXMJRIYKYII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=uksot+r0; arc=fail smtp.client-ip=52.101.72.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="uksot+r0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDU5pJL3CyfFEQboxgfySezV5n197PU9pyh+5OnOsiEZi3Svoa0TEwy4iQONiinDPK8BaS8IxQavC+hL2fXEPM52U1z/CnQYHIsS1pgHP6l9OTG4Z1KULjrSmT0sS2tKXkLdKKhCe+N3ZU42TwTk0Uy6DMTYvR1Tl916DZa8p5OBkM5GTyvUvyeSv6sumjPUKnyn+bn0hNe4ES8BgUr9DM3443wWbsZf6aV4tQ4YqglM7b57Ft9BJH+itgsB2v1V637i3eEheVUJn3ES/Ok1oeoRF6mXioAlty7w8sxKAWoTYBK9OZ4peDNZnThhr6tey7p4oh/zHR5lHKdf745qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5wdYWawjgeCZOI9JYi5rHfqLOSdVZ28risoVJQhfHI=;
 b=MrOyteD9VertBctweGIluF2mvVSOHg1C/EeKjRzI90/5wMG3nDX4bo3XLiTdqCTD6h/c780vBVsWvgol7fvcTpxVv5JK7ygG0tHq1INdGZYAFa7G57CsE+NfWys7JuuaUxILQNrnp31sJsIRLnYhyfRLL+ajIcAulbgqoY1kXg4tp8FLgkGgqJC2lYrmtrKWGKGPP1tzZSXWnng4+SsOanKmuuqwh/Q1EACtUJYjWN0r8cAXW3czHttMSTk46JeZ9S4jyB3Jm5rDr1W+b6Nn9U4TqBjFj4XvoVrkdE2n6S1kC0C864HPfJFt63LYkA9ZpTMSAyc51CNDGs/imjs5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5wdYWawjgeCZOI9JYi5rHfqLOSdVZ28risoVJQhfHI=;
 b=uksot+r0VUnMWyttWcvU3QhcnwIDrnRuVsb5h8Dti8BSl2CIhm/kJBZ06gnSv2TS67djwsBho2eDKMT+i4Uv03rR8chNZSonxaCEeONMT1TmXsKUclZUn2Pd3txvsN3M1cG4ATZB+ww6j3aTEmrikj0WSlYx+a07ir8BVKHtDPzEtTYmcoXWLdCQwPOSP1L04hdsglmOfDYpzdc0uUrerWk9OvkxS3X2Jt3vT+akC7GVELwcaM/X38DzR1wqMtrtU6puaKlzaifnZG1++taOW1FgRND2G/qmagsZsIjl4RE/3OIeMh/wiMpExmqaKV75+4TpymgdKMuh8KhpMvf8kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PA2PR10MB8941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:01:14 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:01:14 +0000
Message-ID: <03e70a16-3be4-4780-8404-17b6f011af5c@kontron.de>
Date: Thu, 23 Jul 2026 15:01:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pmdomain: imx8mp-blk-ctrl: keep gpc power domain
 on if blk-ctrl pd is on during system pm
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Xu Yang <xu.yang_2@nxp.com>, ulf.hansson@linaro.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 peng.fan@nxp.com, jun.li@nxp.com, rafael.j.wysocki@intel.com,
 a.fatoum@pengutronix.de, ping.bai@nxp.com, shawnguo@kernel.org,
 l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260204111142.2147646-1-xu.yang_2@nxp.com>
 <fd6268c7-18e2-40bf-9d78-5f3a45ba319d@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <fd6268c7-18e2-40bf-9d78-5f3a45ba319d@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PA2PR10MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fd1c1c-603b-47a5-983f-08dee8ba79fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|921020|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B5f1KAjAZ2aOdpYrftsuXrb6jr4ZKvZ9Q9CrYYiioiCo9QWszS7gsnIxDlCiXx7jAN97DsGrOphMDzA+yBssunIDncIrv9F6GN7ZdnVM+avb01BcygCjX55YhDnv1ODS7ESpaTz1HPkeVEMMJ1FXdSjX6eVNIu0DBkl+4en07Md9wHdJy93IZL6Y+RKl3wgkIWEUVbMsf+35z/X03tpkCjct9OuGEofcDSG5wWPxGOp0BhblMaUGELcx6ohaW04zNn9T0dQMOlqgio57AVlFQOnlhxscS7LNxkFUVaCrJD3LHRtwk1IOQCcPTh96XoCgLPRdyDJZcLAjgsLBK3o634EH164fmD8EFpCiuZXEIO/bJBNLF5hEEKh+EWNG0+JnOEyTk86iOtrzDVqu8wLViiKimZg89haYiiD24/AfXP5j7hZJmvQEozEirjnrTcwlXz4nblstwmM3NYCFQBg1N8pcJWrdau3WNk990sWkgVpX2xLReo8+Pic9fV5bxoSRWrnBfIRrYPsqTqZ4QD1CNHlLtTMgK7OrP29wVFbIoQ5A0ntAdL6uZuFVI/YnnO9yBF6yLC4MJYhmgu/t9hkG8BnrtREAevdpVjuJhupQdX2VTl3gvb+elfwL4MgUHT+Pbrzt3qvO5EGFnOP3YsUktOoboiqQaHusNSZOE2H69iEFkiz9rRPsJ6//+wmt72jSY6lJHW6TnRGT6rNmkOOXbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWdGZW1iNFliVnlURG5UR0xPMk0xMURhNFhMUklFVXZRb0hLdGQxVFcwbXAv?=
 =?utf-8?B?VE9KMHNsNGhGWXR1V3BnMTcxcmZGb2xoaXEwQUYrTGNnOGxEOGRtN0trVW5y?=
 =?utf-8?B?RjVYS3g4UkJIRENiUnFTOE8zOE9sTjVHMmRDYnJlSU53MVFYK2IzeGluWjVQ?=
 =?utf-8?B?c2c5cURJbmthbVJIdEJBMllOQlROVEtDYk9EVkpyVXRtVFBBZ3hKUUZNNWxY?=
 =?utf-8?B?VkZDckxGWHlDTnNHT0x1Nnh1YXpOMmtadWc2a21EMkVJM1J2Vnpra1ZTVlJy?=
 =?utf-8?B?YTMvY2FCT2dQY1d6WGR5d0RLVWhISVArYS9VZ1kzQ25WeEkxZHNmS1gzbkJo?=
 =?utf-8?B?d2plV2FabXY2QXBYd2FteU1PQStlK1VCQmhIY0xaUUh0dHI1d2I0YXZiMnk0?=
 =?utf-8?B?OGJlOGtrWHVkdDFtZkFBVmhqTU15dE5xZEh4RWZRRURpMlVJbkZqek50K1lE?=
 =?utf-8?B?d0V6SG1kckVjOEkyeDhJK01jeFZzV2ZKa3JiWTMramtKREhydFY2bFRxdmFq?=
 =?utf-8?B?bWJjVGg4Ym5sK3FmK2ZTOVo2NVA0bXNsQ0pDbEtIcmF4WDhHMXRqRVAyV3Mz?=
 =?utf-8?B?dERnRk5WOUpSSmRKWlFXSFhteDFRZmhVdi9kSzhLU0p2VlI3UGhHbkpzZEp5?=
 =?utf-8?B?RnBiQVRRYy9OM3k1cU1EelV2d3lXZGYwMzRCNjlTU0hGV0FzUC9TWTRpTzgz?=
 =?utf-8?B?VXY2YW54bWw3RFVVYVh2U1U3SFRjb2o0alg3TUhUMVNPN1JtS0VNaGpweklp?=
 =?utf-8?B?SDRzeUd6TzRyZFV0MjFtZldVaUJEU3JwSkpBZ2JkTDB2aUlQZjNuWmkyc1VV?=
 =?utf-8?B?clNZNTBzdUY1d28wNEdLY0FCUkZVL2daWW1jMmwvL3IwVXJscERBekNTWWow?=
 =?utf-8?B?RkVPTVFScmNTVUhLZGM1WlhSK2FKSWdvcUM4R2ExYTFZb25aQ1pPcWVwYTFq?=
 =?utf-8?B?dllPenhTcW9ockJMSHRrM2NlYVA5amZBVDVRTENhUlVza3RSMVkxZTZUNVNn?=
 =?utf-8?B?UWFlaDI4SmduNWZFd1dXeXk4bFpub1FFL3lneml1S0U3ZHVaT0RweG9XUnhS?=
 =?utf-8?B?Q05naHZ1czVKOTRWbG96T3BxMnlKNENSd0k4a2JRd2VNWTZXOSszRDgycTVE?=
 =?utf-8?B?ejJOaTJoRFZiVkR2UDZxcmhDZm8yTXVyUVVGR0hEZkxycGRJQ0txVldvZzVl?=
 =?utf-8?B?TFk0VXAzelpZTlVJamlhYmg3TFdIL0RmYjQ4L0I0UmhDWVExVE1vaG9hZXVo?=
 =?utf-8?B?Nk0vb2JTenVjbDRNZGZXWm1WSlRUSi9rSUY4UW53VDhMRWFyTHBhcTNtdHhV?=
 =?utf-8?B?K3FtTkFyT3pTMmhkYUxmeUE4WE84Q1ZER0g0VDAxeFZubUNDZGVtN1N1dlQz?=
 =?utf-8?B?MW91dER4Ry84bnFna0tJRi8rc2NrVWdRbE9tNFA4YWphN2ptbzF6c0pXVFU2?=
 =?utf-8?B?NVBvRFFyN3hHZ1llaVdFQnEwZ0tkeHZxU3JlVjRsTmR0dUM2SmRuUnBoUnY5?=
 =?utf-8?B?N043WWhENjI0dFF6SjZVbGQzVkFXMXRNb3N1UGVzUEdGY3U1VTUrNmgybWMw?=
 =?utf-8?B?Q05jc1QzQk5pWU1UNVNQRHhpeFY4OUpRRjJ1SXorY05kTjIzMnF6MFg0c3J0?=
 =?utf-8?B?MXQySmVDWmM4enZPN0dFWXRmdmdCQzJGNk9KS3pLM3FVWXM4eEhBWVpQRWQr?=
 =?utf-8?B?eUM0SlZZaU9qeDAzQW1tRldsMElGZC9ocFpQdEJHWTJrMjkweTNzcnZzL0cx?=
 =?utf-8?B?enh0YmpiZDkycjAxTHVQYXk2RFNXdCtoOHJvUkxGT1puWHU4WXd1QXR3SkZz?=
 =?utf-8?B?bGo2bUVaR2MxbmZCZk5LT01DQ1NWWGVtQWZXaHo2RTc3VVNFVktSQWlPR3BF?=
 =?utf-8?B?MnBjbVZ6Ykw5R1c5cFB5cXp5aTNwdkF1UGpNZ0s2UkpQdVY1aUdGWFVLZ2wv?=
 =?utf-8?B?TVgzZGxQWWpyNGJzRlg2NmNyVnFILzBMUUZqcVlOeS9SbitObExPUVBjdlJw?=
 =?utf-8?B?VGptcldzWVZYUHlqcW5GVklUVDUrTlNWOUd2ZUZyTzZFVlR0WDloUUwyQW9D?=
 =?utf-8?B?cXhrUFZFN1k4UjdTWnpJK090M01IVFM5RmZ4OHlac1J5RUpqUzBYRHZ6dW5k?=
 =?utf-8?B?Y1BiQkdROVB1dWVrb2FlYjhGUDhqRGlCdlpHNTlzVjh3bERDWk5iaitFZEM1?=
 =?utf-8?B?WHprV2tSK1h4c1lxSGhCUm03cE9WUWtIWTByR2RURGtTc2p5S1ZlN2c0bWgx?=
 =?utf-8?B?WTdpVWpqaWdINVZJbTRuenU2T2lxV0tkWTJibkV2bjRjZCs2bXJWbWZrZWhK?=
 =?utf-8?B?K3h4ZTZ1VnNoOExzbjU1NmxDazRuVFl0TXE3S0JWM0xwMTNOY0svbnV6QVNw?=
 =?utf-8?Q?g0jhm/lgZF5CHmIM=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fd1c1c-603b-47a5-983f-08dee8ba79fb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:01:14.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBiSdcoLUmg+H5VyUuz7kLjke3BX7e8hzxKQtJuUmq10Zkqsa5MkZpT/wdWFMi3+a0S1ukuh46Y6j07jPQlf8CfNhKya2ZFN8Plr1evt9dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8941

On 23.07.26 14:49, Frieder Schrempf wrote:
> Hi,
> 
> On 04.02.26 12:11, Xu Yang wrote:
>> Current design will power off all dependent GPC power domains in
>> imx8mp_blk_ctrl_suspend(), even though the user device has enabled
>> wakeup capability. The result is that wakeup function never works
>> for such device.
>>
>> An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
>> is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
>> block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
>> is created to build connection with 'hsioblk-usb-phy2' and it depends on
>> GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
>> only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
>> power domain 'usb-otg2' is off all the time. So the wakeup event can't
>> happen.
>>
>> In order to further establish a connection between the power domains
>> related to GPC and block control during system pm, register a notifier
>> to power_dev, so that GPC power domain will know that block control power
>> domain is on and will not power off itself.
>>
>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
>> Cc: stable@kernel.org
>> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> This patch got backported to v6.1.y and for me it breaks the boot on
> i.MX8MP with the log below (tested with 6.1.175).
> 
> Reverting the two patches of this series fixes the issue. What is the
> correct way to fix this for the 6.1 stable branch? Should the patches be
> reverted?
> 

Ah, this is probably related to the fact, that I also carry backported
HDMI support in our 6.1 tree. This likely triggers the exception and I'm
probably the only one seeing this as this is specific to our tree.

> Thanks
> Frieder
> 
> [    1.164011] imx8mp-blk-ctrl 32fc0000.blk-ctrl: error -ENODEV: failed
> to add power notifier
> [    1.171108] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000210
> [    1.179932] Mem abort info:
> [    1.182731]   ESR = 0x0000000096000004
> [    1.186492]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.191833]   SET = 0, FnV = 0
> [    1.194891]   EA = 0, S1PTW = 0
> [    1.198041]   FSC = 0x04: level 0 translation fault
> [    1.202960] Data abort info:
> [    1.205836]   ISV = 0, ISS = 0x00000004
> [    1.209676]   CM = 0, WnR = 0
> [    1.212662] [0000000000000210] user address but active_mm is swapper
> [    1.219044] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    1.225340] Modules linked in:
> [    1.228403] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 6.1.175-ktn-ked-0.0.0 #1
> [    1.235663] Hardware name: Kontron BL i.MX8MP OSM-S (DT)
> [    1.241001] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.247999] pc : dev_pm_domain_detach+0x0/0x40
> [    1.252461] lr : imx8mp_blk_ctrl_probe+0x494/0x580
> [    1.257276] sp : ffff80000997ba00
> [    1.260601] x29: ffff80000997bb70 x28: ffff0000c0aaa9a0 x27:
> 00000000ffffffed
> [    1.267774] x26: ffff800008e37c78 x25: ffff800008e37ab8 x24:
> ffff800008e37af0
> [    1.274949] x23: 0000000000000007 x22: ffff0000c0945010 x21:
> 0000000000000038
> [    1.282124] x20: 0000000000000188 x19: ffff0000c0fa6580 x18:
> ffffffffffffffff
> [    1.289299] x17: 20646461206f7420 x16: 64656c696166203a x15:
> 5645444f4e452d20
> [    1.296474] x14: 726f727265203a6c x13: 7265696669746f6e x12:
> ffff80000962c280
> [    1.303649] x11: 00000000000000dd x10: ffff80000962c280 x9 :
> 00000000ffffdfff
> [    1.310824] x8 : ffff8000096dc280 x7 : 000000000002ffe8 x6 :
> 0000000000000000
> [    1.318001] x5 : 80000000ffffe000 x4 : 0000000000000000 x3 :
> 0000000000000000
> [    1.325174] x2 : 0000000000000000 x1 : 0000000000000001 x0 :
> 0000000000000000
> [    1.332351] Call trace:
> [    1.334801]  dev_pm_domain_detach+0x0/0x40
> [    1.338913]  platform_probe+0x68/0xe0
> [    1.342586]  really_probe+0xc0/0x3e0
> [    1.346174]  __driver_probe_device+0x84/0x190
> [    1.350549]  driver_probe_device+0x3c/0x110
> [    1.354751]  __driver_attach+0xf4/0x200
> [    1.358599]  bus_for_each_dev+0x74/0xe0
> [    1.362451]  driver_attach+0x24/0x30
> [    1.366038]  bus_add_driver+0x17c/0x240
> [    1.369886]  driver_register+0x78/0x130
> [    1.373736]  __platform_driver_register+0x24/0x30
> [    1.378463]  imx8mp_blk_ctrl_driver_init+0x1c/0x28
> [    1.383274]  do_one_initcall+0x48/0x2b0
> [    1.387126]  kernel_init_freeable+0x22c/0x29c
> [    1.391499]  kernel_init+0x24/0x134
> [    1.395001]  ret_from_fork+0x10/0x20
> [    1.398592] Code: d65f03c0 d65f03c0 00000000 00000000 (f9410802)
> [    1.404715] ---[ end trace 0000000000000000 ]---
> 
> 

