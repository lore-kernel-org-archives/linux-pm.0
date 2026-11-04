Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793408;
	b=VnN8wj5nnt55iksHhDixbRJ2n0X8K8L+e0eWDGbVzEILn4eIllgmKZHYZSt+b68JegTA
	 65Sals2iS23mUBZTLgoc6sfz30tk4xnJ8w8fXwkKD6+Rqui6ITXVOboZx+rZ7cwuqRq25
	 2EjvyJMcW0ggtdWKPuXO9UWbu5aTS0K344QCALn+GishjZiiVsAYQfvY1pkl8qGCWnBXH
	 hKkxDr3gWoIzGzbfe8hWZRZSwhinO/MK5VWuZKi2UI73iHMJfZbPSqu9Ysd5tHFg+5Cdi
	 PJINSTmfJ+MWZYUrLUpCbS3mMln7JzXq8dj5pHIeaLQhvkNk2oRMSzuXGiGT3TeWyVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793408;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=owtkK309raNQB22GvecxADy8+vPiCp1R90q3Ul+G270=;
	b=kfpStoumZGYWUuGYFBCen+tumyu2NrOgXDk31eW1tbNsFjEnaaGDrM7t2r7bURlBoxhY
	 HD+NrdEXEer0ID5BSof7Lfu3e4k8U81FSEsb/RLzbJShn5yMNl7MYZeelz+BOirUiJZcB
	 ZJEaNjTlxcwkewOA73BE70RI3eUueS95Ugz4xKN4tcLO0QZ75BxORQhs+VHflB3YZPqY0
	 ys55TgCL+jrvCzJ513RSt7Cl3gVjuexD69ZhDC5AzzMDl7aoDV4Ci4//PY4OWYGsSij/s
	 AAOm1J9VKdtQUyvTzRzQ8b+FvbnJTxKcq9avEZF0B00vLNU+dsbeWrgVZMr7N7pcxBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EtTvnMo5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B8606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97B8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EtTvnMo5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134561650;
	Wed,  4 Nov 2026 03:56:44 -0800 (PST)
Received: from [10.57.16.210] (unknown [10.57.16.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6923F632;
	Wed,  4 Nov 2026 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793793407; bh=h3UV4CCMPjGQmegvH+1jHrS0RtP/OlOvGbWZmxHelQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EtTvnMo5eh0EUbz9PesesZWV+orfoMIuXrfH+7ZP7GYCS6+VdD5FhO4MB45SBzAjS
	 n0ZfQ9snU0VhINoDnfy0VWQmnLOutECtZ9S/l5PqE/j0m4+Rvlj6nMoIeSpfBTPqOK
	 lUUgM/srgAQCOK/47c9zGijU/Rae/efDSY7QXYpg=
Message-ID: <f6e8c9b9-3bda-4001-a08e-8484b58575ea@arm.com>
Date: Wed, 4 Nov 2026 11:56:43 +0000
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
Subject: Re: [PATCH v2 2/3] cpufreq: Force passing target frequency to driver
 during resume
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
 <1995295.tdWV9SEqCh@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1995295.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 19:47, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The policy->cur value preserved across a system suspend-resume cycle
> may become stale in some cases and it may prevent the CPU performance
> scaling logic from being updated due to the target_freq == policy->cur
> check in __cpufreq_driver_target() [1].
> 
> To address this, adjust the existing mechanism to force the invocation
> of the driver .target() callback in __cpufreq_driver_target() and make
> cpufreq_resume_policy() use it.
> 
> This involves renaming update_limits in struct cpufreq_policy to
> force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag check
> from __cpufreq_driver_target() to cpufreq_set_policy(), where it is used
> as a condition for setting policy->force_target.
> 
> In cpufreq_resume_policy(), policy->force_target is set for drivers that
> implement the .target() callback, but don't implement the .get() one,
> which is the case when the driver callback needs to run if policy->cur
> becomes stale while suspended.
> 
> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
> Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
> Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * Always clear policy->force_target if set in __cpufreq_driver_target()
>      to avoid forcing the driver callback next time unnecessarily (Sashiko)
> 
>    * Replace an outdated comment in __cpufreq_driver_target()
> 
>    * Set policy->force_target only if .target() is present and .get() is not
>      present because that is the only case in which it may matter
> 
>    * Update changelog
> 
> ---
>  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++++------------
>  include/linux/cpufreq.h   |    4 ++--
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2023,6 +2023,15 @@ static void cpufreq_resume_policy(struct
>  	if (!start)
>  		return;
>  
> +	/*
> +	 * Force executing the driver .target() callback, if present, in the
> +	 * next invocation of __cpufreq_driver_target() in case policy->cur has
> +	 * become stale while suspended, but do it only for drivers without a
> +	 * .get() callback for which cpufreq_verify_current_freq() is a NOP.
> +	 */
> +	if (cpufreq_driver->target && !cpufreq_driver->get)
> +		policy->force_target = true;
> +
>  	if (cpufreq_start_governor(policy))
>  		pr_err("%s: Failed to start governor for CPU%u's policy\n",
>  		       __func__, policy->cpu);
> @@ -2400,17 +2409,14 @@ int __cpufreq_driver_target(struct cpufr
>  		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>  
>  	/*
> -	 * This might look like a redundant call as we are checking it again
> -	 * after finding index. But it is left intentionally for cases where
> -	 * exactly same freq is called again and so we can save on few function
> -	 * calls.
> +	 * Unless invoking the target callback is forced, skip the update if the
> +	 * frequency is not really changing.
>  	 */
> -	if (target_freq == policy->cur) {
> -		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
> -		    !policy->update_limits)
> -			return 0;
> -
> -		policy->update_limits = false;
> +	if (policy->force_target) {
> +		/* Avoid forcing the driver callback unnecessarily next time. */
> +		policy->force_target = false;
> +	} else if (target_freq == policy->cur) {
> +		return 0;
>  [snip]

This is too early though? Should be something like:

---->8-----
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f0ddb8823cb..66bc53f13eef 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2398,6 +2398,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
                            unsigned int relation)
 {
        unsigned int old_target_freq = target_freq;
+       int ret;
 
        if (cpufreq_disabled())
                return -ENODEV;
@@ -2412,12 +2413,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
         * Unless invoking the target callback is forced, skip the update if the
         * frequency is not really changing.
         */
-       if (policy->force_target) {
-               /* Avoid forcing the driver callback unnecessarily next time. */
-               policy->force_target = false;
-       } else if (target_freq == policy->cur) {
+       if (!policy->force_target && target_freq == policy->cur)
                return 0;
-       }
 
        if (cpufreq_driver->target) {
                /*
@@ -2427,13 +2424,18 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
                if (!policy->efficiencies_available)
                        relation &= ~CPUFREQ_RELATION_E;
 
-               return cpufreq_driver->target(policy, target_freq, relation);
+               ret = cpufreq_driver->target(policy, target_freq, relation);
+       } else if (cpufreq_driver->target_index) {
+               ret = __target_index(policy, policy->cached_resolved_idx);
+       } else {
+               return -EINVAL;
        }
 
-       if (!cpufreq_driver->target_index)
-               return -EINVAL;
+       /* Failed updates still need to be passed to the driver next time. */
+       if (!ret)
+               policy->force_target = false;
 
-       return __target_index(policy, policy->cached_resolved_idx);
+       return ret;


