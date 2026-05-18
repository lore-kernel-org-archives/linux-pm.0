Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988723815F0;
	Mon, 18 May 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127695; cv=fail; b=QAv23a60IEunTFLI0DHhS5hQDbLI9nxuCE5p0YoZDoJeneJf5udnF/1sqaQy21H98VPlnlNB3Uvm4pKHDj3mkPbZfgmTTBRwqpIa7/HxP+XH8MmnbldZAGLGtFslDz3KgV9hBQa0qJ6nYv5myvoXnisuPAva/g1pLwu8IvmIswU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127695; c=relaxed/simple;
	bh=Nlxi+X0afx/W4Z2OySGbtF2HBxPLx1Kh7rn5bnkjvjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7E06LvBl9pMj/wz5EDLPKsruNnrDxt6Mnj8iyWnRhZqWQ2Kw/2MZUA5fI2NbU6yzgRslZtAm2vIK6fHvaekNO9F5qTWFFYDk8g5eRUVsMS20mVt6RpMO9y5tgfIOLLVKOBvACqw/TsIipCo/HKKUkb3oc+PC8R8b958lOXqWR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NNV/bt5U; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NNV/bt5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKFXnymmcp5EfnBCWqFTiHGn/RUoPjOcOiLbJIjg5AaUdpZxoj4B3gZdjfydxjWAUP9QpHp/yr893obFTwrCvwRAtxR9lCZytde+bdvx1KZ+Rn0ewpnulfOgG3L3iJYVZEvG41ene3pgk+ObZU1nJhVq+j+jmfIj0WYRAAWQyqxWXQT8hPNCPalvTxcgr/YXS2U+n9kXfgzci6WOmb8hcay85w3USqUIobzXwjkVK7tteEFyJBd8EPm5nRqGOKoVUbqbnRobw7ULQrHPNCkLsHDJsj+baO5OfF68VnUnS4iCQOZ3IlAh6bEUF7Neksz8F//qTEINyJ4e/V1JrBRJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNJziEFmDmxADJwwKP3qOl0oCvax7vYbimEJBl7ECr0=;
 b=n7AReYJhO+QqkqXrU3pVkBxeMU8FbWd0UMUAQJZc7vtTA7z413fBB+hQk9VfVb7RjDczNWXIXrfKL59W++wqXdzQkKCxsde9VcHlW6/YFTXJfQ5ZogCmbOL32JlecOAVp0MjkTXrc6znNEzpyYYZdnIXFBEQXvxX4jCV3SALviA57NT01bjbPgxSvipLvkubvhy1sj2sOP1B7d3wHj7NxKxOpqtNXLAdtqtismQflunpc9sbVa/LsMbH8K7CWD7tuaItqmne/BKeLU3Qgx+BGujzRCU34Hef3Qj4XOjlRPlYiLx3EUJ3hPRM7ZTVmzs0EeeoRCZ9cF/ic7dUWfrebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNJziEFmDmxADJwwKP3qOl0oCvax7vYbimEJBl7ECr0=;
 b=NNV/bt5UWHJM6MlbB7VCebQOimNr6hQZMMaxWB62nVKckyc4YI+csMZDT3/SVdlret66QVr+NCZAkCudWh4vg3K6mriJ9lk9fJzvPMaoVBr0BzINvOex6Hz2aVuJI85WDp6GOeTjz+oXlzQUD9ojdfhssmymB8yj/SAJwxhz5O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 18:08:09 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Mon, 18 May 2026
 18:08:09 +0000
