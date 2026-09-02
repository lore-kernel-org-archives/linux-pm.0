Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012048.outbound.protection.outlook.com [52.103.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B53E3C73;
	Wed,  2 Sep 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339572; cv=fail; b=SPASXtaI3QkdrYQtB3npFzK7X7K5CHjifrj5ztgieH7AglK2fIcimX3ejwK91XUA3CpSL8+soIeyzjGQpQ0AaMGACFBc7NFX0aTL/pwVrr6D1YJvghbpKlFT2ak2Zs5Ptv+yRML3ZpQ9LCijUEvNqh1OkOSUvD0FDTrtCPGkBo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339572; c=relaxed/simple;
	bh=XYXFAjmJXtNCJgQUZP+mtTx4PWNDgCr5+wWnJg36TgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtjSHFl4+/Y2kbXxZuHacAPSMkelUK5XeqMcAzgXmkDTg44pz7ikxLEYx24Y4ZvmaAaMPCYneq+3KUx9CqLqMMEJAUGI8nES4ku1jIzmDDUTMUPqcWNSWr+aGqivRODXHYYFCp5bXMuEy7yZiJo7yt+WVNIh7Ts+hS/IqZa7okc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bdmNYZ5z; arc=fail smtp.client-ip=52.103.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bdmNYZ5z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ooaklp5guhjWCatwsRsT8qF2Yb8ZGe/x7+Q7cDMiu3pzvc0YCE0dUr1Iy5Kr5/6uXecspevLfoMtwY9eodG6oYLrH9/xEB788ltQXwg5A4JHtEZxtfdMy6jNSAY5X/ZInzAu9ggdN5nETV1IRt2IRsu0q1+WaHZ0zeAIo1yN8f+yQ0sno3kU+6R0lzn87GBlz8UyrqI7k522dSmE/ph5j6LcIXcKhFlhF2C6+DFxB3422yG0bQHHeLmZKkEsaClDokQNiyTIHgWDxLOj2Kr2Zsbk8In0SkXgBbPthjxizm45W5REyGkXnEm7BGeTPKe+lcU9ZMyzF5rIIuNM0u1CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUnym9ntw+27Iz0uXo+wpgqUkzGXf0Bjbv0I05p9rZg=;
 b=vzxLihsWzmWmxRPhoY6LdnEuAavW+LXyiHRjA8JEPXlK9KUywvOL0frPOJPBWpQC5OGDtEb7EcguBHQ5Qbjf0gMsfN1zGcHDIq+Qo8zql/GSALUKrdbpcbVpunKLIfnmNc3CQzqmBeFPboHgnDih0RAlTnFpYCKbdPFa2nYTsLrXCuP4vtHGwr1+FBeJvJ4NG7u0aMubuxBsNJonucrCdcIhqJtQv31Ra/PjOjSbfo/KkGlrp9HYTcOGqnUzXGHJhfzTelI61iY6FnPhASKzxdf+YcXCVeIF9+mB+A6/A6uER4AWO/5hFWR5I743pDjb2nMxtFO/vzqRZjcrZ/jN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUnym9ntw+27Iz0uXo+wpgqUkzGXf0Bjbv0I05p9rZg=;
 b=bdmNYZ5z3hsHI4WyMrAXFPzw7ZbfPkih1dT+wHjzIAksZHeuvirRvNbk0x5B+7YVB4QXLyt6NvkMErb1glUqq3uDtW9dL4kANk9X2BX/mUA/oVnNrEYI+yhxUBSue+K0B+5sKlHvYZyPWypycPo8ER1sVg+02V/v3NcZ+IyZQxQW0Hxyq5PkT5Ku29hS6kfZTatuuDIb0OWQljqBv3WsPBSfUuUE3sgrz2sW/sSYM9Rz+RLQ2dP40h9FEmcmW4gEBbmsSF3HBrOez8pNV5xxfJxICAXhLG+aXbuNdrBF25xyqAKoYki+XchCPfOVq0RPYjW8SEt1PRz7rb8t3upIjg==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by KU2PPFFEE04EBE3.apcprd04.prod.outlook.com (2603:1096:d18::573) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:59:23 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:59:23 +0000
Message-ID:
 <SI2PR04MB4931F26A705BEC756ED56EC8E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Wed, 2 Sep 2026 17:00:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Hongyan Xia <hongyan.xia@transsion.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <49233994-f46f-4d41-99b3-b40cc23bcbc7@transsion.com>
Content-Language: en-US
From: jong wu <jianyong.wu@outlook.com>
In-Reply-To: <49233994-f46f-4d41-99b3-b40cc23bcbc7@transsion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To SI2PR04MB4931.apcprd04.prod.outlook.com
 (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <f07a9868-41b5-475a-9358-5a436528d717@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|KU2PPFFEE04EBE3:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fe1ac5-39de-465d-61f7-08df08d07bc0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|25010399006|19101099003|5072599009|15080799012|51005399006|12121999013|8060799015|19110799012|23021999003|56899033|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1FqWitIUTZKVU95c2t6VEl2VlBVZEF5WlVFMzh4ZDdlcUE3SlY4cytQcGdE?=
 =?utf-8?B?L3NOSGV3SSttQkNCZHJRM1FDR0lvdzFuS3p4VGZBREpGeUFSK0xPM0U5QlN0?=
 =?utf-8?B?Qk9HNlRsS2VkZXc0cTk0SW9CZmxXSC9yK0RBZXc4SDBwMHc4K2RQU3pPUmVu?=
 =?utf-8?B?bXNPRUNDWUVBazVvdU5TSUlsOHlSdVFnVlBmRFoza0s2WkZxamhoSnhxanpj?=
 =?utf-8?B?SFVHeEUrcnNuejgzaWVhUkYzMCtNUU5pWG9LaDZiWXRrTUJRWXUyem14bVI4?=
 =?utf-8?B?LytjRFB6bWJiR1N1Vlp0dnRVVmdKc3dnM1BjeU9Fc0xzSXJqRWtORVFMV001?=
 =?utf-8?B?MDAxUGQ4Z2RNQURnWkJqVFZpeDR5RGZZb3BWN2djWDRxazZHU2pLekt6Y05m?=
 =?utf-8?B?Zm5wVUdTQWd6SDZjT1NqMjl1S3pYZlRMU3hoMG0zd2VndHpjcUduNGpoeFkz?=
 =?utf-8?B?MXdkNTdZT1ZDNm1Gd2VjSnlvYXdjUlhzMXlHOUFIemRCeFVWOWxLcDl5SVJM?=
 =?utf-8?B?NEtWNnFkTk00dytuek5vK0xUdGF3UTdkS1pNc21mRWJzVnJremxkOUJyTEVz?=
 =?utf-8?B?M2JpeFZOQ2l0RFZYbWhCTzJUclZGWllBRnZUVWhhdkJnSFdYQWxleTVBL3h3?=
 =?utf-8?B?Z3lNdVhDaTBXWFp4NEYrdkRqRDZsTlg4Z0k0SERoVWlLbzFkeXY4SWJqay96?=
 =?utf-8?B?ZmlZZ1BUNG41Z2UzM2JKSmREL01PbHNTWmdxU3BaM3R4cDE1YWhndEJkUU9h?=
 =?utf-8?B?WkZpWVQvZTdiOEtjVHpQaGVRdkk1YzlsWlAwVHpuckZCRC9Wb0NEMk5wa1dx?=
 =?utf-8?B?Tmd1VXlDVFMrdVpib2VKQ1BhQkt1UlQrVlRXbHNrclFTVldtNlJWTVJUbHFr?=
 =?utf-8?B?cmZRVTVqU0pPWWR1QTJjQzdZUHlUY2lzSzNsWEk5VFNsOWZBRUpYbENRWGp0?=
 =?utf-8?B?WktsTzByMitMdUhVc1gvUGxMM29wOVVXcnRET3VheHQzZlp6WnRNUFlJT2E4?=
 =?utf-8?B?ckxOVURncjBLTlgyc3UzejQ5cDQ2V0FYOERpUHE0WHd3bkN3bTY5dzl6WmJU?=
 =?utf-8?B?UzQvZ3pZTmJ6SnJGcmpreGhSSjBwSGZkSU91UU1lbjZKZGp4VXNPRFM3VVh6?=
 =?utf-8?B?RWU4SG1PUUwwREhiclBTS2dld0RGbjdsZk5UTUhOZ21Xbmd6RytrTlVTTG8z?=
 =?utf-8?B?c2dFOTJoOFFOYjBBNlh6OXZqNHBRK1hrYlZCeUc5ZE43ZFlRK3dOL2dBcDBa?=
 =?utf-8?B?RWswOC9FTWluYjU5SmpvSDFjcFBOK0xrVW5wS0NYNFg1ZXVYMU1KSGRtNUpG?=
 =?utf-8?Q?hn3Oa/HiH6lN/ZRmOSgMUiVGcARj71HPrW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERPaW9RcUc5eTJlTVQ5Tkl1SmtVUDZpT1BuYUdUdVQ3UkZtV3ZCYVRqdjlh?=
 =?utf-8?B?aWNFdHlDS0taaFBXY1R0OXdNL0IyVlZrTjZ1UUswMmxKLzB1VWxmUWVFV05K?=
 =?utf-8?B?c3FxMTJrOTVUUmJMbUxqUE4xc3paTWUySjVhbERKN0xQcG51VGFyRUJSKzZ6?=
 =?utf-8?B?V3M4OUlVeDhheGJNOVl0MmladVpETTRFNXI0YndZWHdqNFFFVjcxd1c4ME44?=
 =?utf-8?B?QXNpQzRid2tvMUNJL0VVdFAwQ0c4OXVlQVlaYWs5b3BDeGV5aE9VVWhMUkxB?=
 =?utf-8?B?V0FScnZXV0RuZHlqZXI0cVM2cno3WVE2UzdxNk5Vdkd6K0IyVkFyWHBtN1M1?=
 =?utf-8?B?YXdVdGZMYlRaMlk5NU1hNVcwekh6Y29SRDNqMGhMWkN3ZVVlZUhTYmZqUTFY?=
 =?utf-8?B?TG44dEtYNDR5SXRJTitEaEtGV3pRRDBTTVdlTGF6VDZxQW11L29DZnc1bkpU?=
 =?utf-8?B?aThPV1d2ZHVaQkZ0cU5ZSXVhOU94ZzJkenVUZzVOQk1ncEFNaVFRYmpJRHd1?=
 =?utf-8?B?M2hZcHZwKzAvWnVTU1ZCcFA5eE11dm5NMHNaeHRPNHAybWk0NWdSVTA1cE03?=
 =?utf-8?B?L2FrYTNWaENuYnpxMGRVTDlYejBtZFVWc3ByNTB5TVRJUnQ4Ny9EQWNQcjlk?=
 =?utf-8?B?R0UvVzVZc3NwMVRaT1dDNlR6Y3dBK3ROQnlCdGJ0RHM0L0lqaXhoQ01xS2N3?=
 =?utf-8?B?dXdEZXo2QUQvRS8zVTdOeHUrWS9HeW1jOE5CSTNXMHJ0eHJzTEhDZFBaTzdU?=
 =?utf-8?B?T0w3S1YyWS80MVNxS0YyUkR0YVhDc3ZaejIzZU5uVmptbHQvY3E0VWhNdFJu?=
 =?utf-8?B?dHpZa1pJMTNUK0Y1dXBjNHZQMURnbXBXYzExNzl5cnpxVjFqQUJKMFUvenpY?=
 =?utf-8?B?am01Zmg5VC9PYkxHZ2sxaVpRZjk0a05jYytxT0t3YkpMYXNiTU1kakFrTENJ?=
 =?utf-8?B?SHphczhQV3A1NFdXYnNMQUpxTEVZVEFyNVZiQm5QNXdGM1lkVzhWZnlWZXRx?=
 =?utf-8?B?bWZwOEZ0bS9kTE9mUFJnaFFKeEl4MXRXelV1WlRDVUxEOHpiSHhueFlvblor?=
 =?utf-8?B?cGVPY1dSZEdZSnI3QzVIMUZBK000YzY2SlVFL2Vsb2sxYnU4dWxCd3dDMk81?=
 =?utf-8?B?dFd6cHUzZWc0cVBzZm1PZEFzcmNQQWhEUlZkYnRLaW90Z2R1UzUrUUo0dng4?=
 =?utf-8?B?YlplWWtFdHIzZFc1Smkxc3psTTBwMnNTcm9GM1QyWnRpb1lnYytqTWg2MlU5?=
 =?utf-8?B?RCtuVXNna1MvaWhRTTRmMGZPa084UFNGa3VlMzgwWlZOTDdRcEpIVW95T1Fi?=
 =?utf-8?B?VTdQT0pOaGVwcHJLakpQVlBDVU5xbXZuZjQ0VHIyS3lRUXRiRnZHV0g3VllF?=
 =?utf-8?B?UlQvdXZMMk5qWVN6VXBwZmxWNG5kVHhmWnV4QWdmcnZaWE1SUlBSNlA1N1RY?=
 =?utf-8?B?Y2lxbzlrY1d0KzZGelpaaURuMDRXQlZQNXFoVU8raXM0bDZHQmg0SmpWSkJF?=
 =?utf-8?B?UmZEb3VRVzk5emdJY2s4MklPVWRBaHFpZUlRN0RJRUdPM05rMjJBNUk2Y01U?=
 =?utf-8?B?VjljaU1PbFhwQ2hrbW1SckorbFdDT2pFNUhuazNUMjExeE14UUc0anlBNnI5?=
 =?utf-8?B?cks0M0k5Tmlhcjl2TmF0VVRocXJBMGRwWkkramMxbFUycmZjZjNrWHdFUjZB?=
 =?utf-8?B?NzU5dTlwRGdIV0dmVTRuNXd0bThENHVBOTdXbSswV2t6ZjBEQnpXUmIwZWsw?=
 =?utf-8?B?VHpVLzFlZDEwVnBvdTdtU096YVVnNU1XUDJhbS9yUGJlYlEyc1pmd3lsRm0x?=
 =?utf-8?B?M1ZSRXM1SUJqOW9rT3ZaZituS1NxYmpmRnA0THRLMHdFdzAyYTBEdnFiY3Vn?=
 =?utf-8?Q?5xUJ1EeCzc5/7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fe1ac5-39de-465d-61f7-08df08d07bc0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:59:23.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFFEE04EBE3



在 2026/8/25 15:40, Hongyan Xia 写道:
> On 8/24/2026 9:06 PM, Jianyong Wu wrote:
>> Hi Vincent, Hongyan,
>>
>> Thanks for your comments.
>>
>> My original commit message did not clearly describe the concrete issue
>> being fixed, and its explanation based on frequency invariance was not
>> correct. After looking into this further, I found that the issue I
>> observed has a different cause: the cpuinfo.max_freq fallback added by
>> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
>> cpuinfo.max_freq").
>>
>> The commit message says:
>>
>>     However, in the absence of arch_scale_freq_ref(), it is reasonable
>>     to assume that cpuinfo.max_freq is the maximum sustainable frequency
>>     for the given cpufreq policy.
>>
>> That assumption does not always hold.
>>
>> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
>> autonomous boost frequency, while policy->max is resolved to the
>> highest selectable _PSS state. With boost enabled and policy->max
>> unchanged at that state, the measured CPU frequency can still exceed
>> policy->max. Thus, policy->max does not represent an effective hardware
>> maximum-frequency cap in this case.
>>
>> Nevertheless, the cpuinfo.max_freq fallback makes
>> cpufreq_update_pressure() calculate positive pressure for every policy,
>> although no effective maximum-frequency restriction has been applied.
>>
>> The underlying issue is that cpuinfo.max_freq is the maximum possible
>> operating frequency and may include an autonomous boost frequency,
>> whereas policy->max may represent the highest selectable _PSS state.
>> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
>> that the available CPU capacity has been capped.
>>
>>
>> Therefore, this patch checks the wrong condition and is not the right fix. I will drop it.
>>
>> Instead, I am investigating a fix for the reference-frequency fallback
>> in the cpufreq subsystem. One possible approach is to use the highest
>> non-boost frequency-table entry when arch_scale_freq_ref() is
>> unavailable, and only fall back to cpuinfo.max_freq for drivers without
>> such an entry.
> 
> I see. So basically on your system, cpuinfo.max_freq includes boost
> frequencies whereas policy->max doesn't, so the policy->max <
> cpuinfo.max_freq arithmetic comparison gives you 'pressure' even without
> any actual pressure in your system. You might want to re-phrase the
> problem better as it took me quite a while to understand it.
> 

Right, that's exactly the point, and sorry for the confusing wording.
I will re-phrase the problem statement in the next version.

> So this is not frequency-invariance-related. This basically boils down
> to the definition of different policy->fields, which might be better
> commented by people working often with boost frequencies.
> 

Agreed, this is not frequency-invariance related. I have followed up on
the cpufreq side in a separate reply to Vincent, proposing to let
cpufreq_update_pressure() tell whether policy->max is an actual cap by
checking whether the boost frequency lives outside the frequency table.
Input from the cpufreq folks would be very welcome.

Thanks
Jianyong>> Does that approach sound reasonable?
>>
>> Thanks
>> Jianyong
> 

