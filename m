From: Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: [PATCH v2 4/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 06 Jul 2017 23:44:09 -0700
Message-ID: <c04bdad3354a0ee0aabe63fe813fdaf5@codeaurora.org>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdGGGoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 02:44:11 -0400
In-Reply-To: <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel-owner@vger.kernel.org

On 2017-07-04 10:34, Patrick Bellasi wrote:
> Currently the utilization of the FAIR class is collected before locking
> the policy. Although that should not be a big issue for most cases, we
> also don't really know how much latency there can be between the
> utilization reading and its usage.
> 
> Let's get the FAIR utilization right before its usage to be better in
> sync with the current status of a CPU.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c 
> b/kernel/sched/cpufreq_schedutil.c
> index 98704d8..df433f1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -308,10 +308,9 @@ static void sugov_update_shared(struct
> update_util_data *hook, u64 time,
>  	if (unlikely(current == sg_policy->thread))
>  		return;
> 
> -	sugov_get_util(&util, &max);
> -
>  	raw_spin_lock(&sg_policy->update_lock);
> 
> +	sugov_get_util(&util, &max);
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;

Given that the utilization update hooks are called with the per-cpu rq 
lock held (for all classes), I don't think PELT utilization can change 
throughout the lifetime of the cpufreq_update_{util,this_cpu} call? Even 
with Viresh's remote cpu callback series we'd still have to hold the rq 
lock across cpufreq_update_util..  what can change today is 'max' 
(arch_scale_cpu_capacity) when a cpufreq policy is shared, so the patch 
is still needed for that reason I think?

Thanks,
Vikram

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
