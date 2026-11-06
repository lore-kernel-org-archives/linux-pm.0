Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986353;
	b=yn82YDguSJ1nAfu2Kg3PnOp7pwBbLuQSEgWE4Exnt96ArYsE84b8hQLSPMEl5kwFpFK4
	 gUfinUtH9r3hjQQi5/Dz52WcVB+cChSrrfS5q/RhnYEZYQ+JgwZ01lf/m5OZ7+KfnvgsI
	 xaprcmQMYP2y5S1l37IoWfOnHC5qi8wXb9Aeelnl744cf/w472ADgwy9Q6Y1GYfEK7Rk4
	 ZzxsaYfY+RD+Oy0VqIiUbtJ9EL7ylt/ZCpt2V4MlV/L2Cr1nBgyJGdhG+8Vu1sSomhplb
	 X6zX6D/XMaiy68vrfvNnZVRaSZsFxKXPoas8/CSNZLV0GfWmF3eD81DcJqghrrSiF8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986353;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QUjPQH1cL8N/9URMv3jru+HqYy9OSWW11sbMjvE7s6w=;
	b=U+Q8uD7hQepPQBAZ7e7MRnUOAtZtFnLPfr54YoW4n4qcMXGye3d8MiBYzzjuygOG9G6L
	 wXrAU4bBoPpXPLQufXoJ3oSuWYLSrFRoYKliLnt06KY+ZOlI3j9NmD04bZLKdOmgHIUyX
	 l33MesmwwTHROOq13xSma7hqBqRp4b8WCDEJ8BKVCVzITetcKaWM1dMMOzYRjFW1Zwija
	 ob+crP66Hi+k2Mee1r4VcOLEI0rKSN/0uNISo04SaUWqU79m8kIX4gpa9mY3K6x3VH7Lg
	 vzVcStSRVmz2eys3Ia0v8gWZMH70qWO+1dgOqpnjxJbtqZP2PY1wUa5NNcpfBvaVnFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tMCdkqsG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D40606A326;
	Fri,  6 Nov 2026 17:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D40606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tMCdkqsG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D4D1477;
	Fri,  6 Nov 2026 09:32:29 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BD303F632;
	Fri,  6 Nov 2026 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793986352; bh=3nfA1zsC2kWsMvZC6kHSJ1pTDsUMnfkun7dvKU5Nyno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMCdkqsGitTUPwyMszbGU4m+j+P0i0dA5EGJ8UJPKWs21++tqlBNz25cSuXewzX/X
	 gb62Ce/XhDh8M7hPeCwMrDhr3wtdUlJdthcLSQPW6w3pJ8B8AUyLVRAypR6nNQDOTA
	 HKc5EKzNO2qOiOlsDIjb813xkSeMn0A2Qyt9pcVQ=
Message-ID: <fcc2edad-9edf-4243-92ab-4c1949ef5de5@arm.com>
Date: Fri, 6 Nov 2026 17:32:29 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cpufreq: Fix updates of cached resolved frequency
 and index
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
References: <5176274.31r3eYUQgx@rafael.j.wysocki>
 <3472677.aeNJFYEL58@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3472677.aeNJFYEL58@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 15:05, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The cached resolved frequency and index, cached_target_freq and
