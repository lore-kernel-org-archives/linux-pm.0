Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DD04C0436;
	Thu, 17 Sep 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642920; cv=fail; b=cze9of27EqKg8B2KQaeJU9D+lt7TtTk5kzZRyrYeaXnmmBd9mLyD0ErS1Z/e3BKyz/lKjXKK47lyCQeVz35mZTGrO6ADj3wpbe1+YWBGYa9rYJTyGem7/uxJOCbwPIVi7tGLSVUh73LWakdnDtr52EKHyAfdyIoCxsysPqYWPtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642920; c=relaxed/simple;
	bh=YRqMmRdWYi8JsaS+O//UGJXv13MjTUqP0PeNVl+M94Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5nIvi2DEyz8YZ5+oL4840SdzQ0zLFWhyx1/QHXpnVLP52g1M4gCAsLV46JPTagNgGHL6nIKu7dhe4e7ClirvMel99/vVfMW3mksddqNIajYU+2UEOsAYAKxAie9hy/3Ysv2mq5ZqazXCP/Nuxx0XYKPHVpRoEwmFlKKWDkGMjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWCDY7rg; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UWCDY7rg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgSsiqv+S43RVA25AtzqxF3Hn+fhcoHsxN7+X/Ft2qJTouoU+sNIw6ihyQwpn4WF3Ym3uYrgFmU4qsaN1Q+L3B1JpiUS4L9xb/CWQ4j3+LBFLe4fjPAc5Wctsf+Y93WmzxIDR4sci2i/y39/iYZCmR5kbRsZzO52NqHcE3ZA7kE/90qtA1u/T7s/vyymqrxcJ7hwyCBNwRMeIDh/BsqprTvFf2zPY7ntMfbtGtp0/h5IVP0kDIe6LAVPHvsDyY2OV5HgV/zWBJbQYpk0/Ga/iMc/f5CYf0ahAS3f992BkNzbu0eK/lDfKENYJY935msYd5fIeZl2ju2wnKh7NhtHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2soHO5pqVhPKU0ZvTfbVCSI26pWUOxaocuEWCEw3AiU=;
 b=wCz+66CvwKibNxKcQ4T46Bic5fnHzbOPPSYTXMxozv2gdd5uSc3rpTgYJqlUNzs0+MWJf9sgQsc6gECimhj3o+TLDE2qG2Lb4K+Rl7jLo5jri9Bt9puYH6GhWR9kml3aXp1BJNZw0KJy/UAcHLkQJ5g2tKffNhsnOOkO+hjkE6oK/uIvR7WYP70JkRRh+jqX6CNyUEtb9VByMpZTsuKoW8GAwsDdg/J6Rk9eqwe3Kq3CmIFP+2BEzhmR5PfPF2o14GXMyTXaRJZtPmOMcdF0Nf3T+rZBl6y2ZXCnQb/zurrQ2+EBoR9/lx+77sLPD/kp4CD2yHo1zpWCff0RffBlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2soHO5pqVhPKU0ZvTfbVCSI26pWUOxaocuEWCEw3AiU=;
 b=UWCDY7rgWI1Bp1YsezsSzJqZG9kgpwwRQ8lcs26OaSLAFETufBnWT/nSNHHFrrdu/b2Yv9z+GZns02PHZ0I/UfienFgYGUP2Sdk3at2z7K0wD+zdKlPxRlwxyGjm4qBiqB0cT3oOxCjT8J72yThRKVbJ7s1Qk99nADMCsrS9yNgga5QncjoDRN+kLwIaDaiBFaAnezCBXLlQGIAiNTuvTVkQcBvT7i6aw85oxC+oQsf/7OMkvLQAVMbJyVSsqY3LB3107G4KpSkEa3QNT4BI9tuT8WqCb62czzoBaPVWgtcDX22Z128ikSXklWB5LZkiRj3DySV1apWgnBCm6OAd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:01:47 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:01:45 +0000
