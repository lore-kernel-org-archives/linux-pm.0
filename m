From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Sat, 22 Apr 2017 23:07:44 +0200
Message-ID: <8915951.Nmj3GAYbcQ@aspire.rjw.lan>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net> <000a01d2b9e6$393afef0$abb0fcd0$@net> <000301d2bb31$c0037790$400a66b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57797 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426896AbdDVVNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Apr 2017 17:13:55 -0400
In-Reply-To: <000301d2bb31$c0037790$400a66b0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Mel Gorman' <mgorman@techsingularity.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On Friday, April 21, 2017 11:29:06 PM Doug Smythies wrote:
> On 2017.04.20 18:18 Rafael wrote:
> > On Thursday, April 20, 2017 07:55:57 AM Doug Smythies wrote:
> >> On 2017.04.19 01:16 Mel Gorman wrote:
> >>> On Fri, Apr 14, 2017 at 04:01:40PM -0700, Doug Smythies wrote:
> >>>> Hi Mel,
> >
> > [cut]
> >
> >>> And the revert does help albeit not being an option for reasons Rafael
> >>> covered.
> >> 
> >> New data point: Kernel 4.11-rc7  intel_pstate, powersave forcing the
> >> load based algorithm: Elapsed 3178 seconds.
> >> 
> >> If I understand your data correctly, my load based results are the opposite of yours.
> >> 
> >> Mel: 4.11-rc5 vanilla: Elapsed mean: 3750.20 Seconds
> >> Mel: 4.11-rc5 load based: Elapsed mean: 2503.27 Seconds
> >> Or: 33.25%
> >> 
> >> Doug: 4.11-rc6 stock: Elapsed total (5 runs): 2364.45 Seconds
> >> Doug: 4.11-rc7 force load based: Elapsed total (5 runs): 3178 Seconds
> >> Or: -34.4%
> >
> > I wonder if you can do the same thing I've just advised Mel to do.  That is,
> > take my linux-next branch:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> >
> > (which is new material for 4.12 on top of 4.11-rc7) and reduce
> > INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL (in intel_pstate.c) in it by 1/2
> > (force load-based if need be, I'm not sure what PM profile of your test system
> > is).
> 
> I did not need to force load-based. I do not know how to figure it out from
> an acpidump the way Srinivas does. I did a trace and figured out what algorithm
> it was using from the data.
> 
> Reference test, before changing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL:
> 3239.4 seconds.
> 
> Test after changing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL:
> 3195.5 seconds.

So it does have an effect, but relatively small.

I wonder if further reducing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL to 2 ms
will make any difference.

> By far, and with any code, I get the fastest elapsed time, of course next
> to performance mode, but not by much, by limiting the test to only use
> just 1 cpu: 1814.2 Seconds.

Interesting.

It looks like the cost is mostly related to moving the load from one CPU to
another and waiting for the new one to ramp up then.

I guess the workload consists of many small tasks that each start on new CPUs
and cause that ping-pong to happen.

> (performance governor, restated from a previous e-mail: 1776.05 seconds)

But that causes the processor to stay in the maximum sustainable P-state all
the time, which on Sandy Bridge is quite costly energetically.

We can do one more trick I forgot about.  Namely, if we are about to increase
the P-state, we can jump to the average between the target and the max
instead of just the target, like in the appended patch (on top of linux-next).

That will make the P-state selection really aggressive, so costly energetically,
but it shoud small jumps of the average load above 0 to case big jumps of
the target P-state.

---
 drivers/cpufreq/intel_pstate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1613,7 +1613,7 @@ static inline int32_t get_target_pstate_
 {
 	struct sample *sample = &cpu->sample;
 	int32_t busy_frac, boost;
-	int target, avg_pstate;
+	int max_pstate, target, avg_pstate;
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return cpu->pstate.turbo_pstate;
@@ -1628,10 +1628,9 @@ static inline int32_t get_target_pstate_
 
 	sample->busy_scaled = busy_frac * 100;
 
-	target = global.no_turbo || global.turbo_disabled ?
+	max_pstate = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-	target += target >> 2;
-	target = mul_fp(target, busy_frac);
+	target = mul_fp(max_pstate + (max_pstate >> 2), busy_frac);
 	if (target < cpu->pstate.min_pstate)
 		target = cpu->pstate.min_pstate;
 
@@ -1645,6 +1644,8 @@ static inline int32_t get_target_pstate_
 	avg_pstate = get_avg_pstate(cpu);
 	if (avg_pstate > target)
 		target += (avg_pstate - target) >> 1;
+	else if (avg_pstate < target)
+		target = (max_pstate + target) >> 1;
 
 	return target;
 }
