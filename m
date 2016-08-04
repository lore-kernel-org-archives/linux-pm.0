From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait
 condition
Date: Thu, 4 Aug 2016 15:09:08 -0700
Message-ID: <20160804220908.GF26555@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <CAJZ5v0j_MrarqdXh8DHHnMm4EbzEksJ8f=BD_=VzPfSD00qRKg@mail.gmail.com>
 <20160804022418.GD26555@graphite.smuckle.net>
 <11865228.rNvS61kIxv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36855 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934243AbcHDWJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 18:09:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id pp5so86297789pac.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2016 15:09:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11865228.rNvS61kIxv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Aug 04, 2016 at 11:19:00PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 03, 2016 07:24:18 PM Steve Muckle wrote:
> > On Wed, Aug 03, 2016 at 12:38:20AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Aug 3, 2016 at 12:02 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > > > On Tue, Aug 02, 2016 at 03:37:02AM +0200, Rafael J. Wysocki wrote:
> > > >> On Tue, Aug 2, 2016 at 3:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > > >> > On Mon, Aug 01, 2016 at 01:37:23AM +0200, Rafael J. Wysocki wrote:
> > > >> > ...
> > > >> >> For this purpose, define a new cpufreq_update_util() flag
> > > >> >> UUF_IO and modify enqueue_task_fair() to pass that flag to
> > > >> >> cpufreq_update_util() in the in_iowait case.  That generally
> > > >> >> requires cpufreq_update_util() to be called directly from there,
> > > >> >> because update_load_avg() is not likely to be invoked in that
> > > >> >> case.
> > > >> >
> > > >> > I didn't follow why the cpufreq hook won't likely be called if
> > > >> > in_iowait is set? AFAICS update_load_avg() gets called in the second loop
> > > >> > and calls update_cfs_rq_load_avg (triggers the hook).
> > > >>
> > > >> In practice it turns out that in the majority of cases when in_iowait
> > > >> is set the second loop will not run.
> > > >
> > > > My understanding of enqueue_task_fair() is that the first loop walks up
> > > > the portion of the sched_entity hierarchy that needs to be enqueued, and
> > > > the second loop updates the rest of the hierarchy that was already
> > > > enqueued.
> > > >
> > > > Even if the se corresponding to the root cfs_rq needs to be enqueued
> > > > (meaning the whole hierarchy is traversed in the first loop and the
> > > > second loop does nothing), enqueue_entity() on the root cfs_rq should
> > > > result in the cpufreq hook being called, via enqueue_entity() ->
> > > > enqueue_entity_load_avg() -> update_cfs_rq_load_avg().
> > > 
> > > But then it's rather difficult to pass the IO flag to this one, isn't it?
> > > 
> > > Essentially, the problem is to pass "IO" to cpufreq_update_util() when
> > > p->in_iowait is set.
> > > 
> > > If you can find a clever way to do it without adding an extra call
> > > site, that's fine by me, but in any case the extra
> > > cpufreq_update_util() invocation should not be too expensive.
> > 
> > I was under the impression that function pointer calls were more
> > expensive, and in the shared policy case there is a nontrivial amount of
> > code that is run in schedutil (including taking a spinlock) before we'd
> > see sugov_should_update_freq() return false and bail.
> 
> That's correct in principle, but we only do that if p->in_iowait is set,
> which is somewhat special anyway and doesn't happen every time for sure.
> 
> So while there is overhead theoretically, I'm not even sure if it is measurable.

Ok my worry was if there were IO-heavy workloads that would
hammer this path, but I don't know of any specifically or how often this
path can be taken.

> 
> > Agreed that getting knowledge of p->in_iowait down to the existing hook
> > is not easy. I spent some time fiddling with that. It seemed doable but
> > somewhat gross due to the required flag passing and modifications
> > to enqueue_entity, update_load_avg, etc. If it is decided that it is worth
> > pursuing I can keep working on it and post a draft.
> 
> Well, that's a Peter's call. :-)
> 
> > But I also wonder if the hooks are in the best location.  They are
> > currently deep in the PELT code. This may make sense from a theoretical
> > standpoint, calling them whenever a root cfs_rq utilization changes, but
> > it also makes the hooks difficult to correlate (for policy purposes such
> > as this iowait change) with higher level logical events like a task
> > wakeup. Or load balance where we probably want to call the hook just
> > once after a load balance is complete.
> 
> I generally agree.  We still need to ensure that the hools will be invoked
> frequently enough, though, even if HZ is 100.
> 
> > This is also an issue for the remote wakeup case where I currently have
> > another invocation of the hook in check_preempt_curr(), so I can know if
> > preemption was triggered and skip a remote schedutil update in that case
> > to avoid a duplicate IPI.
> > 
> > It seems to me worth evaluating if a higher level set of hook locations
> > could be used. One possibility is higher up in CFS:
> > - enqueue_task_fair, dequeue_task_fair
> > - scheduler_tick
> > - active_load_balance_cpu_stop, load_balance
> 
> Agreed, that's worth checking.
> 
> > Though this wouldn't solve my issue with check_preempt_curr. That would
> > probably require going further up the stack to try_to_wake_up() etc. Not
> > yet sure what the other hook locations would be at that level.
> 
> That's probably too far away from the root cfs_rq utilization changes IMO.

Is your concern that the rate of hook calls would be decreased?

thanks,
Steve
