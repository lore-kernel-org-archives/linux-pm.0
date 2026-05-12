Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736884C6F00;
	Tue, 12 May 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580150; cv=fail; b=gL72Iivucv3tbM+cB73tM0RV+RYvySOoJj1nMEmlMxZFML0iDu//YiG+8lpH4kzaC8c+P2q8Qg1rsz8qOYQQSM7sOka7bHj5/oO/QvdpGg8llmitP4OE2J6nxzxov1MaS2/MxNJzo4M8fXya0r8PzwFjnAJ2Bg17wnsL4ykda+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580150; c=relaxed/simple;
	bh=uuIBt6x/ITt2AtjqK9HaU5Aho0UgQdcesjvsxaDze3g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uyIgKH/i/eMSmq/MXcM7WIvcDGheXd27gkIFb/hKv9Te4qf+gT8i28GuDISN88f2KbhJm3zKK2LBzRbBBxpYAmtyQpyrqWl5++332NQ27FnaI/Krr9OaR104Q9rhLt9tD85skRoAR9eP4geGj6w6cUtZrxY8A8aV35hEZ2rc83I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKHa4fK5; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKHa4fK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3C2AmYdnQviKHRlDUlE6n6BAQLDW1+5Fmq9Nme8kJm005N/dWQHI3VtxbTYBSEM6iWnfXaMfAr2t05gpiWD6jqhS+JgwG1JspNmgWiObLELkSqv4nlR9vx8MOyFK/9hiYGvyUKXD6oRyYKctrl1j0YBi4yiJa3XQn4FmSAsQP20Np3/C7Nsdkks114lOjlLSmRkb8KJh7FQll4pDxqVAr/6FjekCW35AO91Stk9tqjtIhLiNdCida1FaJ79ZMZuuyLnVMIfr+1tHuTvB5xgN6zc7Ck4csViZXDWlRBxY8Ze01LtH1xBkRZvwWBqLhexRhUBX4KwzBJVFd56tNdbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gsMJeyY6kSEcFG7DginwVXweBBCT/wShWxCDqCZTCg=;
 b=pMWI/hb+zLnSx7vWidY+q0t4Hjy8vMDAHoxNY/B9A8Z9aT4M68UVeSDqxai9ROkC5zlTUoQmybbH/x5BN0J9m2pYr+hWy4OkLgssxzCoEC2eLuBm9jCGBiAzYgEB8wsutuN27jUWObtyzAjt1zPVQWOPf9S6ItdtK2h4HwcH5rp5W4J2KHksc6jRkyuxFQ/tBgoIxeJ4U/RihTPNPlpIQ4jh+pcvVS1IdXfXuMTuYpQjH84rMHwrLtqZZFwuOUAYLFPu/kGAOWYp0FdI5VVGAMvmRD7zOebXr6dAKYi02oR8/N/Qj4c5wL49nwOG1LqkDmLovrZD3g5Veqg3LtpQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gsMJeyY6kSEcFG7DginwVXweBBCT/wShWxCDqCZTCg=;
 b=DKHa4fK5GHUfjOzbzkt9eAMjGPeUFIIFa5M2o6qryxTQdSWfX5Q/01bx2u0EnslMynL0svpRIHmuuz8wDl6OhYXWsl92ZDsIXAmLRMEMet5rY0a2VJS40J8r1fCtxMg4/LdOfDwzg5fVp5Wo+kG1cVPCyE8UXPoHtxRso6oFPTHsojFpIG48p/w+19tXNGdc+BsEILuGFWMcG6UTK3DnVVWYp6eO0sNsIQRg/cD0pgqQS2Sd1NhLIN/0E7TUKer7nnmzxfQTi0aiSl6pXLAUEDbKpQMfLKLSRLyjH/x0GdM0Y6cv0FNAAiY0hdsOXuudgSScyz2lgtt/PARHxLt/2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:02:23 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:02:23 +0000
Message-ID: <f76548b2-a6cb-4577-bc19-a8e47508b398@nvidia.com>
Date: Tue, 12 May 2026 15:32:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: mask Desired_Excursion when autonomous
 selection is enabled
