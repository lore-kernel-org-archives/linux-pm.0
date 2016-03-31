From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 31 Mar 2016 14:48:43 +0200
Message-ID: <20160331124843.GM3408@twins.programming.kicks-ass.net>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43874 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbcCaMst (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 08:48:49 -0400
Content-Disposition: inline
In-Reply-To: <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 30, 2016 at 04:00:24AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new cpufreq scaling governor, called "schedutil", that uses
> scheduler-provided CPU utilization information as input for making
> its decisions.
> 
> Doing that is possible after commit 34e2c555f3e1 (cpufreq: Add
> mechanism for registering utilization update callbacks) that
> introduced cpufreq_update_util() called by the scheduler on
> utilization changes (from CFS) and RT/DL task status updates.
> In particular, CPU frequency scaling decisions may be based on
> the the utilization data passed to cpufreq_update_util() by CFS.
> 
> The new governor is relatively simple.
> 
> The frequency selection formula used by it depends on whether or not
> the utilization is frequency-invariant.  In the frequency-invariant
> case the new CPU frequency is given by
> 
> 	next_freq = 1.25 * max_freq * util / max
> 
> where util and max are the last two arguments of cpufreq_update_util().
> In turn, if util is not frequency-invariant, the maximum frequency in
> the above formula is replaced with the current frequency of the CPU:
> 
> 	next_freq = 1.25 * curr_freq * util / max
> 
> The coefficient 1.25 corresponds to the frequency tipping point at
> (util / max) = 0.8.
> 
> All of the computations are carried out in the utilization update
> handlers provided by the new governor.  One of those handlers is
> used for cpufreq policies shared between multiple CPUs and the other
> one is for policies with one CPU only (and therefore it doesn't need
> to use any extra synchronization means).
> 
> The governor supports fast frequency switching if that is supported
> by the cpufreq driver in use and possible for the given policy.
> In the fast switching case, all operations of the governor take
> place in its utilization update handlers.  If fast switching cannot
> be used, the frequency switch operations are carried out with the
> help of a work item which only calls __cpufreq_driver_target()
> (under a mutex) to trigger a frequency update (to a value already
> computed beforehand in one of the utilization update handlers).
> 
> Currently, the governor treats all of the RT and DL tasks as
> "unknown utilization" and sets the frequency to the allowed
> maximum when updated from the RT or DL sched classes.  That
> heavy-handed approach should be replaced with something more
> subtle and specifically targeted at RT and DL tasks.
> 
> The governor shares some tunables management code with the
> "ondemand" and "conservative" governors and uses some common
> definitions from cpufreq_governor.h, but apart from that it
> is stand-alone.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/Kconfig          |   29 ++
>  kernel/sched/Makefile            |    1 
>  kernel/sched/cpufreq_schedutil.c |  528 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h             |    8 
>  4 files changed, 566 insertions(+)

I think this is a good first step and we can definitely work from here;
afaict there are no (big) disagreements on the general approach, so

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

