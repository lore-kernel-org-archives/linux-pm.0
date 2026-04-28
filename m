Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A440B6D3;
	Tue, 28 Apr 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380991; cv=fail; b=p5pQDVl6DRJ4p0z8zsnvwH+Yzmwk64VJR63563iBRAxwtZx4DqQo/lR6DHpj0FgeuHdZFa/Kxe0OG5PuhEN1baF68Elf15hni/fPZH5eIIGGLTEzZNbasL+Ps/TokcINnzpSQG2FRIXDU0sUVQs4gKjOBy8gFtjk1WXJvT1TNRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380991; c=relaxed/simple;
	bh=M11k5fALJjrse+IJtpf3wsVp1qBkBG6R83VkhxW9CGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9irpus72Y5J3+Jfc9BKy4zkr/exMybd1WELjpoFCE+BeDbJ1EcV13Ax0Plepsm/E75AVZJvrNDNPYoVRF2+yMHFaLI+uUupltaI0msLD+uiUvqW1shFpOL1aD06Knf3kyYT53Dl+cy3zXDz1sfRDQcNdbA99scts6QQt7U0ZpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjm1bjWT; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjm1bjWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxShfsvuA1YJw1lnpRLYWrqhCAMxk69eIGp8G7qiG3YmT7fdrHqlb8C0pE2gJ9Cdtn0FoGZLt91bV0XRSo7a04AhYi3KXZ8BNmeRcY3dXzGptDI3v97yL796xTkECI2D8wiIcoJSbG81ZVrpPPdajTs+I5/80Lo4cAlUxiNrK2JFpV5V8a3TDJgGyBWT86y3EByAfJRtqWq36pSpe4sOgPKi6H/GoMlnXhUDnFnTcL06c1WD2oRWpL0/EXi04qOmMte4SR8FXqLAi0Yr3/Z//cytpT3uGV1alq2OY4q2jQHC2Du3Q5/nCJN9hDSw+7BbZGjYq/T16SuOwQsrG1wO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abCosawTBKQX1Z/bksQ1K9KmQN3d1ZxWHDuE+ywvM5o=;
 b=ffwRohh3Ei4RG55Ctgub0tDD025LaPUM2jCsE/y0H6pMoFzxzFk8QFi9Xd4FR6ScN8dTM3Nk1edqk6G5pJEb6ojxejwzjcrObUSmeardF0Sbyg6LhdfGyG/ezfGU6itCOpVB4Q3Cir4uS7cQUau+z/uJeJY4G+sXQsu4HrOKa9MGVM6seBwKIqkAuOyNuPjpSkfb6P76WnAbE2IQPTKoIi4C1GHnm2fUpPsQGeicJtOV8dLOsmmZqqEkBIQME1nz7JwXXQT3NOo9p2DIujCuQxImsljBBnVfMk7WuingalPDE6wq1yywEdcxJeACjns3vx6c8cuawM1np3QjZHOQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abCosawTBKQX1Z/bksQ1K9KmQN3d1ZxWHDuE+ywvM5o=;
 b=sjm1bjWTE+CBi8wobvFShDd+0fU7hR3uVsGvIPF0K89/SCcDfMoPNs9TPAExFR32+j26DADlgk3lAg3YzUuRVSYRiRpNKUmop/c0IewnI50iiYpuVmJzcy60LC99HVRtSN1l0CsEuY7w1ETtR+imFIeLsAnRRSitdfw/n9bFuznOqEniNktM3LkE1qAmMaXA++SsiaAl5APZBDYdOPI4JN3wpasyvEpzo/Eu5dZxyw6+8ZSr00Y/dOjcXFxryn4hLOeXhen3vpMeg+rCv6UG4xUBd9HL5xP0kW0TcPckpApZwQqOhmF3asDHPVCR97MXmm1af0gdcqqdd+uXcrfucQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 12:56:09 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 12:56:09 +0000
