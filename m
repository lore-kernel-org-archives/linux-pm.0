Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8834BB5BB;
	Tue, 15 Sep 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473968; cv=fail; b=Fd4UUSpxWgEBT/QtXIqaT3dwbGj62HlGc6b66bTkX1ydESIUe/V1h5JkahfwyAnFF4/8Yi6ki+QGfPpA7L0+yFDvKjK6kUUDlob8/P409Vcj9Pyfm81GoaGxY9LEQjZyzQM54y+qVgWZxDUhIbYQGMhqwZderAKRIXQl/M7spKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473968; c=relaxed/simple;
	bh=j07Wd3/Awrw65l1zesqG1SGxVwicOpWt7BRb54sSOtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDI+JineR4KAGiqiLpvQK6EB01q/sf6Z8jVtffNFyDb44GAAQiU756Jk6/jgeTndrXtFUJQ0OQqFKxkHv50Wmf6nd5HJFo1b/2q6TmLrsU84oivhLOnGRQHfXL2aW+zZUGtSS5rRw4uvjd18Qn4KSE92tFrxHJMrCd5aS37jLNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hbn6P5yD; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hbn6P5yD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEwnfst6TH+OG9HvDVsxwwHfCwZEmq8vXPjOn1jOCO4/+Y/z3sfsXArMv197Vtvr4KYMjXeRNhUmjjLh+60Q5DlyuPpHfWdjv6o6RxmfIiRKkCMh5IwMNqQYHUQ0lCyj/NtZbpFA5v9GGfNvcfZjI4uu+Z8YWPmRT7/RJHUpj/bCY99V/vJsWVjMJ1d5QxvKwC5wbLZR43DQ0oiRB+d+XSlUeGufvmUMBvVlQ/ZpsWBht4AVbjRMYNCKideB1u+h+xblrQilzN9JX1Jx+fryiQuEM9vtEyjynJOxOa9S6ncp5bNiAE2O47XHBszo56W4l/Nh9elXF/GR+B8F2EzTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aAXjEcV3/PLh/HNyxN74MVtJRkIGNHp0R7X7X3xlIM=;
 b=Y/2Vmk//ndAOHks7FRPWHiZjPy3k+9/ikyqty0zxyGAaGWoiKfCMiID2rLW5EZuucWOZSPww8MrT4n2hEDaHwHn6Q+jceeUontXz/zWkWtA+UjUH0OEU+poYKxGeXVgm5oK3O64k+mEtJzewgJnmEeSv+TJKgW6LbxIM0eUbpWLxT4jbEO7oWYHROX6v/ONSyyJ5lVRjY0l4f0jpp6nP52H1QSduK4Phupm2jivfVNUM8HZi8UabrWyd66VXSdDPu3UVIleSbBxB2FBuLrf8buQIh0S9mJnxJ+BLhcdtRJcfHhoro9jvCwPGRVMP2upwFweMOtLGIW8lMDgXi9TnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aAXjEcV3/PLh/HNyxN74MVtJRkIGNHp0R7X7X3xlIM=;
 b=Hbn6P5yDVA9kg9PV1daES6SOHFFvfRccy9+sQK3ZK6TOhP9f/3Rbf8pF3HpHVOEMONlesiX8DAwnF3e3Q5DC28Ylcq6TdTpgCAsiSroy1hH//4NaHtdTc/D65Pi1IKeLcCcw2BhYpyLHFi90+pmTMuWbkpXOQ5oK9K5vo7yFMtARbHlXM/4AXx6lK/eHySLW6PmdX5l9egtvtqoQLin/7zS+LUrQzG0VzS/JPMO7fhSDWzcLngPcmlN0Pf2mJKkHnCM7CjNm1rSv10SE/g3urKYu5EhHoBnLXeOCMB36wozkBAnSIyYjTyuFdqmcx6M1KD4v759z8o8fJ0/hfWR9Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:06:01 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 12:06:01 +0000
