Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F04168BD;
	Thu, 16 Jul 2026 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231657; cv=fail; b=YXdKxSa0Rt9H9pqpVdpjrNmQUZvDS4/ZylLgG9MoiT82QBtr8yq+7KCNFbN7B9HBJh56YZeaN6dO69tIpQwwMsIk0h6m8cshViU0XD19W6bWn7DMjo3s+mtGIWFg+cOAlPvL1R4xbZdlH4abpPwgnlP1wk1lLVCjxLzuDwPn45Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231657; c=relaxed/simple;
	bh=xLxSL4r8/DtszAnOgSogVeUVMKjOC81hSEYhaxISGgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aszp5r+DvWWZfTQUsAhMdfnXohIEQjgksLkKR/0dOYHXYJduHLFaabEu/cO4Uymv9zME4JZ+s61h2YyMnq7xSGDMBXpumffSTtTBe8SkLtNXGr/wfGPc9bFJnfWFo5D2CYItTDTMcuVAAO/AdSREhVFkoaEz9k348LXl4ncwM48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CfaduYzC; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CfaduYzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDUTjBGIKlOUhpomkT4f89C/PMeNNkByI+CFbX5n+hWinXPnN0kIXKPdLAQ/YtUQX+img5033XgilbmTAakJB0+bg67u0B9mEARgu+UUNLNaCD+nFSdU0RjfM5pEePKr6XoWjAsO+CyXom2q+TAiipjU85QlmZ1dZ2PhM6Ijq2y1yF7J9RvIxm5hpHuc5Zu0XxGv3BJJJXIKh75MtVFK1A2yv6KcBtYghAc/ROK41pMN9SVSCckyaTBQtv2P+RE/0LVW4WNUrdlMk0ucVJLf2Fw5YlsBeRn/4nwYO2CHrz0GkCIE3IDessvoJw12P4Sy9xrHnjNdudxX/aISYHn83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM3fHWwn/Vzbf1n/upZJwK5WVFreqlcS/6Q+JTzuq8Y=;
 b=vOHIw70ipcAGo05ISlJV4i8Jxiq5kd4moScWnwV3dvL6uHGHBWXgn4n1OaVT5n66m+gDSMDr+k7fggEIOfXST379NccshxSxQ4w4ce7rjRs3JGei4srmhhQdHC+RR5yoMw27UKNDhgNiBYMjKG2SaFGWt7prWcSlsHBJKSXRPA9DJGJ9c0xpKVJ6BDA4G2G2UfVXyMFD0vgwrJ5E8zdRcOoMLMRWV1d11Bt1wK+Mtu7OWw5LF0fa0VeHUtqEtsiLOjBTUQ5LqTwie/+ptUuyfkWexRPErcZHlc6CMcG5OuS9KOMp29xOfv8ncu7+skKWBtlP+WB4tQe2+cJByHBSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM3fHWwn/Vzbf1n/upZJwK5WVFreqlcS/6Q+JTzuq8Y=;
 b=CfaduYzCaX/7faM55RW23LjvGLv+tzIJ+vzMqfazGmzMvVFMuo6EGlbVtBOD9Q98FvzK+mp5bL58mqRQSmhPLOagCD02YR0jqct3DE+TmD4nKYai0ZuAU6os1dUhO3CXTVWaaFegBz9yT509Xi5a9d3AVqxi2e0Fn8/ZoY2OHMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Thu, 16 Jul
 2026 19:54:14 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 19:54:13 +0000
