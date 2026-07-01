Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E5282F1B;
	Wed,  1 Jul 2026 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942024; cv=none; b=HV+Q3sYz0xZhIuwEypqE5XeXBVkjMBdW1h2A15ey0kGuN4ZYmrCSxx71GBP2uW9FIQK3dZB3u1+r5EnKLPuJa39ol0VL3gI6NWSF3auqQWHM7cGtrVRG74KdZkyg4x7yw8VbY6J4BVtvsifhhw5G1Ot8oaxfowKvugI8d4UBpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942024; c=relaxed/simple;
	bh=PZzeuqPCmB1eNY7dOEhMPK9sqw12cOhCvMQRpwOxku4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4oT7ngM5AG5irJHPn5l/Yx82CzTk/tW+kcwKrdLFA18jM+CgxXDoakDuS1R5lOQtxSP+wfO6Bw+TC3nLNa0xAYaNHl7xqLjnpDSqsiULgvnEuN82sSE4/lE6XCGO7z8h80ipd2jHTKYji2Edi8KD/Q3LLUYohtOO1N59sI8X5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCq/sOkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCq/sOkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBA1F000E9;
	Wed,  1 Jul 2026 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782942023;
	bh=f2TSNTOr28pG9ZvaTCLDevfHgzOLh/rc5rNXG29p8PM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SCq/sOkT45tDAkzdEFwrD/HkginQBUz1Ej4va8PnsL9nRX0nH5CIWdWwyRhbBCF2Z
	 8V6YwHPkKkApjNku8RGI+bsfR52LVIM2G7/5S/0HFNuOGFcgqrUdvycRV5FIalks2W
	 cBVSAvc6LtoQ2gPbX0EniXgbF4O8ZhxNNp59VbxP1eQMd2iTiC42sd8eYD6ErBg0FR
	 AcEcAkRb6Qq8AceLsauO5oDx/KW24ycJJYAtZaBaz2eo0J8URrjdagQQXvjgJowU7Y
	 vBH1s2JB9QhxpCMHqmntUZBE3kyUHDQ9w0dJ2MlDvxEs4jGEEcebm3EpDF3eyZcCap
	 lYnEj1f1/Ht9Q==
Message-ID: <8155d7c7-2a10-4fec-bfde-0aeb017724ac@kernel.org>
Date: Wed, 1 Jul 2026 16:40:20 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] cpufreq/amd-pstate: Repurpose "amd_dynamic_epp"
 cmdline and corresponding sysfs
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630185904.5602-4-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260630185904.5602-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 13:59, K Prateek Nayak wrote:
> Since dynamic_epp has been converted to an
> "energy_performance_preference", toggling the feature via the sysfs file
> is now redundant.
> 
> Repurpose "amd_dynamic_epp=enable" command line to opt into dynamic EPP
> by default when the active driver is loaded, or switched into. The
> "disable" counterpart will "dynamic" option out of
> "energyy_performance_preference" to ensure dynamic EPP feature can never
> be toggled.
> 
> Use a tri-state enum to differentiate if the user has supplied a command
> line parameter or not to enable the feature by default vs keeping the
> current defaults as is and allowing users to toggle it later via the
> "dynamic" option in "energy_performance_preference" selection.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Honestly - I have to question if we even want to have the kernel command 
line option anymore.  If userspace can easily opt in and out as in this 
series, do we still need a kernel command line for default policy?

I'm of the opinion rip it out, less to maintain.

> ---
>   drivers/cpufreq/amd-pstate.c | 48 +++++++++---------------------------
>   1 file changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c7eec6b96dcc..61f30820d95a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -82,12 +82,18 @@ struct quirk_entry {
>   	u32 lowest_freq;
>   };
>   
> +enum dynamic_epp_state {
> +	DYNAMIC_EPP_USER_TOGGLE = -1,	/* User can toggle dynamic EPP. (Default) */
> +	DYNAMIC_EPP_DISABLED,		/* Dynamic EPP disabled from command line. */
> +	DYNAMIC_EPP_DEFAULT_ENABLED,	/* Dynamic EPP enabled from command line. */
> +};
> +
> +static enum dynamic_epp_state dynamic_epp = DYNAMIC_EPP_USER_TOGGLE;
>   static struct cpufreq_driver *current_pstate_driver;
>   static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool amd_pstate_prefcore = true;
> -static bool dynamic_epp;
>   static struct quirk_entry *quirks;
>   
>   /*
> @@ -1839,39 +1845,9 @@ static ssize_t dynamic_epp_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
>   }
>   
> -static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
> -				 const char *buf, size_t count)
> -{
> -	bool enabled;
> -	int ret;
> -
> -	ret = kstrtobool(buf, &enabled);
> -	if (ret)
> -		return ret;
> -
> -	guard(mutex)(&amd_pstate_driver_lock);
> -
> -	if (cppc_state != AMD_PSTATE_ACTIVE) {
> -		pr_debug("dynamic_epp can only be toggled in active mode\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Nothing to do */
> -	if (dynamic_epp == enabled)
> -		return count;
> -
> -	/* reinitialize with desired dynamic EPP value */
> -	dynamic_epp = enabled;
> -	ret = amd_pstate_change_driver_mode(cppc_state);
> -	if (ret)
> -		dynamic_epp = false;
> -
> -	return ret ? ret : count;
> -}
> -
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> -static DEVICE_ATTR_RW(dynamic_epp);
> +static DEVICE_ATTR_RO(dynamic_epp);
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> @@ -1983,7 +1959,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>   	}
>   
> -	if (dynamic_epp) {
> +	if (dynamic_epp == DYNAMIC_EPP_DEFAULT_ENABLED) {
>   		/* Dynamic EPP is only available with the POWERSAVE policy. */
>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>   		ret = amd_pstate_set_dynamic_epp(policy);
> @@ -2076,7 +2052,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   		 * If dynamic_epp is enabled by default, toggle it on
>   		 * when switching to CPUFREQ_POLICY_POWERSAVE.
>   		 */
> -		if (dynamic_epp) {
> +		if (dynamic_epp == DYNAMIC_EPP_DEFAULT_ENABLED) {
>   			WARN_ON_ONCE(policy->policy != CPUFREQ_POLICY_POWERSAVE);
>   
>   			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
> @@ -2410,9 +2386,9 @@ static int __init amd_prefcore_param(char *str)
>   static int __init amd_dynamic_epp_param(char *str)
>   {
>   	if (!strcmp(str, "disable"))
> -		dynamic_epp = false;
> +		dynamic_epp = DYNAMIC_EPP_DISABLED;
>   	if (!strcmp(str, "enable"))
> -		dynamic_epp = true;
> +		dynamic_epp = DYNAMIC_EPP_DEFAULT_ENABLED;
>   
>   	return 0;
>   }

