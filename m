Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2C3148C2;
	Tue, 24 Mar 2026 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388358; cv=fail; b=kG+HyKO2Ur6b2nfOH8EStk/raC/CT2n7kKQcZr2TnBIh4+qFYeOdBRVsrWrIzv1M57h69jPq2Llzwt29An8ZMZWQYwtf6+9k71BrV1v39VWYMjHWbeKHoUW1S02qDLtaZjORpibQlfsn9I4msUuYr/z8+LUXx1k52uuqAbwuLCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388358; c=relaxed/simple;
	bh=qw5QcJlbAvS4z4+1jdrlUy1zv8qyKZR9gNfepXolN4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoFQRCrB1hHHPSABClZavgA0h9Ap7RLURS1SJb6Il2aqUCqRVy9qa9bcQ/pFiF75cFpdzXpzFIKXI7Lk5+okl0qoSlSgWy8p1X+eyqVIHloNO/NqK1G1neGXVsk1WYKwua78xs5Fzx95JTd+FM1jlO7apJIiCbBSZS27HY2asJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pem+9t4G; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pem+9t4G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+oAnbO48lmZM+z6wHTCHojTpCVf/3wZYHUB17dO69ctLdYecvkyovTxApq4uCBsGkGHBDn9nfzOSyLrmQKHbXIo/yzbzsHPoUFu+V0LALQOrY22VkIo9DJ4kY2v8dEREEt3LhygC9RMc61ANiN8gzO/H+QEZWVpQAw3YrsZ/YVamixOW0XJnBPawW6FvmakZUMIvbmQp2yXVfI+2ACo1ixLJVtTryp4rF5CujtEkABiQu+9fhvdaULo4WkLx3vedjDE0QgA1AIpIl9OE5xFzqy/vSZnteo71jfwNgbNMBFYTP6f8H6GVZGQiwL70EP+RlPRq+cr6hcVur2cGgzEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thMklu4RqrErmam+ozwt3GdSpa5uD+BAz7F3prqebD4=;
 b=rs7NMUDgQHzXYz+Q0rznq7nW2xL7qduSQ6r8Z1vHkayIHXA/JmrNERY+AJ0tRnpLQXxZQDBMAEhpGBJuDFii/xyZ6He4Pe/tky9uFhCOsl6bY/AfdOqiGt4F4wWhIyfPZFAJf1/YYU+NZvAp68GfMkUt1z5fz0RdL8gZfI1UNwvyISdO+Z2iPuJyAJyRHAGTjSjkpNnRr6RV5rxmrSsNOFX6/7vzsi+ur91fuLhWtUhAbMMagNTTvKqgACAQezNZccU0Aj/N1NYk0KV+hkX5oIpsDv+6b/hM7MhRxlyZeuuzDq55FxgiXNfe9lTjZehhSPvs7cmtiPAWUD0hl/b9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thMklu4RqrErmam+ozwt3GdSpa5uD+BAz7F3prqebD4=;
 b=pem+9t4GXu1E6OxxSKL7M+DxOv0ahvpE7+5LoLMkPusZMc2rRGnu8r81+seBP6yNUfFrQi85QlF5rFFsp3tYuVzB4J537zvQHpVp0Vc4C7CVgu9L+VGo5Iqod0GzrfAJoMX9hNqlt6hESqDVZxzgsZNpORK0RxoUIP1BOwH3Jv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:39:14 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 21:39:14 +0000
