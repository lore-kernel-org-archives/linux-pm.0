From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Improve IO performance
Date: Mon, 31 Jul 2017 09:39:25 -0700
Message-ID: <1501519165.4920.58.camel@linux.intel.com>
References: <1501224292-45740-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1915794.l080sD0sSP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46062 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbdGaQjk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Jul 2017 12:39:40 -0400
In-Reply-To: <1915794.l080sD0sSP@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org

On Mon, 2017-07-31 at 14:21 +0200, Rafael J. Wysocki wrote:
> 

[...]

> >  #define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 *
> > NSEC_PER_MSEC)
> > +#define INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL	(NSEC_PER_MS
> > EC)
> >  #define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 *
> > NSEC_PER_MSEC)
> First offf, can we simply set INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL
> to NSEC_PER_MSEC?
> 
> I guess it may help quite a bit in the more "interactive" cases
> overall.
> 
> Or would that be too much overhead?
It will be too much overhead for clients.
 
> 
> > 
> > 
[...]

> > @@ -1527,15 +1529,18 @@ static void intel_pstate_update_util(struct
> > update_util_data *data, u64 time,
> >  
> >  	if (flags & SCHED_CPUFREQ_IOWAIT) {
> >  		cpu->iowait_boost = int_tofp(1);
> > +		current_sample_interval =
> > INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL;
> >  	} else if (cpu->iowait_boost) {
> >  		/* Clear iowait_boost if the CPU may have been
> > idle. */
> >  		delta_ns = time - cpu->last_update;
> > -		if (delta_ns > TICK_NSEC)
> > +		if (delta_ns > TICK_NSEC) {
> >  			cpu->iowait_boost = 0;
> > +			current_sample_interval =
> > INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL;
> Second, if reducing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL is not
> viable, why
> does the sample interval have to be reduced for all CPUs if
> SCHED_CPUFREQ_IOWAIT
> is set for one of them and not just for the CPU receiving that flag?
> 
Correct, the read data may be passed to some other thread for
processing.

Replacing this patch with one below improves simple grep user time and
system time by 40% on Haswell servers.

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index 48a98f11a84e..dce3e324a9da 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1751,6 +1751,16 @@ static void intel_pstate_update_util(struct
update_util_data *data, u64 time,
 
        if (flags & SCHED_CPUFREQ_IOWAIT) {
                cpu->iowait_boost = int_tofp(1);
+               /*
+                * The last time the busy was 100% so P-state was max
anyway
+                * so avoid overhead of computation.
+                */
+               if (fp_toint(cpu->sample.busy_scaled) == 100) {
+                       cpu->last_update = time;
+                       return;
+               }
+                goto set_pstate;
+
        } else if (cpu->iowait_boost) {
                /* Clear iowait_boost if the CPU may have been idle. */
                delta_ns = time - cpu->last_update;
@@ -1762,6 +1772,7 @@ static void intel_pstate_update_util(struct
update_util_data *data, u64 time,
        if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
                return;
 
+set_pstate:
        if (intel_pstate_sample(cpu, time)) {
                int target_pstate;
