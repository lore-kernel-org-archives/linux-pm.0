Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECE3F0ABE;
	Thu, 23 Jul 2026 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842088; cv=fail; b=C7fxYD/vb/Zla7cbDeN5x8dwCMfp0vGuqczSO7ooK/raeQDa+evf4y6PEt16o3jEOLEnV0TsQnFwCfvPabytq0nARsixSe3wZw8KSKS7LoB/TTO8HIv9ZkRwX3QJnyD5Bve2gpzKY0A9wqr0ka847dDqYuKdpu5NT6GvN+hoqWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842088; c=relaxed/simple;
	bh=DX5upIsVj5oe3gY6Wcd5OMRaBvDzs1UaJbCL3OrUfD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JF3P/kIhne+ZuW0QCeCHGglRh0J1mdTJGrIkDJz7ZZ3EPazPJyfWOvZgPXsvWL04W2OUgUKSeuBqTop8bvdgG3HDJW4pPKI1DRFIKSpR5QXu09XMfUYtRN52ZZkDnbn0g/OW7mdFskNtPVg/yWZxGyy4DwrC4aWq/wTKJlBpV28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHl1lPNX; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHl1lPNX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiY9IAzPZjqc/aSe3C6F9gyE714GMhBSk8oaYaqRptSqn/rbcTPoPQEFzcmeC7pXaFtXxIQVVJjouk0RKQRMnlvOp3gQCpFyBn2RlRwfi0uAOnY99dFSJZt2d5EdTeUUNbvZ5v1OaxMG/+xaBAT4Etmu7cGhuuQkZJQOZG3I+K5U1BZjgaBTKmMXBiIBD5q8rbrK/rz/k/Gvhixrf4aJl2LH4ePjaN7XCqeP6q9RK92Rrb7SxxVe7p2w79NN0BZIga3J9sa1lYNyg1+tXJ2F2Zi9zAamAnSNSS46XWzl0KWDOLfGSnH42rGgIOa9Hz7RriLIP6mdrsQp57xFzp1J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGpLobtYDhrv7/FohssdPJ/CkwmqvQY63J4NzPdKGc=;
 b=dpP3YMr27AkGKbm+1+nzj9dA9wl9b+VufIWoZnIajczX/ewl6hHD8K2Lzs/lx/nXmw82o4V+SVUkUZQ9RqDwKC7V+I4/WmTsu5dPa3ck8Ua4K7XqDMNPISCW4ELqoaXignUdjRod4GQ9exd/rIIAO7MLPdX4F2Sr5Xbt4bW8QBgcHM6o6WP+mm4q3aMNmePwHcOJNorcrRyN+TDQ6yh9wr8PYMkyN6Uin/OlGF0q0RQGgU7BwbGiAAvEZ8AolSxZczFbGzDvG2/e5Bga3eZJ708qGiZDleVrQIHz7EL1c0UhZ8gC/ONvKj1UYth5Z6HoQg6zhHGFcmHiP2KfJHmekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGpLobtYDhrv7/FohssdPJ/CkwmqvQY63J4NzPdKGc=;
 b=XHl1lPNXsuMl9KzhyZFN4qHh/qnlX24igKgX9HWq7f36AYiWHcyqLAFf+9Fz31A0rZZ82vW9TBCA7Da5XiKqZoV8d8p3YnpP5LlAZuerCORq4fINIHaC3EnRhGX15AKnUo3kaKLSj9t+pDyseLj2SCBeWD/eszaRMxMwh2fKubbzkIBLbSSaB3+f5glUCEQmgflyAOii4iwICw8xIbqocJuioCziiffQzjiNiegfOgXN34DjH4ugZNbE+RFYav/yV8bS6UhH3yg4rBcVrdQzccKrP2U5n40Yqeh3xruS7x5z9LLYwU1X60/IngczYPJp6Q2v7wN0LWCPkz4ZwbK1sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 21:28:03 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 21:28:02 +0000
