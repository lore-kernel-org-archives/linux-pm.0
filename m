Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A583B71AE;
	Thu, 17 Sep 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671571; cv=fail; b=KxsDsaIZAULD8cATqGrWgaezHAAgxqzQE6779OH/DPTMr1jXT7oJjNgx7GTu8Zz0UUWnv6Pb1nDLUqYoJ2Vfp4JsLhcAfdrmP0aBMTxrUwpUr/054Ls8dbNJZkV/7dr3up5YbrVpcIW1QDRCXp07qPdwYpCk1iHvAu/IQbYv7RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671571; c=relaxed/simple;
	bh=tg29YTX42MazPYzzrCdPj03Yln3W+7CPv8fS6FYIWAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uw4nAFudl1ZNZZwaalzek2b2x3eo3lMsNuMrn2ClccN22MSRAGenY44wFOx/0GP7SQ/Ekwyrij7q6uW9cwUD45EXUXFUYwCrrjDic8hAN/KFjBcBYbrWo/OzSt/QbeNWguNh/OwUND5C2yaESsrn0MgXL3jm20o4zkJ2WK3uoE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KE4Di7Wk; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KE4Di7Wk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdZDiVMwdI/jdwU7oDCGzBnRcKNw1SjbdV7J8yc+BJShrrbTlh5EJoNcPPOnqI+TNCdM6Co3/h4Atvqh7AsO+zjdNvTx54WiuTvMUl2TS2WNVQQ8vYnWr7AB4K8B4Auf8BgK05OIQ0d6XnqBhWM1s1v+RTYHWbbhnhOyz8M7Ze9PTm66DPQulNNFRxTW+DuEzheFbLjNc5/a0kt7WHbLg7rWStjvWzQjvpAzpvOOyZRXB1focR5NDYOu5aNuqajb2Gz0aVLgHlBwRjmxP6ae+MvOoYLjXoVqwjQr9rF7qavWM2LyUm27V+ATPR7ykskyEJJbnUEFh4fljqCMb9pf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82cQHuh5Qgo+fp1DcF6QU/KB+k+4HBH3Pkr1/vm+scA=;
 b=YFAwxFcp7t3ph+tK7tMAmBCVeD6Tw0OYYr0rZnfGDPxWNYn4vcVqXPbEN04OOMIrVN1QNH2IVaFV384IqxExAjIiZEqa2TWkDb1vUPL6XVIWkNJT+0tHmaYLerrqi5SJK86eBBmRODqx3gNVs3tiqqqbLG9ibX1E9erg8n6UJgYunJhK0H6NFN3VeqH5GiwLZXEMS/UrDU5dY33cEHkcV3DlkdAthUGQChtzXgqtkr3atd7sruPPe1AJ4g/B6S0fktY3TyDqS5Q2yiPZI3PLszD+y8gsQo3XaQntygIkaAez5/vH8Q777dNSAqQUCufA6kEFX0O72EglfPpawLDGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82cQHuh5Qgo+fp1DcF6QU/KB+k+4HBH3Pkr1/vm+scA=;
 b=KE4Di7Wkc7H1zTYhvPftYECHNOzmK81Pz/yJlhu+JH0rfbRy/CcetOlO3J+INHlBh16BIULFDtvGJvFO3BJYM0zyryMZ00XfVjQ8Wli4EP6Wj2PAp4LXtZ/n9iWFfKX3/B6/pwIrAxVAtGuqZRfZxDe/I7BBFPbD2kRozZCBXFqmB2ncbhxIDctq2xzZnjKA/J2f+4V0j5XNxrQHzh27bqqHkd26vnLaVOkD/H2bu1oqdRH+C5klOs02ExULMxyLUDfUFx5hSaijxBYXjf0Z+RfFdrm6ZdAiozcnky7arBPgvgwQdZ380tLI8sGLaLJDdnKGuP89w3XareyPuiDS9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:59:19 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:59:19 +0000