Message-ID: <753b98a6-b3f7-431b-a867-eccbfd15d357@nvidia.com>
Date: Tue, 15 Sep 2026 17:35:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, lenb@kernel.org,
 saket.dumbre@intel.com, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <20260806200857.601152-2-sumitg@nvidia.com>
 <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::7) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: cddd7b44-cc32-4bf1-6982-08df1321b583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|18002099003|22082099003|921020|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Dib/00qK2iihgDyYkMbrDNAzi3r5YZU7NradXvBcr6Oa1Hrui49qAhe9Mgcf2ggbcyj5wxzKUwx+Iah/WZWXV7GVxmDPRg9MRE5JGYc1i97QetsTfiT1ytZHWmhjkC1G/Wsh3gk8nb/hqr4evX1SfH27cz9NLCurfBriDc1kvMFyjsh512oO9udlAH/QiJyRSZBjn7546hNXD441O93wCBd+DbPaUjT4DjFR8yKlbmQ7obI7zs+ZLUtL5w7/z+eZteNHN8BpTU9TZ+H9ceah8uCBV0AX+srZjcpZ8dpTokoC9u55MZlogmEKD1g0itj4IBS5rGnCs8MjoFMgw8ZcyFHz/yay6WI1fSLTgDDKfO3UR2zWnS1I+BaQxWJc6M0gGY+fO14yoRkkF6bc+032/2UlxsY5D3h/K2VlOiWayph4JXD7IWxFS67cLxM3F1lqJHrb91mszkoERWcCv1PAaBl00mKMiBsOFUrNiKLvIAxEmLAEcys4fjIgj/BiT+nt806l/OebHycLfsZ3wcezI94Lw3voyBuG8MnCGuEiZAlGCLdaEYHKSvucbwFsY+1sfPy9MZB3KGEWVpjw1ywdb8Je1HIXdNkA2mTbWuzE74nC/ZcRJFXH2vYeVlLHZB0jd5Ldt97TSeh46vG9NKoe3YNSRYj2GTtkdM3GRbNxyacrBahE7USdLebAp9OA/jq4Z0+qD4bIMKPxav7uaD8VNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(921020)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3pEanJQMFI5ZHE0bkc5bFZXNkFxb3R0OEVQTDJ5SmhKdG5QSFpIQnRlalZH?=
 =?utf-8?B?c1RxZlRUZ0VXcWdzdzVObWd1MjA0clNFV0VKZE9qNFNTUDRzdk4yTGRCTkQ2?=
 =?utf-8?B?aUMrWHVxUU40czhWNnBhb1dGcURMcUdaQU8vd2M3Unk4WEFsbW83T2tOK2ky?=
 =?utf-8?B?SjJwVW9td2F2SzY0elJvcGpUc3NGUVhYVE82V2R1aXROOFpnRTh6TmNvUGRW?=
 =?utf-8?B?STYvOGUrbDhPRXRQN2R3ZEpuUnl1aFJHeTdzMVVGeEpQUmtSNGE0VEZmNktY?=
 =?utf-8?B?enpIc044Q2IyWk1VYStyZjBEak92NmZ0Q1RVU0lxbUR4R05vYWNlUFZoakta?=
 =?utf-8?B?Tm9YanllS1ZjOEtSYlVZWjdCMytORk9kS0s2NnJ6T2NMN2lwb1RCdW9YTUwz?=
 =?utf-8?B?S0JETGllUEdDOXlJT1JYUURBSWNCandLUWhMK1J4T1FjNTlDNUVZYzhwMmVJ?=
 =?utf-8?B?SE9TcU1ndjFJUnJwbGdOMGNoYTB1NTd6RTU5UU5TbVBsL3NBSkJaTmtYWGYx?=
 =?utf-8?B?VHJ6VkN3bG5yUDVxZnFId0x0ZkhSU1RLYm8xRm1NNGF4SkhwY3V5Zis2anBO?=
 =?utf-8?B?ZWw0aENOQmlhQTdtYzZ4QVVDMElqK1g3Qm44QXRSdm1uclNxblk1SXFTdzN2?=
 =?utf-8?B?aGIzSitvVWQzclczekVjT1V3b3lMMkp3Z3JKRDNYNUtkQy90cWIyVDJNVng0?=
 =?utf-8?B?U1NwSFNNYUMzcjlBaUlWRXN5a0RNT29aOUd3czRzb0dnVmNvMzU3aFhHRHNP?=
 =?utf-8?B?S29EZVVtL05QTFdCbktDVnF0YWI3VlRVZHlyTGdKV0pTKzhxOFUwSTl3N1hG?=
 =?utf-8?B?TFJlQy9samgyU2hobFNIdHJudGptNkxWdmpJaTQvZE95NHB1S2hBSHl1bXdB?=
 =?utf-8?B?TmxYNFJqNnBUNnBPN3p1aU9aZk4vcjBjQ2k2Q0Z3M1FXYmxzdC9JQWx6Ukd4?=
 =?utf-8?B?VXd1NEpXODRpY3Nxc1RoK3VyaDZiQ3RVS3ZBVnV5cCswdlF3RnEzWkhHUjNG?=
 =?utf-8?B?cFRHWm9yWlp4UU40RmFmSW1TNEd5Sk03WTZEM0pOdGF5VUVMUGd3THJhNUpC?=
 =?utf-8?B?T0RWK1ZKU3BwdTBvV0NMWlcxS21SWGl5blA4dHZ0aWh3Uk1aYmRuQjJWa0J4?=
 =?utf-8?B?OTdkSytTL0NndlBFYnZTVGY5RENLbkVyQW1ha2NHWVpDZitQVDkyZ0VyK1hx?=
 =?utf-8?B?WC9qTEhwQlhPem1IWUY5Q1BjekN2UDFNWlBlaHh6Z3ovZndwM2NoS2RQdmVy?=
 =?utf-8?B?eUluT21nUVVJa2psV05HR3BoTVYzakdvT21tMkhLMkQ1NW9waWEzTE1aa0lk?=
 =?utf-8?B?aU1tc3RWUCt2MVdibDNad2wxUkNNZGFMSUtRRFpDNDFrRnA0ZElwZTRwUTFF?=
 =?utf-8?B?bVM1a3BxcFFSUTRHNlNGT1lqMUptc2RrSExlOEY3R0NnWXlLQTlGZFZjM24v?=
 =?utf-8?B?VVRWdkNYNTBXdTZzTUJ4bUVjRjFUQXVQV0FlbFdxd244OWZiSEd6U250WWNk?=
 =?utf-8?B?TUdJbmZvb0doWnZiZVF3eE9ycHZVblJWMW9JMnp4NU1sOVQrSGFOSzl4TGQ1?=
 =?utf-8?B?MjFOUnBIZXVMMTBuRFBsUmlnSlNqbXNZZjRzbXJhWEw4bG9ORmh4UEtLUmEr?=
 =?utf-8?B?L1UyVjNLcjVlYy9BREhFRE9jUENsZUg5UFVIWkpJNWVNbXRHSnBRSGxWMlNy?=
 =?utf-8?B?d0x1K1RFZkZBR3k3ak9WM01Ob0swM2pTODdMTm1SemdaUVNJMEN2T3NPVVU3?=
 =?utf-8?B?ZkJkaGlJdTFad3lzSm1QSzk2V0VzZEg4MDJaTTBXNFRONGloSUNnTm9qR05M?=
 =?utf-8?B?Z0Z5NCtBMDJ6eU9VT3RieTB4QkN2N2M2cElXcDFNblBHT2p3SWJpT2gzajdM?=
 =?utf-8?B?QTkrMkpob3hwYjNzSHpKeE14Q2h5WERML1F0bUU5SXJaMGpVQ25BSUJsZWtJ?=
 =?utf-8?B?ZXREMHlSclZtdjhuMmQxUXpObnFIcEhSWi80N29vWlk5aFlPNi9qN3RwNVVK?=
 =?utf-8?B?ODJjMGMyWFhvdE8xSkM0YTJmQ1FXOTJRVlVUcUc0VmJIVmJTYzFCbFdzQSsr?=
 =?utf-8?B?OXFJZTBUbThzbVFxYmxnMytEcTZoTDZ3aFR0MHlqdVdTT0N0bEZKNDJKc291?=
 =?utf-8?B?NGgydVVUbVNCVnJvSUpIblBlbnFCY0RjMjNZT0h3cnpKRXZPYzZjQktOM0VF?=
 =?utf-8?B?UFMxS01qVzRiOFpwQ0ZNd1ljME9LKytoWXZOVVBtZTdiaFFSSWt3USt3YVJP?=
 =?utf-8?B?aVFoaFZoS1BQR2h6QkU1SW5LNFo1UHVyYW51UVJLMUZIVGRCeTRnOFVFSzZO?=
 =?utf-8?Q?hlXnzhpQz0zj7DAQdh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd7b44-cc32-4bf1-6982-08df1321b583
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:06:01.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8yusCO4QKZQjS79bOqTFUu8uf3f+JcQl+EImSxYwR+ojIEftTLxL8zxEoXWq0rp8l3rnoPRvkY32QBvsDJsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676



