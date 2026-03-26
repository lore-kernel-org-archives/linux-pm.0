Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FD3358D3;
	Thu, 26 Mar 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553700; cv=fail; b=ZH04d2Qobyc1DU0GyjfEAU2rEvoQCoHNXDbzIm+wvl5Fdy3c7cDU2A/OE5x5CHeobwHklH0CDWgb8pj8cx49AaeUsAewVaNNJ1kFP1F4Dn16iEhmKMltedlBwA4a8DfKNV5tuRSz2vETY9NPcfwa+qUGlw965mGA7NanbrVT/LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553700; c=relaxed/simple;
	bh=nWhpn+pHxraTyTJa7hQ/c2awkC/LPJnr863mws1FHaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2uoqsSnuLEWSdD5uBczmh/65USGx80Dc66r9yTUuqElwXALW3wIugYL/yKtgWEe5tVEWWLNcNuLJZfRc1253QgHrMm6I4AcnKJTSOjE8fFaZwAUF7tzwjY7F8pMjVpcEBUSST2oN8ZdCPSl4vvdg/LBAfiYHFCJ56SFOiHB3y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0SZjSgm; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0SZjSgm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=garrkJR/Cs2EGHKGEY+inCoIspVJPucz1CpVjd0dBPQC6ZMZY89OJ8oflyDjKhwwMZoDinpncOii22VMyz+4vDfdb30WWleYpixryTbSjFzgvKFrlDaCTZxuxJ5dutsxszF8ELoVSJXqqA46IO373sYWaKOR4yjes0qBrsWNPYbgB3r9SYvhEATCYUYIEevqpGRReEI6MnDRh6JvZsymCbdJxIazy46rXbUfLu9APuZ0rXnjqGu2vPmjkqtExQf3uaIal7ug7dcURH8aJ5D3H/dGgiWFibTV/D6iZ71xdSlGbrNNf2ApclPd3G2z5C3cfgG54s46DCRdOSobrouuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MTpOFr+CABxk1XTVuUuCXlvu6uJpr9nNPCjtXU+ULk=;
 b=mkfQKgm1Upv4CgedEygFAroAGpCefw1TAu2SPBVD0XfrDEwUPNfCaKVXAATwDhQZvMaqCjOa7ahwIef8tA+lxRvCxDNggVVfs/GVxhMhM594s5Lj1lwlli4A8YTaX5MdLbRTo6QoY7fCJ3N2HcCbSCvrm8OD2VJY09EYykNFHLjNpJUGjYG9iFbxahoNwv0ue8oz15hK5XyuHsMc6kuS0sHAO6ajltvhQRWRBo0zY/slQwRMIEnY3I213wh8TWU91yKbjt5NZodrn/TxagMdFCs7qefY521zk+bOixoGp3Y9zjCRIKt8FyWAhA/qXrwX1hg8HrT7OOm8i9jQC2Pddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MTpOFr+CABxk1XTVuUuCXlvu6uJpr9nNPCjtXU+ULk=;
 b=a0SZjSgmkkchjpXWs7GHsl2GB1eaYOQMFmgZYubmz5IogElOFdAU79Fz+fafA8v9PiizoZ0kn0Q6KDLsXtyaUDS/r+HdvAtEGYbsrvfkav+k2Ct8VoC/kQeq2oMzsd5X/eehviOzkoh+tugCZ7GxTp+MYIm7OF4tp3LJDJk9Npg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 19:34:55 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 19:34:55 +0000
