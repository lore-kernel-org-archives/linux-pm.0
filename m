From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU offline/online locked
Date: Mon, 23 May 2016 15:40:41 +0200
Message-ID: <3351136.myUMJKBnm0@vostro.rjw.lan>
References: <19792191.esL3UuyORb@vostro.rjw.lan> <5580598.s7imtWPVt5@vostro.rjw.lan> <20160523035703.GF2850@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160523035703.GF2850@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, May 23, 2016 09:27:03 AM Viresh Kumar wrote:
> On 20-05-16, 23:33, Rafael J. Wysocki wrote:
> > The policy rwsem is really only needed in cpufreq_stats_create_table(), because
> > the policy notifier is gone when _free_table() runs, so another version of the
> > patch goes below.
> 
> Right. I saw that while reading your previous version but didn't reply
> because I wanted to do a more careful review.
> 
> The first issue I have here is that the _init and _exit routines in
> cpufreq-stats aren't opposite of each other. Which shouldn't be the
> case.

I'm not sure what you mean here.

> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpufreq: stats: Fix race conditions on init and cleanup
> > 
> > Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
> > are not carried out with CPU offline/online locked, so races are
> > possible with respect to policy initialization and cleanup.
> > 
> > To prevent that from happening, change the loops to walk all possible
> > CPUs, as cpufreq_stats_create_table() and cpufreq_stats_free_table()
> > handle the case when there's no policy for the given CPU cleanly, but
> > also use policy->rwsem in cpufreq_stats_create_table() to prevent it
> > from racing with the policy notifier.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> > @@ -238,7 +238,13 @@ static void cpufreq_stats_create_table(u
> >  	if (likely(!policy))
> >  		return;
> >  
> > +	/*
> > +	 * The policy notifier may run in parallel with this code, so use the
> > +	 * policy rwsem to avoid racing with it.
> > +	 */
> > +	down_write(&policy->rwsem);
> >  	__cpufreq_stats_create_table(policy);
> > +	up_write(&policy->rwsem);
> 
> I am still trying to understand why we will ever have a race here. We
> might have it, but I just want to know how.
> 
> This is what we do in on addition of a policy:
> - send the CREATE notifier
> - Add policy to the list
> 
> So, the notifiers are guaranteed to complete before the policy is
> present in the list.
> 
> CPU 0                                   CPU 1
> notifier                                cpufreq_stats_init()
> CREATE-POLICY X                         cpufreq_stats_create_table()
> __cpufreq_stats_create_table()          cpufreq_cpu_get()
> 
> AFAICT, whatever may happen, __cpufreq_stats_create_table() will *not*
> get called in parallel for the same policy.
> 
> If __cpufreq_stats_create_table() is in progress on CPU0, CPU 1 will
> not find the policy with cpufreq_cpu_get(). And if cpufreq_cpu_get()
> finds a policy, the notifier would already have completed.
> 
> What do you say ?

Say cpufreq_stats_init() runs in parallel with a CPU online (say someone
loads the cpufreq_stats module and a CPU goes online at the same time,
not likely to happen, but still possible).

Then, the notifier may get invoked when the loop is in progress and because the
CPU is added to policy->cpus (and the CPU's per-CPU pointer is set to it) before
invoking the notifier, cpufreq_stats_init() may get the policy pointer for a
policy that hasn't been initialized completely yet and then run in parallel with
the notifier for that policy.

At least I don't see anything to prevent that from happening, maybe I'm overlooking
something.

Thanks,
Rafael
