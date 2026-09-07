Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9D37106E;
	Mon,  7 Sep 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768524; cv=fail; b=fC3D4Ed4kQB/uKYK1unIJKoHnLxBUjNXAhafBxrY3e3EssUfiLlPG33JZlYWJ23oB3PR4tp/qBIS19Kcsbh+OwpwSgAWfeMnPyb1FhDcDLBDX9s9HgR2AopsWi31BABiN/zoMtbILCSSPZQDAu6A0l0kkunEXzzfagDPAOZXcVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768524; c=relaxed/simple;
	bh=mNNMwXH6gfPWBXtmV/PrL54K1wrYMsaoIVSJk8OcDmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDNNb2LeAehZwurhMT2xRN8Wp9dNnyYej7WtGDcNTNAbcaPdhPXTGvKT5eTuHzGse94LvEBpRPD/SFNjggPExtJ7go4xCz+2CCyO25X/xkX555Bc3ANKisF6jeeTLNZRq43yupT5sUc9sv7GwK8yaTfLqGyhpNjdQKiCdlsW+Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zz75G0c; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zz75G0c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyQpY08D+mrlMQbQVtA5AKU7U7xnsTRuyZrNx5Tl5erd5JAd64O7eSz+HvLpJ+GswrAfI0/Duh2ojyYEDhGipGxhVnIRweUT7YaPzmYkqUeNIPQWucWVeVzr56/SfZnWnkIF3qLZMS+m8koBDW1XkOAZxuvdTxQPRGkq9FUjpvXOK8d5mk3+VmbLWK92/taynXaTdMWc5o9ymxMLH0Nn3LsF44xzxxovkhoBXMo9itcOBkGQpY80MCPjDTV3B3Okk0kpGG05bKxK6Md3fXnprFH5S1usENTsVJxAEHw0YjCc5BzhcLjFfH/yMkn7463DOymC/vnLhglJVUe06T5hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TYh7Izv0HlPXXVKvHR8J4TQiA1oOauVtphFqujveXc=;
 b=Pg/wsKVRYK3pAZGMEIsE+KcnlsBB+ayPn2G/rGzPltuh25dBE8lmNQxWCQPicrrPWzyzIYNNF11CD56r2NNplxuzRiVpHGMHUCQ2qS5257yzkyOm302NpxTtU+UwM121oefy2SUldk9IRqDKVdPoZ2hzKnO6obg5yRHVf9X+DhMsnjCZ8wjHqz1q5mg5t8RUMl2t/zSYMxNTWc1fLXJBYmydKTk9ICAKjkt04AyxEvW8S+fbwmO9tlhg5BjeUT7BJO2IcuSe2/JeY4xLkBwHLVyQzOI1l2UH6Kcw+NxO8PsyQFWiZCBVZEWCtejh/LjFAD8MZPUijyCtw97+imw7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=transsion.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TYh7Izv0HlPXXVKvHR8J4TQiA1oOauVtphFqujveXc=;
 b=2zz75G0cd6Zuw4EKOrLq6YCnFr1dkf+vgNYhtY4tpEX24jtU2FrJRryVh3FnZIPKTJf8M3KvdWfhguGaFzCHIVePiP3+UKVnuAG61sHojmfDE33FHZB+AhSjQyO6prGm4HzY7j7UZrr3yGTJsrdfzhqBA5xCrdFeqTn7h7a+W7Y=
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:08:33 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::90) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 08:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:08:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 03:07:51 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 03:07:46 -0500
Message-ID: <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
Date: Mon, 7 Sep 2026 13:37:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Hongyan Xia <hongyan.xia@transsion.com>, jong wu <jianyong.wu@outlook.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 888eb1d8-294c-444a-ef63-08df0cb73567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|32650700020|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ye7n/myelJ0zq8nvvg+NHyuYN32aQWA9w4HzYYkMuFOCIALdOSJIvnN0VOzWyKAd2SD6Do1nNSQt9ZRp/q6zvGc1QTQmgIiWGsM2HJX+cOy3whgrC9cJ/EcxnfCX3jGLw80lml0AgSHnlVSuamfWVp7kmEhMrVMl6bwb1Xg1PQqdkbGjVHbkVtfeGCAQ5yogEVtjNc1P9l1efPL6X6eZ/9TH8euqCgfsCSygE26kcaL4mOmGXzIMLmDUYBpclU7dZVogs9kpWg42M4du3CTFv9RF6wJidKcIJ9aqb8b9dATLqBBf1Cyns9Ry0R4N47EYINnILhT0NFq9rX7V24fN3LOuzs5YtA/Shu55LN7h0Ackf8HRSkgPdbT6i2qKApDQh/8FvFdumVCNL6Tlc3riNP60if65yjexqd32j9hnTlJPiET+dfT3sN6mxOcms+d/ga/T9aPjLi3jYEPk6yf+kH55FriDeZ3B2K500Wi0uJg8gpYro7BNkePJ726MA0ljY1BRpEkof53lvqKnJy9qFiKuBRVW5zWCdIKJcNFzazqTXXQza5Ih4fqcfCcaD7BmjaKc9qdwFyNU/DIUHXWfsnPNuW8vNrGcav/DA1OQ9gxHV7jkQf0nnqPAeBhMwlIx506jn2hyr9tjJHZUOclAhVN62xjWaay//F1pXbqx3aPNoqulmZVnBYDG+tr4+9f/5BXRqag3uBOZylczEIV2iw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(32650700020)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9c/D8bTan9OpiQycRioWrdwKOipYBAUGJbKOHh6VkAUBsewAt55lUi0q6g7j0CzS6Vx21a44jksM/TuJ2FR592r1xYpOw0+Q1n+vurawzCVwqhmLGuPh1mNd37Tj8STduwimi370KW1CFQNVBvpmzxfePqkt9dP9XCTpkfKu4F+wNh52hfx3tFRoOUuusImYcoexpeSsnBMll2sduuaynj5qf8GPfPCUuS9iY4FZmp/860Uh5y3jBSGtYWErBm8RKD2Sf5PlLfzfMIjbgJM2qEDMSyMKuovZ6JWDF6pIiJwJH44M1+jpT7TgCdI7Z6SpHUSr++zD3QH3lpEhxwfz43evC4HC5ebr48HTpkGuLmM1Dq4oyn50pLeTVC3x0CUPKwrfnYVpCSqZe1yLByyix2VgTwSkhtOY/H6Ax94zZ2fbO9f5tGU4YgXbGhRSUVvW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:08:32.4053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888eb1d8-294c-444a-ef63-08df0cb73567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