Message-ID: <ad24ad9a-2b30-4952-b36a-210c08a62346@amd.com>
Date: Mon, 18 May 2026 13:08:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
 <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
 <139d2f0e-72d9-4721-9d5a-d1d4a2a95fa1@nvidia.com>
 <72fd2fcc-6303-4980-beb7-e4b711ad6406@amd.com>
 <e1a546f2-6e7e-4236-97bb-f72bea0137f7@nvidia.com>
 <7d7a6ab6-b1ea-484c-a275-19acca50c483@amd.com>
 <985f976f-1144-445b-96c2-df5bd57ecf05@nvidia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <985f976f-1144-445b-96c2-df5bd57ecf05@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46)
 To DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4cf575-1ece-4bb1-e982-08deb5086aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|11063799003|56012099003|22082099003|18002099003|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info:
	SqCM5lkZwGxcKmq/HeQM2+hch/pTSv+o5MntWwsrdudoyhpY4hgUp2B4KBTuFq0MyYjfC4jR1DMWOLPKhVYDfE89UIrtZ+2eLgliellHayrWXZLLaP7WH8BDlNFXK37Qj4rKe/t8jbInAj2kEwhP0vQN1g+NxBixrKnigccfx2joSTsXLOL4Tvn0/uQPzZsReS560d8ad4bey7pg+GUzfcxfZxV+JIPaYtkN3gCEqpYXwMLwdo6yPpvwxSseCk0NgdujQobUNMLsbb6sSVQR1Zs3nRezAXJ9o7XTlCGqhPgEdSqN4UIGc4vQ1mOKg0Ni6m2HNC9Ac8gZ1pvcKNy1qT6by2eq+D7uRLXvh5rKsGLPEkRqsnaaMQNDwS617Ts4/gfmUisnSvxOgcveIzbMbusmrFIk4QFHaG6wQlxjh1Iy96DjLh9kbJ2FpZF8oT5i7s8aewMgOsPyGEvIQ8D0gZxcNZO9EskXLbFQ5aHKMCNlqwvKHpasCwjfYocIFftGWk3tSSnG0vaH9HEbBQ+oBT2vYC35+BxuHKMM9uyj+2895leGVnGrPkxXxvKRbgwAtAen+jXKVZitOR2UMoWARN0jL8swYDa6cN/kunvZIz2fZ8xUnK+4mnoQN2CuXrmLzbFVDTfe2U2tPeufH+AFIQzWlken5le6Q+kUeCKnRL5ro2wQxOMSZXHT2ZqvuB4F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(11063799003)(56012099003)(22082099003)(18002099003)(4143699003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RNOFZKZXFvT2VXamRLMm5uWGNHSDB2U2hNNUllTUVLc2VscUFXQWNVVW50?=
 =?utf-8?B?djJwdEZkRml4cjNiaVlZQS9mVHBoOEYwOWFSNU1WdFBWU3lnTjZvb1ZMbFBq?=
 =?utf-8?B?QmpHVHhOSXIvSjB5eHpBb0lKK1Y2dW9maGR5eWVLRGU1cENnZ2JPNDJIa1ZP?=
 =?utf-8?B?bXpGemZsb3pGaDMxWHNvQ3IxU0hpNmhuektMa2psMmo0LzcwRjdsY0RxMzJS?=
 =?utf-8?B?TmorR3lRRktpbHlDYXl2UTBKTkRTSmx2Y3lxSW9SY0VWQVg3TWRQM1VFNWJl?=
 =?utf-8?B?bkhFdXg2UkdORkE4MjZvRlhpZWlwMG96WXlvakVaYWtBOVJwclNFeWxGMVYr?=
 =?utf-8?B?VkV6MTN1RWlTdjV3R1Rnd24reHl0Mnl2YTV0MEpkWEJqeDRtNUxneFc4c3NC?=
 =?utf-8?B?eERTM1BGajNxMFIwenhyNGRqbUlEODJrclMxSVVWdUFqbDNobE5wMHoxS1M5?=
 =?utf-8?B?aGI5bGJqM2xpZ3o3L2tJREwrWGU4WVNGWC9qc0tGYW1SQnRwVmQ1WmxBaHVP?=
 =?utf-8?B?RkhxV096Vno3NEZSd1Q2enNDSGJaUXZCN2hkTkJQVmk5OHpjZ2Zhd2wxVDRJ?=
 =?utf-8?B?c285WGFlWFB6WTRmbmZZRDF4VC96RVpOL015dFowdVU4Nmt2dC9TY2dyNUdK?=
 =?utf-8?B?SldPZTg3cFpnak03L0syWHZ4QWFZMHlzQldLdm9iNkwrRy9IYlFCZEg3eERW?=
 =?utf-8?B?aUpVTEtrdHMwRzQya2dOdk11Um1yZlh5VUdSeE03TGlDVzM4MEx3b2F0dmFK?=
 =?utf-8?B?KzU5dWRJV2VxVmhOSUkwUUNZNVAzRVFTVzZuZGIxSUw4VVc5c1BGMUZmc2wv?=
 =?utf-8?B?T0VjbkFMVEwvYjNxWWwwRHZocjZNM2pYTFc0dFQ1N0hPbFEvV2k1L3RMd0k2?=
 =?utf-8?B?cjBrOFNnY2FnVE1wUjF4dnpoM0JxR0pPajVFVVl4TmVCZ081dEtKL0RDVnEx?=
 =?utf-8?B?by9PMG4yRjdEemxkWE5JWHZyeVdTQmt3QXZ2bityTytOdFI0Yng1blYrOVZx?=
 =?utf-8?B?ZXMwa1hHeWloSitObEZtQXBCSzN3UjQzQ29LYXpkZmZweXFKK2xueTdaMnN2?=
 =?utf-8?B?VXBydWh6SVMyK0tLbXpUN2Z6Y2VERktlYzZNNTFyMDFQM2M3ZnlDQVNMVi9K?=
 =?utf-8?B?a0pXcDRqdmEyQmMwd1Vjbmthdnk3Sk5Iby9OV0RDVG1WaFk3UkkyOXJzK3Jv?=
 =?utf-8?B?ZlNwWmptRitpbE1tb3lqYTRJUGpTK3hZdithVDNmWVNMNkx1N2E2MVYvTFdw?=
 =?utf-8?B?Zk1USHBkVVZVSi83L2JXT1k2eGdEeXZTcS9RVGptZ1pmUHFrejdSYW1lUWQv?=
 =?utf-8?B?RDhjVFRTc1NKZkg0R05WZTNJZzErRW5leGxvQm55ZTh6eHE1L3FxYUUxZ3ly?=
 =?utf-8?B?RSt5SDZ6K1I4M2EzeGsrcmduLy8zQ3pYajZnc3cwSW9rckIveFJYdGNGeEV4?=
 =?utf-8?B?dXZ1bjQzSXJaQkZ6UkVnak5LTHZOVDduK3I3b2pHSC9lTE83ZS95Y1REeDNz?=
 =?utf-8?B?a2E5WHZZK1cycytOTlMvYkNoLzR6OVhWclR4Slp3YVNIVGQvdDVCUmRiNTNR?=
 =?utf-8?B?N1RHL2VWNGx3UFBLcDRvcC9Edk9pYkdZZmZQbWxic2NLOXRicllQM0JPZ0Zh?=
 =?utf-8?B?QWs5NjZrQldMWmh6dTZjKzNKNmFqcU8ya0FneU1jYklmYUV4em5ZQmJzdU9S?=
 =?utf-8?B?K3FnRnd1Y1RhZWovdTNXR2FrMFVDUGRsZXFsOEZmelpoZm9BdUdSSlgwaGpu?=
 =?utf-8?B?SnhUaklRMDVGM1BwbE5oa0dFeEowTWt0WFc1MXQ1Z0x2eU1EQktkWTdod3k1?=
 =?utf-8?B?RHdnbmpBTEEveEFYanpIL1Nydnc1RFBTem5CTFp1SkhydlJ5VktXNjExRWFU?=
 =?utf-8?B?OEM2TVJzQnZML3RvTlRsMGJRNjhRcVZyUVVwNEdRSmZweis5TnprUGt2T0xZ?=
 =?utf-8?B?OU9hUjZRMzc2MTRNSDlJaTVaMWR0YUUxWWQrVnNRZlB5V2NlYlRwbU84VXFT?=
 =?utf-8?B?b1hUWGtBNm4ySEJZeHlkb1J2djBmRk9CWjM5d0hTamRXNmtMU2s0S1J1M3V2?=
 =?utf-8?B?c3FNU2szWEQ4SVh4UGtNaisvTkVmRU9KaS9nS3hIaWEvYkkyUm5VWHIyRnMw?=
 =?utf-8?B?NjJYZnp0SHVlMXNYUndpWHFQR3lWbGVaQ0hyUTMvQmlTU1REYmZSb3Jkc3Az?=
 =?utf-8?B?aDZubTNWZzJXTTV5WVp3bFBMb0VUaHQvekUvRWlRamdYRnNUcVphMzVtNXIy?=
 =?utf-8?B?QzNsVU9Ec0hxNUd6SjF3dkRIZExFeGRWUGM5eWRPRW12YmVkQXZTVkdnUEdR?=
 =?utf-8?B?RU9YeTNreEdLZjZncGxnT2RTeVFFRStaZEkrVGpONkJSRlUraGJmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4cf575-1ece-4bb1-e982-08deb5086aee
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:08:09.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM+N+9JcyIfcLvoc5ym6PsgNUpxqxW7U3fs80hdrUdyPy1hEEPV5Xu3HgMUMx47WwEtb+6Th3daGfKD64Q/KGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769



On 5/18/26 12:22, Sumit Gupta wrote:
> 
> On 18/05/26 19:51, Mario Limonciello wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/18/26 09:15, Sumit Gupta wrote:
>>>
>>> On 18/05/26 19:20, Mario Limonciello wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 5/18/26 08:44, Sumit Gupta wrote:
>>>>> Hi Mario,
>>>>>
>>>>>
>>>>> On 16/05/26 02:43, Mario Limonciello wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On 5/15/26 07:26, Sumit Gupta wrote:
>>>>>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>>>>> CPPC autonomous performance selection on all CPUs at system startup.
>>>>>>> When autonomous mode is enabled, the hardware automatically adjusts
>>>>>>> CPU performance based on workload demands using Energy Performance
>>>>>>> Preference (EPP) hints.
>>>>>>>
>>>>>>> When the parameter is set:
>>>>>>> - Configure all CPUs for autonomous operation on first init
>>>>>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>>>>>> - Initialize desired_perf to max_perf as a starting hint
>>>>>>> - Hardware controls frequency instead of the OS governor
>>>>>>> - EPP behavior depends on parameter value:
>>>>>>>    - performance (or 1): override EPP to performance preference 
>>>>>>> (0x0)
>>>>>>>    - default_epp (or 2): preserve EPP value programmed by BIOS/
>>>>>>> firmware
>>>>>>>
>>>>>>> The boot parameter is applied only during first policy 
>>>>>>> initialization.
>>>>>>> Skip applying it on CPU hotplug to preserve runtime sysfs
>>>>>>> configuration.
>>>>>>>
>>>>>>> This patch depends on patch series [1] ("cpufreq: Set policy->min 
>>>>>>> and
>>>>>>> max as real QoS constraints") so that the policy->min/max set in
>>>>>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>>>>>> during init.
>>>>>>>
>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>>> ---
>>>>>>> [1] https://lore.kernel.org/lkml/20260511135538.522653-1-
>>>>>>> pierre.gondois@arm.com/
>>>>>>> ---
>>>>>>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>>>>>>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++
>>>>>>> ++++-
>>>>>>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/
>>>>>>> Documentation/admin-guide/kernel-parameters.txt
>>>>>>> index 0eb64aab3685..7e4b3a8fd76f 100644
>>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>>>>>>                       policy to use. This governor must be 
>>>>>>> registered
>>>>>>> in the
>>>>>>>                       kernel before the cpufreq driver probes.
>>>>>>>
>>>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>>>>> performance
>>>>>>> +                     selection. When enabled, hardware 
>>>>>>> automatically
>>>>>>> adjusts
>>>>>>> +                     CPU frequency on all CPUs based on workload
>>>>>>> demands.
>>>>>>> +                     In Autonomous mode, Energy Performance
>>>>>>> Preference (EPP)
>>>>>>> +                     hints guide hardware toward performance (0x0)
>>>>>>> or energy
>>>>>>> +                     efficiency (0xff).
>>>>>>> +                     Requires ACPI CPPC autonomous selection 
>>>>>>> register
>>>>>>> +                     support.
>>>>>>> +                     Accepts:
>>>>>>> +                       performance, 1: enable auto_sel + set EPP to
>>>>>>> +                                       performance (0x0)
>>>>>>> +                       default_epp, 2: enable auto_sel, preserve 
>>>>>>> EPP
>>>>>>> value
>>>>>>> +                                       programmed by BIOS/firmware
>>>>>>> +                     Unset: cpufreq governors are used (auto_sel
>>>>>>> disabled).
>>>>>>
>>>>>> Rather than unset doing nothing, have you considered having it take a
>>>>>> midpoint like 128?  That's what we do in amd-pstate (default to
>>>>>> balance_performance).  I think it turns into a reasonable balance.
>>>>>
>>>>> Thanks for the suggestion.
>>>>> I can add balance_performance that enables auto_sel with EPP=128 in 
>>>>> v4.
>>>>>
>>>>> On changing the driver default (no param behavior) to auto enable
>>>>> balance_performance, it would be good to keep the current behavior for
>>>>> now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
>>>>> EPP and Autonomous Selection registers are optional.
>>>>> A default change would affect existing users relying on governors.
>>>>>
>>>>> Thank you,
>>>>> Sumit Gupta
>>>>
>>>> But couldn't you make the "no module parameter set" follow the behavior
>>>> to only set the registers if they're available?
>>>>
>>>> So the systems that support it start using it, the ones that don't it's
>>>> a NOP.
>>>>
>>>
>>> Would it work to add balance_performance as a new mode in v4,
>>> and discuss changing the default separately as a follow-up?
>>>
>>
>> Sure.
>>
>>> Runtime detection helps for unsupported platforms. But platforms which
>>> support the registers use OS governors today, and silently switching
>>> them to autonomous mode on a kernel update is a behavior change for
>>> existing users. They would also have no way to boot into sw governor.
>>>
>>
>> But hopefully it should be better battery life/responsiveness for those
>> scenarios too, right?
>>
> 
> Yes in many cases, but if some workloads rely on specific OS governor
> configurations, then that would get impacted.
> I will send a separate change later to seek broader consensus on
> enabling auto_sel as default without any param.
> 

I suppose another option is to have a Kconfig to decide at compile time 
whether to turn on autonomous mode by default, so systems can avoid 
moving to this if they don't want to.