Message-ID: <697493bc-4879-45c0-ab59-6006d70d3428@nvidia.com>
Date: Fri, 24 Jul 2026 02:57:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-2-sumitg@nvidia.com>
 <bc0ba136-7f40-4198-8b71-557de0babc0f@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <bc0ba136-7f40-4198-8b71-557de0babc0f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: cebf07d8-4ed8-410a-a014-08dee90146b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	x0NYWtay+8quF6Y9F/eWw9DPTze3LweYv/sFsHm0VXiwntAWABTsQasWbqgRNMTEiEEcjWLd+QXihUKXtlpCzeJ11GULVqvlKaxF55ouD+oVF5N4DOP9iH7QF85ooBa3IWyvU3m2w8hor3ICCbva8oFAeXP2ALeBbGBo6LfL5pfmJbuw6hteADV6Wyvkv4TbULojxCES+uyo21433tuHnCw0PIcUEysCUNrkIBmxzYQZRQSpmkvpKwIIFFEtdP8HwH91HWcZ3kqKg4P2wFop7NDprYuefmKO3Z0JpCkjS/jo1vFu0jhiGBoDWgIMUECVRC0gDox6JPdvdV/uPR250/BpjwdxHwR3UgYVq0UpiNo5R+/pNBWxKmFtER/ql7r23CHxGOHGNRFfdqKL/Hn1yALF9Y3fQd+g9VPkwj+eVE3Gz1nBhcNP120PtuKrHzzdk7BLhM/C+7I/st46bK/4NVNt+KSHWD/+wfZyUV8iLdHG+7qfn07XR70EWGzl/hZnsCVMQC3iLowWqvdY5lX+4hyqZ8P/JjHp+ka9B9VymieN5MuDVNpx0YWT3bvmRw7W4gyNrqFUWXVJhuZ8CKpp5gqLFzr1GPYG9PxorTylPZ8AaED4eGm3M0HnrCR3unN4IYOGo1kuGAF3+RZ5H4OfIv1rWgn66pK0t8nFs+fAPeDtSCfTadQWnmuA6OFGbEsMq0/xPnwMtmLKyhTkAFuBJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXViUnNZcmhrblFOS1ViZGhzalpCQ2pVbTZKLzJkNFViRmFWbUVzTmpKZ0Ey?=
 =?utf-8?B?d0MrUXFhMk5QUE9NNm5JaU5ic1JjcHhNSVo2VW42Yytxd1RCUGlzNzJqZS8v?=
 =?utf-8?B?d1BnS1pnWjRiVVBud2JkYnJqL0oyWUxUdC9SYi9uUmNaRW0xSnZPOWJ0TVJ6?=
 =?utf-8?B?SnhRS3plMTVLWlFuZnNhcEdISFh1NHBzS1BmSVcvRituK3JzMmRJM0ZLM1kz?=
 =?utf-8?B?WWViNjNRZTJZSlgvY0JNMjRBanhZanVna25SMng5cUJ6eVNwdG5Wc2RWck1n?=
 =?utf-8?B?TDBCdWQ0MTdjMWtXaVFIc3Z0NjhwelpEdmxDMHFSbkhMd2xUTTVjM3N2WExj?=
 =?utf-8?B?YVdDTHR4UmxoM0UyV0F3YVRHWHdOdWZhQ0xoUzRBTFIxMi83OUlBR3VPNDBk?=
 =?utf-8?B?WTJSdjZwZmttSGd0WGVDdi9DRTFvL3NVQmFKTVJRSW5lZms3T3VHR1lqNFpa?=
 =?utf-8?B?RUdzYnREOUZmMUZPZk9hYUk1ZS8rbHA3NzJRMWpkUEJ3bFhkTGo2R0FDMXRD?=
 =?utf-8?B?eml4dWJHQTYzSWdWMmMzRUMwUWlBVnZ5MkZOUFYwc1BmT1ZBOXZnUXlOZGJq?=
 =?utf-8?B?VkF3UnpzekxhckxQYk10bm5wU1Z6RDNYNm8ybWQ0dmk4OHRUTi8yeS82QjI2?=
 =?utf-8?B?NEZBYzU4QlpiOFJBY0h4Qjl4ekdtdzR5bWgvaG1HL1RmR05mTnVKcmZsaGpX?=
 =?utf-8?B?Y1VCMjVaSHJBWi9hamg2TGZzdTBPYS9QQnlWbTQvT3krUEVVK2k1K2M3SEZs?=
 =?utf-8?B?WVJDeHM5Y2dNNE9OdWlWcDRsVk1CQVlLWWtjdkZFZG5Ea3o5cVBPaXhuSi9m?=
 =?utf-8?B?cENVdmV2NFBXS2plNGUrc3ZYNXdHdXhUSFNiVVhKdGdHQjlYNWVhRUNkZGFQ?=
 =?utf-8?B?aTd2QW84b2ZrTitGT0FqR3Z4RzI4NlViaG5HNUhMcXZNUXg2Yk9vZTJQVXF2?=
 =?utf-8?B?UFdQVFU0T2REYU5QWVFxZE5ZYjVhVVFnaHQxNjhoa20wQXlOSm5XTVQyNFp4?=
 =?utf-8?B?N2QwT1drV2gwSUVqUEFnL0l1aHE4OFhhRFdjeTdaYndZKzJjL3NDMGRvdjg4?=
 =?utf-8?B?WG9NQlBRVGI0aHQ5U0VhZ2NDc0ZYS1c5ZjZNdUZ6b3BIeU9KVU9Rc0grRDA4?=
 =?utf-8?B?dzhUdlFTS2kvQWpnWnF5ZDUrbysyMzZpS1UrUk1UcDlKY3pPT3QxRlN4SUo3?=
 =?utf-8?B?a2p3b2MrS0luN0hnVGRLeHlFMG9tZEJpNFdDUlYvVDR2TmtoZVZFV3NpNjdr?=
 =?utf-8?B?ZnFhUFN5VDdNTVZKZy82Wjdya291anArdDBvbUk0Y0FvVlVLdHlnbWpmZzhy?=
 =?utf-8?B?bWtyTmJzQjA5Y0wxYnViT2ZkVVh3eXc4Ry9KdFhqY2Y3ZUlaMnRESFZrdWpY?=
 =?utf-8?B?Sm1tUXVKNjZURENUM25EZFRTV1VRVnVKeFVubE5QYXRqVi9vYndQZjlLZGRG?=
 =?utf-8?B?ZkpFUm1ETm1vSldnWGxTTGlYT0FjYmhUQWNkZGxneDRGZ3poakp4MERSSVpC?=
 =?utf-8?B?MHFTOEJHVzZraHZNMWljV0xHdEZFZ1RuZHpRUjZTa2V0dllhV0Z0eDJQaFY3?=
 =?utf-8?B?amdwcFJxNjE0UmxJeE41VmFyT2xCSHdVY3BEVzR6b1BhNURjQ0dIOWIxWDg5?=
 =?utf-8?B?bUNHeXpHWXJNdVpFQTBEQVZuaTRVdFUrem9wMzAwN1Rya3g1UTlVVTJuMjcr?=
 =?utf-8?B?ZEJYeWpqZjlJbko1aElZemRvbWl2aTVDb0FMNmhJZXd2WWVtL1VHN2Fic0lt?=
 =?utf-8?B?ZHhJeU8wWlNZcXhOWTJqU0VYaWt1ejMyWW9zWmtCaEV6ZmVPcTV3VWZVdVBD?=
 =?utf-8?B?TW1PbjlFVmU2MW1XanhHZ3l2R204aGlSWUg1UGVxZWs3bGo5SVVCR0UxUGFM?=
 =?utf-8?B?MFlJYitROEx5WFgvRXo4YTlPcmtSZWNnb3Y4RE9heGtxaWxVc0I5RG8zK2lv?=
 =?utf-8?B?TDFxWk55dXI0SlhNbnNkelFCckZIZk1kYlVsVmlLVEVmWlRBMENyN01jYlRO?=
 =?utf-8?B?SXB0aHlQM3ppbEFERVdEWU1LeGlrTTc2b3ZvU2VQemZmZnhoQk9rUC8wMUlZ?=
 =?utf-8?B?amRENjJqMHdNbm9ZeGYzcnFzZGN4ZU9UTlFCeTdFYngzK1JwZjNLTHVHT3NT?=
 =?utf-8?B?eGl5bVE3YnEzUTFvcXp2eXJVRlhJbzZlT0pnUTJDVlZZdlUzc1MyRGpZcE5W?=
 =?utf-8?B?ZXZjOWpIYmRaVjJDb1dtcHZNUXp6K0hBZkhtQTNWZ0MvTWFMVUdHQm45ajlJ?=
 =?utf-8?B?RUx5MHpXSHNlR0lpbWJySExQLzJBYzhiWHFLbTNaeTVseDBDeFRYUmFtMnlR?=
 =?utf-8?B?Qml0ZmFaNFk2S2hTSExLeTdoczVaQXk4aVoxME8rZU9JU1VwM0N6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebf07d8-4ed8-410a-a014-08dee90146b5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 21:28:02.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHry9tNLUZBgqrtNCEKqemCUuAUZ0JFwXWvgDs+rd545YU7nVh9Ui+pdo4dkNatYrPM8afxkQDkrYVMwJe8JbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749