Message-ID: <6ff31c1b-8d97-4e63-9397-c2e04ae997ed@amd.com>
Date: Thu, 26 Mar 2026 14:34:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] amd-pstate-ut: Add a testcase to validate the
 visibility of driver attributes
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
 <20260326114756.20374-10-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260326114756.20374-10-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:5:80::27) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9aa61c-5e62-4766-3645-08de8b6ec20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	X4KAWaZeK9+Ig15l+e9KCYCQDTOCZ/espxgqfN8lFWbiSqyjhuOPWybl/FZrYl2KVga9GhY1kJWXb/zOCOuGC92RCnj2J7MdYFWgKW18yK4ZVO75ODBjqaTNWSwkEI/QFBhdE1I+fcz/k+Q/wYvdNkZl5F7vDFGsAGQWdHH+94u+3gfc1wDpsjYaRG1cG/NGZbfGjbmcVFAAXPCDYK11wFtBBveyp7aiaPv8BomP5bW/7X9E7zz2juiu0hpJuX/GeAKOZI3WA4X8A9q4wnVHvPYkTF+/4IeXYlntmOqLZ0NRt66vdR5rGJUEnE1uVY9YAaWaQiK9fWFX1+8+kEQ55Itsuk6lZ+P3AYAMTPy2+c6R5TzmuS1iY63HAKgw+WwkFWNt1jESCmG/K57QG1YRj9JJwqqUbdeK608eWrzgX7Tge9lF3rFEZGwu1I/kxffCpTzZtQqbI38CCUuKEL8SYKyj+j5Wcy9o/xCl8XcRRvmGfUPrF9mwcBOJQBFOAjmSZXo8Cbdg+nNVMNodJSc9d0p9xl6Atrv5giCEq2JnfSC3HMPCI8lmJNapeb3dOLVZy6qa+fcBHorf1ecjc3PIcVTZYbUvumz6GRYR0rsjAPsI9/SGXJNxA8/ElUH6GzXKahwsszeFfVx/KZAOWTCc08z62Pn887p2nSAs+JLhOLb5XW4QoYPOnmWy0yx8UbfFzaDk+P4YgYUlb78exZH8d3VaUlIcEsRESyRtAuN3ULE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXlIUHovb1BzRWt3REZWV0ZyTUxtY3FEOU5sRVZsQ1JFM2MwdGlkS3p0Y1NC?=
 =?utf-8?B?Y1ZscnlvcFh1SGlwaithdXIxRjcxNXd3WFBWT01QZjVXejRURitNc0FXZXc2?=
 =?utf-8?B?U2h5UTBieThSZzhoRStndlFFdUFLZkhlREpVS0RiK282UzZRV01DSVByc2g1?=
 =?utf-8?B?S01qUyszSmJORW1ONFRwbW96OU1oM0N5REdlTktydkJBWjdtSExmRVhrb1Y3?=
 =?utf-8?B?T2tUVlltN1JMNVcvMmU1cGN0Wkk5SkpmU1YwRzlNV2R2UE84RDNZc2lGMmQ1?=
 =?utf-8?B?RnVHbC9EdmFLVjFOZ0xKSmRIekJCalY3Ui9zY2V6Y1QvN3ptUXJMbzg5V2VE?=
 =?utf-8?B?eTB5QW4rN1BZVWlmZ0N0dlNKYnc2blhscERkbUZOdndybW1DUFhrZkxsWUxm?=
 =?utf-8?B?YVU1L2svc1g1bzIzRktzallnc2I4em03RG04d0lBMWxNTlBoT0NyNDlkb1VY?=
 =?utf-8?B?ekNCR1gzbnZkZGgvZmJrcUxLQ0NyRmZZOWwwak93QnBlQ2t4YzBjNlhyRXZl?=
 =?utf-8?B?ckhsR0VkZitUak1sK0kxazZQdE0zZjFkZVo4ZUd6Ynd1cTNTS1BJYkdCM3p2?=
 =?utf-8?B?Nzc1OWwwdE44NVFSMmpCOEZYVkxwTmhUVS9Ucm1QSDV3Q2NwQ0p1WjBRTVBi?=
 =?utf-8?B?SUZVMUpOdFIwUXduazllcnpzOWpzSU1JSFBTSFp1U2lBUCtnM1VLbUNLZ3di?=
 =?utf-8?B?ZFkvVWMwMzM4aGx0cG93M0xWOTBLNWlBbmU2TVZ4Nld2NUU4R3hQNHdBdXBz?=
 =?utf-8?B?L3NlRkthYUZjZEtUdWRXenh1Y2VvOFdSZVJVYUdTaDZ5VDRkQ0RReTdwOGc2?=
 =?utf-8?B?TThIM2N6RGhONURQUEZjcnRpdXFJQmRTSkk3dE9oSWJBc2IyK091YUtjUVVn?=
 =?utf-8?B?MlFhMmhBZ3hQZW80UXlvVHJnMHdhK2VnaSs0YkYxVWVSTzRJc0hsTFk4eTFj?=
 =?utf-8?B?aVk5MEt0bjdlY0RUTWwyU3BQaVJLdkJScWVJcDNzelp1Q284QWdYTUpiZjMv?=
 =?utf-8?B?RHpRR2NtNXdzVTFjN2hzNGhydU5DSkpWWU54MFdTa0liRFBsR3pTTithNzc4?=
 =?utf-8?B?TU5JS0MwMVk2c3dzZ29BeG1uS25sajlaS0ZQdGRRbG5UYXltdi93aXhEdDd5?=
 =?utf-8?B?aE9vdXRJQnRoc09nQ0FISjZQTUJWVDM2a09BSHRFNkhXUCtjQXhFR29Mb2Ur?=
 =?utf-8?B?M0VZdzREb2VSNXVmc0tPM0w2UGFFa2lrZUJPbURDTGtkVVVRelN6MlRRaG84?=
 =?utf-8?B?dW1SQVU3dkZJcjNiNDZLaXkyblRBQUh4a1hNV0s0U3ZZNTJsWVo1czRjR2RE?=
 =?utf-8?B?ZDl5TjZTa0NjVXFrcWQzUGZYVWQ0MjlaQUpoNmVTNXlQVzRZOFdjZmxOcVE4?=
 =?utf-8?B?S0Y0VXJFMTlZV1RuOXFpblBzY00vSDJlN0tIdi9HY0tRNFJrTmszWkVZM0or?=
 =?utf-8?B?ZkRTN0I1Yk1vZVlVYWFkclFtQzk0eGhXLy83akhnTExTWnBodFZ5QjRMNkpD?=
 =?utf-8?B?dXlaZmtrNTFCbmw2NFZ0cVl2KzVYckdmQzJjZnErTU5Bc1R6d3JINGd2LzNi?=
 =?utf-8?B?cFk1TTJCdjA0eHpmRERKQmxJWVpXdEIzRWVZN0dnaFAwSVMzdXV0ejdtaFZu?=
 =?utf-8?B?ZzVRb0JSNHdxaitxVGU1MisxeERIZlZlYlllMEZIc0xTUzNnVlI1UURWTmFs?=
 =?utf-8?B?MVNkL0tXcVk5TjhiQlhIMDc2aVhWd0t4QnViSFFRaHJneHlrTm53Zi9IN1Ev?=
 =?utf-8?B?UTI1UE5zYnY4aEpUUHkyT2ZxMlFyNmZ4UThoaUhTeVEySngreHppT1JlQmkx?=
 =?utf-8?B?Wms1dHE4UGpPVDJxSHpXTkZpYXVrNUJoZFVCNHFFNmlzU3RVczNnbXAyUXlj?=
 =?utf-8?B?aTFKUWRHV2xodVVtK3dOSmlueWRxMEs5bVR0NnRPRTBlclNndjNHM0JucG92?=
 =?utf-8?B?TGsxK0NYd0dzdjBqRzVwanhSWmJtdUNTR25mUHBPWG1XZ2hSZFlwNmViZUhk?=
 =?utf-8?B?OWJVQmFSemtkUXBWbWdhZWhyWUlZQVJDMnNiVkpzaitzaEpvbDc3aUlNdzlR?=
 =?utf-8?B?Z1ZMY2xIY2lUbGxjT3JRMk1VbGhiMitSNXBvV0ozeUlOWERYSlRIUTB2c1NX?=
 =?utf-8?B?aVhJV3IzRG1keVZlMUVrWGdyYUVGWDA1T2FWU3RQcndYYjFKMFpIYkRCSFc0?=
 =?utf-8?B?QktMNVA4V1hVQ1Q4T0t1aGZXM3BMb3UxT3h0NDUyQ1MxL1A5aDlLZmZHY1RT?=
 =?utf-8?B?K2QvYVB4dzdWV2pxZ2R3T3I0U1VkWlVsV2dsVXorTlpzMjA4d2paU2IzdWlS?=
 =?utf-8?B?ZEFsU1UrbTZWMG5rNm1MeUZ4YXFWVzZUTm5DL0d0S1pycG1iYXFYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9aa61c-5e62-4766-3645-08de8b6ec20c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:34:55.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAPdThkFaYx2KEhmDAlTLSAS+GN3GdSshFYQSXFZEKsK4vRHxC9c8gQd6hzMynv3UKjyWI1IdfUjWMtAXqi/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477



