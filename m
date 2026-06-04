Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6023507C;
	Thu,  4 Jun 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598622; cv=fail; b=j05Dkm3XaA2DaFXToMqkQJm3dmGPssbVuJUIEzvSW8fTAgElUjAhCgqSA2fD0d+DULXzv+wvjNIfykc8UzjZNa/94wtcFFrbucGtP14DQ60HZ0sUyJfc+2MK7yGfKWAd50k5VuoTovcutHEIzV5x3e2w3FOSS+V9u5/DikdAgfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598622; c=relaxed/simple;
	bh=ni382DyGVNGc0wjWtGlG9C1JyOiyqje1KnD+/woT1eA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2VodVeXYybAzB+soZTYR8fo1y2QEpt6NND6RiKpVB7FWlWN7GHo/qoAlaNI6CnpjezChY5CEQXh5FIOTWL1Ut1Ynm+CCCKFMI+DmN8FXm5GnuO9lsi0a+n4opiTweidCt4G5Ivi4wWloc/CAkRjzoci/1VekK5ae5LEBTTtFQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVjXZBv/; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVjXZBv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTfNNmtUJHkd82cDwwYMu3Pej6FK8mfKWXG0dXsJirXwUwVZK9nfDOLvfz+asLbbevmIrsmCUv6C+Vwg3M0S5evLPmCcFNiY6L3E8uASyGU1nujIY8LRS8L2zEU89UMjJS22uWUWiIOULI8xTAWC7MCqq25gw7Y8L+VVLdF04/l6LyOlIruQlLJwfUsunOA/gy0WtX0T5VLouj2xy5TXPPSPQnmKvn6Rpz9XRyDz1Rf3A3PnXYNM1AzB00Tjbtfg1FnmDp971QpifGhRltAKkEKXq7yJnENtRF1tQPop2eOajfXt9ZiBgWc63i0jBmArASBqtiaDtd5HbagXGc11Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATY48Y7oWjpOTIqA+UhRQGpjm/qt2KIBhp0bEdkGklk=;
 b=BX8BbYFmQo1YDu3B8uAJmHXbe54XDHpGRh4uzAcz2Usy4d9yEy0HPGQ+g7KMOYkaTEWiPWgLW/fKq9fk4DF36PWsxBxwNFMtIAclF4ir49frUV+cAFPFHj4NALmvXK8QicBhjg9I3YF9MZkBZ13bZaSWOlvx2HqmMTh1qqVjm0baLuwHIeKAvyey1Oku/LKNcMhUeHRV+GOtHSnBkBVD3yJrsIMXPqgOzwGgABhS0k0wI8wbt/BHsxCJsKyk1dKuA+/ioF04CSiK134fg+b4MHSx4JnXH5C6MPMldGv0CDsRaXqUIUlaL+5XFSKOagApwHBaeplG+/5cqOHPLOWgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATY48Y7oWjpOTIqA+UhRQGpjm/qt2KIBhp0bEdkGklk=;
 b=aVjXZBv/zRmGt79VXAe83bZD/h28+pBvgKR8x4YYRVLFbO0UqIZL/UyTeiSMunoE0AHzTkAL1XC2Nr4uyadXW+8wFuyEa4YzB4up9L+fpQrYNj/ydrs8heI8ntZEVx1+nM3EL6gYv+G7X28YU2YuM5csqI2jDfeDUFSn4y2KZms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 18:43:36 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 18:43:35 +0000