On 22/07/26 15:48, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/16/26 16:38, Sumit Gupta wrote:
>> Without online()/offline() callbacks, the cpufreq core fully tears
>> down a policy during exit() when its last online CPU is offlined,
>> and rebuilds it during init() when it comes back.
>>
>> Add lightweight online()/offline() callbacks so the core instead
>> keeps the policy live and reuses the driver's cpu_data across
>> CPU hotplug. This avoids re-reading the CPPC capabilities on every
>> offline/online, making CPU hotplug faster.
>>
>> Re-enable CPPC from online(), as it may have been disabled while
>> the CPU was offline.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index f6cea0c54dd9..432c6a6288a7 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -722,6 +722,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +/*
>> + * With offline() defined, the cpufreq core keeps the policy alive when
>> + * a CPU is hotplugged out.
>> + */
>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>> +{
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Re-enable CPPC when the policy's CPU comes back online, since the platform
>> + * may have disabled it while the CPU was offline.
>> + */
>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>> +{
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
> Keeping the policy alive means cpu_data->perf_ctrls survives hotplug, but the callback does not
> reapply it. A governor restart does not guarantee an immediate target callback, so the controls
> may remain reset indefinitely.
>
> I think the online path needs to restore a complete, current performance-control request before
> returning. MIN/MAX should be recomputed from the policy and the last requested DESIRED value
> clamped into that range.

Agreed.
Will change online() to recompute MIN/MAX from the policy and clamp the
retained DESIRED into that range, as described in my reply on patch 3/3.

>
> Also, what about suspend/resume?
>

Good point. On the platform I test on these registers are retained
across both hotplug and suspend, so I left suspend/resume out initially.
But the same mechanism extends to platforms that do reset them.
So I will add it as its own patch in v3 where suspend() saves the
OSPM set values and resume() restores them, reusing the online() path.

Thanks,
Sumit

....