Message-ID: <404f0fea-4980-4e7f-ae05-eadcc2b13d7d@nvidia.com>
Date: Thu, 17 Sep 2026 16:31:33 +0530
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
 <753b98a6-b3f7-431b-a867-eccbfd15d357@nvidia.com>
 <26439302-6759-446b-a498-310c218e4102@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <26439302-6759-446b-a498-310c218e4102@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a77439d-e500-4ae1-d018-08df14ab101d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|921020|4143699003|6133799003|11063799006|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e6nDytxlyukQpjc5/EKpGL7/kwfCsaHzi6c4Z7zZ8qiy1QpYxdDIY4gNFU0+lRWn31ume1YS1yoln8OM5q2kRUbUVsNfaPnBVUDCmMCgSV5Ou0FCiNTww9k8s6BLy/pVB8Xy3MK6MtCA2G12IhXuwHKlMMD3Ob8j5Gp8tVOScKB9TXqggoz5W7GaLHhu+KE/F4twLdD259eHu+Fw+rB08xbEF8eJOWbxX3sOC0wFKhtNHPMdD5xKIwH+8BvxtUOx1QPYbbljwSM4cP+UIEkNr4XRdcZ4ggMMVnhjQIx5ruMw/e3uICFt8KqKxAg6zmbtjmed1Izf7XV/ta0ISNh9//RXEDyANzd+hltSuhT8Z9rKgCXB+QLVbS7mZYU/bm7NKaB1YBnVeBCHzd1H1nDWz6MhpPMHTAuymU9cPOlOTJKfXNM2P9+RFl1QcTlyxU5QREagrx0VH+FxIP4luyYUwQg74bDLsSpxjQeC/dElMkl1B4y/xencuIuhajxzGNXU/C0v3aU+w3Sww0MoVGJNCkw0bXxSumHmNUQ/PmagKXtzmfGSYTQUz0Xnqz7/DI7yp8iAXw5Y7tBxSXFhP8t84Ptr1+Y4+pxiWQJHyBQDBhRXdRXifbZQXvykLuKU7c9LOSVsBMnY5ZvcChuV6aDUsmtgmfq0wfydQTeruAEbPNNtW3rFa4FittHrfCDveOGuzVyCQpMAK782B1uRQx/ffA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(921020)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDBOR3ZJWXVxVkRqZmFvRk9mUWRueWp4Rlp2ME9OVFAzTXdJUWY5RW5JZENX?=
 =?utf-8?B?aThFU2lMVS8remVITm12QWdMbENYaHFaOXhiYUN5Z0NHYit3d3dEUXp3VE1k?=
 =?utf-8?B?b0MyL2pWeEliWVFma1piQTFqVGJsc0xOaWZKUDBYakozdXJwOFNRTmRyZlo4?=
 =?utf-8?B?QWhJb0VucVlsSmZJcmdjSDk0eHpZUEJwWUVzYjZFaEVSL21HVFFrUGoyWWUx?=
 =?utf-8?B?cExLNDIwWHN3aVFnaUZNZ3ZsbDlOTGtiNmhoTWV6ei96eVdQWGFPOTNUWUZV?=
 =?utf-8?B?V3Y1TG5KTTFhTDV4NEZGL3pFN1pyZzYyVmE0bXVzVitGbG8rdlMzU2JxMzEy?=
 =?utf-8?B?Nk1Jd3VDMCtMMjRIb0s5cndneGJta1NZVXVObHZXS0llZjc3MTM5M1BQUW01?=
 =?utf-8?B?bDFLZE4yV2Z0QXpjekJoNmlSWHlhbmZ5eHltN1VGcGptSFMvL05YRFZSOUc3?=
 =?utf-8?B?aFljaWJ0MVlTMWRMSHY1MFU1OEhHWnI1Sjg5RTBoS3VVT2RmR1oxZmFBWmFz?=
 =?utf-8?B?anR6Nzk3R3huZ20yTUsya0g1NUJDYU91NmxaTFFoUjdYWVhMV211UjlrN0Fv?=
 =?utf-8?B?RGtuajgvSXhJaDVlbEZEUlA2QWFPMmowazhCemJtL0pCVHZ5cVFzMUNVMmdT?=
 =?utf-8?B?TWtidUlkbHlDZ0dRdHhvZ2dpaGdJZnhoRzFMZ294aEdoSHRkVm85SjN1dGlK?=
 =?utf-8?B?czFXM2dWSTkyN3pGYVFPUU50WmtKbG9uTzZub24vUmNlSjk4TVgyRWxCRDY5?=
 =?utf-8?B?VTJwQ3FqcWZBUllYVzdqeHJsRDRsZ1JXSlBUSHg5N0tNZ2xxQjY0cTZTai90?=
 =?utf-8?B?MG5zL1ZteGFSYnBmWERqM25jcE45ZWREOHZWcnlYa3M1Tnord1hyMkVwbFQw?=
 =?utf-8?B?YW5JOXFudnhkZjMzVE5MZU1WRlJpaFpTRHJubGZyVHpCT1dVWnFZTGwzVFd5?=
 =?utf-8?B?cFpXRWxtRzBoUWpJZXVDZ0o2VXc3dU1vY0VuSkFNQUpIZ0U3bmg1TjJYOXd5?=
 =?utf-8?B?THhTVFJKV2NUUnM1RlVMdXVVRVA1S1RPZUh3Z2pMOFEzRTkwcDhyVjZwUjVh?=
 =?utf-8?B?YnJUZG9Rak1YWHZ6TmpBNlV4WXlPem1MTGt5TDhYbHM5anpVWEUxTmZnaEcw?=
 =?utf-8?B?cTFBZVBROXhWWTl1eTRXaVdOa2Vpclc5Nm1LQnp3NFRIcU9OVXVwSTRGb2wr?=
 =?utf-8?B?VFdaaytKREo5dkNTcVNTcWdaSlFBamYycnY0dTFHZ1B0UzhPT0Y4K21nakFU?=
 =?utf-8?B?TnJJNzRROHlLbHVnSDlqVHYwTnJzQi8rbEFscTZ5TmdZS01rZnBlU3BvV2Zh?=
 =?utf-8?B?VkNBbUhOVTVRVXhGRUFKbm5aY3JoSW9KVmNwTTFaSkthRWxrQks3Tm1vSUJq?=
 =?utf-8?B?MXBYZHh6Z2Y3cjRDSWxoRWExYmg4NmNpWnJzTytUMWRaNjNnZ1J0Y0Z3MkNW?=
 =?utf-8?B?MFhieTJHK3JYaWJ2WElocXB4TmhjYWoranFCNkJtUW10NzR6SjV0aGkyYTFx?=
 =?utf-8?B?QXg1RkJOMjNXWFpmeHM5enFoTXdDdUV4OEVPTW9na0lleHhWQzF6WWpwb0JG?=
 =?utf-8?B?MldWRFVjOEpnSXZnSTJ0UHlSOXNvU20zNmtoVmZ1UWpvR2pkQVRQbi8xREVS?=
 =?utf-8?B?V29xSVZsZlZMNGFkd2k5NDF2NHlBWE8zVHhLYjFYaS9WYW82Vjl6SDVpalIz?=
 =?utf-8?B?TEVSanR0bmlZdlU4amU4MFE3TmRYczNjbmFPUlZzQml2VXVWZnZxQXhEdVlO?=
 =?utf-8?B?WEx5UERMbEVMRklDcW9Hd0RlTkRkZW9FeDQ4elRuQU5JYjBRdytYNkxkMFdM?=
 =?utf-8?B?NXlxUGZCMGJxMlh6R1pRK2VUZmQrdkpvRmdIdGhUeGlmazhFQ0hJRDBqWWZO?=
 =?utf-8?B?QzlvUVJTVTlib1pQdXgzOHFQOVFhVGFyQXhvajc4WG5qWjZyaEFaNGlnZHVV?=
 =?utf-8?B?MUk4Nmg5Vzd2OWs3WDNWbTZjVXRwbnR1TGtlcVFoTG9ubVpIVWYzVTg0OU4y?=
 =?utf-8?B?YVBSSjJrSjZYZHo0V1lnemZucnhZN2dQWlJNazFsaGJaeFdRK0NqWkx3T1VL?=
 =?utf-8?B?RUhxWU96UG9yRGs5ekd3S0E4NmsyNlBuN04xRFcvUllOK3BNdUVJc1lIVStD?=
 =?utf-8?B?Q1F0LzVWd1B6aHFMTnJRbjI1ZjMzU2M4VTYzL1ZqTnRRcEhxVWsvbk91ZVp4?=
 =?utf-8?B?aHQwL2JNcjVvc0JHZ1RoYk1scFlCVEJIOXUwQWgxb0VQV090MmhsOTM5S0ZV?=
 =?utf-8?B?a2VOeUNMbkRlVjFJemIrMjdPTyszaHdQeFpnTDJmWjNjUVEvTGJjZlAxcHRx?=
 =?utf-8?Q?IBfW4Ho1DpOfmp9d0Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a77439d-e500-4ae1-d018-08df14ab101d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:01:45.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjeJkl1n8Nlyc4zR94blqtggI9JZX4seXpdWqd+iICgiITdZbjbxGiqDgLw959BjJ0Obt9UM9Hy6fs3OrvH45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538