Message-ID: <19b236de-ec1d-4abd-a78e-17e4faa3b75a@nvidia.com>
Date: Fri, 18 Sep 2026 00:29:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Christian Loehle <christian.loehle@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, lenb@kernel.org, saket.dumbre@intel.com,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <20260806200857.601152-2-sumitg@nvidia.com>
 <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
 <753b98a6-b3f7-431b-a867-eccbfd15d357@nvidia.com>
 <26439302-6759-446b-a498-310c218e4102@hisilicon.com>
 <404f0fea-4980-4e7f-ae05-eadcc2b13d7d@nvidia.com>
 <7d250745-bed7-4e75-a3b5-17565d8ff662@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7d250745-bed7-4e75-a3b5-17565d8ff662@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::6) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f17392-50c8-4beb-5ade-08df14edc6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|921020|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KV2vYPmYv6WyeTtBrhoCjEmbJkcusmYqd+OWV4dZkcYuxt/vYI8L4CuPEJfNPr6uyi2AjtsGgA+ZYmCA+VaeYdrFji1oKOxPph/TnAoMrZ+OXayFW8fWobMkLkmyzKICWyyk1T2xv91J1jYfVL1yGB2uJFJc3G1/Df0jT7E3e/yE32fmfyUdlXqrBcxqDAyH8N+ZIZB1wbyMDaHkwxp1qED+UT2XaewKnfCy+fqTQLWXZSqLQYcntTVr1VutEMWSuxWO8c1nMVR92xQwleYjcExpQ+PFOZ3G2DwQrQLnYnf77zGb/IeruURA3VBBffM89edZLYhJHO6wy0GuaLqM4saTiaDWGWI/bJfTNmjgQ9Wze4LOF4vzm922Ur2yqxqDoFXbDIn1WG79e1xrXX5U1NzW5bHZB7f78oc9ilR/MUcQCNQ4sWw+M66YI8HAsKucHDxKRaIYx2THarHk0krZdQqni31lAfPYWRs/ADWSpb/kHZ4U4TDDxj3CdtJLacKz6D2LhAJjR3sctzt0g6G1seSF7f90dOYS8hfPPPyBO6xsyX7qekTkSm7NgNDGEQoO6Yrhmy1VZfimebP9oSy7xBDY+cg4Nklz1X6YyHHAPo3SHlrQfZJ97u31lT1JfxypIM2OcFp5BsqAF5mWk0VXFBTIUUVW3aq8qXCwTIHbrqMjYUhtWIqJWjjgC220QdexkNp2mxUvirlvvqWsGmwR5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(921020)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xTaml4alV5cjlEeXpOMytkOEx5NXhtODI5QThyUkMwaXFsSE9nZXhLVEFz?=
 =?utf-8?B?T1UxVnVPUWxab2tuN1ZGSUc1ZnVYUmc5QWdaNHBVdHQ3R05VZXJxZ3MxSUJs?=
 =?utf-8?B?SWNncytVbDhnUm5ZTXRobHYxMWtscnBiMzFmYWxlaXgyMDBzU2Z1cmVNYXUx?=
 =?utf-8?B?STdyUXg3SVRNTndLY1UwTjFqbmJaTTRMaFA0L1RxWTFZU1ZaMVlLUlgzZHAx?=
 =?utf-8?B?OTcwelhPeDlhbk9ZbUlsRGVUQXhXUFhEaGJvU2hCMk5DVGt2WFM3bVczRmFQ?=
 =?utf-8?B?aFhXaFlPRWc2ckplUjdpbTh1RHRGbWsrTXM3djM0NDU1SHAzNTkzZW5NRVBW?=
 =?utf-8?B?dGtCTzkwUjdPaS9DTHRYSGRlUXhUaDhWRUJvYUVsUjhrVkNYUkoyMzlrL3Nu?=
 =?utf-8?B?R2o3R1ZFR3I2cmNKRU9oY1h0Wlk5NTBCNmRQK2RmOVZ1eDFjUUxDQTdvU0hp?=
 =?utf-8?B?T3BQRWp4QUQwRlZxL3FzV1Y0cW1tc1RlRkJEcThzbVJyUVIxazMzUExBZGpl?=
 =?utf-8?B?YzFoekxBVWxMRUxqbjFEbGUzeUQ2MFY4QmJWWVRka1BCZHNmdUtaTU5OK0M5?=
 =?utf-8?B?TVNBQkRvK0dWdG5BNGhiTCtQN014SHVZcjhQZ2xXYTBoRm9XdkZ4UFFScVdp?=
 =?utf-8?B?MGxMMDRWQ1N4SU5ObDVneUJBb3ZtQ3dFc0l5cFFoWEZJUFFCU1BJMkI5Qy92?=
 =?utf-8?B?SFF5T3EzZXBGTjhZSElkK2pXSkExNEcveUUxMUd0K3hDblpabUtSOEF0dGRB?=
 =?utf-8?B?N2xCS2hZczBheUxLdnQ5VEJBYTE4ZTE3S0xqSmtJanpoWnFhWmFIeExkSnRJ?=
 =?utf-8?B?VGRxNnFpVzR2eExJNko1dVBXYkVJRVlTaHFmeUZtZVg3WEY5N0luYjNWNCtv?=
 =?utf-8?B?V3ljYWlOWHdvb0Y1RHpnaVBWbkV4a2txMkJXTUh6ejVmZkdLUUJ4ODJnUVU3?=
 =?utf-8?B?ZERnOGJ1RWhXY00yNDdnQUdyVEdGbFVUSVZTSUxqNnlwN3ZoNzNyYW1rSTZt?=
 =?utf-8?B?dXFkd3BCUWFLdGVZSUZaby9uUHM4N1dXT3hLOGxNZjJwS2xkU2M0QVdya24z?=
 =?utf-8?B?anJtN3RYOUViWVdSb1hSRG9ycXg1enVJTk1rYUM0T1YrNjA4NUsxTDFjd2RQ?=
 =?utf-8?B?STdoQWNtYjdoR1pCVStGT1lRWDNadHVISVRnb0hjdks5QkNIVlQ1NFhuUjRE?=
 =?utf-8?B?cHZwYWtESVBWanM4cjUrUzJHSkVxNEZ1Qy9iMklZZS9QVTRqeGV5TXdkSEF5?=
 =?utf-8?B?cEhwcm9Va2dxSGJSNFNhMFB5SDVxb2xmRStwMGdZM2dpYnRpTGV1UDlTRWha?=
 =?utf-8?B?b3hyakprdGRoZ3dlQi9QNy8wZ0VldFpOYUZkRTFxcXUzck1xVkJ6VndJQTVM?=
 =?utf-8?B?ZE1tczJQVHAraXpMV3VKaFA5NWQ0OUY2cjNPRXFpMCtDNHh3d1JROGdjdS9v?=
 =?utf-8?B?SWFRYWMvclZlNjZWYUh5S09uNmt5dXFGUTlReC9XeFBFNlFQYUw5TkN5MmtC?=
 =?utf-8?B?RWZLSkQydzU0Vk04dU9USnhiSURyMUpVZy9lWW5ic1lzWjgzemgzL0d0bDRw?=
 =?utf-8?B?L2NvNDBJeHFMeWRCZzUwMUlScHM2REJ4RDc0R2VhUEw2K2pEMEIyU1dldHBU?=
 =?utf-8?B?M0dGbFV6OUxZdStkV1BsdnJ1aWhpZXIrLzhHVHNTaHdXK2lVdkJGT1lBV3VM?=
 =?utf-8?B?WEFIOHJGLzlRTWJtaXdDeWdHdlJ2N1RGUnhHL2pOTVVhN0V0Tld4R3M2UXht?=
 =?utf-8?B?eEZXKzg0eW5zQzlrZHl6cEEwMUpOaHlSaW9VblZQTHNtMlNrRW1JQU0vYnJq?=
 =?utf-8?B?a213UFo5LzgxaEpENlZJTHRLRyszNnArUGJtdGxKVkZEQit5Z3RIU2N2VEpR?=
 =?utf-8?B?bmoxVFdES2VobzY0TVQ5OEI2dHAxbWdqaTM2bWNINDYyUllTWU9mM0dTLzZI?=
 =?utf-8?B?ZEZPWU9ObUJLUGsySDg5bXkzY215WWJjUVl0K1ViWk5DeWZlMjY5QmN4eWFH?=
 =?utf-8?B?dVE1TVZFZHhsbXk3QVJuNmdYTklvM1FOVWJLbXhCTWxqdUliYWJpK1RkTlBN?=
 =?utf-8?B?T2RERWw2N0FHT0E1U3lWKzJkOWM0OTBIM0ZFVDFsSExCaHFYbGZrbFdlNTV1?=
 =?utf-8?B?enBDcVd1ZnZvVTNqNndiNDYyQkFCWVlrV0h2QlpsUU1WcitMSkhZMENaQnpP?=
 =?utf-8?B?MDZ2V1ErMUE3NGlsQjZWcDZadlJOU25INFJTbzVwcmM4eERPSkgxNGltakJF?=
 =?utf-8?B?czErWDZDMjI0ZEhpK211dnpqS3RKT0lDNEo2Q2pFVHJQWEs5NkVvQ08yMUE4?=
 =?utf-8?Q?pUhVlcHsF28Lt14hCh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f17392-50c8-4beb-5ade-08df14edc6dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:59:19.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UQ+LJyVMHttkqoE7tNA3Oq91m4opQ1qQYb+qSn1nbgaDvHAaga07KB8WtbIKTQvLPJXERftz0ZRqrbfpyBobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108