Message-ID: <d79f8a3b-7280-42c1-91d0-403534d502a1@amd.com>
Date: Tue, 24 Mar 2026 16:39:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] amd-pstate: Add sysfs support for floor_freq and
 floor_count
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-7-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260320144321.18543-7-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:806:d0::10) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b9556aa8-aec4-4dbb-0782-08de89edcb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GU63UnDhL8gzZYaG3Y7xlbqcnG+QpwXIz4Eq221yHz/zXdUIFqoS+WFgdG6qFasY4/Dgq7O+gyfmax70Xu7nTHgiSdPrUdGYcT4seXKnwXCwrn21bVymfb9wG97o+SAVJsXtTvd8hcy/uLT4sP3pu/fRvxUJf9xoWc0EdIDLd725RWola2cy7dtJQq3awa7qZyXLli2QHdMhrwl6Fi2PBgLZm5lma9j+2rEgZ6rwt6ukh5GeuC9jAgMeJgvO6PxY+J6hY6mVn89lfOC37lJyeZGDlkuHUIlQvaw3/1WnwmjOiTzddgEK98xBE14igqzSwkSntBbxCMaz9sUZSDb28qEmr9/w8ZeXAR1m1qLnKpDs95/5Y7kQKUlGQqhPTvPQiIk/GiAXGZntfUQVD0eWA+X6NgTzZUxOgvVtg1/J1xKs2CYfMp4/rEM9VVqbqtkYkJTQNhjnAQ/+SWB4GDOvM6gREBtli/0cs2bSAfFBxeqCbGJSjHT7bV/XZL5kslR42ITAK8UzgyxQGIBFmU8Lk3oI5nUcK24LAK5mlmreMjcbj4022YVt403IcEwjxsvBfUhUQHzFvSA1QyqBsahmWFA6FeOXqtxjDn2iF2CQ3n7oEHKFxYEGHQqb6fqBxlmWI3Ft0SAue3xpLdkILTmWcDUN92wVTUM/tCwSpI9tIUoQLyumAIHnBuyzJy8KIRnW475GC+hpWHKdSwdMmvqjyUwbsm0xXcLdeZEXyUNaCdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5wV3I2bmVhRDZRZkxJaWQ1SG1lWjhlK085aWUvUmwrMVRzK0UvcUJFWnZw?=
 =?utf-8?B?UmZHTTBad0ZGTG0rZHZHdWdQVFY3MVpZMlpncUxORmt2b0VORW1HZlA4RjZV?=
 =?utf-8?B?V0daMlc1QXpWM1RQUFNzSzduQTMyakUzM2hHYmJuYVNoVUttSlVnUHhEU2k5?=
 =?utf-8?B?elNvNERGdmZjdjRZR0NaQUVzSVRVNWRXeTExcDV4NHpMckI3Zk91ZTRxN1Zk?=
 =?utf-8?B?M1p6UjJmQ2hrUHZzNHRIOUh2VjNiRDFoZHdtVERacWlENVZtbVV4U21vUEJi?=
 =?utf-8?B?bldJUHRWU29Mbm16bzY0TU1pL29GajJLQjRDT01Ea0RFMHdUQS8wYUFaUFJ3?=
 =?utf-8?B?dlUxb0lVWEw1WlI5bkg4YnAxQVhzUEF0L3JLVmg3ZW9KeGNreHppd3VqOVdt?=
 =?utf-8?B?R2VSa0pzcnh4TG9hTkZ4WGdwSFQzejRMcXNMZkVkM0JJZUhWbEhEQlZ6Nldk?=
 =?utf-8?B?UUZ5eXF0Zi9tbGI4RUlHSk96QVh3czJiNWYwWnQ0SWVFRlF5cHlKWGZ5ODFV?=
 =?utf-8?B?alNDTDJoRUFmTUFET3BUT3p2WUpOQ2xSU2ZHQjYwZEF2bjdUUDhZbHF3ZTlv?=
 =?utf-8?B?TU1PZ0hTQXZzNWx3dk9acjdVU3c5bkYxNkpQU2pKM3p1b1hoOTdFMVVCYTFh?=
 =?utf-8?B?VHQrTjdOeGdqdWcyNWI3Z1B1dnFmUTlPRDVRNWk2VWFnSWtPMzhacVgvSmJO?=
 =?utf-8?B?YmY2TDRDK0d5cmMrcDhFekYydVI1ekZZWlh3T1dSM0ZtWkRUVHEvNzd0bG9W?=
 =?utf-8?B?V09LUzdhM2lCaXhJNC9qSEFyM3IrSmtNWXROSzl6L0hraW15M0o4RnJ6VmtF?=
 =?utf-8?B?VFZFTHNwcXlGdG5LYnkxM3VoV1NkYjFIU1NNVmxyR3dMTnpwUjkxWjhoMHo2?=
 =?utf-8?B?RzFubFhVempPU0VOd2k1NEhjd2gxbnhtbDZkNitmcU1tY0ZWRzBBTm9TQmpq?=
 =?utf-8?B?S2NTeUdOcUt4Y1B1cDZrdWs3bzA1dWppb2ZLdUROWXd4M01ZOEtDeUNJclRK?=
 =?utf-8?B?R0dvbDJPMGVpc1dIcWF6ZEdDN3YwUEt6a1YyMEpkUEI2eXllTVRuZExVeUF1?=
 =?utf-8?B?dm92alY1MFptWldpa2dzaGt6RCs5N1pTZ0cxYklBWGFTOG9vL2t4R0pITmx3?=
 =?utf-8?B?ZmFnTmI3dDFQVEhCeGJYanR6aTFvaTNQTE9pM1cyaW56d3JDNzF6MkVBWFZu?=
 =?utf-8?B?bGNQMUNqa1NuUlNZWk4ydzNTYWkzZ0hqM3ZKZlN0eFhpUDE0QnlKaUZzRGda?=
 =?utf-8?B?RThXUGJpU1o1NDJtZGZOQW1VQnh5RWw4SFphdEpnUkRsbFYyUjhQeFR4T3FE?=
 =?utf-8?B?cFBKWG54cjFabGwyd0xsNks1dkIva2RKS1FZeVRuRVRYWlVDaTRsbzZKUnZP?=
 =?utf-8?B?ZUVsVU1vOEhKbHkxVUNVSGw0NHVJUVgrR08zVGYrQ2M3Kyt3cHlWbFlDNUZi?=
 =?utf-8?B?aUx0VFdYZ2V6YmxIUVk0ekRzUHBsUDZoSVU1M1pQMjZmb0IyUnp1RTlySlRR?=
 =?utf-8?B?M2RJVk10L0xhbnJXeFJ1bU51QUFEcktEdlRXYXBFS2pZSzNFTlFqZDhFczEy?=
 =?utf-8?B?bG1BaW50YmdIa1NlaVBHc2R2UG1PU1FZU3dQQVc5SW5KVWNDQmVjTEpMbVF3?=
 =?utf-8?B?L2hMUzN0STVzVktpVHZ3eG1PVXpHR0xOWDg1OFZkS3hvdFJZayt3R1J3ME1B?=
 =?utf-8?B?T0F0aWJPaThnWnhKbmN4UXZBRTIvbXRBOGFGb2Z4ODlaZGNhVHorWVlsOEUy?=
 =?utf-8?B?eEdvSm80Q1l6Q2V3UWd3TDN5TFloVTZURTdrQ2FtNU1DakpaalE4SXZWSDJW?=
 =?utf-8?B?cjNadnBscFJXUCt1a0RrZmJCbXNnUnVwbjEydFlVRU9yTmlaeUg0bDdTUkZy?=
 =?utf-8?B?d2hxcGx0UkQ3NjRkd095Mk9tNDkyZkZFQVd2Z3ZFdkNuTEQ2Tm8yekZHa2tO?=
 =?utf-8?B?Slp6alg0bE1Xb1MzSTl2K0VYcUFRVGlsNm9xS2pRUm8xdXBVU3JMS2lmOGNk?=
 =?utf-8?B?SmFKSzgyQmdYaVNFNXlnclNQZDZMM1pFNXFPQ3VTUkJTUG55dTFQSFQ4ZU14?=
 =?utf-8?B?a2RwWHBLWmdjdEdHaHJsQW03WGQ5S1pQQjU0SlFtV1pNeEdSM1VOUndNTTJM?=
 =?utf-8?B?NzNidStiUDlsRk1ZVzZhSk9VRjByYXZ5YjAxbXU1SkZwZXo5R0lTREtHS1dV?=
 =?utf-8?B?Sk9FZlphUUltTmdxUXpvL0wrbW9GbXd2czkrbjFET0REZzYrYjV4RTdRcFBP?=
 =?utf-8?B?Slh4cThpL3ZEZ2I4cGVjRm9RR0hZamFyejFySFdBY3hBaGsyWUNibFJYbVU5?=
 =?utf-8?B?aGRBSWl1QnluaFdGa1RWbThhL29HVzZSUm1vcUpYK0VNYVJGNSt1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9556aa8-aec4-4dbb-0782-08de89edcb57
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:39:14.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnka+5iMTJyyBrTeV2IPA9HiEqJB5Ho3YTd1j38KsJEeE/TudQ08WEnvdmOxoUygGaB8VmQtozVT7zA0+3KwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977



