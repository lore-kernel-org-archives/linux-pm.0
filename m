Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AE168BD;
	Thu, 16 Jul 2026 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231830; cv=fail; b=dKNLwINGUFmQvSjN+sVOapk+EHVsaUWuTD5jBqkcpjRi/Ni7wn7GfwENsQ2osg89Z12T3OAfWlPe2dL8stzC6wYnDQdNf6wRwPfqsIhbchAJGM8etiwXQhQR2zjst8S+L9O4JuVSTgbex27PvPMT+82eHxCwCl6cUoaZog/xkE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231830; c=relaxed/simple;
	bh=ywfygNCXC1WqZ93bEegCA+cdVpPLISkbANJWMVHRsDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U93JPYvPIcncmKtD2s0tgx8E3lje85fYG7zO7uLtUyTHct5lpQ/w3HzsDbZ/4sV50NQrtLL+9SYfOETL3rMDRtVd5fIWRoTTdlFWgfToUPPxeIF9sqzuxIuoaVKzkGzOX9dUT9i5gJrGiNSzLyhy+3j+68Kf8+O41YE9BMWwIBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HS3ysjYB; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HS3ysjYB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi1n6BuL9v0v1F9WXtQnmFEntbjyjaUeknoia8GW4BdBxeopPSuqWp1PiBLPIeOnrRz187gmO0qG12Tvnd4Dg0DfGs0QVYuOAx/CWMBkPIRnAF2LVllRZ8a4fKwjL2zCDsxO+QxOEsl5QWWZafO5H84oxkk6rOB3AKUS/5bs77sGSr5ON5WV2dPcMIe7RFrANc7vbGo340L9zkmgEJYKumhvV66HJhf2AVhPwGYUxEcjGRqOey7MTTpAC0MonIfXpX+mRhXAyYWoFR1ldJNOTpXfvdfX/P+sccXimv7h6cbNJHrMwj93joNSUhRwF3B0piIK6+B9A422DC+G2loxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyk5D1I+GOUwLRLLtLR+pA4R1nAZsWFvBVCH+j2OLuU=;
 b=y6xY0TthF2626rvfkDFPdSptmhErSXOXSX1Yy08hvjeZ6ITyARlnD0mdKdo+Z/ElZODdLkwlLZ/E2/YEXJCwH9kt4UYTswHfzl1o/XJmCabSz4r+9iLhJc+XWVkBPqPOn7friX7kqYvVTM8QsDY0sQEjHixDU12Kz4ZSRDTuEVsdqdll8uF3gk2fUcA4Zhyi7mrLjj7XE3u3H7Dh2owvDl8waDC029I5vPgf0IFvw7IzIrYnFhLfPPCd6v8bMomBYH8U0oUB3MGblesGhDUniVlWoef1ulPKBYtIZ3kKIr49lKrTyKXW2wykKKaBE07eW+xEJDeeBg2S4fU80wxMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyk5D1I+GOUwLRLLtLR+pA4R1nAZsWFvBVCH+j2OLuU=;
 b=HS3ysjYBIRmPuH5x0MWW7D+knmeWTsAhdIW2txenDaH7bi7lM+X7HyxKLGVKOSEhyZMrumqY+FNzTQrMFn8Nm5j8droCa6SVdSzBxcPzEfjOjMnziOawENKhM30ETlyM0FhjYyELr3nU3nd5jMDED0tkffYsEW7SgYmFKk6xEgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 19:57:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 19:57:04 +0000