On 17/09/26 18:38, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/17/26 12:01, Sumit Gupta wrote:
>>
>>
>>>>>
>>>>> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>>>>>> Without online()/offline() callbacks, the cpufreq core fully tears
>>>>>> down a policy during exit() when its last online CPU is offlined, and
>>>>>> rebuilds it during init() when it comes back.
>>>>>>
>>>>>> Add lightweight online()/offline() callbacks so the core instead keeps
>>>>>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>>>>>> This avoids re-reading the CPPC capabilities on every offline/online,
>>>>>> making CPU hotplug faster.
>>>>>>
>>>>>> Move what init() and exit() did on hotplug into the new callbacks:
>>>>>>
>>>>>>      - offline() requests the lowest desired performance, as exit() did.
>>>>>>      - online() re-enables CPPC and restores the performance controls, as
>>>>>>        the platform may have reset them. Failures are logged, not returned,
>>>>>>        as the core would free the policy.
>>>>>>      - online() also resyncs the frequency invariance counters, so that the
>>>>>>        first tick does not measure across the offline window.
>>>>>>
>>>>>> The restore in online() uses cppc_set_perf(), which writes MIN before
>>>>>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>>>>>> saved MIN could briefly leave MIN above MAX on registers not accessed
>>>>>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>>>>>> ahead of the restore when the saved MIN is above it.
>>>>>>
>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>> ---
>>>>>>     drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 128 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> index 80893844353c..4b3da9a3e122 100644
>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>          }
>>>>>>     }
>>>>>>
>>>>>> +/*
>>>>>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>>>>>> + * the first tick after online would otherwise span the offline window.
>>>>>> + */
>>>>>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>> +{
>>>>>> +     struct cppc_freq_invariance *cppc_fi;
>>>>>> +     int cpu, ret;
>>>>>> +
>>>>>> +     if (fie_disabled)
>>>>>> +             return;
>>>>>> +
>>>>>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>>>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>>>>>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>>>>>> +
>>>>>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>>>>>> +             if (ret)
>>>>>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>>>>> +                              __func__, cpu, ret);
>>>>>> +     }
>>>>>> +}
>>>>>> +
>>>>>>     static void cppc_fie_kworker_init(void)
>>>>>>     {
>>>>>>          struct sched_attr attr = {
>>>>>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>     {
>>>>>>     }
>>>>>>
>>>>>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>> +{
>>>>>> +}
>>>>>> +
>>>>>>     static inline void cppc_freq_invariance_init(void)
>>>>>>     {
>>>>>>     }
>>>>>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>>          return ret;
>>>>>>     }
>>>>>>
>>>>>> +/*
>>>>>> + * With offline() defined, the cpufreq core keeps the policy alive when
>>>>>> + * a CPU is hotplugged out.
>>>>>> + */
>>>>>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>>>> +{
>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     /*
>>>>>> +      * Request the lowest desired performance while the policy has no online
>>>>>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>>>>>> +      */
>>>>>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>>>>>> +     perf_ctrls.min_perf = 0;
>>>>>> +     perf_ctrls.max_perf = 0;
>>>>>> +
>>>>>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>>>>>> +     if (ret)
>>>>>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>>>>>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>>>>>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>>>>>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>>>>>> + * Lowering MAX is safe, as the MIN written first is never above it.
>>>>>> + */
>>>>>> +static int
>>>>>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>>>>>> +                               const struct cppc_perf_ctrls *target)
>>>>>> +{
>>>>>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     ret = cppc_get_perf(cpu, &cur);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     prep.desired_perf = target->desired_perf;
>>>>>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>>>>>> +     prep.max_perf = target->max_perf;
>>>>>> +
>>>>>> +     return cppc_set_perf(cpu, &prep);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Restore what the CPU may have lost while offline, as the platform may have
>>>>>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>>>>>> + * or the core would free the policy and leave the CPU without cpufreq. The
>>>>>> + * governor redoes the control writes, so they are best effort, unlike the
>>>>>> + * enable, which only a later online() can retry.
>>>>> Sorry, I don't quite understand the last sentence.
>>>>
>>>>
>>>> Will rewrite in v5 as below:
>>>>
>>>>    Report failures without returning them, or the core would free the
>>>>    policy and leave the CPU without cpufreq. A failed write to the
>>>>    performance controls is not fatal, as the governor's next request
>>>>    programs them again. A failed CPPC enable stops the restore, as the
>>>>    writes that follow may not reach the platform.
>>>>
>>>>>> + */
>>>>>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>>>> +{
>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     cppc_cpufreq_cpu_fie_resync(policy);
>>>>>> +
>>>>>> +     ret = cppc_set_enable(cpu, true);
>>>>>> +     if (ret && ret != -EOPNOTSUPP) {
>>>>>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>>>>>> +             return 0;
>>>>>> +     }
>>>>>> +
>>>>>> +     /*
>>>>>> +      * The platform may reset the controls while the CPU is offline, so
>>>>>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>>>>>> +      */
>>>>>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>>>> +
>>>>>> +     cpu_data->perf_ctrls.desired_perf =
>>>>>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>>>> +                     cpu_data->perf_ctrls.min_perf,
>>>>>> +                     cpu_data->perf_ctrls.max_perf);
>>>>>> +
>>>>>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
>>>>> Actually, I don't quite think this is necessary?
>>>>>
>>>>> The motivation of doing this is fair (as mentioned in v3), but what's the
>>>>> real consequence of transiently setting min_perf larger than max_perf?
>>>>> Platforms should be able to handle this.
>>>>>
>>>>> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
>>>>> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
>>>>> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
>>>>> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
>>>>> be able to handle performance setting cleaner if those are separated.
>>>>>
>>>>> I don't suggest we complicate the driver for now?
>>>>
>>>> Agreed that it is not hotplug specific and can be done in the
>>>> generic API.
>>>>
>>>> cppc_set_perf() would have to know the programmed MIN and MAX to pick
>>>> the write order. Separate accessors would let it read only those two,
>>>> but that would add a read before every write, including fast_switch().
>>> fast_switch() doesn't have to touch min/max_perf, but it did at the moment.
>>>> Caching what was last written would avoid that, but the platform can
>>>> reset the registers while the CPU is offline or suspended.
>>> Yeah, understood.  My question is still whether it's practically useful and
>>> we're complicating this.
>>>
>>> Two reasons.
>>>
>>> 1. Platform should be able to handle min_perf being trasiently larger than
>>> max_perf, otherwise it would be fragile.
>>>
>>> 2. It depends on the reset values of the two registers.
>>>
>>> I went over the ACPI Spec and didn't manage to find a descprition on what
>>> the default/reset values of min/max perf registers should be.
>>>
>>> For a sensisble design, min_perf defaults to be 0 or lowest perf, and
>>> max_perf defaults to be all 1s or highest perf.  In those cases, we are
>>> safe to directly restore the saved values.
>>
>> Hi Jie,
> 
> Hi Sumit, Jie
> 
>>
>> Agreed, those values would be safe, although they are not required
>> reset defaults. A platform could reset MAX to a lower value, such as
>> lowest_perf, while the saved policy MIN is higher.
>> Restoring MIN first would then temporarily result in MIN greater than
>> MAX on non-PCC systems.
>>
>> This preparation was added in response to Christian’s v3 comment [1].
>> I had already posted v5 [2] before receiving this reply, and it retains
>> the preparation.
> 
> I basically agree(d) with Jie here when I commented on v3:
> "I think cppc_set_perf() needs some prep first before using it on reset values.
> We assume that reset value may be Autonomous Mode on, right? So we must never
> write MIN>MAX and vice versa. I think we may just have to read and write
> the 'otherwise-offending' value first on reset."
> So I wanted to have this (as prep work) within cppc_set_perf() not in cppc-cpufreq,
> 
>>
>> Christian, are you okay with dropping it and restoring the controls
>> directly with cppc_set_perf(), as in v3?
>> Any general requirement for ordered MIN/MAX updates can then be handled
>> in a separate CPPC core series.
>>
>> [1] https://lore.kernel.org/lkml/40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com/
>> [2] https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
> 

Hi Christian, Jie,

Thanks for the clarification. I will drop the preparation from
cppc_cpufreq in v6 and restore the controls directly using
cppc_set_perf(). I will address the MIN/MAX write ordering in
cppc_set_perf() in a separate series soon.

Thanks,
Sumit