Message-ID: <617c91ba-86e2-40b9-ab77-f61afc6156f2@amd.com>
Date: Thu, 16 Jul 2026 14:54:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] cpufreq/amd-pstate: Set min_limit_freq based on
 bios_min_perf
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
 <20260715074822.16324-2-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260715074822.16324-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:806:d2::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0364202d-5daa-4e5e-2f6a-08dee37402bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6+HVJVQRQoJQKVZWF+yMlP5qn7//FJMx84d3Cby87VZUnXN2B56WFJkiyvFI81zNZP/y3CmqW2vpdkLHge3q8eo2xgJGWHhFmux0zx+vX1iojxDiPnN3vOm7KaUC6PVBvYeSX9npyaMjGXNyje+BXbr6qaOJ4XME+PavGJZiTREk8+7+qhS4K3FE4s7NzXtxwRLf7sfuO5e0BSjCozNkqiFmRKV8MVoy6MrEYd9iG5E36xoKTJh8l7OnRF1XyRDYVXsM4fDx85I0zYWwXXZpFuByGHGVXqXWURajrWsSYWsRFWElA6YnH1lCseYLgIARaYQs6Ec3bJTv/UmL6Q35sduevoSxzaWkuCzg6PIcxI9oXJWrM/v2wRaUnZXuN7DsFJurLCm9P4viQGN109Vyd45OwwLiRLFrse1+Z0n/h32OA3B3YaYHJQSpqAY7wsTFb+7eDDj6JAG63BZc8Tb8jjeXq1lQLcv93vpOuEzP0Kg3B30kdLIWZR+D6lE3qAwXzJPWbGzclj4GCNRCmhWrMI6UrparROjT/DuP0w0AQ1b2BwPWHWVoZbWX9Ca6t3HToi5836JBefmwvIIdWffzrcKKz5U85/e4YyFcd9sfCt6NltWegT4swazhyvhi8FLXCxFd6sxzHtCmHWDEgPq9SoltCL+43JdHA80BQCcYyQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lUWGptT3BBcHk0L2JQYzRhdlZmRWc5TVVjRVNFSms1ZjNsbzZQNFJlbzhu?=
 =?utf-8?B?SEZBc0ZFN3hBMFBFVUIwdVQxSUF1MVdPMUZQWlprb1d6NVZzS3VndEp4Zkxk?=
 =?utf-8?B?SU5DU1NXc0R0REJGSkpWWkNhbHk0VkJxTEpkYjhXMUh1ZVZUTGxWZ1BSSDJS?=
 =?utf-8?B?VEh5dmU0T28yTTRDc3FxR2F1NWt4M2d1Z1ROeTB6cEZ5cEpRR3YwamlEK3pn?=
 =?utf-8?B?ZGdmWVZOTXJCeVIvM0IycTU3TGRGd2tXc2pnNGVDdHEwbkNQUzdRUGR1NCtt?=
 =?utf-8?B?Rmtkc1RUS2hSWGxDV0hGbVV2bjI3ZnhBZGpzcFJLd3VraCs0dU42Wmp3TjFH?=
 =?utf-8?B?TmdSeDNhOWU4YTBZcHJFRmVCbUJTQnB6UW1kZEZDR3Y5ODZqeTdwNm5TOU9W?=
 =?utf-8?B?ZmtLcWlPRm11VXlYaDM1ZmpsTnEwNk1QejdyV1kzWjdqZnRmZXRyTlM4UEhG?=
 =?utf-8?B?UnFSYWViSCt4cW9HRzY4cVFFYmtmNTM3SmhQL1JsTzhCRGUrQVdrMUh4c1BK?=
 =?utf-8?B?UkdVT2JxUlJUeDNLUXpXSjZmNE5XVEgxckMwUUp5UWw0cmxQTHpaMDNVajRK?=
 =?utf-8?B?Q0NIL0pqR2hScEU1c0JpdVRKSS94VFY4aUptVUV2bG1iSWxPYWR3U3lMNFV2?=
 =?utf-8?B?NFByTVZiYWhOdnNITThUc1F2MjY5VG9XNit0K1djMTVqckRiWHAwYm1NSUZB?=
 =?utf-8?B?ZkRDemZBOWZhM2kwZmt5VytNdnR3eVkrSUw0TWRBM2dNYTRqV0Fuc01nY0ls?=
 =?utf-8?B?MHN1d2NIZDh6aDNzVzUvZXRzTHFKUmhSQ1NzVU5RZUE3cWUwMGlZWm9tTzh3?=
 =?utf-8?B?N2VLaDZwQTRqbVlKcFdPSEtrS1FjRUdhYVdjUkN5OU9STE4wQzE0QXIrSlo2?=
 =?utf-8?B?dStWWWV1NVhBVU9PaEJPVXI1MEtGN3BUcCt0bjg3YzN5aC95OWRwOE5mNjNL?=
 =?utf-8?B?TGIrOTlIUjcvVXBCaEdOQndmMlIyUDRJeHp3SDE0a2ZQN0o1K1NOaEFuZWt1?=
 =?utf-8?B?NCtqc1o2K1J5ejdCckcwK0dPcnQzMjlQdzZhQWovTUlqWjdCcFE4YmFBRW1L?=
 =?utf-8?B?YUJOcnF6SUR1ZDU1OVZ5Z0NXbDNPUjFmRGVkMmZhYkU4RFcxd1dRcGgyaE9s?=
 =?utf-8?B?Z2JVL1R3NWJIaDBOREVHVWovc0J3b1hFNUpmY2ZMWTRhYXhIZlpNN1RZcEhm?=
 =?utf-8?B?WGNoVmFYR1hFYUo4TndDR1puSFZqTmxQVy94OVFvenpKUXEwRHZYNmVQS3Yw?=
 =?utf-8?B?Z2R1eEhrT2VHSmhWcExKTzNoaE83OGxaK01NVVAwVWtLekpTK0dDZ1JVSCs0?=
 =?utf-8?B?SkNUU0hDYXZ4SDhNcVdIT2w4dm5LQ0tKbzVHSVQvWU5XZXUybUFuaGZ4VmhD?=
 =?utf-8?B?VTNINWZiUHcxTHMvVEFpeXRFNWh3V2JlYUhUTkNPWUd2bTRlejN1MFlleGdN?=
 =?utf-8?B?aVc4TmZ2TWNxREo5aGdPS1ArVXhhdU9UZlVlM3BwODI1dHJLK3NtWXVacnJP?=
 =?utf-8?B?UWF6aWVwclcxV2J4TUVodnlMQkwwTURTSDNqMlBBa2JiNWd6dEpIUkJqMzF4?=
 =?utf-8?B?SS9JdHNFSlFkZ2VjbDhWb1ZNRGw2Zzg1VGdDR1ZRMkdMUXZEakhlRjEwakNs?=
 =?utf-8?B?Y081MVY5Z1ltOUxoUDZ4K1E1Z21KZ3k2ekRKTEdIMkhhczkxZVAvR055VDE0?=
 =?utf-8?B?RWF5RzdLVlVESm5EYkJydzFmWTZVV0oyUms5cERiWTVRM3VabkUzaDdWbjhr?=
 =?utf-8?B?QnlXZ2tGVHh0OGtrNnU5QW1HZGk1d05SWFVRUmpyUnRaMzB2Qk5oeHhRazFk?=
 =?utf-8?B?MTViV1B0UEhJTGp1Kzh1dThPcDQ2OUU5eU5OamdOWU1DbHdyZUc4U0RPekNP?=
 =?utf-8?B?MTA4V0Z2T0hjdEc3azM2SVBTV0Y3eE5iekRaaE9ydGg3ckpsV01BcjZJZUY2?=
 =?utf-8?B?TXo3bFkzUTVOaTRjNCtTZ2dqblh4ZkFLMnJ4cU9ROWpGMzNBUnhwamM2enhm?=
 =?utf-8?B?SEt5dDlnV0pnVzBkcWpCVEk5Umk0ajQwSkUyMVZueERPWWJRSVlmdWthcU5Y?=
 =?utf-8?B?QTZTRlhOQ3VEbXNwbEZ1T3lrTi9PamtWbkJValVjejNHNHZ2ZjZBTGJGbjIy?=
 =?utf-8?B?U1VkQk50TWIxYm5zeUR4a1dVOGlDRzNqYVBoTXJIK2tSYytFTlhzdFY0bU9D?=
 =?utf-8?B?eTZxZGxDbHRjVUREQmpCZC9YSG1Kd1lxL2dzdlI0VmJ4OXNtczFXT09rRlJs?=
 =?utf-8?B?RTAwdmNmSXh2ditIaWFpVWhpcU9TamtlK2l6b09Dd0JSYXNZdTB2c3NpTU9G?=
 =?utf-8?B?RmVHRE5zNDBoeWp2aXRJWkVQaWNjTTR4bHZXMEdRS09UaUFjaVhZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0364202d-5daa-4e5e-2f6a-08dee37402bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:54:13.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6wFn+xOUATNB/zGgTh1OTXB8UKH5Pe4YAohJ8IF6lfWlA8nH7GwhEzby46tqFWeZ9ZtbLGPmk2AaAQsgsf+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097