Hello folks,

On 9/7/2026 8:02 AM, Hongyan Xia wrote:
> On 9/3/2026 10:04 AM, jong wu wrote:
>> 在 2026/9/2 17:37, Hongyan Xia 写道:
>>> On 9/2/2026 4:49 PM, jong wu wrote:
>>>> 在 2026/8/25 21:05, Vincent Guittot 写道:
>>>>> On Mon, 24 Aug 2026 at 15:06, Jianyong Wu <jianyong.wu@outlook.com>
>>>>> wrote:
>>>>>>
>>>>>> Hi Vincent, Hongyan,
>>>>>>
>>>>>> Thanks for your comments.
>>>>>>
>>>>>> My original commit message did not clearly describe the concrete issue
>>>>>> being fixed, and its explanation based on frequency invariance was not
>>>>>> correct. After looking into this further, I found that the issue I
>>>>>> observed has a different cause: the cpuinfo.max_freq fallback added by
>>>>>> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
>>>>>> cpuinfo.max_freq").
>>>>>>
>>>>>> The commit message says:
>>>>>>
>>>>>>     However, in the absence of arch_scale_freq_ref(), it is reasonable
>>>>>>     to assume that cpuinfo.max_freq is the maximum sustainable 
>>>>>> frequency
>>>>>>     for the given cpufreq policy.
>>>>>>
>>>>>> That assumption does not always hold.
>>>>>>
>>>>>> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
>>>>>> autonomous boost frequency, while policy->max is resolved to the
>>>>>> highest selectable _PSS state. With boost enabled and policy->max
>>>>>> unchanged at that state, the measured CPU frequency can still exceed
>>>>>> policy->max. Thus, policy->max does not represent an effective 
>>>>>> hardware
>>>>>> maximum-frequency cap in this case.
>>>>>>
>>>>>> Nevertheless, the cpuinfo.max_freq fallback makes
>>>>>> cpufreq_update_pressure() calculate positive pressure for every 
>>>>>> policy,
>>>>>> although no effective maximum-frequency restriction has been applied.
>>>>>>
>>>>>> The underlying issue is that cpuinfo.max_freq is the maximum possible
>>>>>> operating frequency and may include an autonomous boost frequency,
>>>>>> whereas policy->max may represent the highest selectable _PSS state.
>>>>>> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
>>>>>> that the available CPU capacity has been capped.
>>>>>
>>>>> IIUC, cpuinfo.max_freq == boost freq and policy->max reflects the
>>>>> correct highest frequency reachable by the CPU when boost is disabled
>>>>> so the cpufreq_pressure is correct. But your policy->max is not
>>>>> updated when boot is enable and doesn't reflect the highest freq
>>>>> reachable by the CPU.
>>>>>
>>>>
>>>> Exactly. I think the root cause is that policy->max has different
>>>> semantics across cpufreq drivers. On Intel and most AMD machines it is
>>>> the maximum attainable frequency, i.e. the boost frequency when boost
>>>> is enabled. For acpi-cpufreq, however, policy->max is resolved from the
>>>> ACPI _PSS table, which does not contain the boost frequency.
>>>
>>> Proper solutions aside, I vaguely remember investigating scheduler
>>> issues on a Ryzen 7840U. That has acpi-cpufreq with only 3 OPPs. Boost
>>> frequencies are not included in those 3 and are much higher than the
>>> ACPI OPPs. I certainly managed to disable pstate and switched to
>>> acpi-cpufreq on it. I wonder if you can reproduce such issues on such a
>>> machine. Maybe this is a broader issue than we realize.
>>
>> That may well be the case, but so far I have only observed it on my own
>> machine, so I would rather not claim more than that yet.
>>
>> My current understanding is that the trigger would be the driver rather
>> than the vendor: if a system runs acpi-cpufreq and its boost frequency
>> is not present in the _PSS table, the same reasoning should apply. The
>> 7840U you describe -- 3 OPPs, boost well above the highest one -- looks
>> like it could fit that shape, but that remains a guess until it is
>> actually measured.
>>
>> I do not have a 7840U at hand. I will try to reproduce it on an Intel
>> or AMD box by forcing acpi-cpufreq (intel_pstate=disable /
>> amd_pstate=disable), then comparing the measured frequency against
>> policy->max with boost enabled and checking whether a non-zero cpufreq
>> pressure shows up while the system is unconstrained. I will report back
>> with the numbers once I have them.
> 
> I managed to reproduce the problem on an AMD 5900X. I added trace_printk 
> outputs on cpufreq pressure updates. Under AMD pstate with boost 
> frequencies I get:
> 
> [006] .....    34.096492: cpufreq_set_policy: CPU 1 has max_freq 
> 4683471, max 4683471
> 
> You can see policy->cpuinfo.max_freq and policy->max are the same.
> 
> If I force disable pstate and use ACPI OPPs with schedutil but still 
> with boost frequencies, I get:
> 
> [003] .....     4.697753: cpufreq_set_policy: CPU 1 has max_freq 
> 4680714, max 3300000
> 
> So you can see policy->max includes no boost frequencies (3300000 is the 
> highest OPP) and will trigger policy->max < policy->cpuinfo.max_freq, 
> hence applying pressure when there is actually no pressure.
> 
> The conclusion is that yes, this is a wider problem than we realize. I 
> suspect this might also be present in Intel CPUs with ACPI cpufreq.

