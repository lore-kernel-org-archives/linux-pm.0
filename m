Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB52C0307;
	Mon,  6 Apr 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498903; cv=fail; b=R/EgsfjCBKi2X5ms76vdXGqW6QyYpVke8fzbHaEifSBuLHir4AsgaW7s8gGg/Pi02M+BUVKuw2DKk6QI9k/B16zeAjV/Be+xY8DcjcZcwLr+RfgNj2vFXtgCoz6rU5QR0XSfGn3KkDO1Vpy172fhXofUcPCOsSwBagzvtl9gOgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498903; c=relaxed/simple;
	bh=XMbthKumVc2GJR+gLiHGO7LEQkQfC4eA4dSQc6VQqTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uoic9PNS4rFVjMevadziI9C8Khnt0rZ1keXg/4I0HIrmWTsWFoHDi68VgcXN7ziruai2F/zPh3ST49jidlsHG+Y50fLMMsJvfJ7qwFH/mUrhb40lywdERkU8llxvvTyihPekqFbUdTVd+7a/rxr/nn4JHuqWspGZYBAVrAQGBF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pc7jh9Ii; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pc7jh9Ii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o18lo2GMyKKM/wmdS/svUBbM89FvDuAEcceSYCgx0PyNDzweugRiqrczdmiRhokYly1pN0hDubi2+Aihxb1vCDzU3Rlp3hcqaPBmFCr2zBT3c+dF8F/fsmPifylfSeu1Vy5pRVp+WWWMTGaOChhpTL60BM9r9kw1Nym00DTtHq8yMo5Wwbb8G9Tk+UTv7s2QQnZwwOkO0V9rcsDXdpH7YGGID7IhxZvT61LB/XPa94R5CDumm0GLa5bM8bXVNyMl0gIE5vrofSJEs+MGhRGhFEXk6EmWM874ZIUlZSpLXLai+dAgBroTH5Jz56glMMRW5B2RnfhxNHH0ZzEyJw2vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+z00k8JhrP0Vcbmwo4aPhjAfiyyu1ElqmQDxjSnh24=;
 b=EpsiuTxWSNi5h+I2UZxm1UpM8TUhHO6jRIM0Y24+nZNbRhatLPRm0Wrc2KTd2Op65qv34YfiD/vH66zuJXEEE3AFCdh1bj1cfJwmc/5LZXWOdVfnyYpH+cYtpTN8B/+EG0rYE9qc64vqlOyeW8BM7drLYHE/my4rwdZgm/szcSzJa/848a1dGl9PtG+Cc7PzIh7kwX+SSH/mPWwXTlyAPCjTH0437mGYPQ1IpTBD6p28b2EF6ub/PCg/Hf9k6oS8uOhl6nAsacErz9+DGaHAKgRnZdakHvbsQ6asI7122/XcjAw0i4NFxidb1sR4xDCPVO4GVig2PjLgDHqFDvtCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+z00k8JhrP0Vcbmwo4aPhjAfiyyu1ElqmQDxjSnh24=;
 b=pc7jh9Ii4hYr2FEZbByiwGXSUY+YXd7UyiG2920s2bsi8qwTvzFYw2+r3psGTl2Tl/4W4sukYmQvgYx91xrQkXES/SfTpd2nF5wt9SOgsJI0I4h6SqzAS5HQlIo0q7X0O+34XWNBw4FFDcYXXza8lt863h2e+5VhYLKRL40RREVhEACHIsMpodjzOVdfr5Bbmo9nKKjy/uA/+kHHV/oweCaXcWglg9vspuuKKCFrCH92XsiAOH3j5z337seNFtptQzF1qxisF+UhRkvHw1rjXLNeanmlnH4NEHRxgw7EVJqZSjxYtzmbb7STiHRktBbVOgUsO/mHWlaz+urNT5EooA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 18:08:14 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 18:08:14 +0000