On 01/09/26 13:54, Jie Zhan wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Sumit,
> 
> Sorry for catching up late.
> 
> A few questions inline.
> 
> Regards,
> Jie


Hi Jie,

Thanks for the review and sorry for the late reply.


> 
> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>> Without online()/offline() callbacks, the cpufreq core fully tears
>> down a policy during exit() when its last online CPU is offlined, and
>> rebuilds it during init() when it comes back.
>>
>> Add lightweight online()/offline() callbacks so the core instead keeps
>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>> This avoids re-reading the CPPC capabilities on every offline/online,
>> making CPU hotplug faster.
>>
>> Move what init() and exit() did on hotplug into the new callbacks:
>>
>>    - offline() requests the lowest desired performance, as exit() did.
>>    - online() re-enables CPPC and restores the performance controls, as
>>      the platform may have reset them. Failures are logged, not returned,
>>      as the core would free the policy.
>>    - online() also resyncs the frequency invariance counters, so that the
>>      first tick does not measure across the offline window.
>>
>> The restore in online() uses cppc_set_perf(), which writes MIN before
>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>> saved MIN could briefly leave MIN above MAX on registers not accessed
>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>> ahead of the restore when the saved MIN is above it.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 80893844353c..4b3da9a3e122 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>        }
>>   }
>>
>> +/*
>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>> + * the first tick after online would otherwise span the offline window.
>> + */
>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_freq_invariance *cppc_fi;
>> +     int cpu, ret;
>> +
>> +     if (fie_disabled)
>> +             return;
>> +
>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>> +
>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>> +             if (ret)
>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>> +                              __func__, cpu, ret);
>> +     }
>> +}
>> +
>>   static void cppc_fie_kworker_init(void)
>>   {
>>        struct sched_attr attr = {
>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>   {
>>   }
>>
>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>> +{
>> +}
>> +
>>   static inline void cppc_freq_invariance_init(void)
>>   {
>>   }
>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +/*
>> + * With offline() defined, the cpufreq core keeps the policy alive when
>> + * a CPU is hotplugged out.
>> + */
>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     /*
>> +      * Request the lowest desired performance while the policy has no online
>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>> +      */
>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>> +     perf_ctrls.min_perf = 0;
>> +     perf_ctrls.max_perf = 0;
>> +
>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>> +     if (ret)
>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>> + * Lowering MAX is safe, as the MIN written first is never above it.
>> + */
>> +static int
>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>> +                               const struct cppc_perf_ctrls *target)
>> +{
>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>> +     int ret;
>> +
>> +     ret = cppc_get_perf(cpu, &cur);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>> +             return 0;
>> +
>> +     prep.desired_perf = target->desired_perf;
>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>> +     prep.max_perf = target->max_perf;
>> +
>> +     return cppc_set_perf(cpu, &prep);
>> +}
>> +
>> +/*
>> + * Restore what the CPU may have lost while offline, as the platform may have
>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>> + * or the core would free the policy and leave the CPU without cpufreq. The
>> + * governor redoes the control writes, so they are best effort, unlike the
>> + * enable, which only a later online() can retry.
> Sorry, I don't quite understand the last sentence.


Will rewrite in v5 as below:

  Report failures without returning them, or the core would free the
  policy and leave the CPU without cpufreq. A failed write to the
  performance controls is not fatal, as the governor's next request
  programs them again. A failed CPPC enable stops the restore, as the
  writes that follow may not reach the platform.

>> + */
>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     cppc_cpufreq_cpu_fie_resync(policy);
>> +
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP) {
>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>> +             return 0;
>> +     }
>> +
>> +     /*
>> +      * The platform may reset the controls while the CPU is offline, so
>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>> +      */
>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>> +
>> +     cpu_data->perf_ctrls.desired_perf =
>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>> +                     cpu_data->perf_ctrls.min_perf,
>> +                     cpu_data->perf_ctrls.max_perf);
>> +
>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
> Actually, I don't quite think this is necessary?
> 
> The motivation of doing this is fair (as mentioned in v3), but what's the
> real consequence of transiently setting min_perf larger than max_perf?
> Platforms should be able to handle this.
> 
> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
> be able to handle performance setting cleaner if those are separated.
> 
> I don't suggest we complicate the driver for now?

Agreed that it is not hotplug specific and can be done in the
generic API.

cppc_set_perf() would have to know the programmed MIN and MAX to pick
the write order. Separate accessors would let it read only those two,
but that would add a read before every write, including fast_switch().
Caching what was last written would avoid that, but the platform can
reset the registers while the CPU is offline or suspended.

I added this in response to Christian's comment on v3 [1], so I would
prefer to keep it here for now. If the generic fix is still wanted, I
can send the core API changes separately and we can discuss it there.

>> +     if (ret)
>> +             pr_debug("Failed to reorder perf restore on CPU%u (%d)\n",
>> +                      cpu, ret);
>> +
>> +     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret)
>> +             pr_debug("Failed to reapply perf request on CPU%u (%d)\n",
>> +                      cpu, ret);
>> +
>> +     return 0;
>> +}
>> +
>>   static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
> For neatness, can we place the above functions after cppc_cpufreq_cpu_exit()?
> such that the order of source functions would be the same as the following
> structure, i.e. init, exit, online, offline, and perhaps, suspend, resume.

Will change the order in v5, matching cppc_cpufreq_driver.

Thanks,
Sumit

....

