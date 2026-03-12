Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C53803EF;
	Thu, 12 Mar 2026 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348391; cv=none; b=K3Yb/gznAyHCYqPR3BHCREmWyps3aIRTJ6xKSmkR0YL/n0ExYW8ZTQ/tZYdy12Yq5Fjl/vvfp/MizDxG4MRGewSMaJlyP+XEfIoY3pkL2PNggxjFHaGFssk/zukJeirSKh+odgfZ4sgmqZn3YVJmCuD0E3mbSPXTA13UNTWpRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348391; c=relaxed/simple;
	bh=wkcmDCOYXat8rhbshXVDO/pCQtPAF6JpJLQ21bReXrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOyXO4NVL9qpeWzT0QQpcA2eHb4SxDNQrYDFk1bmqkajq/nJ4l1yBhR4fH4Km+EbyFzPQjxUBjaC/4bUKKbss4je12Ae/0/3UBEkkGpozVEY0qCPDEDHzHjNWUfcFZhah7+05S0XVyc1sGYX8swwVJumJTQ54/FSOH6tAsstqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqHuxUoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqHuxUoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3796C4CEF7;
	Thu, 12 Mar 2026 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348391;
	bh=wkcmDCOYXat8rhbshXVDO/pCQtPAF6JpJLQ21bReXrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KqHuxUoI7uKTheEv6YNkiDbsB6apusl33YIpSqdw7Zo9+a/LKwT8S58mKQZX+wuwv
	 wACEWPlFOJi1R/yBjfk6tP6bYXAA4FSv7HL2j5R3LgaGZVod+vCcYCIO9+xfjpLXwS
	 5VgeGT3yHaBH7Xd6r8pHzyc0cpaNCl0FFYwGYG7mMxm4K1FrI2ijy+Z54CndEMPMPI
	 Prp5EMs9sbuWPIA/4JLn+GM7ibdAXDZugKr86EMoYAMsji8ZnpBVZ1aeUoyoMGck67
	 /RsTIgw2LmhiSnrCv1TK6soCWMPqyTCvLu+/gVlUqJlkczkjYFOvvNPCcN63vV7Sjv
	 t5Lmis9F7CtQg==
Message-ID: <af51c23c-7dea-4e8d-89c2-1fb34fc34b2f@kernel.org>
Date: Thu, 12 Mar 2026 15:46:29 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] amd-pstate: Make certain freq_attrs conditionally
 visible
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-4-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260311140116.19604-4-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> Certain amd_pstate freq_attrs such as amd_pstate_hw_prefcore and
> amd_pstate_prefcore_ranking are enabled even when preferred core is
> not supported on the platform.
> 
> Similarly there are common freq_attrs between the amd-pstate and the
> amd-pstate-epp drivers (eg: amd_pstate_max_freq,
> amd_pstate_lowest_non_linear_freq, etc.) but are duplicated in two
> different freq_attr structs.
> 
> Unify all the attributes in a single place and associate each of them
> with a visibility function that determines whether the attribute
> should be visible based on the underlying platform support and the
> current amd_pstate mode.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

One thing that might make sense as a follow up suggestion though would 
be some changes to amd-pstate-ut to validate the right things are always 
showing up on the right configuration.