Message-ID: <7e90fc7a-39f1-435b-98fe-4c4915d81856@amd.com>
Date: Thu, 16 Jul 2026 14:57:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] cpufreq/amd-pstate: Correctly reset bios_min_perf
 during suspend and offlining
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
 <20260715074822.16324-3-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260715074822.16324-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0114.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::7)
 To PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 504e3ed2-d8fd-40cc-1d39-08dee37468a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fpPh1DQZ3xQR36sYP5W+QIiApVeJp6LYv1WDDBSIj5nby3lt4SazBUimKDCBifC4mGZ4jYCNysz7A1NCQx8Oztbf97i4BlTaxkMZKXJyzpYzmP1EiYjneL0AnbL+GaAVMaDfBv+wdCAQg26YIkw4flKs2oL4scac993t7JeOJ0fFsnHMoOK/JPPqzL3LNT0opfGXpnyYSx6p/+NfcZf1+0H+5GVEHcpemXATK4tRMakQSbd++krupzuXxcYO8byI3DO7bV7a2qBTkcjs/p2E7d8b1+YXWadTqM/rV+vCTESfeYDlWme8d5HsA6MqXjGm36fOcfyHW/1rAEsSP20x2PtXtNyPz34kQyksL+iA9xzrIkHfqoAjWk9vlhjiC8kBdKeb5FrArNhTqvgbN60wxbSCFptVQ5Z42nR+LjUnAY7YfaSqqJJvmvuUiLCxPe8cNUomMtH5yA/mFxwavIR9C589DmYVnuvIH+UvyKRZ9ggxM80OI4cH4j6WaVpEIuh8xUKFhFWgOAVBHypVBv9KjGYlMnE42AXoQaGqG+sZ5aDbZ9lDadLF0n4fhtiLj0lhR2ejr3X537Ni0d/q9shaXk3DV7qk4qzyQrIojlALXybOuBfN2HBkzK2RdGKUcsQIdrMj2FaSQQlr7ai5R/n+n7Q7IH9gN7aq2a2IzOL1G5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjVEOXhiQ09NRVdEdFBZY1FRaW5CWDhxREUycisvcUtBckYxQmlLdTF6MXpj?=
 =?utf-8?B?a3ZvaWFCQ2hPUG44YnM3V3V3VkpCM00xU1JaQmpQYW04V0c5RHY5SmpXSzRS?=
 =?utf-8?B?NTRwMnMzbE9ESDluWlBwbzJZWEtQQm5pVFVkY2RMUFdCUGIvOHdYbFZkd05V?=
 =?utf-8?B?TjdURGl6czgvOU5CUFIwTzZBSVNMZGVBOFBFSmNjU1pYcnl1WDViSWtyeXU1?=
 =?utf-8?B?QlBhSmRvNTd0NjdEU250d2ZrUzBCeEI1QUdTcFNOZlFnTW1pNFk0OW1Sdkx3?=
 =?utf-8?B?d1N3dUhoUWZ0Y1pjS256VzJCemREVTkxaXZTb1dLb0tIamtWcXlZRjZGaVYw?=
 =?utf-8?B?ZjVObmdmcEtMMVFNK2liUEhSalZIUzNQc3JSN1FBTWFHbUlBZnMxcEI0WFN2?=
 =?utf-8?B?MWdDaVNuYlc0K1dweFczaTY5Si8vZzJEbFdwaVZDdEp1STdSVGJ2cFZuMFBK?=
 =?utf-8?B?bDBXUWNCUnpselVlenNhWjA0aitsL0UrNjZjYzA3WHJ1SVdPZWswUVY4K1dH?=
 =?utf-8?B?WnUxQjZjUU9tRlRhQVFCWmc5TWRZQWQxSnh2TG5sczd0SEFqWWZNR09zcllX?=
 =?utf-8?B?OWxORldNV2puQzVNRzVsVWFxWUgvOE5UR1NsUFV1WEsrcHRGbTNpMEVZWTV1?=
 =?utf-8?B?dlFKVkZ0eERpSldJWjB2QTd1cGlYKzk1U1pJV0E1dW9kMmJHNXdwKzYvaHIx?=
 =?utf-8?B?a0dvb3U5c1Z0MlJsZVREek1vL3VmRjdDUGRGVU5jQ1FDRXFRTk5NQmJJcW1z?=
 =?utf-8?B?a1ZCV1cyTUhVMmVvLzJsc1RzWE9NTTh4UGhqdS8xejB2OEVpaXBjdVVTNTdu?=
 =?utf-8?B?SHA5M2dJK1lxcCs1c1dsZllncUdicmRNRWdTRmlKUXlYeHJsVCtvUzh5Sm9o?=
 =?utf-8?B?bjFYVGVDUlRCc2IwNkwzT1dlaDNHUm9LWWxRZXBIZ0ROQitXR002VVRPVnk5?=
 =?utf-8?B?YW9CWXFSMG0vQUkyQkRFUDhsaE1pVEFYTVJxWFBFU0V2dlZUQTZWalFnZk84?=
 =?utf-8?B?c3duTkQxMHRlNVd2U2NTRFBKRlZFeHFKVmMzaGo4YmRQYU9EM3VTSXFVUXp5?=
 =?utf-8?B?d3NhS295L3R0MnVuMjMyaC9MV08yWlIwdVErc2RBRDN1dTNSUk5SbWV4dDk4?=
 =?utf-8?B?a0pIeGRKVmRyOVJQQXpmNDhoQWJJWEQ5MFJaaEZ3VmxhSXpubFJmSjRiQW5r?=
 =?utf-8?B?SEphR0tmN3YzckZKVzhnYllQK0pObysvZyszS3NkcGZTNHpBWkdFNlAvQnlK?=
 =?utf-8?B?YWNGekRYVGtMYTBodCtlSjkzYnVIaEZuZ1E2ZEpPUGd6eGR3OGQ4S1R5Njg3?=
 =?utf-8?B?Z0R6SllVL1FJc0dXR1ZSTTNlTVoreUJmc3A2QThwd2Q5SlBrdlRBMndwZVZz?=
 =?utf-8?B?YUplRXpuejFsZ1Fvd3Yva2RpUmJnZE9waThId2xZczYrRTFtQkwwYzRldk1N?=
 =?utf-8?B?QkFteUxDMVhwWXlyNXh4U0NtaDdITnhxOG9OdGl3Tm1MQXY3UlA5Y21LN1Y2?=
 =?utf-8?B?b1FoTDJnZlRBK2NtM0I4RmdaK3NCMXhqVkptQktiUkxacThCczFWdmR5Sjdn?=
 =?utf-8?B?TWd1QVNCOHZ0RUo2Y3grbExieHZEdDlncjR3RFZ3MXo0Y3lKZmlUSTNHdGkx?=
 =?utf-8?B?SUpuaXhaNHNER2xoUkVxLzcrWTFFcDdxMHZuYXIxRC9hL28rRllvclV0VEdk?=
 =?utf-8?B?Z09kbjFHZFFXakN0ZndXNjk0Z2ZQY2s0ZVJKNTV2MUJXaHczMGJnQkh5VjB2?=
 =?utf-8?B?WVlEM1VvVUR0NUdGa0V1RExlTUE0aVJDcTd0b1JmYXI5TnJldGxXenlER3JO?=
 =?utf-8?B?bnl2bkEvd0hjNTNXSGRsekJIaFNic0ZpdnBwWFArN0RsRWdKdHdBcjFNS21v?=
 =?utf-8?B?OGkyaEdBK1VyWW55VFNjRXA2QWpjVnN1Mmp5bU5LQWZEdjJTT2pGc1IvaG5X?=
 =?utf-8?B?TFFiVDhUc3dkVU53Z2JQWHprOUhYelRMcWg5MWpOUjBGTmV1TStpQ1VXcDJT?=
 =?utf-8?B?U0hQSkhQbXZKUWRNWnh6bll1cGZFRy84b1h0ZTF0K1NsYmFsUWE5UXo3NXI1?=
 =?utf-8?B?dmpQallmOWY2SUlRSGVwVGViMHVRSjhtVTZHRGdUV085OVE3d01aMXd0ZFdK?=
 =?utf-8?B?YXZMRU41N3c3cVovMjVzZ0NQTzBuOUZBMnZyTkZMRVRMSUw2Si9hZldTTFZ0?=
 =?utf-8?B?TGRjc3pyYkZaQ1laV3F1bUdUZEFVMVdKYUtpQ2hzdVZ0Skx3NWpPWEwzbnJD?=
 =?utf-8?B?SEt0L2h4OFJaVUtIc1VJYTlQNlJ4dUdsWFpnOHpCaFJZS0xjVjdXYmJOYmJh?=
 =?utf-8?B?QnNIR3AzUjNQd0cwRlQ5UFhXM2FMUnVSRmJxbVNyeVFJenJrVXFudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504e3ed2-d8fd-40cc-1d39-08dee37468a4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:57:04.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYZ6Jgo/sjLI62SrQ066LFE38hiKV/TIO31koPrWZrwKaelyeLWqhMqurpnhY+N5kz2E5UK0VH9ecEh+0jQS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720