Message-ID: <cb4d800a-f5e4-4207-a36a-fde42d0a006f@amd.com>
Date: Thu, 4 Jun 2026 13:43:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
Content-Language: en-US
To: Marco Scardovi <scardracs@disroot.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
 <b4e23498-492a-40b2-8517-6d44eaec8502@amd.com>
 <CO-q9BQiTf6GLfZiYh_W4g@disroot.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CO-q9BQiTf6GLfZiYh_W4g@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e66327-f2db-40fd-d5f6-08dec2692f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	UqgSX3spVfIcExQgyj2So2wAavntbjgMEZ1zE3QE0MXe1qGJ71T3tN7iAczFPOcupiMbp/RuQ5bE84u0katikYOMmoFf35fw9JoD9b6Cr0XR2p4YDhf3W7hwDOVALgAeDTolro9zV0AJqGftxWVa6daIxGkwxA2pZBwlLxzxs5skI4xcMEzWunhsNZBIE+VBjFK34QYcrgJ6uy8WoNA73XRBZ/MAecDdwDwBIC5GWAtWZ+Vg5alkMNjQFpoTKOaKO9AzHoLNKHUj0lDlYHBVNSgBfzavZGjpMhYI6qO0RjrFUa1eKNvGw6ggRj07Jka8zVeRaSLOl0SrD1CN/UQqqx6SXC2Zi5OliqpJQRV7w2Rkvad2KFUgrqC4KTlMfzqif382QioLDMqyUSu1KqPx85yctDcjSgLlAAsXslgm9iyxtgIxyrpNeCQIyMfjkj6Ueb5LzW2PaODNUHCwWsJfR1fE0oBoSbEkr5x9de0VA5HiIrUCwr3ZZHcYt3yHA6BUj2pC+vn63dA40g20oKTxOHIyC4hNzRvyk/07xV1HIz99dfy1EtWrPkR/Y08D4V+e+MG9n0+Q6nFefL3/Kia6BHZ3hmeVbMd/WHitHtInrAq/JX6XOc5bHiY+Gyebvlu7VzQAZbyaQ0PEeXJr3K1haYjmQs4/BxEUNMbbxWXFoAu4MAc2LzA04ReTmNn9tGg0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRrenBGWjFWU1FrdmxLWTU1V2d5RWMya1ZkSjl3YjZJM1Q4RUo0Sm1mOGVO?=
 =?utf-8?B?WTcxN3F0TEtwS3BFOHZsZVZDQW5CQms2cUpNanVUUFJyN3h2Z3pSbk1wVjhl?=
 =?utf-8?B?dDJRVWJOdWhXNy9DQXVVbDRMZWtOaFF0bjBNeUt6c25NMVFoUUt3OUVIc3NC?=
 =?utf-8?B?TVo5NWhqSGY3VEVLeGlRMWNQR1VKcll6WFE4dzhxQ0k2MGxPcURNdGdmak56?=
 =?utf-8?B?VEpKK29qa3B2NzRuVWFVUnJ1OTVUSmtWVXRZQzZrSVgxSnA1ZEpsWTlTZFNp?=
 =?utf-8?B?cXlxaHViYmExZ3hRbkZ2TExoaVhLOG5xL2pFRncvaTc5S2JINGVKb2hGZ1N4?=
 =?utf-8?B?VGkwa1F3b0xQVGNIYS9KTm9lN3d6Y2h5dkZsU0RDd3l0Y3JEMU9WOXcyeFNP?=
 =?utf-8?B?c0xtNTV3R09xUSt1UU5CcURjajEyL3B1anREeEh6Nk9pWFl6R3ZhZmF3YVgz?=
 =?utf-8?B?d0RWUGNGbGVwY21TcEhqZnYwVW9hbnhEZmZyVmZtZ1kxNjhpQkxMcnlTeDhT?=
 =?utf-8?B?Q216dTl4eWgzak1Mek5kOE1jb3N2OHFNdTlwbHJZVXlsTWVaaEFMcTBpbUE3?=
 =?utf-8?B?Q09lQlFnOGhHVFcvQUxoc3djUlVrV1psK3VpWUtQRGVEdi9GZ0VJUHNVdnZ3?=
 =?utf-8?B?N1dMMXUzdXgxM1V1M0pNM2FyK3JLMzNJUXUwamR2THFFT1RvTUZnZFZyNk9n?=
 =?utf-8?B?c3BwWjZJUEMvbHMycnIvL3Q3YlBrSWh3YzdLYXlkNEtoRGs2cmhubUxVZ3p6?=
 =?utf-8?B?SW05K3dTZlhHbUNycjRhT1R1V0hOQy9SV0RBSE5ybER3dTJraFg1bVhNVlFa?=
 =?utf-8?B?dm0wYW9NV3RPdWpIRFdod3Y5Q3kzV2J3bU9INVpkbmtVMW5Qb3Q5SmczTGoz?=
 =?utf-8?B?TGxESWVrNm1FL2Q2RDZNREZpOWdwZFk2aEtWdStvR2hTZ1BQQkZBNmpOVkFz?=
 =?utf-8?B?RkQ0SUZKd1ovUW11SWhjZXlJUXBHTEM2eHBmUG8rQW9QVW9KZWM4Vlh1YWQw?=
 =?utf-8?B?YUk1cmhGQTRVL0xOdXMvMlRXOGNFWDlZbkNtS1RBUFFwcjc3TWYxL0d5azlT?=
 =?utf-8?B?R0l6ZzEyR0U2Q3FSbDBFRzVHTVJxNUJDNFEvUHl2cThleUVBS1NWOWZoTG1D?=
 =?utf-8?B?cTNMN05WNmkvbTB3UFI4S3JoSS8zOGFhMkptUm4zem1NKzZINVJPNnlwWXR5?=
 =?utf-8?B?ejZ3eUxSb0dJaVplYU45cldXTDhYRVp4VFpNZEJmRkx6MndPcE5SQk1sTE0v?=
 =?utf-8?B?OEpqbzVHVjEyOXhDb0RpU1FJbkliMFlnckNLOUZYM0ZaYTllcU4zZnJVNGlR?=
 =?utf-8?B?bEVRclY3SVpxUmZlSllLRVlVYUlUQnNrSXFZMlpEYWVJUjJrTVN2dlB2VWpy?=
 =?utf-8?B?RHhsdlluWXRLZjRva05XeUcrb2pkam1OV1hkQlpTSFFLdTVmSklERlA2M0tX?=
 =?utf-8?B?aDhyeFhhZzdvOXFuS0FUMDNvZW9sQmNEdFdkdDI2WVFWeldpeFErNkpTQk9r?=
 =?utf-8?B?UHA3cWROVUJ6S3F0ZVFmNnV4SHN6WXJsOHZKb1BzUUorcWdiTzl4SHUxeG12?=
 =?utf-8?B?WFVEZ3Y3bEROaG12Q1NLZlppK2x3dXZ4bjNoem93aittcHc5QWxJcTlKdlEv?=
 =?utf-8?B?WUhielBNWXRHZ2pyWkdMOHFONXhDYkJjbFFmWVg4amFBQzBhaGhNY2FmY0R1?=
 =?utf-8?B?QVJXM1dzcEdSbG5BeE1qWjBGRUx6OUxIU0lxQjcxL3Q3V28yYklrclIvZDFL?=
 =?utf-8?B?TGJBMkxzSDcxblUwaEgxeUJwQnVYYk1qVW42S1RWMlpQQ3ppR2tnNHhFNTNF?=
 =?utf-8?B?amQra2Y3eUR2cnkyQUh2WHdGazNmMkhpTm9LSHV0RGZoWlQxUC93V0NsUVFs?=
 =?utf-8?B?SVg2a3dUbklTM1JiZVp3aHNlRXl5ejdZdWJOOWIvYW9WbWN3a3JKQUpYcnlM?=
 =?utf-8?B?THFFRlFEODMzMkxJcDREWS96RjNLeDBSOFhKYkVoSDU3M3lRRkxENGp1NkZt?=
 =?utf-8?B?VmVuTElRbnFNZFovSFRRQndhUEJZdTlqWkk4NnY2Zy9SQm5GMGRuMGtLSkxK?=
 =?utf-8?B?cWdJMUFJN09qZjMySWNwVjI0b1NqczlsemZndEZUUUxTaEZ6VEd2aW5HaGVI?=
 =?utf-8?B?TkhzcStYWmxaMXR1cjdMNTR6N09nZmlxcy9UbURnamZyRFNGck5tK2Ewc255?=
 =?utf-8?B?cmpRTnZGbDlvRG5MTTROdlZXeFNzOG9TNXBON3k4bEp2UWY0cWMwYTNWK2t3?=
 =?utf-8?B?SDdueVdlc2U1T1FOTmRPemMwbUsvZ0RCU1JoV0Z0c0ZMcDVyVy9sYlBmME9V?=
 =?utf-8?B?YlJqTFN0UWlsVGhYL2srRWRWOTY5Z1lHZjArUlFiMSs2TGtCOXArdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e66327-f2db-40fd-d5f6-08dec2692f74
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:43:35.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcyw85nGG0VaFTK0bU5yFMGFlIlE7cNY2OeInlFzLE1Z5g9t9h1VCDxewUp5LJNBuoU9ah2gHdU6hOF2T7MzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457



