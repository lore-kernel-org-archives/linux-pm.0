From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Mon, 23 May 2016 20:49:10 +0530
Message-ID: <20160523151910.GC17585@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <5580598.s7imtWPVt5@vostro.rjw.lan>
 <20160523035703.GF2850@vireshk-i7>
 <3351136.myUMJKBnm0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3351136.myUMJKBnm0@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 23-05-16, 15:40, Rafael J. Wysocki wrote:
> On Monday, May 23, 2016 09:27:03 AM Viresh Kumar wrote:
> > On 20-05-16, 23:33, Rafael J. Wysocki wrote:
> > > The policy rwsem is really only needed in cpufreq_stats_create_table(), because
> > > the policy notifier is gone when _free_table() runs, so another version of the
> > > patch goes below.
> > 
> > Right. I saw that while reading your previous version but didn't reply
> > because I wanted to do a more careful review.
> > 
> > The first issue I have here is that the _init and _exit routines in
> > cpufreq-stats aren't opposite of each other. Which shouldn't be the
> > case.
> 
> I'm not sure what you mean here.

Sorry about that. I meant that exit() should look opposite of init() ideally,
whereas if you look at current code, both are (un)registering the
POLICY_NOTIFIER at the top.

> > I am still trying to understand why we will ever have a race here. We
> > might have it, but I just want to know how.
> > 
> > This is what we do in on addition of a policy:
> > - send the CREATE notifier
> > - Add policy to the list
> > 
> > So, the notifiers are guaranteed to complete before the policy is
> > present in the list.
> > 
> > CPU 0                                   CPU 1
> > notifier                                cpufreq_stats_init()
> > CREATE-POLICY X                         cpufreq_stats_create_table()
> > __cpufreq_stats_create_table()          cpufreq_cpu_get()
> > 
> > AFAICT, whatever may happen, __cpufreq_stats_create_table() will *not*
> > get called in parallel for the same policy.
> > 
> > If __cpufreq_stats_create_table() is in progress on CPU0, CPU 1 will
> > not find the policy with cpufreq_cpu_get(). And if cpufreq_cpu_get()
> > finds a policy, the notifier would already have completed.
> > 
> > What do you say ?

Until now I thought you are trying to prevent the race where
__cpufreq_stats_create_table() gets called in parallel for the same policy. So,
above explains that it can't happen for sure.

> Say cpufreq_stats_init() runs in parallel with a CPU online (say someone
> loads the cpufreq_stats module and a CPU goes online at the same time,
> not likely to happen, but still possible).

Of course, that will be a design problem if it ever happens. I agree.

> Then, the notifier may get invoked when the loop is in progress and because the
> CPU is added to policy->cpus (and the CPU's per-CPU pointer is set to it) before
> invoking the notifier, cpufreq_stats_init() may get the policy pointer for a
> policy that hasn't been initialized completely yet and then run in parallel with
> the notifier for that policy.

If the policy isn't initialized fully before its added to the list, then that's
a problem in cpufreq.c I would say.

But, I don't see a problem here. The policy's kobject, etc gets initialized
fully before its added to the list or the notifier is sent for CREATE_POLICY.
Just that the governor isn't set properly, nothing else.

And if you think about it the other way round, we are sending the CREATE_POLICY
notifier right at that point where we add it to the list, and the cpufreq-stats
layer is expected to work on the policy right from that call. So, it is fully
initialized from the perspective of the stats layer. Nothing should go wrong.

-- 
viresh
