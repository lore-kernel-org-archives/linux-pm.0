Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984D364949;
	Sun, 11 Oct 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762167; cv=none; b=IbXnHCCVtAQx8I7CfY9RYYKYD1S/ZlKd+phrnyGIleKVlfD+cV1+rxMiNvASlRBiquFjVifqNI1Afqrv+GByyjKnmxUd9Pxvyv8J5ffilj6fVCb50j6kujkXm1HPlHwmXZezlARvYL+hGv01qwS7IXHPSG3d4XEgOQibQ/9wUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762167; c=relaxed/simple;
	bh=3ASDPkh7bFKxV+Xlko8luTX0hthlzKfSL5EvxXMrGDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oG6B8V9x3Ey8d+RSCDeD7+6WjpoQsGxh1p4HxRJBLzrCw3lvDYbQ9R/6KolhEzX4lqr38TdAXneuo4etDDEdEOvWXECKMOzZdrOqracxdOnsVIJxK6KzdduLIQ1nHYjHwOk17scQo9mmKkZGFJcupI16gtZyDCEqYL8AGwdwfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pUzafdlx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pUzafdlx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D2B1570;
	Sun, 11 Oct 2026 16:42:40 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81C713F673;
	Sun, 11 Oct 2026 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791762163; bh=3ASDPkh7bFKxV+Xlko8luTX0hthlzKfSL5EvxXMrGDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pUzafdlx1tK6QaNcWKkotjZII53Z7zal0ciES89s7LaZwp5XKCZNwcNi27al3bdvF
	 yAb5GnFBzNfp4qZRRQq7DRBjWeviWuN0Z1Gxti5bQXs42Z8sBfTwpPcdYygaYdB6xL
	 UyLdBk4I0q5GlvKFfs08jpnJcDiKdm7CwqXunbBw=
Message-ID: <33d9cbb5-d4fb-4f16-b63e-5ae89051952a@arm.com>
Date: Mon, 12 Oct 2026 01:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to non-boost
 freq on boost disable
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jie Zhan <zhanjie9@hisilicon.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Oleg Keri <okerixx@gmail.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.09.26 13:38, Ananthu C V wrote:
> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
> max boost is known") introduced a guard for cpuinfo max updates to only
> increase, to preserve driver-set values above the freq table maximum.
> Later commit db80ad776cd2 ("cpufreq: Remove driver default policy->min/max
> init") dropped the 'policy->max = max_freq' assignment from
> cpufreq_frequency_table_cpuinfo, leaving that one-way-guard to be the only
> path for cpuinfo max and consequently policy max to be updated, causing
> both values to be stuck at boost frequency even when boost is disabled.
> 
> Unconditionally track the highest non-boost frequency (max_base_freq)
> in the freq table. If boost frequencies are available, use the highest
> frequency from the table/max_base_freq instead of cpuinfo->max_freq to
> control boost values, so the value can decrease again when boost is
> disabled.
> 
> Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max init")
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq.c    | 16 +++++++++++++++-
>  drivers/cpufreq/freq_table.c |  9 ++++++++-
>  include/linux/cpufreq.h      |  3 +++
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 96515880b4ac..5e6afb6f8826 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -574,6 +574,8 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>  
>  static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  {
> +	unsigned int max_freq;
> +	unsigned int max_table_freq;
>  	int ret;
>  
>  	if (policy->boost_enabled == enable)
> @@ -587,7 +589,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  		return ret;
>  	}
>  
> -	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	max_table_freq = cpufreq_frequency_table_max(policy);
> +
> +	if (policy_has_boost_freq(policy)) {
> +		max_freq = enable ? max_table_freq : policy->cpuinfo.max_base_freq;
> +
> +		if (!max_freq)
> +			/* when the freq table contains only boost frequencies */
> +			max_freq = max_table_freq;
> +	} else {
> +		max_freq = policy->cpuinfo.max_freq;
> +	}
> +
> +	ret = freq_qos_update_request(&policy->boost_freq_req, max_freq);

This looks pretty convoluted. You have to find the correct freq argument
for freq_qos_update_request() for freq_table drivers but work around
this for e.g. the CPPC driver.

cpufreq_driver->set_boost() of e.g. the freq_table scmi-cpufreq driver
does not adjust policy->cpuinfo.max_freq for 'boost state = 0':

cpufreq_boost_set_sw() {

 cpufreq_frequency_table_cpuinfo()

  policy->cpuinfo.min_freq = min_freq

  if (policy->cpuinfo.max_freq < max_freq) <-- (*)
   policy->cpuinfo.max_freq = max_freq
}

whereas the one of the cppc_cpufreq driver does:

cppc_cpufreq_set_boost() {

 if (state)
   policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf)
 else
   policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf)
}

(*) This was added by 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq
directly if max boost is known"). With this the

policy_set_boost(policy, enable) {

 cpufreq_driver->set_boost(policy, enable)

 freq_qos_update_request(..., policy->cpuinfo.max_freq)
}

[...]
