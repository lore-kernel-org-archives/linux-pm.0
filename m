Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AA4657C0;
	Wed,  3 Jun 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512808; cv=fail; b=B0kzPujO2bP9iH/8nn5QbRY2AecnjessAkn70ziwiSHqwQL/qrf4gy8wqcxcFxj9zmkwzgoMkYzZlSLyigwqzZExeUHoUBDnlB/TsuFwqWRsT8f11f1uOFJE+81hfakMwaPQt+CXf9g3YRs7H1fcMs1XUd27uokMgK06AeS9k0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512808; c=relaxed/simple;
	bh=fNRMoulCQaKoHipS1M3GheAkDg4GUIHdjtT5ieMGjbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yga/B8eUxWOoBOec1AAN1D44JofYG/O1XBoEacUENCxfP35d+9wCx3xzdeSJa6dQhv6Mmc9R6yoIMSjNQWHXuY87z8AiyNXhPY6dpjR18wbusbMduqdH3FQoz6CHmxnX3JCF5I0Z/zkfN1+b5kzW3uMmnhvGENbkYKxJQ3nO20Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sd0fXd0N; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sd0fXd0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4cqAUs9r0aLgDpYN0qbePldFj+LNdAhLX/hlsg4/2hImq15HLz+nI5Ifa4wrj98TENwxVm7nC5cgTTS2b6tEMD4tLr4VE21JqFscK06JyOiPBRzEpmFdXXzQW9H1ZUELw9TmAQqp70mqehqxeeZw8FfMHMoKgOtnVsdUCT+8ZHIvYRi2iF1IueyhdYtQUx703P2w7t+7tUdWTwbGHlwSW8VkzxzOWEbj0RXJlW2gBIzutrXtUk0zj7lC1S7U72pNaKSUrt0uPNW9/AysXwCyawdXBKRvurzqs2wK3ot93KzvOcx4qC9/jruSbIDFXEIcGxqsX6waOhR23EMYL98vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiBwmemA3Nntw6usqWudkfL/lFRxtxyQjpgVtyQuphE=;
 b=Ob8UmqUy0jrln1HE0oMkUQEimgNl/76ue6tHYMvsJHOLTQzPAGuHCj5ozoVIttIMbWYagTaHFElYfXMid65uYOIc4UvyGrLHkxr2cKopIVbCrSPwiH3e+pmAh2q4LIFr1tC6vkM8ghvh4QUF2AN6O8A8N5Z02QaZJI1fbZ8jKbty5Wzl2C86Lzsl/sa9JTNLvXzmPZH6zbWZzGCACSOK6b2fvL29kvLBitkLoeOJn8FFjjtiFbmTX/WRX0zYjrkSksSVqho4EzH3uKBA5Qn+NErxiZkQRYa4oEyl1bCBNUTc19oX4NAw8ltQZ5aI0ZRP3rq3fVDxHEI9mw5TOvCGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiBwmemA3Nntw6usqWudkfL/lFRxtxyQjpgVtyQuphE=;
 b=sd0fXd0N0pG4d/wwRy1ilpuKLhz8TPpV8EvfDl7JZxDW/qGU3Pr5gIcL++xHSmbIvkbGjXzgx0Ll3jVUsul6dsFEnKpRzhyyTGE/YUhFBRt/rTNIbfu08x18vuBHYCpb+GumFVMQs1XVNwWvH+yRZEZMDq03DVVO+XNwRvOgYog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 3 Jun
 2026 18:53:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:53:23 +0000
