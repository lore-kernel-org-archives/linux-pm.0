Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDC3E764E;
	Wed, 29 Jul 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336090; cv=fail; b=Y+ar0q9BxuJGlDxkxYt7jtwdNopiNav/Q4MTPqmqy58g77yX5M8GGRklNEBu52zC5MVRkjdeQEy/edthgfkS5lyQqATlvny+q0Dmf3lEWnb2Lult3K6/hwOzo6LCWMvctCjlPvGgHhoZiQnMfpemAFNn0S80kjOkBU/xgIeoMX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336090; c=relaxed/simple;
	bh=8L1uABaEPy3D0Y9rBGEhbIq5wijCiKsc1ffNgKksnxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe/r2bgHyj3+ZkFO/ySihNqWobyQhfhCkek6h4ln0kTcaAcWiI/CGXhhxyNFcXHrgpqCZUZDgZp7CVko8yuCxYMFfkf9BKc8OYRBguAZZK6vjxF4siReqsIzE/7XrAuiBCc5/Ykz5WoT3IMQqEVWYzWu+j541GHNeYZJ9vQgrO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5H44vXV; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5H44vXV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFL3Lyd7vyrWCPCka9RjPQZv+LC8KQ3IsPqaKjBZhKxMVnK1kUdYWPCjH/d6OVooKCnQ6fg475RZ2aIuRylMI15MTXKIxWmv0EbdO5fxAieQmY00G1ZgYATTyqq0BeM2761/O/trHJg1yLr6h6IOkITuSR3DluqpjTKvnP+762QE5di4lauj/ILPMSxr5mMe5YbjHLaDVAD/aOHJJ3Mab+4lcKZZ+xRV6hUdCDZsWAX3rWmM5cSuR3WIX7/CQMSZDxMbinm4MiWZ182BJAeJqIBkml58/q8e1u0p6u9WGkhDCsm3+zv1GJuSIgL/BnOEazwQ8pzedOVGwtMbjs2WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml3uZWyjIV4cukBCyKVlZ42lMx2L5mfJHXTSriVe7VE=;
 b=uzc82PsyiTL2D1HYjoNifEPWFPgqRR8Naf5KHGL8fbz69PZ10+DBspfoS0gljCDD4rolbNUyTuLAwL3YXE79V+tkMHUL8zz4T+AhW+PzmUpscK0bdAEftevaTtzl56zokyunkFn6lir2GV5qVmy7zqkxrXJ2hYlpk+R4CmrahTKK3LC2RjPJCQGNqCOJ/XBs/Qvp83RgOIm72D30XVg7p4PSu4/BAR/QXc/xHvJ2yCZns4PgJlWxbCBDvGX+bqhtsb12ljEcXEE/DqvFs/sAGrgmqQ9Xs13Br9xDK/WAK3V3lrByrGo9iBAsyrKNpZYuH8lW/oo7CnAlyRxPwEnu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml3uZWyjIV4cukBCyKVlZ42lMx2L5mfJHXTSriVe7VE=;
 b=d5H44vXV9H4KMvwK0OlFWS0sbYv72vEc63NUCSiae3sZlHKv489MA9HQyWL2kmeB3Wy4iv+uIaVTvjEBjH1oG1DM86YimrOeaT5DKI4mJQ2UVT9iQZyjh2oWRBQHQ0D8XlCcPFhJELTZW5X7kk5E6jAqqU60kEXTve4MpPFY2W8af3Pyo+NGACiMRbRYWnwjhFisQ54O7I3ZRrAMbRty3PZ8HP6h4jcH4RnN0iGHKyThrLfXKl8p3D93zk29yVABS7n8fFHtakmsgzwv4GsldXF2tMiw6OHZ/aR4VbLl39Z+OBmA6PDpdYTkD0D/t4KldYkJ5lyqkOMQFt9BT2iPig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:41:25 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:41:25 +0000
