Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF63B6344;
	Thu, 14 May 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789524; cv=fail; b=YxlMdOGgZoy6U4UFnOIJYm2yoS6D9oGw0Z9jlxm5avgxfDbzHReQOfiM+DvKHJv2cKO7dE1r4mR93THbpYAG3ixK5eZ/NSVbAvQpaiQTYYmSHowFuTcQg+otljbwt3SAumzNLo5dlnsaJ5ISXH1X2WMCouXD9Cd89K9si8N7zVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789524; c=relaxed/simple;
	bh=NC1UPEmrqibzkRTVXbZ+Woi15ez52TObOHznaPBGxE0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GoPEC+e0TpUxHyhBdhulNifliyg5c6sfvnoOEuPlpoT8qcKOCLTih7pC82PHgkT+JZT9fwBIwgTYcAKXne02olMkqivJt6PNWIYfeUA/xU+bUVcHLb73qndZl515SaE1JGuUhC8In7roOkEFvkIzsCAoJ0vYgUPJPJr3FPv7hK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tSgXk6O6; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tSgXk6O6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/j/o+RF7IOiuPpaE4VsrZSUTSr3DgMTWkSnzBTv4yy36aeOmU3yTCTCaHYGJzU9Op+zUXZxLtSoid7KIBKVtQxIre9plZZbLV6iqNAiPz5md9/FOXqSHQ4A4GJVKjM4UmrcTNo4VV19tOM5SKZA9CNOh8ql6F6V/hC1v6MHRomDh/CXIcYWkVKvUNc538wDYE93XhMOGS1rWspbhX9f5Nov7agt+8uSsjzd42kwB/IhjW3l4+j4g6RtAL2rcyitfCKNljzKpxE+xCpRqn2ecPhxG8j0TJR+nanKy/0zUFz5IzpDV+8FttK+d0kGFv9qEw7e5rnCO+ntGDQHxO3K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM8g6xZvNLNoWxH5Q8XtSNcTUZr68ShU9zDBw0TnaYU=;
 b=iwl6auc1NUoHlwgAQdICW/9wTZ2MSMB3IXmQ6gMxKWBKYxe6tGXa/O8iKCbZQ95yUHfY2qR2X3mC/A76vXXmbq+ZRyaP9XPo7u18iCoo//PvkLH6gPpL0Bp+ntfUR7Ut46IP6UjjFrG1t1QmKM/6A1idd5IxZdklZYnyZKWFUXi0HQb6c+3vTpHk3j6Yf1PxAbirqXLkFLEoNMRu2R0SVMHx7bgaEA2rdAaQXzCgHHZS5GImc2dYjEXm/Ay/LsScVQW7NiyzT7Xy+/vEVunt2LOSm+/bQ+fLgYUwZl5kH0puSblyNxTb3jr61QY+32mLGVScIzTIx/eKtHwVqjvV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM8g6xZvNLNoWxH5Q8XtSNcTUZr68ShU9zDBw0TnaYU=;
 b=tSgXk6O6sjPYZCyGIpIjfnLv2yG8kzFb66BiRHGRG2IlN/pdfl/UQfUUSoCq6F1F3J+f2zWm5f1VlfQcVw6yVdPyJjBbJrICSws6Io2tmxLR0T3HQsw6/jkhucsC8iWSZLdryK2EWUuyPd6g3qnAS5iT3nRpRwz9Samct4w6SoO0rycWIwlVtb7U+tk/BrKlXEUxavUP8WhF0y/BtUmDgIfD2QuNx+38PMHXYfnhuOl4wdAA7f4583gv92I83PSuQhWts1rXV35zII4nc/kJ8aEv/DU1Re9N0bPwhWlTZGhlGMrr6fTDag+2C+jVyd0LstjuDg+BrnhhC7qhZ/EIMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 20:11:58 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 20:11:58 +0000
