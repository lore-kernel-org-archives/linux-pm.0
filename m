From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Thu, 26 May 2016 12:46:29 +0530
Message-ID: <20160526071629.GW17585@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34702 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcEZHQd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2016 03:16:33 -0400
Received: by mail-pf0-f174.google.com with SMTP id y69so28128933pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2016 00:16:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464231181-30741-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 25-05-16, 19:53, Steve Muckle wrote:
> The slow-path frequency transition path is relatively expensive as it
> requires waking up a thread to do work. Should support be added for
> remote CPU cpufreq updates that is also expensive since it requires an
> IPI. These activities should be avoided if they are not necessary.
> 
> To that end, calculate the actual driver-supported frequency required by
> the new utilization value in schedutil by using the recently added
> cpufreq_driver_resolve_freq callback. If it is the same as the
> previously requested driver frequency then there is no need to continue
> with the update assuming the cpu frequency limits have not changed. This
> will have additional benefits should the semantics of the rate limit be
> changed to apply solely to frequency transitions rather than to
> frequency calculations in schedutil.

Maybe mention here that this patch isn't avoiding those IPIs yet, I
got an impression earlier that they are avoided with it.

> The last raw required frequency is cached. This allows the driver
> frequency lookup to be skipped in the event that the new raw required
> frequency matches the last one, assuming a frequency update has not been
> forced due to limits changing (indicated by a next_freq value of
> UINT_MAX, see sugov_should_update_freq).

I am not sure this is required, see below..

> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 154ae3a51e86..ef73ca4d8d78 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -45,6 +45,8 @@ struct sugov_cpu {
>  	struct update_util_data update_util;
>  	struct sugov_policy *sg_policy;
>  
> +	unsigned int cached_raw_freq;
> +
>  	/* The fields below are only needed when sharing a policy. */
>  	unsigned long util;
>  	unsigned long max;
> @@ -104,7 +106,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
> - * @policy: cpufreq policy object to compute the new frequency for.
> + * @sg_cpu: schedutil cpu object to compute the new frequency for.
>   * @util: Current CPU utilization.
>   * @max: CPU capacity.
>   *
> @@ -119,14 +121,24 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>   * next_freq = C * curr_freq * util_raw / max
>   *
>   * Take C = 1.25 for the frequency tipping point at (util / max) = 0.8.
> + *
> + * The lowest driver-supported frequency which is equal or greater than the raw
> + * next_freq (as calculated above) is returned.
>   */
> -static unsigned int get_next_freq(struct cpufreq_policy *policy,
> -				  unsigned long util, unsigned long max)
> +static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
> +				  unsigned long max)
>  {
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
>  
> -	return (freq + (freq >> 2)) * util / max;
> +	freq = (freq + (freq >> 2)) * util / max;
> +
> +	if (freq == sg_cpu->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
> +		return sg_policy->next_freq;

I am not sure what the benefit of the second comparison to UINT_MAX
is. The output of below code will be same if the freq was ==
cached_raw_freq, no matter what.

I also have a doubt (I am quite sure Rafael will have a reason for
that, which I am failing to understand now), on why we are doing
next_freq == UINT_MAX in sugov_should_update_freq().

I understand that because the limits might have changed,
need_freq_update would have been set to true. We should evaluate
next-freq again without worrying about the load or the time since last
evaluation.

But what will happen by forcefully calling the cpufreq routines to
change the frequency, if next_freq hasn't changed even after limits
updates? Wouldn't that call always return early because the new freq
and the current freq are going to be same ?

@Rafael: Sorry for asking this so late :(

-- 
viresh