Message-ID: <d8296b93-9bc2-49fc-b46b-d7dd37af2abd@nvidia.com>
Date: Wed, 29 Jul 2026 20:11:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-2-sumitg@nvidia.com>
 <40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::29) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb9d78b-7b9d-4268-68ef-08deed7f7759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|921020|6133799003|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pr9d/ARvuUDcu3COhobSJl6nDnh3Mvf1mtUtViMbTNyHOqadZBqJKT2r1cVXrKilBfcyBEX7DxC5H05ljWO4hd/xDoZKHwJ0oodgNfNmSx6VhFma7cEYeyBgi6QZsE9a3NqsStf/MneEXlOdm77oEbk3cUfWH/yWQoY1UEw+2eCslEE16xIl0yiL2cOL74VOZn85PE3S+APj5pRDGOZW9woBTUHy8+oXkn4/AybN/hxddOc9rpfBdkVRuulgWwrVWPfDWo1R7W84P6NLeviVhm8H+/Fo2vzcxE/3KUHlpGFjbmvdbQvI46rRcABSMwMq2/rSz4iyJ4Y1ft2FyC5Dj6j2XZEfl874a4xRAE6oRBoDr09EbD4lN3Q+h62m9ymmuZBOax53mDYvUmLK6L3uys3shdTs8UahxM3DiTtPh7t00TVlEbdfeXdnGvrIl9lfDvMnAaggyOkC8HzPIi7F7VeJG+jseMhluhdXwgejBUZUy6WFP5vrTfF1vpHaVW8UsAHSHE2VAN4DnBST8QzjnDrlH7FI1Wf6v+76CC1AB95/b8qL1xMKQsUXUoLY9JNpoCfXvIFURnVfLJwouqIZ1+bON7kb4KijMhGKgNFX0/vh06NqgWW35rb3BHiByWwCt0pUBlE6r+P6+lIKHELHUpKxG6boxSl3bKtNDkYB+bIZkRHONxzBfeXaPUNMATOvyFPqa53y8M07M4aR2yy3hQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(921020)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjF5NnBURlZlK1p3eXBVN29EajNZdWR5UjVpbzFuZFNQRG9WanBwMndsaDFR?=
 =?utf-8?B?YlJtbkY1cWU5dTk4UGU0dGs1K0w1OEpHM2VvUWJDaGMxN0l3K005NXBnY1ZO?=
 =?utf-8?B?aDN0ZXJMWXJlQWpNTXJiMDRJNkRQamd0TnRyZU9EeTRaMzArb0ZNRjJ1MXNh?=
 =?utf-8?B?TUIvOFVWK1dnMHNObUQwZE5HN3hXUjF5aGlVQWNma3oxZlZhQXAyeEp1QS9x?=
 =?utf-8?B?V3p1bitpSlpTT000N0tiRGJoWTF6Mk1mNWRoVWh5UjRwZ21lYUlmbHI5TEh5?=
 =?utf-8?B?a1Z5NzByTE90V01JRkJVVGN5OGo0dGVKUUd5TXFPMEVpUEVqWGpOT3ZvSXdN?=
 =?utf-8?B?MjVqTkVJbkRzMStQeXJrTzFUdkJqWU9OZXRQZFVMa2ZMeTFZYWdrdnpVSCs4?=
 =?utf-8?B?N3VqencxdmJmem1QQ1Y3SVh5ZUFIZHNDZkIzTkdwdkQ0QjRjMWZrTTNYNXYv?=
 =?utf-8?B?UnBPR3ljeVB6U2ZySU9WcWVuczB6UnQ1YmRkSlZtbGtKcElOTVZ1d3BMNDZk?=
 =?utf-8?B?UzFObkhIMVFWS2dNRXl5azF4RDMzL0hoQlNNRXVlbWFUbE5VK2orcStnbkpO?=
 =?utf-8?B?QjlPcmZmWkdFbTZtcllqK0YySk1nZk9OTXlJU1ZSL3RTNzRUcnZaSFd2SjFH?=
 =?utf-8?B?ZGdkMXNKTC80VXZYOS91V0tKckZkbGt4N0RwYTA3SG42RHg2bEhGS1ZKSlYw?=
 =?utf-8?B?ZjZnMlZTSWdNVUdEMFlPaVBkZ2ZEOXZzNEJJaDBVSW90b3l5WXU5NFdpb3p5?=
 =?utf-8?B?WVBGb20zN24wTDhtRmxjdW9EWUxidDNxdXMxV1RNai9vVFBQcVg1Si9yWFNI?=
 =?utf-8?B?WDg4RDBQQjUzS3V3MEdUTkQ0cituQWo0Qjd6WW8rSjRkZ1pxbnR2alpFRmxG?=
 =?utf-8?B?aUFiUVJFNEFjSFgwU0JGOHFRSEZvTlRDTnZYL242Q3NteFY3d1hxSTEzOCsz?=
 =?utf-8?B?STIyNWtMNktDVTdRRUZwYjNQYk5wNVF3c3pCWXp5c3ZoTVhDa0Nnazl0Smha?=
 =?utf-8?B?OHVMaGp4ZVU2Uld5aG9VV25OZU5KNWdrTWNUTS8yV0g0bERVaFhhVmFwanI3?=
 =?utf-8?B?UGJXdUFOOUlwb0psMFNPOXRlNStaTkM5ZlN1MXdOZ3dBSkNsMmtTK2NnTHJy?=
 =?utf-8?B?angrbnpvTE1IUmRQeXZnQW9EMGUwOFRsY2FKYUJPTEE4cXpNa2hHcjdMQnVE?=
 =?utf-8?B?SSs2UlVFdGdwbUFiTGxvdzVFczJybTBkNzlONlVMODdzcDA4QS9RcEx5MmdT?=
 =?utf-8?B?cHArYy9OMGxSMy8vb2ZacHUvYWlRcDN1U3J3Y0tldk5PeEtFRjA0Smg0Y0ZY?=
 =?utf-8?B?Ujkxaldiclh6dlQ1VkRwc0MvOTRjbStPN2s1bi9VRW5vM0N2YWFMMHRpbkhh?=
 =?utf-8?B?MVk2cTJydGFDbm85WnBibThBUVhOd3lZQVJVWUtPSkpMcFlyQTJTaVMzaUMv?=
 =?utf-8?B?U1NCTFNINzR1alYvN0poalV5VlowTXEyWW51UXBUSElGZXpPSGk2R09UNk9r?=
 =?utf-8?B?QmhuZUdWZkZpb0ptM000eThtaXliY3E1VWxJRS90NHlyNVNwdXg4eEh3ejA0?=
 =?utf-8?B?czFmdHh5Z2sxRVRVcVcvYm5iVk1Xd083TkFpTlpRSk1tRlBJTUxRenB6NTNC?=
 =?utf-8?B?ck9rN2o5Q3IyL1Y0eURSQVc5K29lZis0dFRMWWZZTmdHVEtxa1l1Y0JLMFVU?=
 =?utf-8?B?V2JvY1hrT3FLaDYwS1pSdTRFNGxlQ1J6THJaSXlhU2xxQXpoUnFzOVN5YnFE?=
 =?utf-8?B?TlkxL3ZRb2lidmxRVTZacEt5YmUrWm9mVnBnTk5kVW1RL05GZVlmTEYrWHRn?=
 =?utf-8?B?NnVsemR0aTczUllyY3YydHpaTjFEcEppdzljVHZjKzVjV0s2dTlNQ3dHWXVE?=
 =?utf-8?B?eC8wcUJYczZSbnFUcUtvY0ZKZkcweExRRGpXUmUrWkVDVFNLR0V6aGdJRys0?=
 =?utf-8?B?MWJDSlg3amhaWjk5d3lhZC82T2pldytiMFVXQVQvZjJJZzd5aGdldWF6TkU5?=
 =?utf-8?B?TGg0Vm1haDJ6N3RjMjNFdUVNVXVqMjJodnhVWmRDSlRjTHRkTWFlNlI1Y3Fa?=
 =?utf-8?B?Z3ppQWJPMisrMC8wVDhzM1JYZlZ1ekJJWWttWXdBTnF6eHlJNXp2aVN6SkQr?=
 =?utf-8?B?UXJETUw2c1daUUJXU2dkQzBvVjVsMm5KSm1NMlJNSHpDZElSUGJnVzRaRE9C?=
 =?utf-8?B?ZlU5TnRLSW9zMVE0L2tERWJ2RTFZVEVRV0F5QmppTmpEekMraWYrYnFCMW5O?=
 =?utf-8?B?a1grdnJ3cG5TSEhKcjdONXV3QnFHdm4vTE8xYTBrdXJaWHdoSTRTM2VnU0xU?=
 =?utf-8?Q?QeFO7t2iNc5ERcbGmw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb9d78b-7b9d-4268-68ef-08deed7f7759
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:41:25.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvRkAN6qnJiQcMs/4nE2s6E2+Otw3clPVOORuZInhvP85V/dqGFQRJ3Qb/QauGGhXHQyp3Kf+KQ1iR9EWAQydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236