Message-ID: <b0f17f59-38cb-4f08-bb9c-6f9dc55caee2@nvidia.com>
Date: Tue, 28 Apr 2026 18:25:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-3-sumitg@nvidia.com>
 <747cb549-71fd-4627-bca6-6aba3118bbe4@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <747cb549-71fd-4627-bca6-6aba3118bbe4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4fc1a1-5310-4793-1513-08dea5258491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ESbOAiO81pCh+SzLnu5D/OcZkm0uTk2Aipdg+v4c7OdIweOCMKWttQrEJAEzN0+XM5ScVWdCPtQwuY1IWjA3o7zo3/hzqktGLS8Xk6Y1t/R6wukb2Kuz7mYXNR5GqvFtpcy9EFK8aErXYJltjS8+88VERkfM55LROejeq1gYEfyqTtw4gjNNvS2UCEXs+B/A1L4tZYfLZj42IRu8vL0j9X6gvwTWQQD/n5hPHr2EkAXhd5y9mJ4iemmAeV9HAgdEnSal1CqmV+HwW//GhdSu8JgD6FfOJ+IG3ZwrASUz48tJorxqINcRSC038joyiUtokUAtBKEa9QPU/X0kauGq5AExkXGtXezvFC1UMzN2QO0JFvw4XaaTwEZvUWPw+N7J7ftJ4Yotw63tsgSXJoOd7O8L+ykLxhi83YMuqRECVKFD17R9j66j0KDR6jQyi2FuW+cNUvjrgnIq20rybdkp3v0Z/pVZuQfai96lYBT173vWX3hX8rYp3fszu9HBG6lg6vLwNc6pKOVXEWyouiaoe/qErICniT+u5GbVXHZkAZYTNpY7EZyJwnff3uyS4CEtyWSL22FYmWT8eZ1LHRiFlyGYtJIfBQ/zgmJbMH85z1VXEPiJD5vdUzwEgXL8yhtvK+gvLQeoDArUdieFDXIWkFHJCW0vPjMJ4pzwaUprKp5C2pfr+ujEinGYEFBAe2fHO0YL/1Yu31kvsNWMFOG8eoF4DmJTs5NA3Fzmt5jdYvBGTTtL3akfy9W/kb+7mQS0QpWJQ6qC+/3IaMsOBcloeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmRFZmticitWaXRDZFRxZHFkZDVveWVINkNNeUZXa28vMFZoTGhaSjJzWEF1?=
 =?utf-8?B?MkhOMjJGbWl2SlZaUkFtRE85UnhtYmRhWndVek12WjRNZGJNTTRjeHlRbmJv?=
 =?utf-8?B?UEYxS2dzNkdYbXdXb1Q4L3pVbW5PcHRVK0xTT0Q1TjJhMWc1eTZ2ek5NSGha?=
 =?utf-8?B?WEp1aUlUZjEvQkVVNW14WU9VVTNBWVJ1d2RDNWJneDUwV1hCM3RTb0pvYXQv?=
 =?utf-8?B?d1NJLzB4SHB1U1duOXpvT0xWbzE2eGF4NzNjUnI0VXhFNDdPSDB6b29zZjEy?=
 =?utf-8?B?cW0zOVBWYnhIU0hlRWdwRW02cXI1bkdWRGttYjk4NFBGWitDbzcvUG9IUC93?=
 =?utf-8?B?RTl3SHZjbFJLcnVueEhNRjcvWkJmRUpRNzhFVm9HeGVwSURkQWNLTG53UG4v?=
 =?utf-8?B?NUJIbEE3M2RZQTFoSmlFbXRuSGdSb2FLVEtQTUpLYVJUbmwwWWRuTG1NM0Na?=
 =?utf-8?B?Z1BDdDJSZFRDdDdoVnBDaHBQcVRpdmlnWGxYMDBNSU5HMGpDQmRPRlRtY0ZT?=
 =?utf-8?B?NStBYndKQUdDd3hvV1VDRGRzdVJkNS9kWWRUOEM5bXNpTDRFTFExY0VyOFNq?=
 =?utf-8?B?VG9tOUcrNDJTdytZdVh5bGp4T2NXQlFDamk1WXJJSUVSMDZsbGVzU1hnQ2l2?=
 =?utf-8?B?cDNVejZhc0VGNVlCRnhSVytwNTYrRHE4UXJKa1NVbWgwMzg3Wmh5MjRBMUhJ?=
 =?utf-8?B?RXZ2MVpuSWlicW5TVUpsY0s3ZVNjN0Y0NGJOb0JralJhWi82d2lZb2NIVXhW?=
 =?utf-8?B?VlFkS2ptMERxSHlWWUhjamgvd1ZUbHczU3UzQ1R3U21pNzRxNFQ2MGZTZVRv?=
 =?utf-8?B?KzVJTkExbXdWS1RJeHRMZjJUME9yaTFHQitCa3NYUEF4cEVzRkFtaUR6Z09a?=
 =?utf-8?B?ZGUzWGQzL0NYRitpR0IreVZqNHJYbm1sdVVDSldSUTMzaVFkajBiWUE0dnlH?=
 =?utf-8?B?VlY4VUZVYUZVTmZYTTI3UEVQQWg1WUNIVzF0YW12Y0JtcnlaUnFvUzMyTFM4?=
 =?utf-8?B?bWJucGMrZG45MUFmbGxjUHhlL0ZWd3lsTlpJV0hDYytqbk54Ky8vb2JHTGRW?=
 =?utf-8?B?Wm1YbGJoTko3WlA4cS84WE83ODRTMlpudHhRYmVpbnMxc0kyMGhnL2pENi8w?=
 =?utf-8?B?UkhNV0Ewa1pMTU1CR3VteXhiV2tqOEsyZVN4SlJOMlR3TVRRbWVVY0JwbGJn?=
 =?utf-8?B?MXJ0MWNGOXFXNUhIaUNNaU9ZSC91eHNEWVhxbXVWMjFNcTRvbVFSb2g3Vy9u?=
 =?utf-8?B?WmNmeDBuY2ZocnFuYUJwV3RpTldvWHgwNUVwWDNvNmFLeXlid0lDU0ZHZEFF?=
 =?utf-8?B?SmxUczBtTThReHROdHU2cDJTWFdZZjJ1V0taNzl0MCt4UkRGWWpTTExrNHYx?=
 =?utf-8?B?MlpIamxLWjZkMjh4TUEyREtvcHlyaWlZQkIyekVHcFVkOGF0MnFyQWhlSXp4?=
 =?utf-8?B?Ylp5MkwrQ0JicXFhV01RVDFMNFN0M1hkQ1RadDVPS3pjTzduZ0RlVUJzNUVE?=
 =?utf-8?B?LzI5QXY5ejRSOW9iRlZEbkpIMVErV2JKcXJJRzZBV0RGT3J2VnRDd1JQQ2JV?=
 =?utf-8?B?YWlucXMwdWZ1UVNhd2ptK20zVkVpMHpYUmR6bEx1UlBXUW94WHBRTFJIck1v?=
 =?utf-8?B?QzIvUm52QWg0MmlzaCtyd1hSQ2c0emJwK3FUaDVtbGpweGF1aXlxVUZJblUy?=
 =?utf-8?B?ZjlzNnNVMlNuZUVOUGlhbnhkM2YvWVhwOTlxTzE4aUFSUHYzT3lCOEt4N1lN?=
 =?utf-8?B?bkdxaEVYaWFhYVJRekdxeEdjaCtEK3I1ZjVqdnNuSXJlRWNHdnZ6WFcwdG8x?=
 =?utf-8?B?a0c2SHZuMU10d0RDZkRXZHcvcHVBR2xLK3J2SHhNUU01amhQYldFYzU0WDJD?=
 =?utf-8?B?VlNGYjYvRjVPckgram80SEdIajNxclo5cm9LWXVyRzFtYlJZWjFLSnJNMGZ3?=
 =?utf-8?B?N1FabFdFN0RHbE5rRkdLTGRCSnUxR01FYVJucVpkWWZDT2xOaVdCa1ZsSEVw?=
 =?utf-8?B?ME5CT0N1R0JkZXdKNFJic01JaXp0MkdibjFaeEtvRncwbmhnd1VyVnFtYlFN?=
 =?utf-8?B?Rkw1czVwVkFBWVBlbTEzYUNQL05qMERPTFhTTzA0dDNBaTBxWHl4L2dmMVM4?=
 =?utf-8?B?aTk2RDF6N2ptangrd1ppV0hWMzF6M2o5bXZDeHc2bFV5MEpyaGJKeEdmMStY?=
 =?utf-8?B?QU1xSGVNc0FQYkpSTFRQYlZSWjM5TmIrSXIrVW9IOXpXd1lHTDlNcjh2THRS?=
 =?utf-8?B?c2o1YVMvRHovbndSSjZIWDY4cTBLUjlHeGZ5V2VtcGlJQnV3Y1BpWXVxQTZq?=
 =?utf-8?B?LzFadE5KOTkwOGIwUFNCWkhxMnVNbnNTSXFkWUJDU3hMbDhZTXZZQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4fc1a1-5310-4793-1513-08dea5258491
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:56:09.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0f7Jrh+F6uonzHv1Cxahxf82LXRxfO1Eb0BZDapile5bNFiDe3bNEz7DtUKq2nhahv9mzmZ/zxIigDEaHVahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681


