Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FF391E72;
	Thu, 14 May 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786151; cv=fail; b=o5GLG+BmglznFpkh8GELXzqruGtBcPPO3YrkRCgxgoTLqVakbXHXi81K5xeEd8KnZIaTA9k6ULDDwszEmufa79rdLjWJNlvUoEDkzGqr2+ObDgklsurhLKdNnl7uUIhLlmX2DLXv3bCChdEoWtb1GqA2HnF3bjyXFHFDHUeJ/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786151; c=relaxed/simple;
	bh=FdqZdE/5KpZ/QJYEyYAVCTilAyLCNEfcBn0AdO3nxNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mj21zbTZAx0NcTKz6k/Js/fBlF9bZ0s+7YsLE/SXlYKV97K8cjZKF4lLcCXCpqjI48HXHPyuta3CIlIkaYLy5JynCuGlixezWImmZWhh2bOaiTrlOxk8WtQZzfi031rtFpKNIa4Ojk3OVb/xpJmPM5Ly+lswFNADQL6d5z5xxDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzG+F78t; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzG+F78t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGmOVj10XfK0F/FB6yyxRBwCy4sfYYtlUSmSWBRaMhRPWFLzGik0vlxNS3ZA8w2F+Ic9MP5LHLqH/bvRyXJ7k9lf2DysZoSaie6UFKhYRdimWrSqWhHQs9GumedQGOiu4+q3oQ5rxMfu+OENNp3T65TuXlg5UP1Hn1A64zetUankxwdyKj8nP5g6h3ZwrAFuJhioPlglQb5/pXr/RDYSQgVoUC+D2KlXeVkYGTszGbe1nOoryM3V3P9YHyGNag78cviiZ5oVwjtADvGbST47staACkuARfHGRQjNuwwf9BJ6EHTc6IoGRoA9usBOvckubwiO+i7tnOJzoFfFzUFnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdqZdE/5KpZ/QJYEyYAVCTilAyLCNEfcBn0AdO3nxNo=;
 b=oQRiiuBThUZfjSkIcVoxAJeIKBL/o/2wiiQwxK7kW0wdWR++IQCHSg6NuN8eu9ZYqFqml58HX+opwwEvBgTgJzvkW9UvFwnpfFTIdupWEyd+b6ip8p6DHLHqFKL4q58bKSFzaAychaBPsc0A3SkVbXrM5HZ/Wze1/2JpHktYn2Xj/D/B8jWpxAbGpCKCgPczMphQmZk+yVqb/Q5oe7fV9O9hizYwM6XugMM1PlvrMrp/YWHVlyG85nLiniafUwVUarJ3Jw3ZYHMLLCA72EC+MdAaeQbQCTrp7YwMDWXckpNA/QhqlcmR08em8pCteGTEfv+EUm+zAnR4ciHKrWVBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdqZdE/5KpZ/QJYEyYAVCTilAyLCNEfcBn0AdO3nxNo=;
 b=mzG+F78tsKKepXde84ckqJ+ZS0JKs3w7zkyrN5cwMOhD7uC+YM8FoaJrcZ0zmofSwSaRuZkva1jNn+Is4IgkPOw4LKy3yy6EXu+UpUnXVW5RnBNUsT5fo2zZ8NDa1LvKNVF6JGdVNi6Y4qSofKTt8TDD03tLNklQeRcy93CqgRoz6JKR0NPOGFqYs6k5EBr9cZ+rvW6/sSx2+tJDpkZ6+0XbrAQkLoc+ZoxklYEzQvGhzPg1hVhB6KYYA1PMGLYiag1D1XWkAbrxHu0L3G2C8OlSzAFCLFDBI5RkrKxZsUVgB+7NerIoxpHBIGrNsaGClbVppOG55fKC50eVh4sC3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 19:15:29 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 19:15:29 +0000
