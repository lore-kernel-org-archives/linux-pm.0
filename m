From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] sched: cpufreq_cfs: pelt-based cpu frequency scaling
Date: Wed, 6 May 2015 14:22:40 +0200
Message-ID: <20150506122240.GY23123@twins.programming.kicks-ass.net>
References: <1430777441-15087-1-git-send-email-mturquette@linaro.org>
 <1430777441-15087-5-git-send-email-mturquette@linaro.org>
 <20150505090042.GC21418@twins.programming.kicks-ass.net>
 <20150505182347.16410.16338@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45463 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbEFMXA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 08:23:00 -0400
Content-Disposition: inline
In-Reply-To: <20150505182347.16410.16338@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org

On Tue, May 05, 2015 at 11:23:47AM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2015-05-05 02:00:42)
> > On Mon, May 04, 2015 at 03:10:41PM -0700, Michael Turquette wrote:
> > > This policy is implemented using the cpufreq governor interface for two
> > > main reasons:
> > > 
> > > 1) re-using the cpufreq machine drivers without using the governor
> > > interface is hard.
> > > 
> > > 2) using the cpufreq interface allows us to switch between the
> > > scheduler-driven policy and legacy cpufreq governors such as ondemand at
> > > run-time. This is very useful for comparative testing and tuning.
> > 
> > Urgh,. so I don't really like that. It adds a lot of noise to the
> > system. You do the irq work thing to kick the cpufreq threads which do
> > their little thing -- and their wakeup will influence the cfs
> > accounting, which in turn will start the whole thing anew.
> > 
> > I would really prefer you did a whole new system with directly invoked
> > drivers that avoid the silly dance. Your 'new' ARM systems should be
> > well capable of that.
> 
> Thanks for the review Peter.

Well, I didn't actually get beyond the Changelog; although I have
rectified this now. A few more comments below.

> We'll need something in process context for the many cpufreq drivers
> that might sleep during their cpu frequency transition, no? This is due
> to calls into the regulator framework, the clock framework and sometimes
> other things such as conversing with a power management IC or voting
> with some system controller.

Yes, we need _something_. I just spoke to a bunch of people on IRC and
it does indeed seem that I was mistaken in my assumption that modern ARM
systems were 'easy' in this regard.

> > As to the drivers, they're mostly fairly small and self contained, it
> > should not be too hard to hack them up to work without cpufreq.
> 
> The drivers are not the only thing. I want to leverage the existing
> cpufreq core infrastructure:
> 
> * rate change notifiers
> * cpu hotplug awareness
> * methods to fetch frequency tables from firmware (acpi, devicetree)
> * other stuff I can't think of now
> 
> So I do not think we should throw out the baby with the bath water. The
> thing that people really don't like about cpufreq are the governors IMO.
> Let's fix that by creating a list of requirements that we really want
> for scheduler-driven cpu frequency selection:
> 
> 0) do something smart with scheduler statistics to create an improved
> frequency selection algorithm over existing cpufreq governors
> 
> 1) support upcoming and legacy hardware, within reason
> 
> 2) if a system exports a fast, async frequency selection interface to
> Linux, then provide a solution that doesn't do any irq_work or kthread
> stuff.  Do it all in the fast path
> 
> 3) if a system has a slow, synchronous interface for frequency
> selection, then provide an acceptable solution for kicking this work to
> process context. Limit time in the fast path
> 
> The patch set tries to tackle 0, 1 and 3. Would the inclusion of #2 make
> you feel better about supporting "newer" hardware with a fire-and-forget
> frequency selection interface?

I should probably look at doing a x86 support patch to try some of this
out, I'll try and find some time to play with that.

So two comments on the actual code:

1) Ideally these hooks would be called from places where we've just
computed the cpu utilization already. I understand this is currently not
the case and we need to do it in-situ.

That said; it would be good to have the interface such that we pass the
utilization in; this would of course mean we'd have to compute it at the
call sites, this should be fine I think.


2) I dislike how policy->cpus is handled; it feels upside down.
If per 1 each CPU already computed its utilization and provides it in
the call, we should not have to recompute it and its scale factor (which
btw seems done slightly odd too, I know humans like 10 base, but
computers suck at it).

Why not something like:

	usage = ((1024 + 256) * usage) >> 10; /* +25% */

	old_usage = __this_cpu_read(gd->usage);
	__this_cpu_write(gd->usage, usage);

	max_usage = 0;
	for_each_cpu(cpu, policy->cpus)
		max_usage = max(max_usage, per_cpu(gd->usage, cpu));

	if (max_usage < old_usage || /* dropped */
	    (max_usage == usage && max_usage != old_usage)) /* raised */
		request_change(max_usage);