On 7/15/26 02:48, K Prateek Nayak wrote:
> msr_init_perf() accepts the configured bios_min_perf in CPPC_REQ MSR
> only if it finds the other fields (bits[63:16] + bits[7:0]) to be 0.
> 
> This is intentional: a kernel unaware of bios_min_perf can leave the
> last perf request programmed in the CPPC_REQ MSR before kexec and the
> newer kernel, which is aware of bios_min_perf, should avoid incorrectly
> interpreting this stale value form last CPPC_REQ as the bios_min_perf.
> 
> A kernel aware of bios_min_perf is expected to reprogram the CPPC_REQ as
> seen at the time of reset during suspend / onlining. This allows for
> kexeced kernel to pick the bios_min_freq during boot without needing
> complex mechanisms like KHO.
> 
> Although suspend / offline callbacks correctly restore min_perf back to
> bios_min_perf, they fail to set other fields to 0s which causes the
> kexeced kernel to think the CPPC_REQ is configured with a stale value
> from the last boot.
> 
> Restore the CPPC_REQ seen at the time of the boot during suspend /
> offline.
> 
> The "cpudata->cppc_req_cached" is temporarily clobbered when the CPU is
> suspended / offlined to reflect the perf state at that time. A
> subsequent resume / onlining will use this clobbered data to reconstruct
> the CPPC request and force a reprogramming of hardware to restore the
> state back.
> 
> Since cpufreq is suspended at the time of clobbering, the state will
> persist, undisturbed, until the CPU resumes activity.

