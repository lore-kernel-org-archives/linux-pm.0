From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Fri, 29 Jan 2016 23:52:15 +0100
Message-ID: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41651 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755086AbcA2W7a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 17:59:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Hi,

The following patch series introduces a mechanism allowing the cpufreq core
and "setpolicy" drivers to provide utilization update callbacks to be invoked
by the scheduler on utilization changes.  Those callbacks can be used to run
the sampling and frequency adjustments code (intel_pstate) or to schedule the
execution of that code in process context (cpufreq core) instead of per-CPU
deferrable timers used in cpufreq today (which Thomas complained about during
the last Kernel Summit).

[1/3] Introduce a mechanism for calling into cpufreq from the scheduler and
      registering callbacks to be executed from there.

[2/3] Modify intel_pstate to use the mechanism introduced by [1/3] instead
      of per-CPU deferrable timers to do its work.

This isn't entirely straightforward as the scheduler context running those
callbacks is really special.  Among other things it can only use raw
spinlocks and cannot invoke wake_up_process() directly.  Also, calling
ktime_get() from there may be too expensive on some systems.  All that has to
be taken into account, but even then the change allows some lines of code to be
cut from the driver.

Some performance and energy consumption measurements have been carried out with
an earlier version of this patch and it looks like the changes lead to a
slightly better performing system that consumes slightly less energy at the
same time overall.

[3/3] Modify the cpufreq core to use the mechanism introduced by [1/3] instead
      of per-CPU deferrable timers to queue up the execution of governor work.

Again, this isn't really straightforward for the above reasons, but still the
code size is reduced a bit by the changes.

I'm still unsure about the energy consumption and performance impact of [3/3]
as earlier versions of it led to inconsistent results (most likely due to bugs
in them that hopefully have been fixed in this version).  In particular, the
additional irq_work may turn out to be problematic, but more optimizations are
possible on top of this one even if it makes things worse by itself.

For example, it should be possible to move the execution of state selection
code into the utilization update callback itself, at least in principle, for
all governors.  The P-state/OPP adjustment may need to be run from process
context still, but for the drivers that can do it without sleeping it should
be possible to move that into the utilization update callback as well.

The patches are on top of 4.5-rc1 and have been tested on a couple of x86
machines.

Thanks,
Rafael