Message-ID: <1be44380-91cc-4eda-b7c6-43ac752c74c9@nvidia.com>
Date: Fri, 15 May 2026 01:41:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cpufreq: cppc: mask Desired_Excursion when autonomous
 selection is enabled
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 pierre.gondois@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513044208.161607-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260513044208.161607-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:8:57::23) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 372452f6-2be5-422d-27b8-08deb1f50d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	K6ZKbLjhwJfxLppMGlr8kwg3cYrVJboGQS8ANJMn2fwnmsSM7UblrgLl52ayEFiqPSXJJqHB4gd2w2vVT3z+nU9IYkoPQaSHspOfX5zSz8B0bxe8WdTHjMOL367+mMcU9Bcc7DrEMVqMoQpt0xrcm60aZ4meMSSdBQ7HF2O+SqelxRR7Uk0pdKUDpWn2fBxeubXo626qEbQs5JXGiQuqrYdYtv0zI45BG4TStIvpgoheIKgyeNSpuM6go9gCsTZU8gxnjPlp27/GCpeK+q1WktQ4im7xz8leqcQ9RLPETaaBqTSUCUeUWnxNMSxq9h+ZYqAQj9GtIhTwAkovO1WsDc5iOmNPXYFzCHcaLowHRfQLwT40sLnSe7/fqxiA73JoohKaSaJ6MCxNJ/D0lGD17idVNBJcujFgmMh12zRGB5WvA/XMyh6q7e1Vdks++m8D8OUGOtQzaeIM33d1aB1cBQwMl2xtH8tj/RyV6bSC+fB/xNl640uiOGTy3c+CMbDlSYjIvBpjDe7RpRar3UW8xYq1vFWTXafjeqNTZvV9udGtnJljTrbsgeV4fs0rccmR6x4B+OEutTMc7kUviech5/UMA7+Sg6jv8/mo9cVUzu91AevE0pkQPTOg9lQPQ/BRqdJfuh4V4X5uhxaAHRD/KDFy+nsdSZCd9X/l6u36zWacIxSrsPMPkHMlzD4R3fzF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRpL2MxRmRDd0RmMFhCZldlc0VtNXh6Qy9ITVYrblhUSk5QK0RHdDUrUkYx?=
 =?utf-8?B?eWNrZTZ5bDcrc20vMDZCc0pIZElyUlI0eXI1aUhzN0IxUnh6T3ljK3Y4ZHQ1?=
 =?utf-8?B?dStiQlU0ZmlETjBrQUxkS3VSWkQ4RVQ2ODg4d3BFclhLVnZhQ0JMekJreXVI?=
 =?utf-8?B?bXdCOVd3a0Jhbkd3YUZ0YUFpYWJKcTExYzRnWXl6Z1I4eThucG1hVUFPTER4?=
 =?utf-8?B?QkZUSXJXRVIzbDZkaGp5TTYySE43dWNCcTlpM096YnZ3MmUwQ3JlamxQNzZD?=
 =?utf-8?B?NkdyWjZXMnJzZzNHSVZKZWhxMjE5bEFJU1FKdHI5NDFTMXV6ZTFqd1REMERH?=
 =?utf-8?B?TEFVOVdCR0o2YXlabFZMdTczYng3dVQvNndZYkZkdzRRMEliNWRJemNFNzdE?=
 =?utf-8?B?Ukxic3dia1BCZ0Y5TGNCQW5lbEVOamRZT0lUcU9JNVVSNlBES2llN29ISXU1?=
 =?utf-8?B?cmQzaDhrdGlHYmdXOUU5VDhmNVljSFBpcWQ3RUNqM2Nxa3ZqRUdFQkdqalVp?=
 =?utf-8?B?N0JiTFYzblh1R2dLclR0cVBHQ1lHek1VTE5ZZTBXeXpmS2RVc3VORlRJdkNr?=
 =?utf-8?B?YWo3dVNSWCtXb3Q1SjhIWEZSL203YXU0cFdQMGpHN3o2Y2hVNFJ0ZVJXQSs3?=
 =?utf-8?B?eHJtUjhmTnhHR3djeGdCUEFDNzRzTlNQOXkwOGNQSTNQVFhTRXVDcms0ZUZ6?=
 =?utf-8?B?L2hpYzdZY0E5Tm4vK3E0SHlHdjFsM2s3ank5VkhaYW9lSlNlR2FHckVwbCtk?=
 =?utf-8?B?SVNOUVdHbjdaSUw0RUNyakl0dkN0RDJ6dFZlR2JlN2NmVkF1cTZhU1hKUWQ0?=
 =?utf-8?B?TnBWeDdOaHZ4bWpvZHpORVkyd0tReEZzVDQwZHplSGZZVkExeC82a2ZQY0FH?=
 =?utf-8?B?cDNnN1B4M1o0YTdtdVVUY3FVUEVqVG9qNjh1NWkxSFk4VWdKUWhwYncrRVY1?=
 =?utf-8?B?WnM1dTRDYmFGQklDSlMwMlQ2K3NCNVZ0bnVkTE50VWNQQ2F3TEZhT1h5SlJj?=
 =?utf-8?B?ZFFHa08rKytORCtzaFZyYW5aQk10WndIUThkaUZIRlNvZjBYMkVPYm5LTWVs?=
 =?utf-8?B?S2Q4ZVhjUXZ2MGhIS1hhbm1VWHJoQWJ6VVlVYTk4RFlWeXp6OTcxZ2s1Qkhm?=
 =?utf-8?B?c1JLM2hrS1NQMlgwMmZQOFV2YWZKY280c0tGOVczZjJvai8xMk5jZnBnc1h1?=
 =?utf-8?B?WE0wR241U0s1bUJwNmxFblIyRCsyalpsQjhqaUFqUGhndlJFU0phMTFpVCtR?=
 =?utf-8?B?MldvSG5YWTUwV25tWjJPUUVXRmlmUlhsbE9ZSTd6VjA4SjdzaU5SL0ZyNHF1?=
 =?utf-8?B?YTdrQklvQnZhemNRMDFDd2ZVdDRoN3Bpdm1nU1QxdFZiWlpLb01janFuQjhU?=
 =?utf-8?B?WHZGZjcyUHZ1RnU2TVViVEcybk0yUlVlS3NnZjFTTVFWTTc5Qjd4SzUrUFZy?=
 =?utf-8?B?Nmc3NVZ6dnBpeGYxblZXK1cvR215VTk1RUdCOXQ3OUQzTVIwNitwU2I0enJm?=
 =?utf-8?B?amJHY3ZiRFhSUjFwQXlsS0RISUMxeUE0V2pxV29TSkFQZmZNSUZrVXZDOEVJ?=
 =?utf-8?B?V1VwTWplRm14c3RJa0tJUHVxdFowakcvYXFwSmlJOE9EVmR2WEtOSEVLcDdj?=
 =?utf-8?B?TmVMY2xRRk5qd2dYRldIWVV6TytGdGVCd3VJRlJXdkRqMFhoUjFMUEZQSXgz?=
 =?utf-8?B?bFpWMHRQakVCdHk5amRHTDg5WVIxSnpDeTlFem9UeG53QzFNNitBaVAvUm5h?=
 =?utf-8?B?Um1ONnZjaXVHM05kNWE3Mk5KRC9nV1dPdXc0ZUdjMkFaYlZNZHlKVWE2UFFr?=
 =?utf-8?B?RWxSMVJGRW1MeHVmSlJmcjRiUUtEU3c2TFZYR0VwNlJtc3pRYjlISktFaS9m?=
 =?utf-8?B?aFpmMmcweVhxS3Bnd2dlS3JOR0dNZ3ZGbVlnMkcyKzR0K21KZG8vWUFwdkhy?=
 =?utf-8?B?V3VEOHZXUW1lOGtYUWw1SWdnc3YremFQV1Z3aWJFNTYyVjRFelBIUjhydjE2?=
 =?utf-8?B?bkcyeElZYW41aDZiSWpVeXRvdTd5ZnJLOVFGaWFjSlJicFNieHMrTDhhaFEr?=
 =?utf-8?B?ZE4zM0VjcTNhb093N29RRGZSZGhCNkxOQlg3bUloNHZZUXdHRGYxZXRxck5W?=
 =?utf-8?B?K1lPMjZielZaU21xWko0UDBFdkJqRm1PaWVNUFU1anZKMUtRRldCbFU0RlRo?=
 =?utf-8?B?cm5UT1FvWXAzeHJkUkM3ZlhFd3RJaThxOVpOcGdORWxvd2JCWDZ2TXh3eDU1?=
 =?utf-8?B?SGVzcHNnYTNTU3NwNjRNamN2aThQRlpwZ0owckZVZ3ZHZHV5QW5XWVlWWjA0?=
 =?utf-8?Q?eeCrmjvVlp0/RZHm6H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372452f6-2be5-422d-27b8-08deb1f50d66
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 20:11:58.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJsb3A2SuwMaNGUkrRngPkwW/0bRTORA+DGpoByj/SL7mbm1JQLifE2DgLgNFi1ObkjPS0eCxZ5d/P1McG/CpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595


