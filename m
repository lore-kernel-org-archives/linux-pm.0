Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725960;
	b=eOjmlbOXFCuUL8VvSc8cOYHcfGJF59dbGwVFmajjnTpzbMWTYwdvP+Cn1G2fV9+HCL+2
	 +lRO+O3Z5ypQCYlOT0RJ5IfzXlBEERCrY9RL7EToTYIx1Fsby7J/atJCo4OzvFqbQZ5pj
	 0N1vDQEYiAvvk04QD6F+pTc30PO8vrNOKKFPOjNsD9ZmRBIy0XPrL8c6jrhQm4LaV4+I0
	 wkO5xXSXjPwRpf9Jy+yyWOCEq6EojXDHSNokWiN65AXP3cdQG/dUA4G88k//SbOmNUpiv
	 UzZM454761hioQO4gIFE7Zi7FamRB61EDWJd4QJZvX1ZiR1jHx46ZjuaOFfgq3SlG5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725960;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jMBi/O/YxdS3DpA1FgfPHgEkTg0rXr4CLzlctrff388=;
	b=mUtblZ4DcyEWpi3DBfkZq1ghmyNHshp7lxUOYwaKy+Kwbzh9L3VTVwcE+gXi0WW3g9U0
	 FfgS0MjwegdcbAAlvcV0PeaNWf2MJptrHIZpojKbitj185g1Tk5118FBCfObHVKz9qgrd
	 Z5n/4C7tag0qZAuwBym7qxY7m2GX2xsje7KhMSLYVCKVLuSWqWEGehtdAStED5LQsZq90
	 Da8QnFUNjJVLMa1+Agn9d31EIwQNcy+6fe4pCYJ+XKzN3kzt6SPufvkp5A23tW1D2GEEk
	 buKp9V9BFdl6kj6ThJv79K+prdIKm4socwgvXdATsxAGtnIJ+qpvSp+G+Fe7Kg7vThA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="gL//k96O";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F0606A329;
	Tue,  3 Nov 2026 17:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404F0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gL//k96O
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C8B31595;
	Tue,  3 Nov 2026 09:12:34 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5A03F673;
	Tue,  3 Nov 2026 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793725957; bh=HOLibGofC98lvxbmB9jkoaGkEuerTzovkAzWL27zyT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gL//k96ODEAV5z9zf6lbjzVwL0/flZwigUfsB9vUmLF9edRnJHr7P5phCYWFnJW5q
	 39MJhmJkZZ5OjZbAmOn75rhS5EnhvjJSUi/eaEjAML6+UIWU+svPKzBNVLcxgk5nVm
	 FbrQZaYOmg+JXwlEghKTyajxNPatAYuf0y+E++eM=