On 27/07/26 18:57, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/24/26 22:59, Sumit Gupta wrote:
>> Without online()/offline() callbacks, the cpufreq core fully tears
>> down a policy during exit() when its last online CPU is offlined, and
>> rebuilds it during init() when it comes back.
>>
>> Add lightweight online()/offline() callbacks so the core instead keeps
>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>> This avoids re-reading the CPPC capabilities on every offline/online,
>> making CPU hotplug faster.
>>
>>  From online(), re-enable CPPC, as the platform may have disabled it
>> while the CPU was offline. Since the policy is no longer rebuilt via
>> init(), online() also reprograms the CPPC performance controls
>> (desired/min/max).
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index f6cea0c54dd9..6dc59f99d880 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -722,6 +722,48 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
> What's the intention of continuing restoring CPPC register values here?

Yes, there is no benefit in continuing the restore when
cppc_set_enable() fails with anything other than -EOPNOTSUPP.
I will stop the restore at that point and return 0 with a warning,
since propagating the error would cause the core to tear down
the policy.

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
>> +     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret)
>> +             pr_debug("Failed to reapply perf request on CPU%d (%d)\n",
>> +                      cpu, ret);
> I think cppc_set_perf() needs some prep first before using it on reset values.
> We assume that reset value may be Autonomous Mode on, right? So we must never
> write MIN>MAX and vice versa. I think we may just have to read and write
> the 'otherwise-offending' value first on reset.

You are right. cppc_set_perf() writes MIN before MAX, so restoring
a window whose MIN is above the reset MAX can briefly produce MIN > MAX
on registers not accessed through PCC. I will add a preparatory write
that raises MAX in that case, followed by the full restore:
----
   /* min/max recomputed and desired_perf clamped, as posted */

   cppc_get_perf(cpu, &cur);

   if (cpu_data->perf_ctrls.min_perf > cur.max_perf) {
     prep = cur;              /* Rewrites DESIRED with its current value. */
     prep.min_perf = 0;  /* Zero leaves MIN unchanged. */
     prep.max_perf = cpu_data->perf_ctrls.max_perf;

     /* Raise MAX first. */
     cppc_set_perf(cpu, &prep);
   }

   /* Then restore the full desired/min/max request. */
   cppc_set_perf(cpu, &cpu_data->perf_ctrls);
----

The reverse transition does not need this extra write because the
existing MIN-before-MAX order writes the lower MIN first, so the window
only widens before MAX comes down.

Please let me know if you see any issue with this.

Thanks,
Sumit
....