On 7/15/26 02:48, K Prateek Nayak wrote:
> amd_pstate_update_min_max_limit() sets the min_limit_perf to the
> nominal_perf to avoid frequency throttling when the system is idling.
> 
> This was found to be an ideal default but is suboptimal for users who
> have profiled their workload at different operating frequencies and have
> configured the optimal idling frequency via bios_min_perf.
> 
> Use the bios_min_perf (if configured) as the min_limit_perf when running
> with performance governor. In absence of bios_min_perf, continue using
> nominal_perf as the default min_limit_perf to avoid throttling.
> 
> Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

This patch I don't have a concern with.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f8d8288d644f8..a6e43db6efefe 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -702,9 +702,12 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>   
>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		u8 min_limit_perf = perf.bios_min_perf ?: perf.nominal_perf;
> +		u32 min_limit_freq;
> +
>   		/*
> -		 * For performance policy, set MinPerf to nominal_perf rather than
> -		 * highest_perf or lowest_nonlinear_perf.
> +		 * For performance policy, set MinPerf to nominal_perf / bios_min_perf
> +		 * rather than highest_perf or lowest_nonlinear_perf.
>   		 *
>   		 * Per commit 0c411b39e4f4c, using highest_perf was observed
>   		 * to cause frequency throttling on power-limited platforms, leading to
> @@ -712,11 +715,17 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   		 * performance too much for HPC workloads requiring high frequency
>   		 * operation and minimal wakeup latency from idle states.
>   		 *
> -		 * nominal_perf therefore provides a balance by avoiding throttling
> -		 * while still maintaining enough performance for HPC workloads.
> +		 * nominal_perf therefore provides a balanced default by avoiding
> +		 * throttling while still maintaining enough performance for HPC
> +		 * workloads when bios_min_perf is not available.
> +		 *
> +		 * When bios_min_perf is available, users have profiled their workloads
> +		 * to understand the best idling frequency. Use that instead.
>   		 */
> -		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
> -		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
> +		min_limit_freq = perf_to_freq(perf, cpudata->nominal_freq, min_limit_perf);
> +		perf.min_limit_perf = min_limit_perf;
> +
> +		WRITE_ONCE(cpudata->min_limit_freq, min(min_limit_freq, cpudata->max_limit_freq));
>   	} else {
>   		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>   		WRITE_ONCE(cpudata->min_limit_freq, policy->min);