On 3/20/26 09:43, Gautham R. Shenoy wrote:
> When Floor Performance feature is supported by the platform, expose
> two sysfs files:
> 
>     * amd_pstate_floor_freq to allow userspace to request the floor
>       frequency for each CPU.
> 
>     * amd_pstate_floor_count which advertises the number of distinct
>       levels of floor frequencies supported on this platform.
> 
> Reset the floor_perf to bios_floor_perf in the suspend, offline, and
> exit paths, and restore the value to the cached user-request
> floor_freq on the resume and online paths mirroring how bios_min_perf
> is handled for MSR_AMD_CPPC_REQ.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 93 +++++++++++++++++++++++++++++++++---
>   drivers/cpufreq/amd-pstate.h |  2 +
>   2 files changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 53b8173ff183..a068c4457a8f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -383,8 +383,10 @@ static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
>   			return ret;
>   	}
>   
> -	cpudata->bios_floor_perf = floor_perf;
>   
> +	cpudata->bios_floor_perf = floor_perf;

Double check the whitespace between 5 and 6; I wouldn't expect this line 
to ping pong.

> +	cpudata->floor_freq = perf_to_freq(cpudata->perf, cpudata->nominal_freq,
> +					   floor_perf);
>   	return 0;
>   }
>   
> @@ -1288,6 +1290,46 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
> +					   const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	unsigned int freq;
> +	u8 floor_perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq);
> +	if (ret)
> +		return ret;
> +
> +	if (freq < policy->cpuinfo.min_freq || freq > policy->max)
> +		return -EINVAL;
> +
> +	floor_perf = freq_to_perf(perf, cpudata->nominal_freq, freq);
> +	ret = amd_pstate_set_floor_perf(policy, floor_perf);
> +
> +	if (!ret)
> +		cpudata->floor_freq = freq;
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
> +}
> +
> +static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u8 count = cpudata->floor_perf_cnt;
> +
> +	return sysfs_emit(buf, "%u\n", count);
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1296,6 +1338,8 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
>   cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +cpufreq_freq_attr_rw(amd_pstate_floor_freq);
> +cpufreq_freq_attr_ro(amd_pstate_floor_count);
>   
>   struct freq_attr_visibility {
>   	struct freq_attr *attr;
> @@ -1320,6 +1364,12 @@ static bool epp_visibility(void)
>   	return cppc_state == AMD_PSTATE_ACTIVE;
>   }
>   
> +/* Determines whether amd_pstate_floor_freq related attributes should be visible */
> +static bool floor_freq_visibility(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
> +}
> +
>   static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
>   	{&amd_pstate_max_freq, always_visible},
>   	{&amd_pstate_lowest_nonlinear_freq, always_visible},
> @@ -1328,6 +1378,8 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
>   	{&amd_pstate_hw_prefcore, prefcore_visibility},
>   	{&energy_performance_preference, epp_visibility},
>   	{&energy_performance_available_preferences, epp_visibility},
> +	{&amd_pstate_floor_freq, floor_freq_visibility},
> +	{&amd_pstate_floor_count, floor_freq_visibility},
>   };
>   
>   static struct freq_attr **get_freq_attrs(void)
> @@ -1748,24 +1800,39 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   {
> -	return amd_pstate_cppc_enable(policy);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	u8 cached_floor_perf;
> +	int ret;
> +
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		return ret;
> +
> +	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> +	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>   }
>   
>   static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	int ret;
>   
>   	/*
>   	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>   	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>   	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
>   	 */
> -	return amd_pstate_update_perf(policy, perf.bios_min_perf,
> +	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
>   				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
>   				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
>   				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
>   				     false);
> +	if (ret)
> +		return ret;
> +
> +	return amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>   }
>   
>   static int amd_pstate_suspend(struct cpufreq_policy *policy)
> @@ -1787,6 +1854,10 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   	if (ret)
>   		return ret;
>   
> +	ret = amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
> +	if (ret)
> +		return ret;
> +
>   	/* set this flag to avoid setting core offline*/
>   	cpudata->suspended = true;
>   
> @@ -1798,15 +1869,24 @@ static int amd_pstate_resume(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	int cur_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->cur);
> +	u8 cached_floor_perf;
> +	int ret;
>   
>   	/* Set CPPC_REQ to last sane value until the governor updates it */
> -	return amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
> -				      0U, false);
> +	ret = amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
> +				     0U, false);
> +	if (ret)
> +		return ret;
> +
> +	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> +	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>   }
>   
>   static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	u8 cached_floor_perf;
>   
>   	if (cpudata->suspended) {
>   		int ret;
> @@ -1819,7 +1899,8 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   		cpudata->suspended = false;
>   	}
>   
> -	return 0;
> +	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> +	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>   }
>   
>   static struct cpufreq_driver amd_pstate_driver = {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index f04561da4518..2f7a96836fcd 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -72,6 +72,7 @@ struct amd_aperf_mperf {
>    * @max_limit_freq: Cached value of policy->max (in khz)
>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>    * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
> + * @floor_freq: Cached value of the user requested floor_freq
>    * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value (in khz)
> @@ -101,6 +102,7 @@ struct amd_cpudata {
>   	u32	max_limit_freq;
>   	u32	nominal_freq;
>   	u32	lowest_nonlinear_freq;
> +	u32	floor_freq;
>   
>   	struct amd_aperf_mperf cur;
>   	struct amd_aperf_mperf prev;