On 6/4/26 01:56, Marco Scardovi wrote:
> In data giovedì 4 giugno 2026 05:56:20 Ora legale dell’Europa centrale, K
> Prateek Nayak ha scritto:
>> Hello Mario,
>>
>> On 6/4/2026 12:23 AM, Mario Limonciello wrote:
>>>> --- a/drivers/cpufreq/amd-pstate.h
>>>> +++ b/drivers/cpufreq/amd-pstate.h
>>>> @@ -128,6 +128,8 @@ struct amd_cpudata {
>>>>        u8    epp_default_dc;
>>>>        bool    dynamic_epp;
>>>>        bool    raw_epp;
>>>> +    /* Indicates that EPP has been successfully programmed at least once
>>>> since boot. */ +    bool    epp_hw_programmed;
>>>>        struct notifier_block power_nb;
>>>>          /* platform profile */
>>>
>>> I'm having a hard time following why this is needed.  Let me explain my
>>> chain of thought.
>>>
>>> We start at amd_pstate_epp_cpu_init().
>>> * cpudata (and thus cppc_req_cached) is initalized to 0 via kzalloc()
>>>     - On a server we initialize "epp_default" via a lookup to the HW
>>> (amd_pstate_get_epp). - On a non-server we initialize "epp_default" to
>>> 0x80.
>>> * we call amd_pstate_set_epp() with epp_deafult as the argument.
>>>
>>> Now in the shared mem backend (shmem_set_epp) we do a lookup of epp_cached
>>> and it should be 0.  We do a comparison of the argument sent to the
>>> function, and this should be 0x80.
>>>
>>> So how do we get into a case that amd_pstate_set_epp() is actually called
>>> with 0?
>> This was the path I traced yesterday considering amd_dynamic_epp enabled for
>> a shared memory system that is plugged into the wall:
>>
>>    amd_pstate_epp_cpu_init()
>>      cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
>>      cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>>      cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>>
>>      /* cpudata->cppc_req_cached has epp_cached as 0 */
>>
>>      amd_pstate_set_dynamic_epp(policy)
>>        epp = amd_pstate_get_balanced_epp(policy); /* returns
>> cpudata->epp_default_ac which is EPP_PERFORMANCE */
>>
>>        amd_pstate_set_epp(policy, epp /* AMD_CPPC_EPP_PERFORMANCE */)
>>          if (epp == epp_cached)
>>            return;
>>
>>          /*
>>           * Skips cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1)
>>           * where the last argument "enable" enables EPP via the
>>           * AUTO_SEL_ENABLE path.
>>           */
>>
>>> There are some trace points specifically for this purpose - you could
>>> confirm there really is such a call by using them at bootup (or by
>>> starting in passive and with a mode change to active at runtime).
>> It should show up in the traces yes!
>>
>>> Then we call amd_pstate_set_epp() with that epp_default value.
>>
>> I think this patch has some merit, although the second patch, I'm not
>> too sure of. After some digging, it seems we always had AUTO_SEL_ENABLE
>> and ENERGY_PERF right from the time CPPC was introduced (including Zen1
>> systems that had CPPC support).
>>
>> Marco, do you have actually have a system that neither has
>> AUTO_SEL_ENABLE, nor ENERGY_PERF? Seems very unlikely a configuration
>> like that made it out.
> 
> Hi Prateek, Mario,
> 
> No, I don't have a system lacking AUTO_SEL_ENABLE or ENERGY_PERF support.
> The only AMD system I currently have access to is an 8940HX.
> 
> I think I understand the reasoning behind both of your comments. My
> understanding is that the main question is whether there is a real boot path
> where amd_pstate_set_epp() returns early before EPP has ever been programmed
> in hardware, which would justify tracking that state separately from the
> cached EPP value.
> 
> However, I'm not familiar enough with this part of the driver to confidently
> turn that reasoning into a correct implementation, so I'd prefer to defer to
> your judgement on whether the additional state tracking is the right approach.
> 
> Thanks,
> Marco
> 
> 
> 

So at least for patch 1 if you run dynamic epp, and are plugged into a 
wall you start out on EPP 0, but I'm pretty sure that's usually the 
firmware default anyway.  But this gives me a (better?) idea.  How about 
we just read the EPP from the firmware initially at startup?

Something like this:

╰─❯ git diff
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3f06e33f47120..0e32f7f92651b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1939,6 +1939,8 @@ static int amd_pstate_epp_cpu_init(struct 
cpufreq_policy *policy)

         policy->boost_supported = READ_ONCE(cpudata->boost_supported);

+       WRITE_ONCE(cpudata->cppc_req_cached, 
FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, amd_pstate_get_epp(cpudata)));
+
         /*
          * Set the policy to provide a valid fallback value in case
          * the default cpufreq governor is neither powersave nor 
performance.