Message-ID: <6392b2cb-0cbf-455a-8c05-c273535b2c10@arm.com>
Date: Tue, 3 Nov 2026 17:12:32 +0000
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
Subject: Re: [PATCH v8 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost
 and limits
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <20261030172745.2045743-4-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030172745.2045743-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 17:27, Sumit Gupta wrote:
> Boost is the performance range above nominal, so lowering the OSPM
> Nominal Performance enlarges the boost range and drops the non-boost
> ceiling. Keep the policy limits consistent with the register.
> 
> Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
> Performance when set and the platform nominal otherwise. Use it for the
> non-boost ceiling in set_boost(), and to update the policy limits when
> ospm_nominal_freq is written.
> 
> The cpufreq core caps scaling_max_freq with a per-policy QoS request,
> boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
> boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
> without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
> the request itself, rather than leaving scaling_max_freq at the old
> nominal.
> 
> When boost is enabled the ceiling is highest_perf, not the nominal, so
> the update is skipped. set_boost() applies the new nominal when boost is
> turned off.
> 
> A platform with highest_perf == nominal_perf has no boost range at boot.
> Lowering the OSPM nominal from sysfs can create one. The core, however,
> adds its boost FREQ_QOS_MAX request only at policy setup, and only if
> boost_supported is already set. Set boost_supported in init() when the
> OSPM register is supported and highest_perf > lowest_perf. Boost can
> then be enabled after the nominal is lowered.
> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Thinking out loud here:
I'm curious if there's actually a use-case for this, presumably once we
let userspace effectively dictate boost allocation, we practically expect
userspace to sort out scheduling, too (e.g. by pinning?) and therefore this
becomes largely irrelevant?

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  4 ++
>  drivers/cpufreq/cppc_cpufreq.c                | 72 ++++++++++++++++++-
>  2 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 6af7fa86e44c..d219fc27a0c9 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -362,6 +362,10 @@ Description:	OSPM Nominal Performance (kHz)
>  		Write a value in kHz, between the frequencies corresponding to
>  		Lowest Performance and Nominal Performance.
>  
> +		While boost is disabled, cpuinfo_max_freq is set to this value
> +		and scaling_max_freq cannot go above it. While boost is
> +		enabled, cpuinfo_max_freq is the Highest Performance frequency.
> +
>  		The register cannot be read back, so a read returns the last
>  		value written, rounded to a performance level. It returns
>  		"<unset>" before the first write. Reads and writes fail with
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 662397526433..7cac31de7325 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -915,6 +915,29 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>  	policy->driver_data = NULL;
>  }
>  
> +/*
> + * Return the non-boost performance ceiling. This is the OSPM Nominal
> + * Performance the driver last requested, or the platform-reported Nominal
> + * Performance if none was requested.
> + *
> + * The register is write-only, so the requested value comes from the
> + * software-tracked state rather than from hardware.
> + */
> +static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
> +{
> +	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 ospm_nominal;
> +
> +	ospm_nominal = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
> +
> +	/* U64_MAX means OSPM has not selected a nominal level. */
> +	if (ospm_nominal == U64_MAX)
> +		return cpu_data->perf_caps.nominal_perf;
> +
> +	return (u32)ospm_nominal;
> +}
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
> @@ -974,9 +997,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	/*
>  	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
> -	 * is supported.
> +	 * is supported. A writable OSPM Nominal Performance register can also
> +	 * open a boost range at runtime by lowering the nominal, so assume
> +	 * boost is supported in that case too, letting the core register its
> +	 * QoS request up front.
>  	 */
> -	if (caps->highest_perf > caps->nominal_perf)
> +	if (caps->highest_perf > caps->nominal_perf ||
> +	    (caps->highest_perf > caps->lowest_perf &&
> +	     cppc_ospm_nominal_perf_supported(cpu)))
>  		policy->boost_supported = true;
>  
>  	/*
> @@ -1280,11 +1308,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u32 nominal = cppc_cpufreq_effective_nominal(policy);
>  
>  	if (state)
>  		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>  	else
> -		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, nominal);
>  
>  	return 0;
>  }
> @@ -1494,6 +1523,41 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>  			 cppc_set_perf_limited)
>  
> +/*
> + * While boost is disabled, the nominal is the ceiling. Set cpuinfo.max_freq to
> + * it and update the core's boost_freq_req to match. The core only syncs
> + * boost_freq_req when boost is enabled or disabled, so a plain nominal change
> + * must update it here. Without that, raising the nominal again would leave the
> + * stale request capping the policy.
> + *
> + * Refresh the limits directly rather than leave it to the QoS notifier, which
> + * only schedules the update, so the new ceiling is in place once the write
> + * returns. The sysfs store path holds policy->rwsem, which the refresh needs.

Interestingly the global boost toggle doesn't seem to hold policy->rwsem when iterating
over the policies. That seems to be an oversight, I'll send a patch.

The rest looks okay to me FWIW.

> + */
> +static void cppc_cpufreq_update_nominal_limits(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u32 nominal;
> +	int ret;
> +
> +	if (policy->boost_enabled)
> +		return;
> +
> +	nominal = cppc_cpufreq_effective_nominal(policy);
> +	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
> +						    nominal);
> +
> +	if (freq_qos_request_active(&policy->boost_freq_req)) {
> +		ret = freq_qos_update_request(&policy->boost_freq_req,
> +					      policy->cpuinfo.max_freq);
> +		if (ret < 0)
> +			pr_debug("Failed to update boost limit on CPU%u (%d)\n",
> +				 policy->cpu, ret);
> +	}
> +
> +	refresh_frequency_limits(policy);
> +}> +
>  static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
>  {
>  	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> @@ -1552,6 +1616,8 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>  	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_FIRMWARE] =
>  		cpu_data->perf_caps.nominal_perf;
>  
> +	cppc_cpufreq_update_nominal_limits(policy);
> +
>  	return count;
>  }
>  