On 3/26/26 06:47, Gautham R. Shenoy wrote:
> amd-pstate driver has per-attribute visibility functions to
> dynamically control which sysfs freq_attrs are exposed based on the
> platform capabilities and the current amd_pstate mode. However, there
> is no test coverage to validate that the driver's live attribute list
> matches the expected visibility for each mode.
> 
> Add amd_pstate_ut_check_freq_attrs() to the amd-pstate unit test
> module. For each enabled mode (passive, active, guided), the test
> independently derives the expected visibility of each attribute:
>    - Core attributes (max_freq, lowest_nonlinear_freq, highest_perf)
>      are always expected.
>    - Prefcore attributes (prefcore_ranking, hw_prefcore) are expected
>      only when cpudata->hw_prefcore indicates platform support.
>    - EPP attributes (energy_performance_preference,
>      energy_performance_available_preferences) are expected only in
>      active mode.
>    - Floor frequency attributes (floor_freq, floor_count) are expected
>      only when X86_FEATURE_CPPC_PERF_PRIO is present.
> 
> Compare these independent expectations against the live driver's attr
> array, catching bugs such as attributes leaking into wrong modes or
> visibility functions checking incorrect conditions.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 139 ++++++++++++++++++++++++++++++--
>   drivers/cpufreq/amd-pstate.c    |   8 ++
>   drivers/cpufreq/amd-pstate.h    |   4 +
>   3 files changed, 146 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 3dcdf56883a6..1f62ab6438b4 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -23,6 +23,8 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <linux/bitfield.h>
> +#include <linux/cpufeature.h>
> +#include <linux/cpufreq.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> @@ -53,13 +55,15 @@ static int amd_pstate_ut_check_enabled(u32 index);
>   static int amd_pstate_ut_check_perf(u32 index);
>   static int amd_pstate_ut_check_freq(u32 index);
>   static int amd_pstate_ut_check_driver(u32 index);
> +static int amd_pstate_ut_check_freq_attrs(u32 index);
>   
>   static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
> -	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
> -	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
> -	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
> -	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
> -	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
> +	{"amd_pstate_ut_acpi_cpc_valid",    amd_pstate_ut_acpi_cpc_valid   },
> +	{"amd_pstate_ut_check_enabled",     amd_pstate_ut_check_enabled    },
> +	{"amd_pstate_ut_check_perf",        amd_pstate_ut_check_perf       },
> +	{"amd_pstate_ut_check_freq",        amd_pstate_ut_check_freq       },
> +	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
> +	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
>   };
>   
>   static bool test_in_list(const char *list, const char *name)
> @@ -293,6 +297,131 @@ static int amd_pstate_ut_check_driver(u32 index)
>   	return ret;
>   }
>   
> +enum attr_category {
> +	ATTR_ALWAYS,
> +	ATTR_PREFCORE,
> +	ATTR_EPP,
> +	ATTR_FLOOR_FREQ,
> +};
> +
> +static const struct {
> +	const char	*name;
> +	enum attr_category category;
> +} expected_freq_attrs[] = {
> +	{"amd_pstate_max_freq",				ATTR_ALWAYS},
> +	{"amd_pstate_lowest_nonlinear_freq",		ATTR_ALWAYS},
> +	{"amd_pstate_highest_perf",			ATTR_ALWAYS},
> +	{"amd_pstate_prefcore_ranking",			ATTR_PREFCORE},
> +	{"amd_pstate_hw_prefcore",			ATTR_PREFCORE},
> +	{"energy_performance_preference",		ATTR_EPP},
> +	{"energy_performance_available_preferences",	ATTR_EPP},
> +	{"amd_pstate_floor_freq",			ATTR_FLOOR_FREQ},
> +	{"amd_pstate_floor_count",			ATTR_FLOOR_FREQ},
> +};
> +
> +static bool attr_in_driver(struct freq_attr **driver_attrs, const char *name)
> +{
> +	int j;
> +
> +	for (j = 0; driver_attrs[j]; j++) {
> +		if (!strcmp(driver_attrs[j]->attr.name, name))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Verify that for each mode the driver's live ->attr array contains exactly
> + * the attributes that should be visible.  Expected visibility is derived
> + * independently from hw_prefcore, cpu features, and the current mode —
> + * not from the driver's own visibility functions.
> + */
> +static int amd_pstate_ut_check_freq_attrs(u32 index)
> +{
> +	enum amd_pstate_mode orig_mode = amd_pstate_get_status();
> +	static const enum amd_pstate_mode modes[] = {
> +		AMD_PSTATE_PASSIVE, AMD_PSTATE_ACTIVE, AMD_PSTATE_GUIDED,
> +	};
> +	bool has_prefcore, has_floor_freq;
> +	int m, i, ret;
> +
> +	has_floor_freq = cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
> +
> +	/*
> +	 * Determine prefcore support from any online CPU's cpudata.
> +	 * hw_prefcore reflects the platform-wide decision made at init.
> +	 */
> +	has_prefcore = false;
> +	for_each_online_cpu(i) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +		struct amd_cpudata *cpudata;
> +
> +		policy = cpufreq_cpu_get(i);
> +		if (!policy)
> +			continue;
> +		cpudata = policy->driver_data;
> +		has_prefcore = cpudata->hw_prefcore;
> +		break;
> +	}
> +
> +	for (m = 0; m < ARRAY_SIZE(modes); m++) {
> +		struct freq_attr **driver_attrs;
> +
> +		ret = amd_pstate_set_mode(modes[m]);
> +		if (ret)
> +			goto out;
> +
> +		driver_attrs = amd_pstate_get_current_attrs();
> +		if (!driver_attrs) {
> +			pr_err("%s: no driver attrs in mode %s\n",
> +			       __func__, amd_pstate_get_mode_string(modes[m]));
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(expected_freq_attrs); i++) {
> +			bool expected, found;
> +
> +			switch (expected_freq_attrs[i].category) {
> +			case ATTR_ALWAYS:
> +				expected = true;
> +				break;
> +			case ATTR_PREFCORE:
> +				expected = has_prefcore;
> +				break;
> +			case ATTR_EPP:
> +				expected = (modes[m] == AMD_PSTATE_ACTIVE);
> +				break;
> +			case ATTR_FLOOR_FREQ:
> +				expected = has_floor_freq;
> +				break;
> +			default:
> +				expected = false;
> +				break;
> +			}
> +
> +			found = attr_in_driver(driver_attrs,
> +					       expected_freq_attrs[i].name);
> +
> +			if (expected != found) {
> +				pr_err("%s: mode %s: attr %s expected %s but is %s\n",
> +				       __func__,
> +				       amd_pstate_get_mode_string(modes[m]),
> +				       expected_freq_attrs[i].name,
> +				       expected ? "visible" : "hidden",
> +				       found ? "visible" : "hidden");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	amd_pstate_set_mode(orig_mode);
> +	return ret;
> +}
> +
>   static int __init amd_pstate_ut_init(void)
>   {
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5eae74a67aeb..ed9fd4155a25 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1390,6 +1390,14 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
>   	{&amd_pstate_floor_count, floor_freq_visibility},
>   };
>   
> +struct freq_attr **amd_pstate_get_current_attrs(void)
> +{
> +	if (!current_pstate_driver)
> +		return NULL;
> +	return current_pstate_driver->attr;
> +}
> +EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
> +
>   static struct freq_attr **get_freq_attrs(void)
>   {
>   	bool attr_visible[ARRAY_SIZE(amd_pstate_attr_visibility)];
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 453adfb445f8..faead0b19a8a 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -134,4 +134,8 @@ const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>   int amd_pstate_get_status(void);
>   int amd_pstate_update_status(const char *buf, size_t size);
>   
> +struct freq_attr;
> +
> +struct freq_attr **amd_pstate_get_current_attrs(void);
> +
>   #endif /* _LINUX_AMD_PSTATE_H */

