From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v6 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Wed, 10 Feb 2016 22:02:49 -0800
Message-ID: <56BC2409.2050609@linux.intel.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2111826.yKEUOzphHC@vostro.rjw.lan> <008201d16458$69b2a4f0$3d17eed0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17925 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbcBKGDP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Feb 2016 01:03:15 -0500
In-Reply-To: <008201d16458$69b2a4f0$3d17eed0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Ingo Molnar' <mingo@kernel.org>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Thomas Gleixner' <tglx@linutronix.de>



On 02/10/2016 03:11 PM, Doug Smythies wrote:
> On 2016.02.10 07:17 Rafael J. Wysocki wrote:
>> On Friday, January 29, 2016 11:52:15 PM Rafael J. Wysocki wrote:
>>> The following patch series introduces a mechanism allowing the cpufreq core
>>> and "setpolicy" drivers to provide utilization update callbacks to be invoked
>>> by the scheduler on utilization changes.  Those callbacks can be used to run
>>> the sampling and frequency adjustments code (intel_pstate) or to schedule the
>>> execution of that code in process context (cpufreq core) instead of per-CPU
>>> deferrable timers used in cpufreq today (which Thomas complained about during
>>> the last Kernel Summit).
> This patch set solves a long standing issue with the intel_pstate driver.
> The issue began with the introduction of the "duration" method for deciding
> if the CPU had been idle for a long time resulting in forcing the
> target pstate downwards. Often this was the correct action, but sometimes this
> was the wrong thing to do, because the cpu was actually very busy, but just so
> happened to be idle on jiffy boundaries (perhaps similar to what Steve Muckle
> was referring to on another branch of this thread).
>
> For an idle system, this patch set seems to change the maximum duration from
> 4 seconds to 0.5 seconds for most CPUs. However, when using v1 of patches 1
> and 2 of 3 and v5 of 3 of 3, sometimes the durations (time between passes of
> the intel-pstate driver for a given CPU) of upwards of 120 seconds were observed.
> When patches 1, 2, and 3 of 3 v6 were used, the maximum observed durations of an
> idle system were on the order of 500 milliseconds for most CPUs, but CPU 6
> sometimes went to 3.5 seconds and CPU 7 sometimes went to 4 seconds (small
> sample space, I'll consider to run an overnight test for a much much larger
> sample space). Note 4 seconds, is O.K., and what it was before, I'm just noting
> it is all.
>
> I have a bunch of graphs, if anyone wants to see the supporting data.
>
> My test computer has an older model i7 (Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz)
Thanks Doug. If you have specific workloads, please compare performance.

- Srinivas
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