> cached_resolved_idx, respectively, may be updated concurrently if
> cpufreq_driver_resolve_freq() is called by the schedutil governor
> while cpufreq_set_policy() is running for the same policy.  Those
> concurrent updates are not synchronized in any way and the values
> written by cpufreq_set_policy(), if it wins the race, may confuse
> drivers using those policy fields [1].
> 
> To address this, use the observation that the only place where
> cached_target_freq and cached_resolved_idx need to be updated is
> cpufreq_driver_resolve_freq() because the only legitimate users of
> them are .fast_switch() driver callbacks.  Although cached_resolved_idx
> is also used in __cpufreq_driver_target(), that is in fact unnecessary
> and it is better to use a local variable for storing the frequency
> table index in that function.
> 
> Accordingly, rearrange __resolve_freq() and its callers so that
> cached_target_freq and cached_resolved_idx are only updated in
> cpufreq_driver_resolve_freq().
> 
> The cached_target_freq initialization in cpufreq_set_policy() is still
> needed, but move it after stopping the old governor and before starting
> the new one to avoid racing with cpufreq_driver_resolve_freq().
> 
> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pm/20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com/ [1]
> Co-developed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpufreq/cpufreq.c |   31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -477,7 +477,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_s
>  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>  				   unsigned int target_freq,
>  				   unsigned int min, unsigned int max,
> -				   unsigned int relation)
> +				   unsigned int relation, unsigned int *idx_p)
>  {
>  	unsigned int idx;
>  
> @@ -487,9 +487,10 @@ static unsigned int __resolve_freq(struc
>  		return target_freq;
>  
>  	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
> -	policy->cached_resolved_idx = idx;
> -	policy->cached_target_freq = policy->freq_table[idx].frequency;
> -	return policy->cached_target_freq;
> +	if (idx_p)
> +		*idx_p = idx;
> +
> +	return policy->freq_table[idx].frequency;
>  }
>  
>  /**
> @@ -520,7 +521,10 @@ unsigned int cpufreq_driver_resolve_freq
>  	if (unlikely(min > max))
>  		min = max;
>  
> -	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
> +	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
> +						    CPUFREQ_RELATION_LE,
> +						    &policy->cached_resolved_idx);
> +	return policy->cached_target_freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>  
> @@ -2398,12 +2402,13 @@ int __cpufreq_driver_target(struct cpufr
>  			    unsigned int relation)
>  {
>  	unsigned int old_target_freq = target_freq;
> +	unsigned int idx = 0;
>  
>  	if (cpufreq_disabled())
>  		return -ENODEV;
>  
>  	target_freq = __resolve_freq(policy, target_freq, policy->min,
> -				     policy->max, relation);
> +				     policy->max, relation, &idx);
>  
>  	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
>  		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
> @@ -2433,7 +2438,7 @@ int __cpufreq_driver_target(struct cpufr
>  	if (!cpufreq_driver->target_index)
>  		return -EINVAL;
>  
> -	return __target_index(policy, policy->cached_resolved_idx);
> +	return __target_index(policy, idx);
>  }
>  EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>  
> @@ -2712,7 +2717,7 @@ static int cpufreq_set_policy(struct cpu
>  	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>  	 */
>  	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
> -			      CPUFREQ_RELATION_H);
> +			      CPUFREQ_RELATION_H, NULL);
>  	if (freq != policy->max) {
>  		WRITE_ONCE(policy->max, freq);
>  		if (need_update_limits)
> @@ -2720,7 +2725,7 @@ static int cpufreq_set_policy(struct cpu
>  	}
>  
>  	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
> -			      CPUFREQ_RELATION_L);
> +			      CPUFREQ_RELATION_L, NULL);
>  	freq = min(freq, policy->max);
>  	if (freq != policy->min) {
>  		WRITE_ONCE(policy->min, freq);
> @@ -2732,8 +2737,6 @@ static int cpufreq_set_policy(struct cpu
>  
>  	cpufreq_update_pressure(policy);
>  
> -	policy->cached_target_freq = UINT_MAX;
> -
>  	pr_debug("new min and max freqs are %u - %u kHz\n",
>  		 policy->min, policy->max);
>  
> @@ -2759,6 +2762,12 @@ static int cpufreq_set_policy(struct cpu
>  		cpufreq_exit_governor(policy);
>  	}
>  
> +	/*
> +	 * Initialize cached_target_freq while no governor is running to avoid
> +	 * racing with cpufreq_driver_resolve_freq(), which updates it.
> +	 */
> +	policy->cached_target_freq = UINT_MAX;
> +
>  	/* start new governor */
>  	policy->governor = new_gov;
>  	ret = cpufreq_init_governor(policy);
> 
> 
> 