Message-ID: <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
Date: Mon, 6 Apr 2026 23:38:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, zhenglifeng1@huawei.com, treding@nvidia.com,
 viresh.kumar@linaro.org, jonathanh@nvidia.com, vsethi@nvidia.com,
 ionela.voinescu@arm.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, mochs@nvidia.com,
 skhan@linuxfoundation.org, bbasu@nvidia.com, rdunlap@infradead.org,
 linux-pm@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 sumitg@nvidia.com
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae64953-95c9-4fe7-ce17-08de94077880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	U8D10ZAYnA542W2vWITYtSDjOhezX+Ii9Ixy9m4xCGxS1jPhyVPjfHTVC0q54H8tErf2duqOlvii7G/y/nZQiJVUs7UT4iBE5/FRsK3/rxtBCNuQdu/hDur7U4oBFQ9nCtlOLsPaLeMHihpY1MFsCdsj50wmbsXCSRcHBEzmqm9HcdCBO2/oAvljeFCeiWYMiFb5LJuOPumQckG3cdt5pc5F/fc0zbD11FFygf0sa6HCf/rrfp6vNsMm9pwOdlT156KQQyWd8RPN1rI4lP7IkOTYqI9HTw+QXSGTkXZts3os/iEFlL82sb9XTB9ZFuksTDlvaRXp/+lGrAHb1tJDCYmNXAkmIlW7svzc9l5qRjcB/MfS/9nASyCnhbvb/gGSx/1A2Am8oL3pInZW0Yi29jzb2ja/NQmwZX+feCEVf1N7vGZYeE5X+gwClprwO8AqmDBQMux5+TFg5jSGlFinNE7FioUT/vL20IEnR/dWoslxsruc5Oej3IAkSQO1CEkYas2P2iWnKe7qeGmLMVTLwLilH9/kzbdzDgRVYgutlTJR7xt5uAI2mnVfkk7HMNKVtf5ZfeC5yARu5jSCamP+Sup9F8alJFI2BDNirfBgZVH13PsLTpLmLYSkLOSgkyXnXRBdXtkyvnN2msXegOmk+fFCQSjlaQcR2KWGHYv4PwK5LmC1GdT9wRedzcga2KLM7h012b5+E6MF20P7zGkoaYA+S+NTrUNcgXAdcoDABOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZXUEVDSFNjblVFWGFtMEczZDdDRUg1cTFJWXI5S1JrMmc3eGVpbW00WGRJ?=
 =?utf-8?B?ZFNqMG1NWnpYbzZxSkV4N3pGcXpaOTJzYXFKdDFUNStjSmhocjE0SkhtU1Ji?=
 =?utf-8?B?azh5emwrRGxaVmwvNHBxdUJFN3Yra3lyUlNJR3orMStuNWo4OE5LTVk1SENu?=
 =?utf-8?B?aGFOZ3YwMU5lMi9TQXBGWVIwWDlBVEwvWWxYR04rYU1FU3hBRk9ZSHRJZW5m?=
 =?utf-8?B?U3A3ZGdwY3QxYkk0Z3ZCMnBpOGxTTWpSSzVDL2l2cWZVbVUrc1JiUjIzYjBL?=
 =?utf-8?B?MkYzTXBhUTRBckVPc09kdDFPbldhWkFCejZjS1ZQUzJzNU5KdlI1a3hRc29H?=
 =?utf-8?B?cmJST1pkbUp2UXEwSjBKeGhZNiszV0daOTQ1aTlEejVQYUVWYm9iTmxZZlZi?=
 =?utf-8?B?blRRZzY4L0M4R0tYdk1pZ1JCdDI4eXgvRTBqS3F1TlA5eU1GTDQxcmU1SGU5?=
 =?utf-8?B?RC82a1R1OTZqWWVQamtjekxnTUVUVGpBNkt1TkhjT3JkeXpBd0Jlbk5rUDhL?=
 =?utf-8?B?bFFpZ05sY1hld1JhYm5SdjYvTWd3YklrYmY5ZHBpM0I0aU5yRTArcUY3emo3?=
 =?utf-8?B?S1FvU1RmZnlRVHhIZXJmZHFIam40LzVWVVV2Tzl2a2dvSHA1VFZXMHZIRHFX?=
 =?utf-8?B?L0YzV0tObEdqeWVWYUdwN0t2QjE3VkJzZm9FN3FDZkhSSHRLQkpXeXlUNEp0?=
 =?utf-8?B?UWNGS3EvWm5sRWR2RUQwZlh1TVRMbHl6N0xaejFFTXg5RkF6T0pVTVZabkZh?=
 =?utf-8?B?Y2N5dWVLZFZmMDdNWGRWTUozaHNXMTdOWU1mVEJqdllUdE82MEZEQ01iRmVl?=
 =?utf-8?B?WDRHTkExTFNzNEpRVXNvQUtIVU44ZGRuU012dndnbng2Mm5KOXpaRm85OERC?=
 =?utf-8?B?b2tLZGxwR2xEdGg0cUlVVjE0VytOWXUwS2N3Y3dhbzRGYXFqOWJVYnkxYmpD?=
 =?utf-8?B?RlZoLzhSQlVHZjZ5RVE3TUdtY0ZSb0JhZFZvSGpjTllMZ3pycWxqbDZkeE5j?=
 =?utf-8?B?TE9Tbmw4SVFkUWNUb1F3ZGVjM2lsR0syeUtSOVg0bmNyT01MWDBzaXJScUhV?=
 =?utf-8?B?R2tVaDIvbDJDL3l2cW1EVndDbHVmSlRDUTJNSGZmbStCUDlDZkpKekVzMm13?=
 =?utf-8?B?ZU42MTliUkRhRm8vMUdjTEwxVnpSZDRyV0NoZjZDT2dNNVJKUk5VYWNtRUI0?=
 =?utf-8?B?Mk8xUTYzSWJTcEdDTVU2dnlBUzExZk9hNXpYb2R5bW5ZMldXUldlTVhPUDVl?=
 =?utf-8?B?UmMzSGNndkJEVS9WSW1xLzNjSi9ra0kxZVRpR29sL3RmOUREck9aazJENUZt?=
 =?utf-8?B?N2Z3WFNTN2l0SGVJQjBZeGY0Y2JJNEd3VE5wekdrWXg4WFNPUHJPcGpVbGVq?=
 =?utf-8?B?SThtVUZMNFVJdi9WT2hCR2dtYUlVb3IyVUczbFJDUlNVcXgzVHZ0dklwU3VG?=
 =?utf-8?B?Wk0xOVh6d1RqZDdySlVpSlpJclkvNVphSnRxNm5xQ1dWS012dDVPbXh6SjBs?=
 =?utf-8?B?TWFHOEhqMFJVWnhZU01OblR0aUlGdjRqN05NT0d2bGV5RjdzQ3lJMnA1eGQz?=
 =?utf-8?B?cHlFd1hId01VT09pT1dGRk9SUm5STHowOVJFWE9majR6TW5CcjRBZEwwSXBt?=
 =?utf-8?B?MC9xQkt5M1NFVDJhV2kxbFdLdUg3em41eDJjZjAxVFhTUTcrS3BiY0NCN0dI?=
 =?utf-8?B?NzRhc2N0T0dxUVFnWFlqbTUrVkpnZ0lVdFd0bDdzTm50MThoc1ltTFU2VkVa?=
 =?utf-8?B?Mm4vTkxSSlZpUER0QW00ZHhSTkhOMFFscHNlTkhYQWdWTytDNm5oLy9xTnJZ?=
 =?utf-8?B?YTR1NlNwT1prRHpVSXhUaVFFN0Yrc1UyQkdUQ0ozL2t1SjFEQlBWTGtVZTRv?=
 =?utf-8?B?MjYvSHE3cmdoeUowcUJzaWk5QUZId2hSVWhZc3NId01zQVVoclZNVk5nbTB6?=
 =?utf-8?B?TXdPb0lGZXBxUkdjWVhVdEtnMEZxUm5QWk5VN3puV244TkFnVFVhV2R5OXVx?=
 =?utf-8?B?KzZNR1RRaC9scEk5OGlsdTNibE5yMzFkRWx0WXowOTM2YWtBQVpSKzlSSmUv?=
 =?utf-8?B?ZWowSlQvQ2QvNmhTbmdRdTB3WlB0MmpXMWFmNmNPY3h3MjFjY3pXcjRLSkUw?=
 =?utf-8?B?UnBiYWp5VmxGam1BcURBV2hkU1BxSXhZTENjNmtSNHBPeE1Kc0RUa2t5YkdZ?=
 =?utf-8?B?S2lYQ0lXczgxcS9MNGRFRWRGdGZkcDIvRVR5Q1VabmxJc3dyaDdxUEFDYnhx?=
 =?utf-8?B?akQ0c3B6SFJuUnM0N1VLZ3ZleTFsOHg1TTdSQXlVUmNEczNOZk56eXZxcW1T?=
 =?utf-8?Q?btT3nh7vY3wnU20bsn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae64953-95c9-4fe7-ce17-08de94077880
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 18:08:14.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb+m/Hn/98/53VhHTCa0ZdjDSLAUQKpmvoJUBmTR5h3B6l6xgeJcsUzEWDUihUHVb8ugz9E1SCOrpDPlxRCP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