Message-ID: <f9295e85-5b02-4513-aec9-1523ed4329dd@nvidia.com>
Date: Fri, 15 May 2026 00:45:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <20260430142430.755437-3-sumitg@nvidia.com>
 <8516aeea-f20b-4afa-a737-1dff636f5c2d@arm.com>
 <9c32f75a-294f-4cea-810e-c011c4dd91ab@nvidia.com>
 <ab6ae808-f953-4147-ae48-419a196c5819@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ab6ae808-f953-4147-ae48-419a196c5819@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: d82b8de0-544d-4444-1af3-08deb1ed28ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|921020|11063799003|4143699003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CXiixHdFQcQM3wo4PXKQdaG8qoCCsQSxPXZM7t4VoUMqy4Qinjk/xNYrZjFMxGPpFFouRxMHZ0K+CPL504ERyzCtc0+cLDr8MkIR7hIReEXmHK5XWIQnOsGUAgpII0DEi696Y/VKrqscAziezTbY7oHexJuMqkTLSPU6zTnn/kNVA6OC2O8npKVxtkNRsfrHOD5njlMhJ1CICVQZecDTjgwLi4m0FqETdMtRg4q6yQIdm52U5PoxoGO9sDm0JCbFNMniSGUoU7VGYkwq/JyIDLhbBp4sXRkrwNHhQiq3OKM/AdZCSocmPVpLH9Rjfpr9plZcdvfkKovcJHcyI68hV/w1NPp9OalKRmvw76KnyAkAWwgdyKcfql18LL4RNOpFKkwYrxMEFwQYNicHvpzQZHIm0q00Q31+JNT5kapkDZImId9+rt3PGNSwVl/vSpnw+PkJb+P7msYwCnoA7hcn0QY0VTcOY6Seuu8+j+5d85m+2EVCxY58hpMuMQI1WMqq34jnggIK5zqMnc2G86tluSNhlmoFdlKmQBENKT0IG5rbiYkMH1kipNHktNLuN9uUiDTMy1VJspZ+XvApZV0wrpKwgU2jplnNvLIJ7pp5+TIfb1BoY7udIO85/U/jJAIAGobg0RhGtePU+XACoLHNexSTkB6SKltIQ/h4jfeqahgBqNIgDL4Wuhotn8L4lKv2A5figi5XuwCzl4Y/tH5UVthKB5TeeZkZHZhrhyTK/jA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(921020)(11063799003)(4143699003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdUVWt6TTZxckdlVTJDbUQ4UTcvZ28zaSt6aDVkZ3h5cWdWdHR4dGZLcW1a?=
 =?utf-8?B?ZlN4S3IxV0l0SFVDQmNMbHNPMW80SEJoeUZGREs2Z016Qnp3alh2elZScUVU?=
 =?utf-8?B?S09VSVhENmNxNUVJOWFFZU5JQmRxcUcyR3hTTVNuODZmZHBWWHRUZFBodUVS?=
 =?utf-8?B?bUZqZjZRMkozaW1aK28vWjhaVU9nS2tLR3NDZWwzNTd6cHhpWlVOSFhieHpT?=
 =?utf-8?B?aGs1bXdLQnRQREl0eG1saFI1dkxLdkRjL3lON1lLcjVkclBpQzZhR0V5T0dn?=
 =?utf-8?B?a0Y5WGxqTFZacnFEU25OOHU5M0ZLMDF0WWljb1I4RktPc3ZobUN4YWVTUjVh?=
 =?utf-8?B?YXA3dTBWbllWYWVHRkhYUHNHaWNsTFVCN2g0L0dGbjBQeFp6dFRTcGVkY1d0?=
 =?utf-8?B?WDNXRXpvSXlReVBDUFUyQmJSZktVMi9YT2VzUWtWcU8xeGZwK0lVVlZEczAv?=
 =?utf-8?B?R1ZYZ1VoMFdlMy9yWWhWYTdCbXN1azUrem50d0dRQjVJWGgxMnNXdUV5cjIr?=
 =?utf-8?B?STEzRVRER3ZTWUVNbDVNRkJZK2cva29VODJ5UVBtazlWS04vc2h2WXR4TFJ3?=
 =?utf-8?B?Vi9KenRsRnR5dHZqTXZmOHcwdWFMeUdhOGd2Ty9obkhsQWZYR2hrUjdjMzdV?=
 =?utf-8?B?ZlFxZWI2MDRIVVVDaXROTjE0UGw5Z3JnZXpuU2tDN2hFZ0FWdEFzUk5mN1hN?=
 =?utf-8?B?aEd0cDFhc1JIYlZ0d3lNSUJydHRDem1ySkhYMkRTMThnaERFSEZFVkRkY1Y5?=
 =?utf-8?B?YkZXak4xVE9qOGsxUTNoM3BtRDZLTU9hUzR5YXM0OG0ycGtPRTZqbUZTQkpv?=
 =?utf-8?B?YzRKTHp0Y0pLeEVNYTM2N2VCbjRNOThzUnlvU0llaStjSzlRaXpCY3lrdFZW?=
 =?utf-8?B?RFBmcUlRNExUVGh5U2xSc1lLa3VHclBObEYvakkvNEtQL1FDN2FFZzNwYlVC?=
 =?utf-8?B?SGJyOUtoQjloKzBxaVE4ZWpQd29UNWRLbEd2MFRCWm1ZM3JOK0ErSTdSenF6?=
 =?utf-8?B?ampDUnZZZ3ExbnNESjFWYXZPR3pHUTFxS3RFcVczL1dqM0V6N3FBcFRreEJR?=
 =?utf-8?B?L0VYaUxwQnJqZzZCOUVXR0RmVEVBcWFPaFBVTGlyT3BqSnY1aE9KQ01xME5r?=
 =?utf-8?B?bk5xTlhyb3NpVkIyWEFBNldVSThsbU9GM2RrT1lzWFpkNzhxSm9EdVNTUGpB?=
 =?utf-8?B?UjdnV01pK0NrdnIwU2F6ejBURXdTc2hsakFnVDRXZXBzN2V2RS8va2g0RFFK?=
 =?utf-8?B?MTY0OGhndk9ncDZYV3NKVDJOc2RNcHdnZVJpTFVVQ3ltaXdXU2VqQkh5MThG?=
 =?utf-8?B?ckFEQmRnT29jeTNXVTFNK01RZjRsdVJMcm52enhURmMxdWpLRXM4Z09LTjBy?=
 =?utf-8?B?QnJVS093ZElsNUxOdVhqUnNxU3AvK1FoMXpkUG9Od0kwKzFTR2tncGZtVGtG?=
 =?utf-8?B?Z0RJcG9pZURYbTZLTlZKYXdJUm5aWVhQcCs4TWZhQ2R2bWxKMGJkajllOTBh?=
 =?utf-8?B?UEtWN1ZHUTZRZzdVajBNc05iaEtKT1g2UTBkMnhCZ3o5eVRaWnQzYkpxbGc2?=
 =?utf-8?B?TTZJaENRSVBpd2k5MGVlc0NIOURvVk51dy8rTUZpSmJaWU9pd1ZERy9rNHFU?=
 =?utf-8?B?N01POVRkN2JmaVNaeUExTEdpWFRPWjQ5eTVNNHNuR0FraS9VcGZKNVJrMU1x?=
 =?utf-8?B?Q2svOThJYW9KNVpUenVmcWxRZGFBV2tZcUNJdExINkNLRXYrMzdidG11T1BV?=
 =?utf-8?B?bWZzVzI2a0t1RzZzTmtNM1Rid0xGZnN5cUFuckpXVUc1WStjeGlLS3VrdE8r?=
 =?utf-8?B?TlZoOVFHcjUrQndzTWRUbnhjaXZSYVJkQTZrYTFyL1o1OTN2OWtDRVU4cm5u?=
 =?utf-8?B?MGJtK0FFbDljS1NwSkljcUNpcWFnSnZrSFRBdVNXdmFIZG1QZDZMRm0xQ1l4?=
 =?utf-8?B?RENDRElCWUFhNWYxNEZvbDZaSGt3NFMxTC9BbWlYRkNzbkUzRVdQK1hDakMx?=
 =?utf-8?B?NW5mZXg1SnIvY1NPV0k2bmwrY3NsUGI3S1YvZWVpcEM2WDlzdHB0ZlZ6K1ZG?=
 =?utf-8?B?bTFlMlBwaWVPN1lKK3cwLzAyTHBsQk12VktOV2pXdnFkZGJyRUloNTJBK1U3?=
 =?utf-8?B?SDkzMGh2c21pa1Blbzl2TGtJampNdzh3b1Nxd0d0NXNrNUMrZVU5dm4vQ1U2?=
 =?utf-8?B?M1V2dllCaFJNMVlwY0pZN3ZSZlVkSU9VMUptZmxmN0wrbG1OS2N2OVhnMmlo?=
 =?utf-8?B?RTg3aStmbzNXbmJ6Y3lPaXpaZEhuYmZudmI2SURhalNVMWRVRmlyR293TWRl?=
 =?utf-8?Q?n5rGYE4kdzp5nC3aYE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82b8de0-544d-4444-1af3-08deb1ed28ec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:15:28.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICXi/n6VCgegsFR4ehuxptDjGEmiUUHNW/vFDpSVDeBNdhVmWJbth3YURbEkusqX1qOtEfcQXGy0X/G01HqYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456


On 13/05/26 21:13, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 7e7f9dfb7a24..d06cba963550 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct
>>>> cpufreq_policy *policy)
>>>>               goto out;
>>>>       }
>>>>
>>>> +     /*
>>>> +      * Initialize OSPM Nominal Performance to inform firmware of
>>>> +      * OSPM's nominal level. Performance above this value = boost;
>>>> +      * below = throttle. Uses platform nominal by default.
>>>> +      */
>>>> +     ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
>>>> +     if (ret && ret != -EOPNOTSUPP)
>>>> +             pr_debug("Failed to set ospm_nominal_perf for CPU%d:
>>>> %d\n",
>>>> +                      cpu, ret);
>>>> +
>>>
>>> IIUC, if (ospm_nominal_perf == nominal_perf), the firmware should
>>> not behave differently. Is this really useful ?
>>>
>>
>> Right, it's a no-op from the firmware's side. The init was only so that
>> sysfs would show a value (platform nominal) before any userspace write.
>> Will drop it in v3 and return 0 from sysfs until userspace writes a
>> value.
>>
>>
>>> ------------
>>>
>>> Also this seems like there will need some synchronization
>>> mechanism to keep-up with the boost state.
>>>
>>> If the ospm_nominal_perf is lowered and boost is disabled,
>>> a freq. update should happen. IMO it looks like this could
>>> be handled with (another) freq_qos_request.
>>>
>>> This new freq_qos_request, if we name it ospm_nominal_freq_req,
>>> should only be taken into account if boost is disabled.
>>> Otherwise, if boost is enabled, ospm_nominal_freq_req
>>> should be ignored.
>>>
>>
>> Agreed, will add the new freq_qos_request in a follow-up patch.
>>
>>> ------------
>>>
>>> Also, the function seems to set the ospm_nominal_freq for
>>> a single CPU when the policy might be common for multiple
>>> CPUs right ?
>>
>> In v3, after dropping the change from cppc_cpufreq_cpu_init,
>> the problem won't come in this specific instance.
>>
>>
>>>
>>> The issues this field raises seems similar to the auto_sel
>>> ones. I.e. :
>>>
>>> - concurrency accesses + need for a scratch value
>>>
>>> - what should happen when unloading the driver
>>>
>>> - the value can be set for single CPUs but we might
>>> want to have the same value for the whole policy
>>>
>>> Maybe a common solution should be found.
>>> (I m not suggesting anything right now unfortunately).
>>>
>>
>> One way to address this is to move the sysfs from per-CPU acpi_cppc to
>> a per-policy node under cpufreq (ospm_nominal_perf_freq, kHz).
>
> Yes right, would it make sense to also move the "ospm_nominal_perf"
> to the cpu_data ?
>

Yes, moved to struct cppc_cpudata in v3.

>
>> In the sysfs callback, we can convert kHz to perf and write the register
>> on every CPU in policy->cpus.
>> Concurrency is already covered by policy->rwsem at the cpufreq layer.
>> This is similar to how we were handling min/max_perf in earlier version.
>
> Yes right. Something I don't really understand is that similarly to
> auto_sel,
> the sysfs rwsem protects the state of the cpu_data->auto_sel field,
> but we don't really have any guarantee that another driver won't modify
> the firmware state right ? (maybe it's just not worth ?)
>

Yes, the cached value is updated only by the cpufreq sysfs store path.
A direct caller of cppc_set_ospm_nominal_perf() would bypass it.
cpufreq is the only caller today, so it doesn't surface in practice.
Same applies to auto_sel, and as you noted, it's probably not worth
chasing until we have more callers.

Thank you,
Sumit Gupta


>
>> Does this approach make sense?
>
> Yes right thanks !
>
>
>>
>> Thank you,
>> Sumit Gupta
>>
>> ....
>>
>>