Message-ID: <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
Date: Wed, 3 Jun 2026 13:53:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
Content-Language: en-US
To: Marco Scardovi <scardracs@disroot.org>, kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <20260603120121.25772-1-scardracs@disroot.org>
 <20260603120121.25772-2-scardracs@disroot.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260603120121.25772-2-scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:b0::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb5db94-5274-4c6c-0361-08dec1a1625d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|5023799004|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uyTyQXzVxVKez3eAHubKnKT+BZWiBeVE5tn3pFJqZv6rvHX00EoNkozcbKxVXSrs4pDR4dX7sO1gUxqT09C+iU50w7e6tv10HyQIfPcXvGjAmdTWwbeMhEwN6rBsP0znZYGqDKyYvS42HM+Y90P54dG7AOeJWdI2EhxqoIhc/50RIjFDT4oiwQfMR4NheqS3rh2ntijSLF86WagAXA+qJvPHmdczahopbKfQD6wCbpFZL36MX3Rd3O0kJ6+tgJsOWRax3kW+GU3x2ijI+kNnMP7ENJaH5DhZsF0twsoVLmpy5tzPaIoMynSwqHRrdzievHslxyjATjsNeHjMVH4NhklPdyoKj/5iotmKGGVrcYuiz/LJy0MIMRipAvmcS7slnDyPEY9uULJtLxCPHsQwgFUVaNWnzJTctJVTRC3j1hGvxzalvyG7bzzkhQ/n6/kQgN6ATcvNkRhKsFfZwknRA6BhydILCLTMxX5WCdbRI5ILkwqUZaOZCO9xu+wJ8ONvYX8spDKWBaWBggUSEFqnhBAKmrhrim5irY71/r9scdD7Dpy10LQiidNl3jsNPwts0DdY4eF8Qt0/lFAtH9CaCYeXtplZuYQI2tAdh+hUY+d1QkSJzNsr/htuDgtv2AvLxVX7H48W1CKzElZDI+vigaGsnc4NEYTnpoMgbTu8aTABluafSa/pcG7y6Z35UrZulArZ2r/iv8cL8UIpVEct0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(5023799004)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVLQVZGVVdydVZqK2xyRWlDbHNRS3ZrSGdMQlN1ZzhYK0xqK0d3QmxqMm1s?=
 =?utf-8?B?aS82VDZvSHRyTjhCRVBOM0dSWmsvZENadWkyMjVlV01BWFBrZHhTZ0k4d0xU?=
 =?utf-8?B?Q09jQWVxZDd5R05qSEV2cWNpQWI0OGh3ZDFxNDZ3aDA3QmRwa2ZJRHdYeGcz?=
 =?utf-8?B?ZnVnbjE3NVJ0U1VSR0dXMFhEUGFZNmJXWFZMZ3ZIUGl4cGxySzRUMlpzQnRO?=
 =?utf-8?B?VmdtT1BpM1lvVUlQUkhPYldDTVh4a29zOFp6TlFqRmpVVzNpc043WWI0VGhx?=
 =?utf-8?B?c3JtRTFiSW9VaExhM1IrU1g3K2YzUUFqY2U4UDNvZnl2YXFtUks2NW9BTmpx?=
 =?utf-8?B?aTcwdHo5bksrQWR5bVc5c1l2NkZBK09FdVJDUnZhRDZFNmhkY21BaHVnZXNl?=
 =?utf-8?B?OXk1R3U4aTQ4NkN6NVVSOHhvRU14cFdwODJSOEtuOUxiRnNYbVMvbGNuQjBK?=
 =?utf-8?B?cXlkbkttY3JpcEQzZUhmUjJUZ1NtOEJscDhtOS9CditldW1raXFxcWJwdW5o?=
 =?utf-8?B?eWZSb2k2alVaS3Rqc2t5ZTVFSnE1VVAvaTFYUDBPMm1DRzZ3a0krU1BPQTVV?=
 =?utf-8?B?YzBXSndwT0ZZMFZsL0lTNXczckJmR0NVbXdSSUtVRjRqVFdNTnFCN3Z4N3BZ?=
 =?utf-8?B?Mk9wNXhHUllQbUVjd2ZSdVhlMnNrUFd4TFNOUS8yaW9GRGNjOUw2THBKWVJ3?=
 =?utf-8?B?THRLTFhaNk1KUlMzUnE5bGVjOEhFcGVzVWsxR3BjUWsyL0tPTzdkWUxqdGtU?=
 =?utf-8?B?emdxQThUN0tFRVlpWU9EL0tiU01seE9TRXk4OUl3ZEFubWo4dllDUmZneUJ2?=
 =?utf-8?B?NTNmL0gzZitYOEhoVHhXdnVZQzdqYkJWd0N5WWpaZHZxaHhaUFlRUGlYNExT?=
 =?utf-8?B?TnQzKytnMHhib1J1cnd6MS9BeDJTQ205TjlvdmlaQktXOUltT0cydXROK1Vp?=
 =?utf-8?B?ZGEvK3JLQVo0My9xUzM0dDJrZUUrTUg5RThpVlQ0R3RmMXd1SDdLNzdjSjRC?=
 =?utf-8?B?S0FpSU1aa2djNDBpMzhPQ0kyMERIRDlTay9VZ1kyVXNtMkM5bkZqWVZJeUNK?=
 =?utf-8?B?MFM4ZVRobCtub0dkZ2xRTk12dzRDK0VmWnZyTnFOMmIrYkl0ekJJM1J5UkE3?=
 =?utf-8?B?U3ZDeWtEWkJ3aVNvT0xzRTRhdTF6MnhubFZyaER0eEJHalRTakxzdDhhc1B3?=
 =?utf-8?B?RG0yWXlIRjU3RmkyN2xBS0J3elByRUliNFNTd1dqaHZTL1hybnBaZU9ndFpV?=
 =?utf-8?B?TFFPazI2WklEeUNvc1prZWNzNUNNM3E0UjMrOTE1bVRpblVtM3h4TUJ1dXFP?=
 =?utf-8?B?UURRSVhkRXp0Y1VYWGp4L1RXdGdub0tkcFMvOGhYbG9PdlM3TDk4aTYvbFNu?=
 =?utf-8?B?L00rc0Z2aUttcy9PMm9pYWlUNm9yQkkxTjN4Nm5PNkdWMXdmRTI4dlo2R1J0?=
 =?utf-8?B?RWN6SEc2YjU3dXdVN0pCVy9XTHJiTnN6Vm9kK21tckx5NG81amsvUlFVZHZr?=
 =?utf-8?B?YWZ1ZFBiRzRmcmNFZUM5T2twMzRiWEZwRWltQ0FRSHdnWW8yTHNNOHpOaDNS?=
 =?utf-8?B?cWp2cktqd2dUSnNYanhXS0FSZWhtZ1B6dlU4UXN2d1h6WU9jS2UzWXpCWjd2?=
 =?utf-8?B?Qm5KMW9xcENXcHZacWlVZVozSVE4WWE4ZzM0ejFsNnVDM3ZrdFkva3ZmcVd2?=
 =?utf-8?B?QmJZV0ZsL0RjTmkveVhvOEd3a2VGN01ZdGk4VVJFVG40NERkbGFBdFBsQVZW?=
 =?utf-8?B?K29LaERLV0crTkhJL1RERUhTbkVicmFuQkw3Q3ltVjlRT1hLM2g0QkY0S0xo?=
 =?utf-8?B?UmVSeHhsWGJpaGh0UzJKT0grMGtoUW9qcGQ2Wk8ycEplcjNUdzBadVRLWDNC?=
 =?utf-8?B?d2tiUjFrbGVzcmNKLzIzNFBYdmk5QVZYMXQyMGhBWjhkV0VGczdjTW5zNXhB?=
 =?utf-8?B?SzI5WlZ3UEkzRWpiR1FobFBDSXArOW1BQXY1QnNGSkdFenJFTkw1R3NkZm1K?=
 =?utf-8?B?Njh2Zzl4M3lSMGhNK3NsR3hINDNCbGsrVSs2Mm5nWEFwc0dTWEN1RlpkSFFp?=
 =?utf-8?B?Z2JhTUtJVHNmVTFQYzJpc0NXWUI4VkpGQldScFVzRFBDMktIMitnQTBxWmF1?=
 =?utf-8?B?M0hXRk4zODVNY0JOcWI3RTF0VzlOdSs4ZTlacWhhcmFndUJXOHVNNEdud2hZ?=
 =?utf-8?B?QmVDdTdRRWxMcmhWMndybEhvdGF0THJIYmpmNFI2UUd3c1dyN2w1REw1eTRR?=
 =?utf-8?B?Rk9kOVkzQ3pVcE1uSW9kcnZhRzhUeXU2eFJLcXlYdE5vV3lTc3E2WU1mY3N2?=
 =?utf-8?Q?6Qx6lzQUNDyb9wB3OI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb5db94-5274-4c6c-0361-08dec1a1625d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:53:22.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dUSdzMDv4ggMq7oJ1HaTLRn7V+ZVfBW9Ob5+DNK/Bf8vA8lIT7UL4lAt/u1PrW+Rkg/w5XJHQuq4292dqeVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159