Hi Pierre,

Thank you for the comments.
Sorry for late reply as I was on vacation.


On 24/03/26 23:48, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 3/17/26 16:10, Sumit Gupta wrote:
>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>> autonomous performance selection on all CPUs at system startup without
>> requiring runtime sysfs manipulation. When autonomous mode is enabled,
>> the hardware automatically adjusts CPU performance based on workload
>> demands using Energy Performance Preference (EPP) hints.
>>
>> When auto_sel_mode=1:
>> - Configure all CPUs for autonomous operation on first init
>> - Set EPP to performance preference (0x0)
>> - Use HW min/max when set; otherwise program from policy limits (caps)
>> - Clamp desired_perf to bounds before enabling autonomous mode
>> - Hardware controls frequency instead of the OS governor
>>
>> The boot parameter is applied only during first policy initialization.
>> On hotplug, skip applying it so that the user's runtime sysfs
>> configuration is preserved.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>> Part 1 [1] of this series was applied for 7.1 and present in next.
>> Sending this patch as reworked version of 'patch 11' from [2] based
>> on next.
>>
>> [1] 
>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/
>> [2] 
>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 13 +++
>>   drivers/cpufreq/cppc_cpufreq.c                | 84 +++++++++++++++++--
>>   2 files changed, 92 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index fa6171b5fdd5..de4b4c89edfe 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>                       policy to use. This governor must be registered 
>> in the
>>                       kernel before the cpufreq driver probes.
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance
>> +                     selection. When enabled, hardware automatically 
>> adjusts
>> +                     CPU frequency on all CPUs based on workload 
>> demands.
>> +                     In Autonomous mode, Energy Performance 
>> Preference (EPP)
>> +                     hints guide hardware toward performance (0x0) 
>> or energy
>> +                     efficiency (0xff).
>> +                     Requires ACPI CPPC autonomous selection 
>> register support.
>> +                     Format: <bool>
>> +                     Default: 0 (disabled)
>> +                     0: use cpufreq governors
>> +                     1: enable if supported by hardware
>> +
>>       cpu_init_udelay=N
>>                       [X86,EARLY] Delay for N microsec between assert 
>> and de-assert
>>                       of APIC INIT to start processors.  This delay 
>> occurs
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 5dfb109cf1f4..49c148b2a0a4 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,9 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/* Autonomous Selection boot parameter */
>> +static bool auto_sel_mode;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>       FIE_UNSET = -1,
>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     /*
>> +      * Enable autonomous mode on first init if boot param is set.
>> +      * Check last_governor to detect first init and skip if auto_sel
>> +      * is already enabled.
>> +      */
> If the goal is to set autosel only once at the driver init,
> shouldn't this be done in cppc_cpufreq_init() ?
> I understand that cpu_data doesn't exist yet in
> cppc_cpufreq_init(), but this seems more appropriate to do
> it there IMO.
>
> This means the cpudata should be updated accordingly
> in this cppc_cpufreq_cpu_init() function.

