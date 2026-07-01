Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FA126BF7;
	Wed,  1 Jul 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941638; cv=none; b=KvxT3sl0mzDYj5TTVOGXb7BBmIbzxn+pgxwt+RFNBdVuFpfW0JeB6AStpdLPgx9Wm5XLNox/A6M4SbfKFOar8LkTbFR++R7cuSK5bEDSViqybxXkewUYVzfgd4waQi1pMUi5N7w1xLWY7QedDdiPXC1+k0u/e0iHYwn+wZfrjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941638; c=relaxed/simple;
	bh=NCN5JdvYlqPKtX2Hl5oxoS9MjCNcHTpmwziRolonokY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTx65/lGhrNSCTLrmbG5UEYuoTmXAzwq6hOOhUc3sNoGNNISOgolcQt7I5mXMfAx/1P4OUesgYIKqwA8clScPlNaxJIyKH/tXfuZ1Y4LlM7cSkAYLVEyG6x2q+3D/4ZhsS3myzJlW2tVYkuWFJ9aZfcXWayHvLz8KeRgXVR2HuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=getmEQin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="getmEQin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D326C1F000E9;
	Wed,  1 Jul 2026 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941636;
	bh=hEcJWo+IzSLjsVMMHfs2iLTV1TMLrwd+8Y4vuS9Ruug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=getmEQin0b4mJeQP0FsWf4mibva5MWspUtF96g1jklfOTIC99gl2LuKbpIb7mOu62
	 yS/qLIZAO3Q3Qq5/QIyHNs3Mc3vmBf/QVz32x7Q1amu6ZDYnlb5GyObYT2ObT1eLuD
	 elzIgbgZIJ6y5rH7yEq3K69GWeuCTfmh41B+HfRZjel0iRKfIiMZVEdwOUAVb3uPK+
	 inI1Ki6vLRnzoMVId9udX0roClYh8GDaquSV8M2+jcbNV7Liu0LQmgKHCkl6/K5xmx
	 BPup/zIDxZj4WheJ/d00hBiGi5ngaaKhab7l6464qEScQRH+RxtbReHToNmmM7IO0H
	 qtZjOqpy3l9FQ==
Message-ID: <01c027bf-0360-49c1-9d11-141f7dafde26@kernel.org>
Date: Wed, 1 Jul 2026 16:33:54 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] cpufreq/amd-pstate: Add dynamic EPP as an
 "energy_performance_preference" mode
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630185904.5602-3-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260630185904.5602-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 13:59, K Prateek Nayak wrote:
> Conver the global "dynamic_epp" toggle into a per-CPU

Convert

> "energy_performance_preference" mode "dynamic" that allows toggling the
> functionality of "dynamic_epp" at a per-CPU level.
> 
> Instead of being a system-wide toggle, users can opt into the
> functionality of dynamic EPP on a per-CPU basis by switching to the
> powersave governor and selecting the "dynamic" mode from the available
> performance preferences.
> 
> Unlike the previous implementation that had to check for driver mode
> before toggling on the functionality, block writes to certain sysfs
> files, potentially disallow policy change, etc. the per-CPU toggle fits
> naturally into the intended design and provides more granular control to
> the user.

No real concerns here, just a few small nits.

> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 90 +++++++++++++++++++++++++++++++-----
>   1 file changed, 79 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1893b0054a6a..c7eec6b96dcc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -106,6 +106,7 @@ static struct quirk_entry *quirks;
>    *	3		balance_power
>    *	4		power
>    *	5		custom (for raw EPP values)
> + *	6		dynamic (platform profile driven selection)

I would just say "kernel driven decision".  Right now this was driven by 
platform profile, but the vision for dynamic EPP was that the kernel 
could potentially change EPP values for individual cores on more factors.