Another idea; how about if you use kexec_in_progress to control behavior?

> 
> Fixes: 85d7dda5a9f6 ("cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate")
> Fixes: ba3319e59057 ("cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 61 +++++++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a6e43db6efefe..6ab769d4bd2da 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2044,6 +2044,8 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	u64 cppc_req_cached = cpudata->cppc_req_cached;
> +	u8 min_perf, max_perf, des_perf, epp;
>   	u8 cached_floor_perf;
>   	int ret;
>   
> @@ -2051,6 +2053,22 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   	if (ret)
>   		return ret;
>   
> +
> +	max_perf = FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cppc_req_cached);
> +	des_perf = FIELD_GET(AMD_CPPC_DES_PERF_MASK, cppc_req_cached);
> +	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req_cached);
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
> +
> +	/*
> +	 * During offline, cppc_req_cached is clobbered with the state at the time of
> +	 * hotplug. Retrieve the relevant fields and then force a mismatch for the H/W
> +	 * to update with the correct values.
> +	 */
> +	cpudata->cppc_req_cached++;
> +	ret = amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, epp, false);
> +	if (ret)
> +		return ret;
> +
>   	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
>   	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>   }
> @@ -2059,6 +2077,7 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	u64 cppc_req_cached = cpudata->cppc_req_cached;
>   	int ret;
>   
>   	/*
> @@ -2066,14 +2085,13 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>   	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
>   	 */
> -	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
> -				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
> -				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> -				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
> -				     false);
> +	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   	if (ret)
>   		return ret;
>   
> +	/* HACK: See the comment in amd_pstate_suspend() below. */
> +	cpudata->cppc_req_cached = cppc_req_cached;
> +
>   	return amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>   }
>   
> @@ -2081,6 +2099,7 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	u64 cppc_req_cached = cpudata->cppc_req_cached;
>   	int ret;
>   
>   	/*
> @@ -2088,14 +2107,17 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>   	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>   	 */
> -	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
> -				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
> -				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> -				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
> -				     false);
> +	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * HACK: Restore the cppc_req_cached at the time of suspend. This is
> +	 * used during amd_pstate_epp_resume() to restore the correct EPP value
> +	 * when this CPU resumes.
> +	 */
> +	cpudata->cppc_req_cached = cppc_req_cached;
> +
>   	ret = amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>   	if (ret)
>   		return ret;
> @@ -2131,9 +2153,26 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   	u8 cached_floor_perf;
>   
>   	if (cpudata->suspended) {
> +		u64 cppc_req_cached = cpudata->cppc_req_cached;
> +		u8 min_perf, max_perf, des_perf, epp;
>   		int ret;
>   
> -		/* enable amd pstate from suspend state*/
> +		max_perf = FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cppc_req_cached);
> +		des_perf = FIELD_GET(AMD_CPPC_DES_PERF_MASK, cppc_req_cached);
> +		min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req_cached);
> +		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
> +
> +		/*
> +		 * Enable amd-pstate from suspend state. During suspend, cppc_req_cached
> +		 * is clobbered with the state at the time of suspend. Retrieve the
> +		 * relevant fields and then force a mismatch for the H/W to update with
> +		 * the correct values.
> +		 */
> +		cpudata->cppc_req_cached++;
> +		ret = amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, epp, false);
> +		if (ret)
> +			return ret;
> +
>   		ret = amd_pstate_epp_update_limit(policy, false);
>   		if (ret)
>   			return ret;