In an earlier version [1], the setup was in cppc_cpufreq_init() but
was moved to cppc_cpufreq_cpu_init() to improve per-CPU error handling.
Keeping the setup in cppc_cpufreq_init() helps to avoid the last_governor
check. We can warn for a CPU failing to enable and continue so other
CPUs keep autonomous mode.
cppc_cpufreq_cpu_init() would then just check the auto_sel state
from register and sync policy limits from min/max_perf registers when
autonomous mode is active.
Please let me know your thoughts.

[1] 
https://lore.kernel.org/lkml/5593d364-ca37-41c5-b33f-f7e245d6d626@nvidia.com/


>
>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>> +         !cpu_data->perf_ctrls.auto_sel) {
>> +             /* Enable CPPC - optional register, some platforms need 
>> it */
> The documentation of the CPPC Enable Register is subject to
> interpretation, but IIUC the field should be set to use the CPPC
> controls, so I assume this should be set in cppc_cpufreq_init()
> instead ?

Agree that the CPPC Enable is about using the CPPC control path
in general and not only for autonomous selection.
Will move cppc_set_enable() into cppc_cpufreq_init() or outside the
autonomous mode block in cppc_cpufreq_cpu_init() as per conclusion
of previous comment.

>> +             ret = cppc_set_enable(cpu, true);
>> +             if (ret && ret != -EOPNOTSUPP)
>> +                     pr_warn("Failed to enable CPPC for CPU%d 
>> (%d)\n", cpu, ret);
>> +
>> +             /*
>> +              * Prefer HW min/max_perf when set; otherwise program from
>> +              * policy limits derived earlier from caps.
>> +              * Clamp desired_perf to bounds and sync policy->cur.
>> +              */
>> +             if (!cpu_data->perf_ctrls.min_perf || 
>> !cpu_data->perf_ctrls.max_perf)
>
> The function doesn't seem to exist.

It is newly added in [2].
Don't need to call it if we move the setup to cppc_cpufreq_init().

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ea3db45ae476889a1ba0ab3617e6afdeeefbda3d 



>
>> + cppc_cpufreq_update_perf_limits(cpu_data, policy);
>> +
>> +             cpu_data->perf_ctrls.desired_perf =
>> +                     clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>> +                             cpu_data->perf_ctrls.min_perf,
>> +                             cpu_data->perf_ctrls.max_perf);
>> +
>> +             policy->cur = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.desired_perf);
>> +
>
> Maybe this should also be done in cppc_cpufreq_init()
> if the auto_sel_mode parameter is set ?

