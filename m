From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Wed, 10 Feb 2016 16:17:08 +0100
Message-ID: <2111826.yKEUOzphHC@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46241 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751965AbcBJPgL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 10:36:11 -0500
In-Reply-To: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Hi,

I thought it would be useful to send an update of this (adding Ingo, as Peter
has not been responsive lately).  The version goes straight to 6 as patch [3/3]
has already gone through 5 revisions.

The intro below still applies, so let me quote it.

On Friday, January 29, 2016 11:52:15 PM Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch series introduces a mechanism allowing the cpufreq core
> and "setpolicy" drivers to provide utilization update callbacks to be invoked
> by the scheduler on utilization changes.  Those callbacks can be used to run
> the sampling and frequency adjustments code (intel_pstate) or to schedule the
> execution of that code in process context (cpufreq core) instead of per-CPU
> deferrable timers used in cpufreq today (which Thomas complained about during
> the last Kernel Summit).
> 
> [1/3] Introduce a mechanism for calling into cpufreq from the scheduler and
>       registering callbacks to be executed from there.
> 
> [2/3] Modify intel_pstate to use the mechanism introduced by [1/3] instead
>       of per-CPU deferrable timers to do its work.
> 
> This isn't entirely straightforward as the scheduler context running those
> callbacks is really special.  Among other things it can only use raw
> spinlocks and cannot invoke wake_up_process() directly.  Also, calling
> ktime_get() from there may be too expensive on some systems.  All that has to
> be taken into account, but even then the change allows some lines of code to be
> cut from the driver.
> 
> Some performance and energy consumption measurements have been carried out with
> an earlier version of this patch and it looks like the changes lead to a
> slightly better performing system that consumes slightly less energy at the
> same time overall.
> 
> [3/3] Modify the cpufreq core to use the mechanism introduced by [1/3] instead
>       of per-CPU deferrable timers to queue up the execution of governor work.
> 
> Again, this isn't really straightforward for the above reasons, but still the
> code size is reduced a bit by the changes.
> 

As it turns out, patch [3/3] appears to lead to improvements in both overall
system performance and energy consumption at the same time (the are small, but
measurable).  It also unlocks further simplifications and fixes in the cpufreq
core code, so we want it badly. :-)

The most significant change from the previous version of the set is that [1/3]
now also triggers cpufreq updates from the RT and DL sched classes to avoid
stalling it in situations when no CFS activity is taking place on the CPU due
to RT/DL tasks activity (as pointed out by Steve).

As stated in a reply to Juri, the scheduler-provided utilization numbers are
not used by cpufreq at this time, but we will be using them going forward.
 
The patches are on top of 4.5-rc3 and have been tested on x86 machines.

There aleady is a metric ton of stuff to go on top of them, so I'd like to
make progress here if at all possible,

I'll put this set (along with all the stuff depending on it) into the
pm-cpufreq-test branch of the linux-pm tree.

Thanks,
Rafael