To: luoxueqin <luoxueqin@kylinos.cn>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 pierre.gondois@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260506101834.343001-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260506101834.343001-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::20) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2639e2-0b21-44b1-f01d-08deb00d8fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	as6rG/RsDq05nvDaAvprpiYGxeuSM0ammEr7sLJSQPVpTVlBjRdGVtFHAnqK8GCpYsSGzyHHQrFEeF7OmvBHd4icSLIwZdqKuKC4jDhR96HNjMd9IqhpE8BBSQbKLUpo1NeLKCjpxMu3f7vdoeMCgYUfVz0V0noduCgEFxJRbo0mWON7tccbqdXQqzLAp44vq3NKB65Vasygw5UlbDztunEUsRlMBwzBjOxpb7RIkpO5a8ZDaYxW7xgoLdQy6Stw+cCnJUJKYEnxIeAwRY3OEQBznj2uCWCBA9exk7o0ShGKCXGhmXeDP6TsJfeuZA9jMw6q9TaWaPSdGFFsSmMh9jXU4owG16+/9wIN44qrj6E1YdiYf7duLOEwv5yNMmCZUrGNKQCOzEdal4QjcDRn3gjckcwm7cyXoqjISU+gz5jBQ/Zvzwkx7W/WNOa1+vFmC6PD6MhTQYg8Bjm4zctp/DuSsc0i8CNSRl0T7hNZf9YpdmDaZql0rmkFX/oJ4TT/WnkJykQVRB6I+tfc9piBhrHnoCjfXKeUCUwDjo1CClu20rm9btzAM64KOKn/OZa7pPDS8BIQ92LsXsnj/9M2meCzhHqUg1dvPYZWNSbAUi3a7q1vZ7A0wTCahFMMHGXRZKj369pe6Tu70pz/ruhyKGunqeRLe5HUvXqi0E7XDogh4V2znAJHEqjapM5I9su1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUp4QjJLYytuQXdXcWNUTU1QYmZ0cmQzVUx1QS9rQTg1UE5uMVZQTnd2ODN0?=
 =?utf-8?B?aTRGemF3b3FSM2ZjS0MvdTlWcHNMRDFiQWdRMkYxK2U1N3lEUDZpekJ4OUk2?=
 =?utf-8?B?QlpnQzV3UGpXdFozbkd6d2g0QnVIS0tDU21YaFBnY0ZucGpLQ2huc090cmVK?=
 =?utf-8?B?T3QvbFl3WkJraCtIT1FwTVd1VUxkOTBCQUhnMFUyV3ZuWjlYb0M0VjYxOU5N?=
 =?utf-8?B?cittVzUxVmZWcWNkdnBwbjNJRGRzaTFkaFNVSkFFckkrQ2JLVEtwNVhuRHpE?=
 =?utf-8?B?WTRlQlRDRloxMGVkYXM1MGlZL2hrWEtJNTdWMGhJSmdVOFFlOWdpeUJqK0cr?=
 =?utf-8?B?TDJNZmFmV3o1NmVKTlN3R29UV1luTklQQW9PUkZBOEY5UHRrSVNiWTB6eldr?=
 =?utf-8?B?OXJpVDNrRG1xYmM2WjlNV0t5UzduSFRTN1dwZjVGbGZwS09rZTlxVVlySTUw?=
 =?utf-8?B?NTJKZkp1Z2JIVFpNaE5kN0szNm1ocU0zbnJ3MlNRRGp5VVJFYTFPejZHTnB5?=
 =?utf-8?B?MlNLMjcydnhpRTErdzA3aVFoMlZkSzloa3hTY2lSQy9JSEpJeEVkZ1kvdmNM?=
 =?utf-8?B?akViMkNaeXlnL21zRlZMd2pWT0xheUl4blZwUDF5UXFWNFMrZUJJTWNVMDYy?=
 =?utf-8?B?UGlTZ1JsWWlCTDQwV3R1NDJoa0p3b2pkYkFWME02cjVVTWp3UzRhMFhtYkFz?=
 =?utf-8?B?NzloTEowVE1YL3JHcFI1a2pMZjloYXZoNzE3RUMyNTB5Qk12eGhuNHVFY3dS?=
 =?utf-8?B?UjJHUXFRNWxMRmZyYko5T0F6R2xuWUExdFhDYWNZaXlmS2JUZ1hPQkh3WG5L?=
 =?utf-8?B?dG9NRW43d20yOWdkVktDWDVvbGYrU2F6V0RSdXNZU1NidUdUMkpUR1krNmQy?=
 =?utf-8?B?Wm5IUmJWa0dwZmM4MHZ3TnlzVndDb0liVitnQlI4TEkzT1Z0b243cW1hRzJD?=
 =?utf-8?B?TjJXd2VKQWs4bTZ4UmsyYy9jS0tyS0cxN1FqMkcyZXh5UUUyK2Q1UW5ZWVBL?=
 =?utf-8?B?Rzh3Kzd6SFlveTNrcFBvdEZqRDFHb0Q4RTBOTWZzL2RNa2NYai9pTFA4d0Vl?=
 =?utf-8?B?ZXpLYXE4U3ROd2g2LzQ2VGdObVdjWGkvRTlsQjFaSGZsLytGWElZOHAwYUlI?=
 =?utf-8?B?VkRpV2ZOY1VMUEl5NWNIN3UzbnNsT2ZSckU2QWFtWWwwS3BEcUpSNkF0WnR6?=
 =?utf-8?B?ei96WVpSVyt2SUovNDRvYnVIMWJLdTJsWnFYa2JCQWE0T3RHaEFvemt6eTNK?=
 =?utf-8?B?dG5oTXJydkxTWlUxOGg4UHI1eHp5UnRxY3JNTHNCekF1Zks4elRJN1Fham9Z?=
 =?utf-8?B?cmNLT0hHWkZiN3NZOUQ5aVUvSllPMzhFSFN4aW1VRUkxaWU3bzdZRGNKUVdj?=
 =?utf-8?B?aTcvUHJZQllyOGMrT1E1dyt1VEFwRFNTb3ZhK2dQMmpIcnNkRDFWR284akdI?=
 =?utf-8?B?RDMrVmwrM05jclcwSjM3MDRRQk5WaXByWUI5aVBiMlcwb05lRjNHSWIwTjho?=
 =?utf-8?B?WU1KS1d2VFg3THo4ZGd1eGYvUHNqWmk0Z1R5QUdKWWJ3bHVQbCtGU2dydXRV?=
 =?utf-8?B?M05BelN6VG92Y3ZzaTNzNjBhZG0yVTdCbDJLaFo4d3NBNVhqWHI0R3JjMytl?=
 =?utf-8?B?M05zbWh5eDBxdEYwYkdKSEtHc2hmZWs3RE05cHBFaUlMN3cyMnlvaXRWeVhO?=
 =?utf-8?B?YzZDZmZkamN0MzJsRzN4Q01pVjV0MFczckk4ZjVyek1qcUN4d2xvUHRBMlhV?=
 =?utf-8?B?UEFWRjNPK2FFbWJtVjkvQ2dIVDVhZGFqS3oyVEJ1RW5KNTZEdWVHZys4OWZS?=
 =?utf-8?B?Y0U3MXdlRzdlTzVHaDFiRGFPVm4zSVhPTDdEelBobk1oY3ZvWGtMb1piZjl6?=
 =?utf-8?B?ZnZJWnlkNHlaSTlTcXR5NFVadkpWOXcyUVJDZ283ODFuUk9UODk1UWhCK3hQ?=
 =?utf-8?B?MTIrYnFKRmkrWkRiekp1RWlJelZ2RXJwcC9pZWZGVUhtOFUyalBPU1VIK1dM?=
 =?utf-8?B?bDN1UUMyb2N1dVRKWEFkaTFmcGZYK1pUWXZSc1Nibzl0ZXpLNmExUkV1NUFN?=
 =?utf-8?B?RStxZkhzR0U2WkRYSjVqT0JCNktaQVlDeHlVNGkwMlc0dVoySjhuRGxQd3M2?=
 =?utf-8?B?c0lvemovT0MraVRRQkFGUnU4b1V0Mm5OaG5WRXpTdGxEbkRXZ2RVSlpMd01B?=
 =?utf-8?B?eUtlaDhYcjh4T3pkTFBqckY2Y1BrVzNleUR6ck1uMHhoUnNXRU5aeGlkTVVF?=
 =?utf-8?B?dlRPVmFrcXQzckxUbUxXYVlkT0R0dTJVZllBZFVsZ2JzUkM2bEU2UkROSms0?=
 =?utf-8?B?QklleElSWjlQSHBteHl2OWRUMFh3NnZsL3AxRitVQlZ1OVc2d1h6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2639e2-0b21-44b1-f01d-08deb00d8fba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:02:22.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6gRUe9ju+ccuWjObxM1RNAsVAN3zOegVRZf8qVCkdO/t//zQoTdLaSngtfjuyBhx+W05AbvwM0jGyWSJr6HdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139


