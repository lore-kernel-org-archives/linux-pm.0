Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0A1C6FF5
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233649; cv=none; b=Owa2DvYuOHPwPLJ9ME0aX/cgD5eBirt3YVvQwBQlezuCvEMdOOR350aDO4Icza7KPpq2AI4IqJXhqM1kiJfAo1XXvTyO9aO99gUIswPvXjuBQs4UVBmYixgWxrJ7nN/s4zHtHhCHNIEGkNnBO5X0gI5txCHl3YH+G1B33UYM83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233649; c=relaxed/simple;
	bh=LhA8nA/gePJ8iZnIhEqq+AusqUBfhy5De2Ul3UbWBIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaoGaHDLxtpY5R42KaoJ9SaT8GsN0tzMIm2dTcCSiGzSBiL78UuZnFr8LCEgsNi2IDWTNHcsxZbIq+MGuiCmVMQjIJQRFa0T9LegmxT4Qz3LcIsB1p27zahyJN5BfhxWKPy/zO1YKZXaehhBtOi0W4iwyOYqhUWOW+Jyh/Hm9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cejYDDMf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cejYDDMf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-366375c4076so613842a91.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778233647; x=1778838447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9WFo19/tiacPEZko0UlNLOgNR3VTMpCZ9FxtExVQYw=;
        b=cejYDDMft9X07kCb3KrBXQxTrGm7AEEZbtGHCaGYldxi83t5VOE4LWq1Y9y2PcKTaJ
         /kH7Gc4hqYA03K/EbF7AINwPkv3BEIscjddk4al8r6C0l7jZWTaHtLQPVEwURJZY55CV
         F74FzmMK9NbLfi/lmdQgJ6uYDeua5MyIT5UlzqL4gEgVBtDG5Je1NwNCanKWRnv+pwsJ
         H0B1pIfUbG5ulUxD/MpmS/nzjLnWuHabeev/X88Cq6/g+Esm0p6uRHAKVQYmwS0hHcKy
         gOnpOBOQIXxR+a1FC9Na6x1URmLePf7pIq6GbcV3Sajliz5W0K/ptkJ1CUKEkd4lx1vB
         Ufbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778233647; x=1778838447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9WFo19/tiacPEZko0UlNLOgNR3VTMpCZ9FxtExVQYw=;
        b=YoSHGYSNQcqKnWAh1QPREvPGYLnR8DCMRsSGD3m5Zg957smnb5SFlPfzwoAllHJRog
         tNppWFDf+83cQwK6hZoeZy3uwvzHnc77F9/33Y2jMCd4GtF+8+UbhpFLzP6pt2ayLSxU
         MV4X8SFLpXRrBb6YjQZ3VqEMmsqJJq/jOanImP13S1xmnJC20kguAbWYO4t5YAwPJhQo
         3QVW3JRs/j+iw+f8ywrZRG+xLu4LCvHFj98Dk7BTY7GxzoFombbuV65lq+8SCgi0Xujz
         13MZj4Ab8pim+zbEF9NCEuOfMK9SOxnCRm5+mAlbLykmtzDltdCxkuwv+T95zmyJGeWc
         l5NQ==
X-Forwarded-Encrypted: i=1; AFNElJ80zQv8/JHEICRMkhX63CCrQ3Rp0Mmj48EnsGJqZyb4StgYEvX6CRBBCybdBhP71oSwLn8+ikjiZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3f282wp15TSP/Hs00ioNWWs7BCPAA/zhbqbjy0ht/fdBnj4Up
	z6W2sWwOf/aO9klUnUCftml3XXpIlZ9we2/rS76RwpYV8VRfPAmjStzNt+DBd0rPt0U=
X-Gm-Gg: Acq92OEEZdeUpeQsAT87zCePhlui9GoLMuQLiRPqdUEyw0r06aiDhNbxDe9MEBQ+K0K
	mSMblr+ybN19nMO9/OTOZ2hnBHWsPI9YXaRSUQwMsAtqdo+ndWkFgpEyUMdDq4l2GtCMsZh0wNy
	pa2ma1EALf3gIV8WtnDIpeGrglP4Yc8uRguyHPaNa0O4MaBEXTGV0cNCY3gGbPp9Vbz78OgJ0ML
	taz7y/tUBWQ8a5FCsynzrgRlNnQo6AuUSNcZi8LFs7X0wPMxScRfoMiP0O8AyO9iDvbcl1sIIa6
	1jMpTp2/KXbW3uDVhg3nINJf2BUYdUSDs1ETWB21Ycduzb0NJZq1PBxZ8QUJmzVLzXE8N+IWdws
	Lt8AQt3wFDQ7mhlvgx3syX/muq6Vb2MsnOoIEMpxSPPvDY9RnmPTCOzLD05FhwLOPEOy/mxv7N6
	ol4swrtSfCbEkzBZrQueomYsY=
