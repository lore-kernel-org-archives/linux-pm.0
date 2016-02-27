From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization data from the scheduler
Date: Sat, 27 Feb 2016 01:21:36 +0100
Message-ID: <3409567.SO0ZcZmU7l@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <1506549.vT7qrjXTKz@vostro.rjw.lan> <1825489.pc33SqXSIB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1825489.pc33SqXSIB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 25, 2016 10:14:35 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new cpufreq scaling governor, called "schedutil", that uses
> scheduler-provided CPU utilization information as input for making
> its decisions.
> 
> Doing that is possible after commit fe7034338ba0 (cpufreq: Add
> mechanism for registering utilization update callbacks) that
> introduced cpufreq_update_util() called by the scheduler on
> utilization changes (from CFS) and RT/DL task status updates.
> In particular, CPU frequency scaling decisions may be based on
> the the utilization data passed to cpufreq_update_util() by CFS.
> 
> The new governor is very simple.  It is almost as simple as it
> can be and remain reasonably functional.
> 
> The frequency selection formula used by it is essentially the same
> as the one used by the "ondemand" governor, although it doesn't use
> the additional up_threshold parameter, but instead of computing the
> load as the "non-idle CPU time" to "total CPU time" ratio, it takes
> the utilization data provided by CFS as input.  More specifically,
> it represents "load" as the util/max ratio, where util and max
> are the utilization and CPU capacity coming from CFS.
> 
> All of the computations are carried out in the utilization update
> handlers provided by the new governor.  One of those handlers is
> used for cpufreq policies shared between multiple CPUs and the other
> one is for policies with one CPU only (and therefore it doesn't need
> to use any extra synchronization means).  The only operation carried
> out by the new governor's ->gov_dbs_timer callback, sugov_set_freq(),
> is a __cpufreq_driver_target() call to trigger a frequency update (to
> a value already computed beforehand in one of the utilization update
> handlers).  This means that, at least for some cpufreq drivers that
> can update CPU frequency by doing simple register writes, it should
> be possible to set the frequency in the utilization update handlers
> too in which case all of the governor's activity would take place in
> the scheduler paths invoking cpufreq_update_util() without the need
> to run anything in process context.
> 
> Currently, the governor treats all of the RT and DL tasks as
> "unknown utilization" and sets the frequency to the allowed
> maximum when updated from the RT or DL sched classes.  That
> heavy-handed approach should be replaced with something more
> specifically targeted at RT and DL tasks.
> 
> To some extent it relies on the common governor code in
> cpufreq_governor.c and it uses that code in a somewhat unusual
> way (different from what the "ondemand" and "conservative"
> governors do), so some small and rather unintrusive changes
> have to be made in that code and the other governors to support it.
> 
> However, after making it possible to set the CPU frequency from
> the utilization update handlers, that new governor's interactions
> with the common code might be limited to the initialization, cleanup
> and handling of sysfs attributes (currently only one attribute,
> sampling_rate, is supported in addition to the standard policy
> attributes handled by the cpufreq core).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> There was no v3 of this patch, but patch [2/2] had a v3 in the meantime.
> 
> Changes from v2:
> - Avoid requesting the same frequency that was requested last time for
>   the given policy.
> 
> Changes from v1:
> - Use policy->min and policy->max as min/max frequency in computations.
> 

Well, this is getting interesting. :-)

Some preliminary results from SpecPower indicate that this governor (with
patch [2/2] on top), as simple as it is, beats "ondemand" in performance/power
and generally allows the system to achieve better performance.  The difference
is not significant, but measurable.

If that is confirmed in further testing, I will be inclined to drop this thing
in in the next cycle.

Thanks,
Rafael