>    */
>   enum energy_perf_value_index {
>   	EPP_INDEX_DEFAULT = 0,
> @@ -114,6 +115,7 @@ enum energy_perf_value_index {
>   	EPP_INDEX_BALANCE_POWERSAVE,
>   	EPP_INDEX_POWERSAVE,
>   	EPP_INDEX_CUSTOM,
> +	EPP_INDEX_DYNAMIC,
>   	EPP_INDEX_MAX,
>   };
>   
> @@ -124,6 +126,7 @@ static const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>   	[EPP_INDEX_POWERSAVE] = "power",
>   	[EPP_INDEX_CUSTOM] = "custom",
> +	[EPP_INDEX_DYNAMIC] = "dynamic",
>   };
>   static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
>   
> @@ -134,7 +137,7 @@ static unsigned int epp_values[] = {
>   	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
>   	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>   };
> -static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
> +static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
>   
>   typedef int (*cppc_mode_transition_fn)(int);
>   
> @@ -1262,6 +1265,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
>   static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>   	int ret;
>   	u8 epp;
>   
> @@ -1302,6 +1306,9 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>   cleanup:
>   	amd_pstate_clear_dynamic_epp(policy);
>   
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, prev);
> +	/* Restore previous EPP if toggling Dynamic EPP failed. */
> +	amd_pstate_set_epp(policy, epp);
>   	return ret;
>   }
>   
> @@ -1372,14 +1379,22 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>   static ssize_t show_energy_performance_available_preferences(
>   				struct cpufreq_policy *policy, char *buf)
>   {
> -	int offset = 0, i;
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	int i, max = EPP_INDEX_MAX, offset = 0;
>   
>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>   		return sysfs_emit_at(buf, offset, "%s\n",
>   				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>   
> -	for (i = 0; i < ARRAY_SIZE(energy_perf_strings); i++)
> +	/*
> +	 * Do not enumerate "dynamic" option only if disabled during boot.
> +	 * Users can still opt in to dynamic EPP if platform (server) has
> +	 * decided to keep it disabled by default.
> +	 */

As we're keeping it disabled for everyone right now, I think you can 
avoid disambiguating server for now.

> +	if (!dynamic_epp)
> +		max = EPP_INDEX_DYNAMIC;
> +
> +	for (i = 0; i < max; i++)
>   		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i]);
>   
>   	offset += sysfs_emit_at(buf, offset, "\n");
> @@ -1395,11 +1410,6 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   	bool raw_epp = false;
>   	u8 epp;
>   
> -	if (cpudata->dynamic_epp) {
> -		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
> -		return -EBUSY;
> -	}
> -
>   	/*
>   	 * if the value matches a number, use that, otherwise see if
>   	 * matches an index in the energy_perf_strings array
> @@ -1410,6 +1420,26 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   		ret = sysfs_match_string(energy_perf_strings, buf);
>   		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
>   			return -EINVAL;
> +
> +		if (ret == EPP_INDEX_DYNAMIC) {
> +			/* Dynamic EPP disabled at boot or by platform. */
> +			if (!dynamic_epp)
> +				return -EINVAL;
> +			/*
> +			 * Dynamic EPP was already enabled for this CPU.
> +			 * Nothing to do.
> +			 */
> +			if (cpudata->dynamic_epp)
> +				return count;
> +
> +			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
> +			ret = amd_pstate_set_dynamic_epp(policy);
> +			if (ret)
> +				return ret;
> +
> +			return count;
> +		}
> +
>   		if (ret)
>   			epp = epp_values[ret];
>   		else
> @@ -1421,6 +1451,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   		return -EBUSY;
>   	}
>   
> +	/*
> +	 * Dynamic EPP was enabled previously!
> +	 * Switch back to the static EPP mode.
> +	 */
> +	if (cpudata->dynamic_epp)
> +		amd_pstate_clear_dynamic_epp(policy);
> +
>   	ret = amd_pstate_set_epp(policy, epp);
>   	if (ret)
>   		return ret;
> @@ -1438,7 +1475,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   
>   	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>   
> -	if (cpudata->raw_epp)
> +	if (!cpudata->dynamic_epp && cpudata->raw_epp)
>   		return sysfs_emit(buf, "%u\n", epp);
>   
>   	switch (epp) {
> @@ -1458,6 +1495,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   		return -EINVAL;
>   	}
>   
> +	if (cpudata->dynamic_epp)
> +		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
> +
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   EXPORT_SYMBOL_GPL(show_energy_performance_preference);
> @@ -1943,10 +1983,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>   	}
>   
> -	if (dynamic_epp)
> +	if (dynamic_epp) {
> +		/* Dynamic EPP is only available with the POWERSAVE policy. */
> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>   		ret = amd_pstate_set_dynamic_epp(policy);
> -	else
> +	} else {
>   		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
> +	}
> +
>   	if (ret)
>   		goto free_cpudata1;
>   
> @@ -2018,6 +2062,30 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   	if (!policy->cpuinfo.max_freq)
>   		return -ENODEV;
>   
> +	/* Must be a switch between PERFORMANCE and POWERSAVE */
> +	if (cpudata->policy != policy->policy) {
> +		/*
> +		 * Disable dynamic_epp when switching
> +		 * out of CPUFREQ_POLICY_POWERSAVE.
> +		 */
> +		if (cpudata->dynamic_epp) {
> +			WARN_ON_ONCE(cpudata->policy != CPUFREQ_POLICY_POWERSAVE);
> +			amd_pstate_clear_dynamic_epp(policy);
> +		}
> +		/*
> +		 * If dynamic_epp is enabled by default, toggle it on
> +		 * when switching to CPUFREQ_POLICY_POWERSAVE.
> +		 */
> +		if (dynamic_epp) {
> +			WARN_ON_ONCE(policy->policy != CPUFREQ_POLICY_POWERSAVE);
> +
> +			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
> +			ret = amd_pstate_set_dynamic_epp(policy);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>   	cpudata->policy = policy->policy;
>   
>   	ret = amd_pstate_epp_update_limit(policy, true);

