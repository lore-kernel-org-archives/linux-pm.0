Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93322332621;
	Mon,  8 Jun 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934811; cv=fail; b=F7UIHe2JJG1gQEko/48txOv5qqkICZD8pzZRAFwAzlh9SOXkE0UUMQRJvjSaWajZobjdwDlwtwwChF5z2ZWsRMMHEVii6G+XEsD2Ueo+aHZZIeQzO2cIM1/DRrQrESxeLP8H76cukEBg8tXDeMNk7CedfwbavXRu5yJ+PUGNkF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934811; c=relaxed/simple;
	bh=113dHhwhr16AhSnqzmjq3eOOX5vS66bmPK5vN+km4z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtHLGhc9MaNd75uR+AyXJ/Sgk2SLMM+2NNlwx01D4257gnETrsbeV3N1dISURCwP/5tGNDbWKXfQxVjWQrmOZhOwvWYiK3CoDw0B5o9bqLL4UH9zBmL/BeaORa7ASlUtiPpT2DpFsucEpPWkyOSybgHj5bIwbMBVblB9MjawcZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZ9ZJzAE; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZ9ZJzAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU0jlQ/VQO583yyIJvgj6S4fzEEPBFeVLteug7HNRKA+Bg/WBXGQwpi6L3K/XC7XuMOmH8aabD2NQ8aXcisomLJEf6WksY6hkOvX00bDCL1z92/b/tkdIgpwNCy9EbBs9B78ocTdIWTOtT77ysEBUigc/Fb/xSsuDb65vzMQJB/WjnVwLSzIn5hvfcjZ2QahX+8euguKzsiXAxfyJ/ufqtsPlJ/BROv6DIFNUY+B7VoHIpXiz13kX+9WXsqfn2qfElRP2j4vPoqo/qKpFUFwIhKisoe2GY8nersxlP+w+386MWgKhoAGXFvq1d6l2jD19SB0f94QxCFCxM9PS2w1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz3FpI7S1LENDqzqCCc4CMi6tqFzqXwUTtn1OZXM2ug=;
 b=GE0VCF5av01ld2Vc8cgCqxNbz/PYC+47VYoex+J6DOxMN+u3CLs7EnzqZcA+E3VRWywhFrIEodu1EkH7eUYLBPsazcpuF2/v7RFp67n/zY+BY+xoHgPxgp0crQTs7c2Rc+c2YCsWpjcU//oxMiz3m+m2qW9yXodv8kL0pPnVst6V9UdprMHwUWGa3jsU72UAGC5vYR3WThgpM6acjv+m7aVHEeRQG4ql3sekMaBBUVFusE2GmL81j+VrpYyhBoyy4bmHVqt/vqn1qOH9rm8Gb3ze6c7TzAOL3dXQIvwCQ92sC645HDrdrqIQ6lBI2zdzv6NUZlk6kdMsvYarq7EA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz3FpI7S1LENDqzqCCc4CMi6tqFzqXwUTtn1OZXM2ug=;
 b=HZ9ZJzAELNe0YVLmbOZrlAaYYatncl4m18rAxiVBCgcd5zDQTG8E9CWEP37tNmdbzxpjQKe7f/tMR/sppNJfGGITJDkAJITzAuphORy+QP5iUJNIGllFNNyi58Bwbqr49M/FcF51W60uvhno7ldG42+eXFKwII6c78/RdHgPLOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 16:06:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:06:44 +0000