On 13/05/26 10:12, Xueqin Luo wrote:
> External email: Use caution opening links or attachments
>
>
> According to the ACPI 6.6 specification, the Desired_Excursion field is not
> utilized when autonomous selection is enabled. In this mode, the bit is
> architecturally ignored and does not carry meaningful information.
>
> Currently, the kernel exposes the raw Performance Limited register
> value to userspace through the cpufreq sysfs interface. This may lead to
> misinterpretation, as userspace may assume Desired_Excursion is valid
> even when autonomous selection is active.
>
> To provide a stable and semantically correct ABI, mask out the
> Desired_Excursion bit when autonomous selection is enabled, so that
> userspace does not observe undefined or misleading values.
>
> Writes are left unchanged, as the field is architecturally ignored in
> this mode and write attempts are harmless.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>>, with a nit


> ---
> v3 -> v4:
>   - Address Sumit Gupta's review comments by reordering the
>     error check and simplifying auto_sel handling in the
>     perf_limited getter
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..d2f86df06129 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -982,7 +982,34 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>          return count;
>   }
>
> -CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
> +static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
> +{
> +       struct cpufreq_policy *policy;
> +       struct cppc_cpudata *cpu_data;
> +       int ret;
> +
> +       ret = cppc_get_perf_limited(cpu, perf_limited);
> +       if (ret)
> +               return ret;
> +
> +       policy = cpufreq_cpu_get_raw(cpu);
> +       if (!policy)
> +               return 0;

return -EINVAL ?

Thank you,
Sumit Gupta


> +
> +       cpu_data = policy->driver_data;
> +
> +       /*
> +        * Desired Excursion is ignored when autonomous selection is
> +        * enabled. Clear the bit to avoid exposing meaningless state
> +        * to userspace.
> +        */
> +       if (cpu_data && cpu_data->perf_ctrls.auto_sel)
> +               *perf_limited &= ~CPPC_PERF_LIMITED_DESIRED_EXCURSION;
> +
> +       return 0;
> +}
> +
> +CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>                           cppc_set_perf_limited)
>
>   cpufreq_freq_attr_ro(freqdomain_cpus);
> --
> 2.43.0
>
