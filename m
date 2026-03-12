Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6E3491C2;
	Thu, 12 Mar 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348595; cv=none; b=LHZsP89HxxV8rlB+xlZld/kcHzqLwsCB0dhU44VfTACPIEyQ6Qu6fZ/Rqb/qXWZOH0Vy4FXn2CC4REeNddS3CefeDcW9BAzT7tVPRLP0M8tyopo7mYWvjEW7scy85oykN6U4uctT9DKB6iVNf61kRDKH0bIZr+VZlWtkeNdYEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348595; c=relaxed/simple;
	bh=DWy2AlzLrfa1YegxIQycssgMSkonK3OEezXTI4ofuH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFR+ElhS8AvjzcXc6Qf++G5Ym8FZfEWh5lSVbg/kQ5uaklq/pbcjqLrivB0d6scOWwLoODHIYkrheel1f/eKEOvOfQX4EmFqteCOGUGlxerqjfp1ahaomkwaPAvH70BGjB3AC/4uIE63LT1l4u1TKFu6E/LB6Y+9GF2/72cpYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtffXoNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtffXoNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FBC4CEF7;
	Thu, 12 Mar 2026 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348594;
	bh=DWy2AlzLrfa1YegxIQycssgMSkonK3OEezXTI4ofuH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qtffXoNzhy6J9Vn2yoJuxPLgs/Jeabk2W5K1f0X+NFur2DlGShAizlKK+RXy9rEPY
	 tx1909oQLxCM3wa5SoY2Dw0Mi+7ma8onf5JeDsqE1k5MGFt0xfOO2gpbGOJivgFm0P
	 uRJLVaqd5RQJdXJyO5zexZP9XiP13e9Qhsci3aHWCnFDGvqkRhhhgEkl9S1zVeECqh
	 alKvvKyyASV+fVRm3qGmMmVyByKXXnypQ3szheJy24SYvLZIOts+W69RsrmoinYLvI
	 jFwGKeafP94Ak/57l/g/lTaybYTwcGGM3xuE78Fq+RtSxvJS4/PO2tSrWb4E56vxY9
	 44+Tj3PProGJQ==
Message-ID: <42f23b7e-9022-432e-b690-a223a3825b59@kernel.org>
Date: Thu, 12 Mar 2026 15:49:53 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] amd-pstate: Add support for CPPC_REQ2 and
 FLOOR_PERF
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-6-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260311140116.19604-6-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> Some future AMD processors have feature named "CPPC Performance

Don't need to include something like timing, it doesn't really age well 
in a commit message.

> Priority" which lets userspace specify different floor performance
> levels for different CPUs. The platform firmware takes these different
> floor performance levels into consideration while throttling the CPUs
> under power/thermal constraints. The presence of this feature is
> indicated by bit 16 of the EDX register for CPUID leaf
> 0x80000007. More details can be found in AMD Publication titled "AMD64
> Collaborative Processor Performance Control (CPPC) Performance
> Priority" Revision 1.10.
> 
> The number of distinct floor performance levels supported on the
> platform will be advertised through the bits 32:39 of the
> MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR MSR_AMD_CPPC_REQ2
> (0xc00102b5) will be used to specify the desired floor performance
> level for that CPU.
> 
> Add support for the aforementioned MSR_AMD_CPPC_REQ2, and macros for
> parsing and updating the relevant bits from MSR_AMD_CPPC_CAP1 and
> MSR_AMD_CPPC_REQ2.
> 
> On boot if the default value of the MSR_AMD_CPPC_REQ2[7:0] (Floor
> Perf) is lower than CPPC.lowest_perf, and thus invalid, initialize it
> to MSR_AMD_CPPC_CAP1.nominal_perf which is a sane default value.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
> Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB

I think this can be in the commit message rather as Link: rather than 
below cutlist.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> 
>   arch/x86/include/asm/msr-index.h |  5 +++
>   drivers/cpufreq/amd-pstate.c     | 70 ++++++++++++++++++++++++++++++++
>   drivers/cpufreq/amd-pstate.h     |  5 +++
>   3 files changed, 80 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6673601246b38..e126c7fb69cf6 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -765,12 +765,14 @@
>   #define MSR_AMD_CPPC_CAP2		0xc00102b2
>   #define MSR_AMD_CPPC_REQ		0xc00102b3
>   #define MSR_AMD_CPPC_STATUS		0xc00102b4
> +#define MSR_AMD_CPPC_REQ2		0xc00102b5
>   
>   /* Masks for use with MSR_AMD_CPPC_CAP1 */
>   #define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
>   #define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
>   #define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
>   #define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
> +#define AMD_CPPC_FLOOR_PERF_CNT_MASK	GENMASK_ULL(39, 32)
>   
>   /* Masks for use with MSR_AMD_CPPC_REQ */
>   #define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> @@ -778,6 +780,9 @@
>   #define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
>   #define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>   
> +/* Masks for use with MSR_AMD_CPPC_REQ2 */
> +#define AMD_CPPC_FLOOR_PERF_MASK	GENMASK(7, 0)
> +
>   /* AMD Performance Counter Global Status and Control MSRs */
>   #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
>   #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fb5d7bb320c15..3122ad5af6f47 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -329,6 +329,63 @@ static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
>   	return static_call(amd_pstate_set_epp)(policy, epp);
>   }
>   
> +static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 value, prev;
> +	int ret;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
> +		return 0;
> +
> +	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
> +	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
> +
> +	if (value == prev)
> +		return 0;
> +
> +	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
> +	if (ret) {
> +		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(cpudata->cppc_req2_cached, value);
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u8 floor_perf;
> +	u64 value;
> +	int ret;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
> +		return 0;
> +
> +	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
> +	if (ret) {
> +		pr_err("failed to read CPPC REQ2 value. Error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(cpudata->cppc_req2_cached, value);
> +	floor_perf = FIELD_GET(AMD_CPPC_FLOOR_PERF_MASK,
> +			       cpudata->cppc_req2_cached);
> +
> +	/* Set a sane value for floor_perf if the default value is invalid */
> +	if (floor_perf < cpudata->perf.lowest_perf) {
> +		floor_perf = cpudata->perf.nominal_perf;
> +		ret = amd_pstate_set_floor_perf(policy, floor_perf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -426,6 +483,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>   	WRITE_ONCE(cpudata->perf, perf);
>   	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
> +	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
>   
>   	return 0;
>   }
> @@ -1036,6 +1094,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	if (cpu_feature_enabled(X86_FEATURE_CPPC))
>   		policy->fast_switch_possible = true;
>   
> +	ret = amd_pstate_init_floor_perf(policy);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
> +		goto free_cpudata1;
> +	}
> +
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>   				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>   	if (ret < 0) {
> @@ -1597,6 +1661,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> +	ret = amd_pstate_init_floor_perf(policy);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
> +		goto free_cpudata1;
> +	}
> +
>   	current_pstate_driver->adjust_perf = NULL;
>   
>   	return 0;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index cb45fdca27a6c..0c587ca200199 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -62,9 +62,12 @@ struct amd_aperf_mperf {
>    * @cpu: CPU number
>    * @req: constraint request to apply
>    * @cppc_req_cached: cached performance request hints
> + * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
>    * @perf: cached performance-related data
>    * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>    * 		  priority.
> + * @floor_perf_cnt: Cached value of the number of distinct floor
> + *                  performance levels supported
>    * @min_limit_freq: Cached value of policy->min (in khz)
>    * @max_limit_freq: Cached value of policy->max (in khz)
>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> @@ -87,10 +90,12 @@ struct amd_cpudata {
>   
>   	struct	freq_qos_request req[2];
>   	u64	cppc_req_cached;
> +	u64	cppc_req2_cached;
>   
>   	union perf_cached perf;
>   
>   	u8	prefcore_ranking;
> +	u8	floor_perf_cnt;
>   	u32	min_limit_freq;
>   	u32	max_limit_freq;
>   	u32	nominal_freq;