>>>
>>> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>>>> Without online()/offline() callbacks, the cpufreq core fully tears
>>>> down a policy during exit() when its last online CPU is offlined, and
>>>> rebuilds it during init() when it comes back.
>>>>
>>>> Add lightweight online()/offline() callbacks so the core instead keeps
>>>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>>>> This avoids re-reading the CPPC capabilities on every offline/online,
>>>> making CPU hotplug faster.
>>>>
>>>> Move what init() and exit() did on hotplug into the new callbacks:
>>>>
>>>>     - offline() requests the lowest desired performance, as exit() did.
>>>>     - online() re-enables CPPC and restores the performance controls, as
>>>>       the platform may have reset them. Failures are logged, not returned,
>>>>       as the core would free the policy.
>>>>     - online() also resyncs the frequency invariance counters, so that the
>>>>       first tick does not measure across the offline window.
>>>>
>>>> The restore in online() uses cppc_set_perf(), which writes MIN before
>>>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>>>> saved MIN could briefly leave MIN above MAX on registers not accessed
>>>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>>>> ahead of the restore when the saved MIN is above it.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 128 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 80893844353c..4b3da9a3e122 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>         }
>>>>    }
>>>>
>>>> +/*
>>>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>>>> + * the first tick after online would otherwise span the offline window.
>>>> + */
>>>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>> +{
>>>> +     struct cppc_freq_invariance *cppc_fi;
>>>> +     int cpu, ret;
>>>> +
>>>> +     if (fie_disabled)
>>>> +             return;
>>>> +
>>>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>>>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>>>> +
>>>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>>>> +             if (ret)
>>>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>>> +                              __func__, cpu, ret);
>>>> +     }
>>>> +}
>>>> +
>>>>    static void cppc_fie_kworker_init(void)
>>>>    {
>>>>         struct sched_attr attr = {
>>>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>    {
>>>>    }
>>>>
>>>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>> +{
>>>> +}
>>>> +
>>>>    static inline void cppc_freq_invariance_init(void)
>>>>    {
>>>>    }
>>>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>         return ret;
>>>>    }
>>>>
>>>> +/*
>>>> + * With offline() defined, the cpufreq core keeps the policy alive when
>>>> + * a CPU is hotplugged out.
>>>> + */
>>>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>> +{
>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>>>> +     unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     /*
>>>> +      * Request the lowest desired performance while the policy has no online
>>>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>>>> +      */
>>>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>>>> +     perf_ctrls.min_perf = 0;
>>>> +     perf_ctrls.max_perf = 0;
>>>> +
>>>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>>>> +     if (ret)
>>>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>>>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>>>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>>>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>>>> + * Lowering MAX is safe, as the MIN written first is never above it.
>>>> + */
>>>> +static int
>>>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>>>> +                               const struct cppc_perf_ctrls *target)
>>>> +{
>>>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>>>> +     int ret;
>>>> +
>>>> +     ret = cppc_get_perf(cpu, &cur);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>>>> +             return 0;
>>>> +
>>>> +     prep.desired_perf = target->desired_perf;
>>>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>>>> +     prep.max_perf = target->max_perf;
>>>> +
>>>> +     return cppc_set_perf(cpu, &prep);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Restore what the CPU may have lost while offline, as the platform may have
>>>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>>>> + * or the core would free the policy and leave the CPU without cpufreq. The
>>>> + * governor redoes the control writes, so they are best effort, unlike the
>>>> + * enable, which only a later online() can retry.
>>> Sorry, I don't quite understand the last sentence.
>>
>>
>> Will rewrite in v5 as below:
>>
>>   Report failures without returning them, or the core would free the
>>   policy and leave the CPU without cpufreq. A failed write to the
>>   performance controls is not fatal, as the governor's next request
>>   programs them again. A failed CPPC enable stops the restore, as the
>>   writes that follow may not reach the platform.
>>
>>>> + */
>>>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>> +{
>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +     unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     cppc_cpufreq_cpu_fie_resync(policy);
>>>> +
>>>> +     ret = cppc_set_enable(cpu, true);
>>>> +     if (ret && ret != -EOPNOTSUPP) {
>>>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>>>> +             return 0;
>>>> +     }
>>>> +
>>>> +     /*
>>>> +      * The platform may reset the controls while the CPU is offline, so
>>>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>>>> +      */
>>>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>> +
>>>> +     cpu_data->perf_ctrls.desired_perf =
>>>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>> +                     cpu_data->perf_ctrls.min_perf,
>>>> +                     cpu_data->perf_ctrls.max_perf);
>>>> +
>>>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
>>> Actually, I don't quite think this is necessary?
>>>
>>> The motivation of doing this is fair (as mentioned in v3), but what's the
>>> real consequence of transiently setting min_perf larger than max_perf?
>>> Platforms should be able to handle this.
>>>
>>> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
>>> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
>>> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
>>> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
>>> be able to handle performance setting cleaner if those are separated.
>>>
>>> I don't suggest we complicate the driver for now?
>>
>> Agreed that it is not hotplug specific and can be done in the
>> generic API.
>>
>> cppc_set_perf() would have to know the programmed MIN and MAX to pick
>> the write order. Separate accessors would let it read only those two,
>> but that would add a read before every write, including fast_switch().
> fast_switch() doesn't have to touch min/max_perf, but it did at the moment.
>> Caching what was last written would avoid that, but the platform can
>> reset the registers while the CPU is offline or suspended.
> Yeah, understood.  My question is still whether it's practically useful and
> we're complicating this.
> 
> Two reasons.
> 
> 1. Platform should be able to handle min_perf being trasiently larger than
> max_perf, otherwise it would be fragile.
> 
> 2. It depends on the reset values of the two registers.
> 
> I went over the ACPI Spec and didn't manage to find a descprition on what
> the default/reset values of min/max perf registers should be.
> 
> For a sensisble design, min_perf defaults to be 0 or lowest perf, and
> max_perf defaults to be all 1s or highest perf.  In those cases, we are
> safe to directly restore the saved values.

Hi Jie,

Agreed, those values would be safe, although they are not required
reset defaults. A platform could reset MAX to a lower value, such as
lowest_perf, while the saved policy MIN is higher.
Restoring MIN first would then temporarily result in MIN greater than
MAX on non-PCC systems.

This preparation was added in response to Christian’s v3 comment [1].
I had already posted v5 [2] before receiving this reply, and it retains
the preparation.

Christian, are you okay with dropping it and restoring the controls
directly with cppc_set_perf(), as in v3?
Any general requirement for ordered MIN/MAX updates can then be handled
in a separate CPPC core series.

[1] 
https://lore.kernel.org/lkml/40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com/
[2] https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/

Thanks,
Sumit
....