On 06/05/26 15:48, luoxueqin wrote:
> External email: Use caution opening links or attachments
>
>
> From: Xueqin Luo <luoxueqin@kylinos.cn>
>
> According to the ACPI specification, the Desired_Excursion field is not
> utilized when Autonomous Selection is enabled. In this mode, the bit is
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
> ---
> v2->v3:
> - Use cached auto_sel from cpufreq driver data
> - Fall back to raw value when policy is unavailable
> - Keep sysfs ABI unchanged by using a wrapper around cppc_get_perf_limited()
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..a439d9621eed 100644
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
> +       bool auto_sel_enabled = false;
> +       int ret;
> +
> +       policy = cpufreq_cpu_get_raw(cpu);
> +       if (policy && policy->driver_data) {
> +               cpu_data = policy->driver_data;
> +               auto_sel_enabled = cpu_data->perf_ctrls.auto_sel;
> +       }
> +
> +       ret = cppc_get_perf_limited(cpu, perf_limited);
> +       if (ret)
> +               return ret;
> +

Small nit:
Call cppc_get_perf_limited() first and return early on error before
cpufreq_cpu_get_raw(). You can then drop the auto_sel_enabled
variable and test cpu_data->perf_ctrls.auto_sel directly.

Thank you,
Sumit Gupta


> +       /*
> +        * Desired_Excursion is ignored when Autonomous Selection is enabled.
> +        * Mask it to avoid exposing misleading values to userspace.
> +        */
> +       if (auto_sel_enabled)
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