Message-ID: <c64935f5-596d-4877-9968-88b375996111@amd.com>
Date: Mon, 8 Jun 2026 11:06:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Marco Scardovi <scardracs@disroot.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
References: <20260605103131.88711-1-scardracs@disroot.org>
 <20260606065756.4442-1-scardracs@disroot.org>
 <20260606065756.4442-2-scardracs@disroot.org>
 <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 701e3aae-e6e3-4713-6b94-08dec577ef84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CBWK6mvXCp/hQFvqKp+MJ7fHbKoUrU4KsR5W4DFoMkUcRwIks2cHHr5R3x+ends2mxcYQwITAngg94Ntfu7nXecMNHu1s0EsPcZU6AhP5WU2izl5nWLS93hOUdxiiJqs/b8PL3oh1HzIPRjLPBJwza5lEFX8W72CdE6+tEXSk5mfxP2EbVS/oFokWlYY0yk8wKw/ojkbIFD2Rjhb/6YchyNWowwfJqcfwmOyaS69o++hRrpm+ybfsCvHvyk352gasPPEIpcJe5qlKKo85OEUWo66TtKY+8AhbYILH6j9ybjMatwzS2c+Vg5o4wxZU2nO3X9cKEfVZKrSDEb82W/mv1qp2z99UJn1qyc0bn6CRytmnBh5/QhTJqklbne8lIK+vaJ+hcYb0lln3GLzPnPetG2xTtTMk0PpzI2StGKca9vP8fGZe402nb6+me03PW9smS7D+PTHOFN0wt2exzjtravVJ1z2eFvgzZyplPQZZX8jNUz+UOOy4DcwZudUdDFpD+A82sz6Qsqz2jf23Zu2qeQOQt+AhN/f7dZ3pIQ5T6uzGSamaLys4m4kgFMrcAHt4T9ouwpNXS/ecs/Y/3e3OS7/3uA5SHzlgafsntITF4C6htOoQQ9tLj1xZbH3/9tQ9ty5BgfSp1JE2HvwnfUF/FFNylY21LWGgXVuqTWUlu739Dr4ThWbdT9A+WS4BnDd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1RyRis0L1lxTXpnOTE4NUQ3aEhIcjVSbXRkaUxNV0MrYTlYdWFwREVuclVr?=
 =?utf-8?B?M29VZ1NiNlFGUXVhUHkwZ1ZaTWV5OE1qc1Q4cW5tbFZZYlUveFhFV0RSOExS?=
 =?utf-8?B?eWl1MFFSSWxnR1kxQTcvYkV0QU1haEVueHJRNEhkVXJFMlNsV2NadnBDcnV3?=
 =?utf-8?B?TTNkdTJvb2ZndEtDVi93TlloQUZqb29oQkpJTXBtM1ZTdUg0VFJOdmNFcDNr?=
 =?utf-8?B?S0pCQlU0dDlobzRQUE1CdnFQZFIva0JmZ2N2U01hL3VEWGhHdnkvTURodHAv?=
 =?utf-8?B?djZvTWlscDY5U3hOVlNwTElVcWtFL2E2ZnhvSEh4UWNVRFlxMzBOWTJjemd0?=
 =?utf-8?B?NXFjWjFVWngyVExJWVdWellGcWsrNkFDZWRLOWcyaGg4MTdBZkxoMEgwVUtX?=
 =?utf-8?B?cmV3M0lRdWhoMTVSa05yRHZYaWlpRlhzNi9mSUJTbU8xRm4yNFkwcmtCZVBZ?=
 =?utf-8?B?eFhWd3REY3JIQ0Y1WGFTR3BJVnlPbWtyY3kxQmtDSUhVa0FCbTdmZkR0cytM?=
 =?utf-8?B?bWptcGhUc2h4REhmMlBINk1WeUh3RDgxclMrQVFmanpKUWp1akdvOHU5SzlW?=
 =?utf-8?B?N0V5R0J4c3pId3BnT2N1ZVdVMllaemdBeS83WWl5cUgvbjdhdVZ3bUxZZGtW?=
 =?utf-8?B?UGNmSEhIb3ZkZ3FST044clk0Rm5sOXdtSlVrc2ZxL0RqK0hnRGZUQ1k0RXlG?=
 =?utf-8?B?Ni9VMXFWd0FLek9RZjJORzBsaDRPb1FiUVNyQXZXODd6K0toeTdHOXBVcmoz?=
 =?utf-8?B?T2V6dVFNM3Jmdll1YWNzalE2a0dINDh6dE9HemxvWDdtaGRiekJMeEhRNXFW?=
 =?utf-8?B?Q2xpbjlxSWFIL2NMekE0VkpLT3BXUnNGWWhJczFmaHJpUXRSMno2QzJZNkUr?=
 =?utf-8?B?RHQ4SHZ1dGd6M25BT3E0MUVtcHAwa3FWc0pnL2Y4QlIzNjU0V01JUDJaM094?=
 =?utf-8?B?MU14c3IyNkZ4NFBENU43UzgxUnNyR29xQlRUWUFpVXk5K2Noc0dqSUtRNHhz?=
 =?utf-8?B?eCtEdTZQcGRjWTVFWFVHbnlMamYxK1hCOFp2VWRURXIyeUNUam1NMTdBTlFQ?=
 =?utf-8?B?M2hHanB4VFNyNEZPM1AxRWFVaEJKVjJoR1dUOTRjTjV4dVhCbnA0RlVocENy?=
 =?utf-8?B?OEM5WkdsVC9VV2NKdzBuUk9LV3NYWGFLWWJmQkdZS2tNbWhjMFJEM3VvZTdv?=
 =?utf-8?B?QnBDVjBiRm9jWEFpRnFIRFFWZEdCMlA5QnlPazB1QjZvT0c1Wk1seFhic1Ni?=
 =?utf-8?B?am5PajRwRTBudlQwYm92UFNsUnFkbUc4Z0wydDBBWUl6NTlDdXZ0UStBNXls?=
 =?utf-8?B?QS9TdlIrMGlHMFdnWmd1cllmeUtkV2xEZHB3L0hGZkczaUthb0tnNW83TExF?=
 =?utf-8?B?MG9Rc21sd0ZMVUJRWXBRSG9TTkFaVWI1R0lUQlNuTm9XZ0JDWTlWWk5yRm4w?=
 =?utf-8?B?OEs5cFduUHVEUzZzZmJpTThkM2wwUU1pMEJLTE5sMGdaU1B4aEo5Qk05SGhu?=
 =?utf-8?B?SlJHWEpSbGszT1liZlpzTmZVZWVIdThoNFlvQjFZQUxBZmsycEJ6V09Mbzht?=
 =?utf-8?B?NVBIaUM4NCsrbVZIbU9kMjYrcXNwaDcybkdyVUZxVUdVSkloa2JvMTRzeVBU?=
 =?utf-8?B?c2NOWko1RDFZNHc2blJLWk41RDJLczBKVjFGTW5Zdno5Mzdzakh0RkIzN0s5?=
 =?utf-8?B?WnhidCt0aU9jVWdqRVVERi9GQUhNTVg3RW1aY0ZWeXZwT0dVSHBSMUY5WTBJ?=
 =?utf-8?B?VUQ2N2RsejI0WVVoTkoyalNZUitQdXIzU1Q0dVRzbmxsSUhHRmpyajU3cThn?=
 =?utf-8?B?YWNPczRGUjY5VHRLaE9wU3BWVkpQMHR2czNvaFowVGpNbzlwdEtaVDNqRGVa?=
 =?utf-8?B?QnVIb2xXd2I4a3kvNFAraVE4SVBPQmdWdEtTaHRyMUUvYlpjaHpOdnR2TnlI?=
 =?utf-8?B?eWxXUm5xWjEwQllMcG5rTDQ5dDdiNGJ3YVgwcUduU2RMUTZCOEpKZVpQek93?=
 =?utf-8?B?WVI5TCtoSzV4M25uRmNaZ1k5bXdvZmw2RE84WGxRU05hVm1rYkU5TDdjQ0Z3?=
 =?utf-8?B?bWlaZkVmOTBmV0YxcXk0ZnFQYnFGOThhV1A1MmRJb0VoVk02OFlaRWxNTHBo?=
 =?utf-8?B?dVRBMWd3dDF5UCtTSVkwYXdGVWRuQTJ2SFVPR3B1bUg1ZUpNbXNlYVNDeHda?=
 =?utf-8?B?Q2djdGQ0ZzFudGNsNVYyL0tULys5WjhWRDB3N1IramtBOEkxY09mVld2eVRX?=
 =?utf-8?B?Nks4ZW83MjJYMDFKL0Q1WkZaUEZoeTR1UTBYOGcwOEYwNU15M2RCZmhuaHRQ?=
 =?utf-8?Q?yIkTjonL6lWCPyOxpS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701e3aae-e6e3-4713-6b94-08dec577ef84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:06:44.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csr1nXBOCt0KD1RDVwP35hVR8MzWvmyYWXmaTi5Bjvxv7kVPbQO/Ws++5jiolLXEaUURxDTioCvzTneJ78I6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491