On 27/04/26 21:06, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 4/27/26 00:18, Sumit Gupta wrote:
>> Add acpi_cppc/ospm_nominal_perf sysfs attribute (write-only) and
>> cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
>> register (ACPI 6.6, Section 8.4.6.1.2.6).
>>
>> The register conveys the desired nominal performance level at which
>> the platform may run. OSPM can request a lower level than platform
>> nominal. Valid range is [Lowest Performance, Nominal Performance].
>> The value tells the platform what OSPM considers nominal. The
>> platform classifies performance above this as boosted and below as
>> throttled. It uses that for its power/thermal decisions.
>>
>> Initialize to platform nominal at policy init. Override via sysfs
>> if needed.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>
> Even though it's a write only register; does it make sense to be a write
> only sysfs file?
>
> I say this because if we're writing it at init time and we're the OSPM
> we should be able to track the state of what we wrote and display that
> to userspace if it wants to know.
>
> Furthermore; tracking the state could mean store_ospm_nominal_perf() can
> avoid the extra register write if the state we tracked is the same
> userspace tried to write.

Agreed. Will update in v2 to:
- Make sysfs attribute rw.
- Cache the value in cpc_desc and skip register write when unchanged.
- Have show return the cached value.

Thank you,
Sumit Gupta


>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 10 ++++++++
>>   include/acpi/cppc_acpi.h       |  5 ++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a1c91ce20cc8..83b4b14652fb 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, 
>> cpc_desc_ptr);
>>   static struct kobj_attribute _name =                \
>>   __ATTR(_name, 0444, show_##_name, NULL)
>>
>> +#define define_one_cppc_wo(_name)            \
>> +static struct kobj_attribute _name =         \
>> +__ATTR(_name, 0200, NULL, store_##_name)
>> +
>>   #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>>
>>   #define show_cppc_data(access_fn, struct_name, member_name)         \
>> @@ -211,6 +215,26 @@ static ssize_t show_feedback_ctrs(struct kobject 
>> *kobj,
>>   }
>>   define_one_cppc_ro(feedback_ctrs);
>>
>> +static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
>> +                                    struct kobj_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +     struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
>> +     u64 val;
>> +     int ret;
>> +
>> +     ret = kstrtou64(buf, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +define_one_cppc_wo(ospm_nominal_perf);
>> +
>>   static struct attribute *cppc_attrs[] = {
>>       &feedback_ctrs.attr,
>>       &reference_perf.attr,
>> @@ -222,6 +246,7 @@ static struct attribute *cppc_attrs[] = {
>>       &nominal_perf.attr,
>>       &nominal_freq.attr,
>>       &lowest_freq.attr,
>> +     &ospm_nominal_perf.attr,
>>       NULL
>>   };
>>   ATTRIBUTE_GROUPS(cppc);
>> @@ -1683,6 +1708,23 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal 
>> Performance register.
>> + *
>> + * OSPM Nominal Performance allows OSPM to inform the platform of 
>> the nominal
>> + * performance level it intends to maintain. This is a write-only 
>> register per
>> + * ACPI specification.
>> + *
>> + * Return: 0 for success, -EOPNOTSUPP if not supported, -EIO otherwise.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24..d06cba963550 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>               goto out;
>>       }
>>
>> +     /*
>> +      * Initialize OSPM Nominal Performance to inform firmware of
>> +      * OSPM's nominal level. Performance above this value = boost;
>> +      * below = throttle. Uses platform nominal by default.
>> +      */
>> +     ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_debug("Failed to set ospm_nominal_perf for CPU%d: 
>> %d\n",
>> +                      cpu, ret);
>> +
>>       cppc_cpufreq_cpu_fie_init(policy);
>>       return 0;
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 8693890a7275..ad1035b0e1de 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -180,6 +180,7 @@ extern int cpc_write_ffh(int cpunum, struct 
>> cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls 
>> *perf_ctrls, bool enable);
>>   extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>> @@ -266,6 +267,10 @@ static inline int cppc_set_epp(int cpu, u64 
>> epp_val)
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 
>> ospm_nominal_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_auto_act_window(int cpu, u64 
>> *auto_act_window)
>>   {
>>       return -EOPNOTSUPP;
>
