From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 0/7] cpufreq / sched: cpufreq_update_util() flags and iowait boosting
Date: Mon, 01 Aug 2016 01:31:38 +0200
Message-ID: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61879 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752161AbcGaXkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

Hi,

Admittedly, this hasn't been tested yet, so no promises and you have been
warned.  It builds, though (on x86-64 at least).

At this point I'm looking for general feedback mostly: does the direction make
sense or is there any reason why it can't work (that I'm not seeing), is it
acceptable and if not, how can it be improved?

Of course, if you don't like the details, please let me know too. :-)

This is based on Peter's suggestions and Srinivas's research.

The ultimate goal is to improve performance for tasks that have been waiting
on I/O in the schedutil governor and to provide a better default P-state
selection algorithm for intel_pstate (which also involves taking the "iowait"
into account).  The steps to get there are the following:

[1] Drop the util and max arguments from cpufreq_update_util() and the ->func()
    callback in struct update_util_data and make the schedutil governor access
    the scheduler's utilization data directly (this one is originally from Peter,
    I did my best to avoid breaking it).
[2] Drop cpufreq_trigger_update() as it is the same as cpufreq_update_util()
    after [1].
[3] Pass rq to cpufreq_update_util() (instead of the time) and make it do the
    smp_processor_id() check.
[4] Add a flags argument to cpufreq_update_util() and the ->func() callback in
    struct update_util_data, update their users accordingly and use the flags
    to clean up the handling of util updates from the RT sched class a bit.
[5] Make enqueue_task_fair() pass a new "IO" flag to cpufreq_update_util()
    if p->in_iowait is set.
[6] Modify the schedutil governor to use the new "IO" flag for boosting CPU
    frequency temporarily (in order to improve performance for tasks that
    have been waiting on I/O).
[7] Add a new P-state selection algorithm, based on "busy fraction" computation
    and "IO" boosting, and use it by default for Core processors.

Thanks,
Rafael