On 6/7/26 23:21, K Prateek Nayak wrote:
> Hello Marco,
> 
> I don't mind the changes, except that it can be broken down into
> two patches as Mario suggested for easier backporting :-)

Totally agree. All the technical stuff I'm happy with too, just split it up.

> 
> Some notes below ...
> 
> On 6/6/2026 12:27 PM, Marco Scardovi wrote:
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 8d55e2be825b..a35cf126e335 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -199,7 +199,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>>   
>>   static DEFINE_MUTEX(amd_pstate_driver_lock);
>>   
>> -static u8 msr_get_epp(struct amd_cpudata *cpudata)
>> +static int msr_get_epp(struct amd_cpudata *cpudata)
>>   {
>>   	u64 value;
>>   	int ret;
>> @@ -215,12 +215,12 @@ static u8 msr_get_epp(struct amd_cpudata *cpudata)
>>   
>>   DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
>>   
>> -static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
>> +static inline int amd_pstate_get_epp(struct amd_cpudata *cpudata)
> 
> The change to return type and the amd_pstate_epp_cpu_init() bits
> should be Patch 1/2 with:
> 
> Fixes: 555bbe67a622 ("cpufreq/amd-pstate: Convert all perf values to u8")
> 
> and commit message stating the necessary error handling that is
> required if amd_pstate_get_epp() fails.
> 
>>   {
>>   	return static_call(amd_pstate_get_epp)(cpudata);
>>   }
>>   
>> -static u8 shmem_get_epp(struct amd_cpudata *cpudata)
>> +static int shmem_get_epp(struct amd_cpudata *cpudata)
>>   {
>>   	u64 epp;
>>   	int ret;
>> @@ -525,10 +525,6 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>   	perf.lowest_perf = cppc_perf.lowest_perf;
>>   	WRITE_ONCE(cpudata->perf, perf);
>>   	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
>> -
>> -	if (cppc_state == AMD_PSTATE_ACTIVE)
>> -		return 0;
>> -
> 
> And this should be Patch 2/2 with:
> 
> Fixes: 2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")
> 
> and a commit message that reads it is necessary for AMD_PSTATE_ACTIVE mode
> on shared memory system to toggle on AUTO_SEL_ENABLE based on the
> ACPI spec for CPPC v2 and below.
> 
>>   	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
>>   	if (ret) {
>>   		pr_warn("failed to get auto_sel, ret: %d\n", ret);
>> @@ -1877,6 +1873,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	struct amd_cpudata *cpudata;
>>   	union perf_cached perf;
>>   	struct device *dev;
>> +	int default_epp;
>>   	int ret;
>>   
>>   	/*
>> @@ -1926,6 +1923,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
>>   
>> +	/* Cache the firmware programmed EPP */
>> +	default_epp = amd_pstate_get_epp(cpudata);
>> +	if (default_epp < 0) {
>> +		ret = default_epp;
>> +		goto free_cpudata1;
>> +	}
>> +	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
> 
> I would actually prefer this "cppc_req_cached" change to be a third
> patch that says caching the initial EPP saves on an unnecessary
> reprogramming later when the EPP is first set but I don't mind it
> being part of Patch 1 with a small note in the commit message.
> 
>> +
>>   	/*
>>   	 * Set the policy to provide a valid fallback value in case
>>   	 * the default cpufreq governor is neither powersave nor performance.
>> @@ -1933,7 +1938,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	if (amd_pstate_acpi_pm_profile_server() ||
>>   	    amd_pstate_acpi_pm_profile_undefined()) {
>>   		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>> -		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
>> +		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
>>   		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>>   	} else {
>>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> 

