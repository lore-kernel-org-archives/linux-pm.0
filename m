Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604729D27D;
	Thu, 12 Mar 2026 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349040; cv=none; b=aYs0rNT5z7IWkG/BqtWYmpR4rJJ/Va1kjsWC9dkJmRwWWVbemHDU76oABNasGtVwACVg8Yka/LMLDMko2hrTFmQiU/Xox2txxNb1fJYEINuyGRemZZ//eRMPqpD6S0rrT84ZHbSEeicISZHN9rnB9sNTHJlZZTWcSSI/veql4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349040; c=relaxed/simple;
	bh=sXtTdTBnoNqOUAMOwOpIGkLlhT4EE0QKLpHkQh5KWAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwnPLtKLTBdBlclJLg4ljfi6+lYBdUzQ0NJxBG/vrTAC6ecFedN8PY6SCip+VH8yuJk+By3bxD9aigA/BZ8F6DwBsN+XyRQHyln98vUkCfo+TpbSZwlrjx6rLLX/cxOtzpYZKN0IOFPoteLZLNtycDRb7sE29qo+EX4aMvC0y68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSW0kHgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSW0kHgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0E9C4CEF7;
	Thu, 12 Mar 2026 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773349039;
	bh=sXtTdTBnoNqOUAMOwOpIGkLlhT4EE0QKLpHkQh5KWAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PSW0kHgkv+Z48F5lfDwRq6s7hcN7l77qocoknDPoZx4Zo9pfyIwr3RX0EAeN2rJLU
	 qVCTYCtaIxvAO75MFGn4/mDY05IhrT5YYRpfdCwmGtkSjoI5PCVo68CNVEUgzRGs+W
	 fUqtJFdAqr4MsTtLHJHCZRDWP9DfiN4Ug265tKmwc4UeXxswgPaPEpoivtXi/2nJKR
	 6Y26ktsVqv/niSPobKj1Q0i+iy0z3+J2NVavlhkJf0FqCrSewRc+zpwfolegmhtQ6E
	 oCOOTOgSt3H+YtbziqCYzBfYeM0+qhdw1uoQZCDfrYgv2RPFltHhRzZ5RsGIrihBCQ
	 M/CDMyxRsd0gA==
Message-ID: <61627830-9ce8-4df5-a894-7e5fed419df5@kernel.org>
Date: Thu, 12 Mar 2026 15:57:18 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] amd-pstate: Add sysfs support for floor_freq and
 floor_count
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-7-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260311140116.19604-7-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> When Floor Performance feature is supported by the platform, expose
> two sysfs files:
> 
>     * amd_pstate_floor_freq to allow userspace to request the floor
>       frequency for each CPU.
> 
>     * amd_pstate_floor_count which advertises the number of distinct
>       levels of floor frequencies supported on this platform.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

One nit below.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 50 ++++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/amd-pstate.h |  2 ++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3122ad5af6f47..54b650f3b4e78 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -383,6 +383,8 @@ static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
>   			return ret;
>   	}
>   
> +	cpudata->floor_freq = perf_to_freq(cpudata->perf, cpudata->nominal_freq,
> +					   floor_perf);
>   	return 0;
>   }
>   
> @@ -1284,6 +1286,44 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
> +					   const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	unsigned int freq;
> +	u8 floor_perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq);
> +	if (ret)
> +		return ret;
> +
> +	floor_perf = freq_to_perf(perf, cpudata->nominal_freq, freq);
> +	ret = amd_pstate_set_floor_perf(policy, floor_perf);
> +
> +	if (!ret)
> +		cpudata->floor_freq = freq;
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
> +}
> +
> +
> +static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u8 count = cpudata->floor_perf_cnt;
> +
> +	return sysfs_emit(buf, "%u\n", count);

just return cpudata->floor_perf_cnt instead of having a local variable.

> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1292,6 +1332,8 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
>   cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +cpufreq_freq_attr_rw(amd_pstate_floor_freq);
> +cpufreq_freq_attr_ro(amd_pstate_floor_count);
>   
>   struct freq_attr_visibility {
>   	struct freq_attr *attr;
> @@ -1316,6 +1358,12 @@ static bool epp_visibility(void)
>   	return cppc_state == AMD_PSTATE_ACTIVE;
>   }
>   
> +/* Determines whether amd_pstate_floor_freq related attributes should be visible */
> +static bool floor_freq_visibility(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
> +}
> +
>   static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
>   	{&amd_pstate_max_freq, always_visible},
>   	{&amd_pstate_lowest_nonlinear_freq, always_visible},
> @@ -1324,6 +1372,8 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
>   	{&amd_pstate_hw_prefcore, prefcore_visibility},
>   	{&energy_performance_preference, epp_visibility},
>   	{&energy_performance_available_preferences, epp_visibility},
> +	{&amd_pstate_floor_freq, floor_freq_visibility},
> +	{&amd_pstate_floor_count, floor_freq_visibility},
>   };
>   
>   static struct freq_attr **get_freq_attrs(void)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 0c587ca200199..ab4caea39f0e8 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -72,6 +72,7 @@ struct amd_aperf_mperf {
>    * @max_limit_freq: Cached value of policy->max (in khz)
>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>    * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
> + * @floor_freq: Cached value of the user requested floor_freq
>    * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value (in khz)
> @@ -100,6 +101,7 @@ struct amd_cpudata {
>   	u32	max_limit_freq;
>   	u32	nominal_freq;
>   	u32	lowest_nonlinear_freq;
> +	u32	floor_freq;
>   
>   	struct amd_aperf_mperf cur;
>   	struct amd_aperf_mperf prev;