Yes.

>
>> +             /* EPP is optional - some platforms may not support it */
>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
>> +             if (ret && ret != -EOPNOTSUPP)
>> +                     pr_warn("Failed to set EPP for CPU%d (%d)\n", 
>> cpu, ret);
>> +             else if (!ret)
>> +                     cpu_data->perf_ctrls.energy_perf = 
>> CPPC_EPP_PERFORMANCE_PREF;
>> +
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf for autonomous mode 
>> CPU:%d ret:%d\n",
>> +                              cpu, ret);
>> +                     goto out;
>> +             }
>> +
>> +             ret = cppc_set_auto_sel(cpu, true);
>> +             if (ret && ret != -EOPNOTSUPP) {
>> +                     pr_warn("Failed autonomous config for CPU%d 
>> (%d)\n",
>> +                             cpu, ret);
>> +                     goto out;
>> +             }
>> +             if (!ret)
>> +                     cpu_data->perf_ctrls.auto_sel = true;
>> +     }
>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>
> There is a patchset ongoing which tries to remove
> setting policy->min/max from driver initialization.
> Indeed, these values are only temporarily valid,
> until the governor override them.
> It is not sure yet the patch will be accepted though.
>
> https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/ 
>


You are right that policy->min/max from .init() are temporary today
as cpufreq_set_policy() overwrites them before the governor starts.

On my test platform (highest == nominal, lowest_nonlinear == lowest),
this had no visible effect because the BIOS bounds and cpuinfo range
end up identical. But on platforms where they differ, the governor
would widen the range to full cpuinfo limits.

I think your patch [3] fixes this by giving these the right semantic as
initial QoS requests. With it, cpufreq_set_policy() preserves the policy
limits set from min/max_perf registers in .init(), which can either be
BIOS values on first boot or last user configured values before hotplug.

I will update the comment in v2 to reflect QoS seeding intent.

I see that the first two patches of your series [3] is applied for 7.1.
Do you plan to send the pending patch (3/4) from [3]?

[3] 
https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/


>
>
>> +             /* Sync policy limits from HW when autonomous mode is 
>> active */
>> +             policy->min = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.min_perf ?:
>> + caps->lowest_nonlinear_perf);
>> +             policy->max = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.max_perf ?:
>> + caps->nominal_perf);
>> +     } else {
>> +             /* Normal mode: governors control frequency */
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>> ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>       }
>>
>>       cppc_cpufreq_cpu_fie_init(policy);
>> @@ -1038,10 +1104,18 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> +     unsigned int cpu;
>> +
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>
> If the firmware has a default EPP value, it means that loading
> and the unloading the driver will reset this default EPP value.
> Maybe the initial EPP value and/or the auto_sel value should be
> cached somewhere and restored on exit ?
> I don't know if this is actually an issue, this is just to signal it.

The auto_sel_mode boot path programs EPP to performance preference(0),
not the firmware’s previous value. On unload we only call
cppc_set_auto_sel(false); we do not restore EPP, min/max perf,
or other CPPC fields to firmware defaults.

Thank you,
Sumit Gupta

....