X-Received: by 2002:a17:90b:2248:b0:35f:bd51:cf60 with SMTP id 98e67ed59e1d1-365ab9b8e8dmr11345395a91.1.1778233647084;
        Fri, 08 May 2026 02:47:27 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da1f5d6sm1741682a91.3.2026.05.08.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:47:26 -0700 (PDT)
Date: Fri, 8 May 2026 15:17:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <6cq7e26levlhwh6aoq6aii3vsyjqtvp2ksymovkosfhuuunv6u@cyab7jjd2fgy>
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423084731.1090384-2-pierre.gondois@arm.com>

On 23-04-26, 10:47, Pierre Gondois wrote:
> cpufreq_set_policy() will ultimately override the policy min/max
> values written in the .init() callback through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
> 
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-__cpufreq_driver_target()
>     \-cpufreq_driver->target()
> is called. To avoid any regression, set policy->min/max in cpufreq.c
> if the values were not initialized.
> 
> In this patch:
> - Setting policy->min or max value in driver .init() cb is
>   interpreted as setting a QoS constraint.
> - Remove policy->min/max initialization in drivers if the values
>   are similar to policy->cpuinfo.min_freq/max_freq.
>   The only drivers where these values are different are:
>   - gx-suspmod.c
>   - cppc-cpufreq.c
>   - longrun.c
> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>   used as a min QoS constraint as suggested at:
>   https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>  drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>  drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>  drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>  drivers/cpufreq/freq_table.c      |  7 +++----
>  drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>  drivers/cpufreq/intel_pstate.c    |  3 ---
>  drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>  drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>  drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>  drivers/cpufreq/virtual-cpufreq.c |  5 +----
>  11 files changed, 51 insertions(+), 39 deletions(-)

I was looking for this series to be divided in 2-3 patches:
- 1st patch would set policy->min/max from cpufreq_policy_online(), if they
  aren't already set.
- 2nd patch changes all drivers to not set it anymore, unless QoS thingy.
- Last change talks about QoS and default values.

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 453084c67327f..1ed4bcdcc957f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	perf = READ_ONCE(cpudata->perf);
>  
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
> +	policy->cpuinfo.min_freq = perf_to_freq(perf,
> +						cpudata->nominal_freq,
> +						perf.lowest_perf);

This can come in two lines now instead of three. Similar issue at few more
places.

> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	unsigned int cpu = policy->cpu;
>  	struct cppc_cpudata *cpu_data;
>  	struct cppc_perf_caps *caps;
> +	unsigned int min, max;
>  	int ret;
>  
>  	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	caps = &cpu_data->perf_caps;
>  	policy->driver_data = cpu_data;
>  
> +	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> +	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +			       caps->highest_perf : caps->nominal_perf);
> +
>  	/*
>  	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>  	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>  	 */
> -	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> -						caps->highest_perf : caps->nominal_perf);
> +	policy->min = min;
>  
>  	/*
>  	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * nonlinear perf
>  	 */
>  	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> +	policy->cpuinfo.max_freq = max;

I think the use of local variables isn't making it any better.

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..700abcb3e2e0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -660,8 +660,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
         * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
         */
        policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
-       policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
-                                               caps->highest_perf : caps->nominal_perf);

        /*
         * Set cpuinfo.min_freq to Lowest to make the full range of performance
@@ -669,7 +667,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
         * nonlinear perf
         */
        policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-       policy->cpuinfo.max_freq = policy->max;
+       policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
+                                  caps->highest_perf : caps->nominal_perf);

        policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
        policy->shared_type = cpu_data->shared_type;


> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>  
>  	if (new_policy) {
> +		unsigned int min, max;
> +
> +		/* Use policy->min/max set by the driver as QoS requests. */
> +		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +		if (policy->max)
> +			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +		else
> +			max = FREQ_QOS_MAX_DEFAULT_VALUE;
>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
>  			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		ret = freq_qos_add_request(&policy->constraints,
>  					   &policy->min_freq_req, FREQ_QOS_MIN,
> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
> +					   min);
>  		if (ret < 0)
>  			goto out_destroy_policy;
>  
>  		ret = freq_qos_add_request(&policy->constraints,
>  					   &policy->max_freq_req, FREQ_QOS_MAX,
> -					   FREQ_QOS_MAX_DEFAULT_VALUE);
> +					   max);
>  		if (ret < 0)
>  			goto out_destroy_policy;
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> +
> +		/*
> +		 * If the driver didn't set QoS constraints, policy->min/max still
> +		 * need to be set as they are used to clamp frequency requests.
> +		 */
> +		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
> +		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;

Why aren't we doing this right after cpufreq_driver->init() ?

-- 
viresh
