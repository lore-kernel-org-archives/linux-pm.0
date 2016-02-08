From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Tue, 09 Feb 2016 00:06:29 +0100
Message-ID: <6398636.DlBgLvxltE@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <18671470.kF8gVcBlTg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41975 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932113AbcBHXFS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 18:05:18 -0500
In-Reply-To: <18671470.kF8gVcBlTg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Wednesday, February 03, 2016 11:20:19 PM Rafael J. Wysocki wrote:
> On Friday, January 29, 2016 11:52:15 PM Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following patch series introduces a mechanism allowing the cpufreq core
> > and "setpolicy" drivers to provide utilization update callbacks to be invoked
> > by the scheduler on utilization changes.  Those callbacks can be used to run
> > the sampling and frequency adjustments code (intel_pstate) or to schedule the
> > execution of that code in process context (cpufreq core) instead of per-CPU
> > deferrable timers used in cpufreq today (which Thomas complained about during
> > the last Kernel Summit).
> > 
> > [1/3] Introduce a mechanism for calling into cpufreq from the scheduler and
> >       registering callbacks to be executed from there.
> > 
> > [2/3] Modify intel_pstate to use the mechanism introduced by [1/3] instead
> >       of per-CPU deferrable timers to do its work.
> > 
> > This isn't entirely straightforward as the scheduler context running those
> > callbacks is really special.  Among other things it can only use raw
> > spinlocks and cannot invoke wake_up_process() directly.  Also, calling
> > ktime_get() from there may be too expensive on some systems.  All that has to
> > be taken into account, but even then the change allows some lines of code to be
> > cut from the driver.
> > 
> > Some performance and energy consumption measurements have been carried out with
> > an earlier version of this patch and it looks like the changes lead to a
> > slightly better performing system that consumes slightly less energy at the
> > same time overall.
> > 
> > [3/3] Modify the cpufreq core to use the mechanism introduced by [1/3] instead
> >       of per-CPU deferrable timers to queue up the execution of governor work.
> > 
> > Again, this isn't really straightforward for the above reasons, but still the
> > code size is reduced a bit by the changes.
> > 
> > I'm still unsure about the energy consumption and performance impact of [3/3]
> > as earlier versions of it led to inconsistent results (most likely due to bugs
> > in them that hopefully have been fixed in this version).  In particular, the
> > additional irq_work may turn out to be problematic, but more optimizations are
> > possible on top of this one even if it makes things worse by itself.
> > 
> > For example, it should be possible to move the execution of state selection
> > code into the utilization update callback itself, at least in principle, for
> > all governors.  The P-state/OPP adjustment may need to be run from process
> > context still, but for the drivers that can do it without sleeping it should
> > be possible to move that into the utilization update callback as well.
> > 
> > The patches are on top of 4.5-rc1 and have been tested on a couple of x86
> > machines.
> 
> Well, no responses here, so I'm inclined to believe that this series is fine
> by everybody (at least by everybody in the CC).
> 
> I can wait for a few days more, but new material is starting to pile up on top
> of these patches and I'll simply need to move forward at one point.

Now that all review comments have been addressed in patch [3/3], I'm going to
put this series into linux-next.

There already is 20+ patches on top of it in the queue including fixes for
bugs that have haunted us for quite some time (and that functionally depend on
this set) and I'd really like all that to get enough linux-next coverage, so
there really isn't more time to wait.

Thanks,
Rafael