On 6/3/26 06:56, Marco Scardovi wrote:
> At CPU boot/initialization, the private cpudata structure is allocated
> via kzalloc, which means cpudata->cppc_req_cached is initialized to 0.
> This makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).
> 
> When initializing a system that defaults to performance EPP, the driver
> attempts to configure the EPP via shmem_set_epp(policy, 0). Because the
> requested EPP (0) matches the uninitialized cached value (0), the early
> return check (epp == epp_cached) triggers, and the driver skips writing
> to the hardware.
> 
> The cppc_set_epp_perf() helper is responsible for writing both the EPP
> register and the CPPC autonomous mode enable register (auto_sel). Skipping
> the EPP write on initialization due to the false cache hit consequently
> skips setting auto_sel to 1, leaving the CPU in non-autonomous mode. This
> prevents the hardware from boosting and leaves the CPU frequency stuck at
> the lowest non-linear frequency (1.7GHz).
> 
> Fix this by introducing an `epp_hw_programmed` flag in struct amd_cpudata
> to track whether EPP has been configured on the hardware. Bypass the early
> return check in shmem_set_epp() if EPP has not yet been programmed on the
> hardware. Once EPP has been successfully programmed once, the cached EPP
> value becomes authoritative (representing driver intent rather than dynamic
> firmware state), allowing subsequent runtime mode transitions to use the
> cache guard optimization safely.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 9 ++++++++-
>   drivers/cpufreq/amd-pstate.h | 2 ++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8d55e2be825b..e8057f3dfb1e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -424,7 +424,13 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>   					  epp != epp_cached);
>   	}
>   
> -	if (epp == epp_cached)
> +	/*
> +	 * After the first successful programming, the cached EPP value
> +	 * becomes authoritative (representing driver intent rather than
> +	 * dynamic firmware state), allowing us to skip redundant hardware
> +	 * writes when the EPP value is unchanged.
> +	 */
> +	if (cpudata->epp_hw_programmed && epp == epp_cached)
>   		return 0;
>   
>   	perf_ctrls.energy_perf = epp;
> @@ -434,6 +440,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>   		return ret;
>   	}
>   
> +	cpudata->epp_hw_programmed = true;
>   	value = READ_ONCE(cpudata->cppc_req_cached);
>   	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &value, epp);
>   	WRITE_ONCE(cpudata->cppc_req_cached, value);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index e4722e54387b..fc6cd4b873f6 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -128,6 +128,8 @@ struct amd_cpudata {
>   	u8	epp_default_dc;
>   	bool	dynamic_epp;
>   	bool	raw_epp;
> +	/* Indicates that EPP has been successfully programmed at least once since boot. */
> +	bool	epp_hw_programmed;
>   	struct notifier_block power_nb;
>   
>   	/* platform profile */

I'm having a hard time following why this is needed.  Let me explain my 
chain of thought.

We start at amd_pstate_epp_cpu_init().
* cpudata (and thus cppc_req_cached) is initalized to 0 via kzalloc()
    - On a server we initialize "epp_default" via a lookup to the HW 
(amd_pstate_get_epp).
    - On a non-server we initialize "epp_default" to 0x80.
* we call amd_pstate_set_epp() with epp_deafult as the argument.

Now in the shared mem backend (shmem_set_epp) we do a lookup of 
epp_cached and it should be 0.  We do a comparison of the argument sent 
to the function, and this should be 0x80.

So how do we get into a case that amd_pstate_set_epp() is actually 
called with 0?

There are some trace points specifically for this purpose - you could 
confirm there really is such a call by using them at bootup (or by 
starting in passive and with a mode change to active at runtime).

Then we call amd_pstate_set_epp() with that epp_default value.