So, I've been trying to understand these bits and looking at
cpufreq_policy_init_qos(), the "policy->cpuinfo.max_freq" should be the
frequency including the boost range but I see cpufreq_update_pressure()
and it says:

    max_freq = arch_scale_freq_ref(cpu);
    if (!max_freq)
        max_freq = policy->cpuinfo.max_freq;

    capped_freq = policy->max;

    /*
     * Handle properly the boost frequencies, which should simply clean
     * the cpufreq pressure value.
     */
    if (max_freq <= capped_freq) {
        ...
    }


Looking at this, I feel "policy->cpuinfo.max_freq" should not include
the boost frequency, or x86 should implement a arch_scale_freq_ref()
to know when boost is enabled vs disabled.

If cpufreq_update_pressure() indeed has to disregard boost frequency,
and anything above P0 is not considered as pressure, we can simply
do:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b898b6544069..068e6d6e15a1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 
 	cpu = cpumask_first(policy->related_cpus);
 	max_freq = arch_scale_freq_ref(cpu);
-	if (!max_freq)
-		max_freq = policy->cpuinfo.max_freq;
+	if (!max_freq) {
+		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
+					  policy->max, policy->min,
+					  CPUFREQ_RELATION_H);
+	}
 
 	capped_freq = policy->max;
 
---

__resolve_freq() will cap "policy->cpuinfo.max_freq" based on the freq_table
entries if it exists (acpi-cpufreq), or otherwise return
"policy->cpuinfo.max_freq" as is for drivers that uses CPPC based scaling
(amd-pstate, intel_pstate).

Thoughts? 

-- 
Thanks and Regards,
Prateek