> ---
>   drivers/cpufreq/amd-pstate.c | 123 ++++++++++++++++++++++++++---------
>   1 file changed, 92 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 24cdeffbcd40e..fb5d7bb320c15 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1220,12 +1220,86 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +cpufreq_freq_attr_ro(amd_pstate_max_freq);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> +
> +cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
> +cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +
> +struct freq_attr_visibility {
> +	struct freq_attr *attr;
> +	bool (*visibility_fn)(void);
> +};
> +
> +/* For attributes which are always visible */
> +static bool always_visible(void)
> +{
> +	return true;
> +}
> +
> +/* Determines whether prefcore related attributes should be visible */
> +static bool prefcore_visibility(void)
> +{
> +	return amd_pstate_prefcore;
> +}
> +
> +/* Determines whether energy performance preference should be visible */
> +static bool epp_visibility(void)
> +{
> +	return cppc_state == AMD_PSTATE_ACTIVE;
> +}
> +
> +static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
> +	{&amd_pstate_max_freq, always_visible},
> +	{&amd_pstate_lowest_nonlinear_freq, always_visible},
> +	{&amd_pstate_highest_perf, always_visible},
> +	{&amd_pstate_prefcore_ranking, prefcore_visibility},
> +	{&amd_pstate_hw_prefcore, prefcore_visibility},
> +	{&energy_performance_preference, epp_visibility},
> +	{&energy_performance_available_preferences, epp_visibility},
> +};
> +
> +static struct freq_attr **get_freq_attrs(void)
> +{
> +	bool attr_visible[ARRAY_SIZE(amd_pstate_attr_visibility)];
> +	struct freq_attr **attrs;
> +	int i, j, count;
> +
> +	for (i = 0, count = 0; i < ARRAY_SIZE(amd_pstate_attr_visibility); i++) {
> +		struct freq_attr_visibility *v = &amd_pstate_attr_visibility[i];
> +
> +		attr_visible[i] = v->visibility_fn();
> +		if (attr_visible[i])
> +			count++;
> +	}
> +
> +	/* amd_pstate_{max_freq, lowest_nonlinear_freq, highest_freq} should always be visible */
> +	BUG_ON(!count);
> +
> +	attrs = kcalloc(count + 1, sizeof(struct freq_attr *), GFP_KERNEL);
> +	if (!attrs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0, j = 0; i < ARRAY_SIZE(amd_pstate_attr_visibility); i++) {
> +		if (!attr_visible[i])
> +			continue;
> +
> +		attrs[j++] = amd_pstate_attr_visibility[i].attr;
> +	}
> +
> +	return attrs;
> +}
> +
>   static void amd_pstate_driver_cleanup(void)
>   {
>   	if (amd_pstate_prefcore)
>   		sched_clear_itmt_support();
>   
>   	cppc_state = AMD_PSTATE_DISABLE;
> +	kfree(current_pstate_driver->attr);
>   	current_pstate_driver = NULL;
>   }
>   
> @@ -1250,6 +1324,7 @@ static int amd_pstate_set_driver(int mode_idx)
>   
>   static int amd_pstate_register_driver(int mode)
>   {
> +	struct freq_attr **attr = NULL;
>   	int ret;
>   
>   	ret = amd_pstate_set_driver(mode);
> @@ -1258,6 +1333,22 @@ static int amd_pstate_register_driver(int mode)
>   
>   	cppc_state = mode;
>   
> +	/*
> +	 * Note: It is important to compute the attrs _after_
> +	 * re-initializing the cppc_state.  Some attributes become
> +	 * visible only when cppc_state is AMD_PSTATE_ACTIVE.
> +	 */
> +	attr = get_freq_attrs();
> +	if (IS_ERR(attr)) {
> +		ret = (int) PTR_ERR(attr);
> +		pr_err("Couldn't compute freq_attrs for current mode %s [%d]\n",
> +			amd_pstate_get_mode_string(cppc_state), ret);
> +		amd_pstate_driver_cleanup();
> +		return ret;
> +	}
> +
> +	current_pstate_driver->attr = attr;
> +
>   	/* at least one CPU supports CPB */
>   	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>   
> @@ -1399,37 +1490,9 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> -cpufreq_freq_attr_ro(amd_pstate_max_freq);
> -cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> -
> -cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> -cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
> -cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
> -cpufreq_freq_attr_rw(energy_performance_preference);
> -cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
>   
> -static struct freq_attr *amd_pstate_attr[] = {
> -	&amd_pstate_max_freq,
> -	&amd_pstate_lowest_nonlinear_freq,
> -	&amd_pstate_highest_perf,
> -	&amd_pstate_prefcore_ranking,
> -	&amd_pstate_hw_prefcore,
> -	NULL,
> -};
> -
> -static struct freq_attr *amd_pstate_epp_attr[] = {
> -	&amd_pstate_max_freq,
> -	&amd_pstate_lowest_nonlinear_freq,
> -	&amd_pstate_highest_perf,
> -	&amd_pstate_prefcore_ranking,
> -	&amd_pstate_hw_prefcore,
> -	&energy_performance_preference,
> -	&energy_performance_available_preferences,
> -	NULL,
> -};
> -
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> @@ -1696,7 +1759,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.set_boost	= amd_pstate_set_boost,
>   	.update_limits	= amd_pstate_update_limits,
>   	.name		= "amd-pstate",
> -	.attr		= amd_pstate_attr,
>   };
>   
>   static struct cpufreq_driver amd_pstate_epp_driver = {
> @@ -1712,7 +1774,6 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.update_limits	= amd_pstate_update_limits,
>   	.set_boost	= amd_pstate_set_boost,
>   	.name		= "amd-pstate-epp",
> -	.attr		= amd_pstate_epp_attr,
>   };
>   
>   /*
> @@ -1858,7 +1919,7 @@ static int __init amd_pstate_init(void)
>   	return ret;
>   
>   global_attr_free:
> -	cpufreq_unregister_driver(current_pstate_driver);
> +	amd_pstate_unregister_driver(0);
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

