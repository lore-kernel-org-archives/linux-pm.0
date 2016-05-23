From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Mon, 23 May 2016 09:27:03 +0530
Message-ID: <20160523035703.GF2850@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <20160520022247.GS32001@vireshk-i7>
 <3805651.Y4agxXsfkM@vostro.rjw.lan>
 <5580598.s7imtWPVt5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5580598.s7imtWPVt5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 20-05-16, 23:33, Rafael J. Wysocki wrote:
> The policy rwsem is really only needed in cpufreq_stats_create_table(), because
> the policy notifier is gone when _free_table() runs, so another version of the
> patch goes below.

Right. I saw that while reading your previous version but didn't reply
because I wanted to do a more careful review.

The first issue I have here is that the _init and _exit routines in
cpufreq-stats aren't opposite of each other. Which shouldn't be the
case.

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: stats: Fix race conditions on init and cleanup
> 
> Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
> are not carried out with CPU offline/online locked, so races are
> possible with respect to policy initialization and cleanup.
> 
> To prevent that from happening, change the loops to walk all possible
> CPUs, as cpufreq_stats_create_table() and cpufreq_stats_free_table()
> handle the case when there's no policy for the given CPU cleanly, but
> also use policy->rwsem in cpufreq_stats_create_table() to prevent it
> from racing with the policy notifier.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> @@ -238,7 +238,13 @@ static void cpufreq_stats_create_table(u
>  	if (likely(!policy))
>  		return;
>  
> +	/*
> +	 * The policy notifier may run in parallel with this code, so use the
> +	 * policy rwsem to avoid racing with it.
> +	 */
> +	down_write(&policy->rwsem);
>  	__cpufreq_stats_create_table(policy);
> +	up_write(&policy->rwsem);

I am still trying to understand why we will ever have a race here. We
might have it, but I just want to know how.

This is what we do in on addition of a policy:
- send the CREATE notifier
- Add policy to the list

So, the notifiers are guaranteed to complete before the policy is
present in the list.

CPU 0                                   CPU 1
notifier                                cpufreq_stats_init()
CREATE-POLICY X                         cpufreq_stats_create_table()
__cpufreq_stats_create_table()          cpufreq_cpu_get()

AFAICT, whatever may happen, __cpufreq_stats_create_table() will *not*
get called in parallel for the same policy.

If __cpufreq_stats_create_table() is in progress on CPU0, CPU 1 will
not find the policy with cpufreq_cpu_get(). And if cpufreq_cpu_get()
finds a policy, the notifier would already have completed.

What do you say ?

-- 
viresh
