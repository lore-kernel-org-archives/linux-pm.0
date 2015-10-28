From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Wed, 28 Oct 2015 08:46:27 +0100
Message-ID: <1614479.PJ5OqJLPyG@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <4304226.RJrgDykfyW@vostro.rjw.lan> <20151028064317.GB30039@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65166 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755567AbbJ1HRa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:17:30 -0400
In-Reply-To: <20151028064317.GB30039@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On Wednesday, October 28, 2015 12:13:17 PM Viresh Kumar wrote:
> On 28-10-15, 06:54, Rafael J. Wysocki wrote:
> > On Wednesday, October 28, 2015 10:14:51 AM Viresh Kumar wrote:
> > > In cases where a single policy controls multiple CPUs, a timer is
> > > queued for every cpu present in policy->cpus. When we reach the timer
> > > handler (which can be on multiple CPUs together) on any CPU, we trace
> > > CPU load for all policy->cpus and update the frequency accordingly.
> > 
> > That would be in dbs_timer(), right?
> 
> Yeah, and we already do stuff from within the mutex there.
> 
> > > The lock is for protecting multiple CPUs to do the same thing
> > > together, as only its required to be done by a single CPU. Once any
> > > CPUs handler has completed, it updates the last update time and drops
> > > the mutex. At that point of time, other blocked handler (if any) check
> > > the last update time and return early.
> > 
> > Well, that would mean we only needed to hold the lock around the
> > need_load_eval() evaluation in dbs_timer() if I'm not mistaken.
> 
> Actually yeah, but then the fourth patch of this series uses the
> timer_mutex to fix a long standing problem (which was fixed by hacking
> the code earlier). And so we need to take the lock for the entire
> dbs_timer() routine.

I don't actually think that that patch is correct and even if it is,
we'll only need to do that *after* that patch, so at least it would be
fair to say a word about it in the changelog, wouldn't it?

> > We also should acquire it around updates of the sampling rate, which
> > essentially is set_sampling_rate().
> 
> Why? In the worst case we may schedule the next timer for the earlier
> sampling rate. But do we care that much for that race, that we want to
> add locks here as well ?

OK

That works because we actully hold the mutex around the whole function,
as otherwise we'd have seen races between delayed work items on different
CPUs sharing the policy.

> > Is there any reason to acquire it in cpufreq_governor_limits(), then,
> > for example?
> 
> Yeah, we are calling dbs_check_cpu(dbs_data, cpu) from that path,
> which will reevaluate the load.

Which means that we should take the lock around dbs_check_cpu() everywhere
in a consistent way.  Which in turn means that the lock actually does more
than you said.

My point is basically that we seem to have a vague idea about what the lock
is used for, while we need to know exactly why we need it.

Thanks,
Rafael

