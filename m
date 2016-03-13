From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Sat, 12 Mar 2016 23:46:03 -0800
Message-ID: <001001d17cfc$67721e70$36565b50$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <003b01d17bf8$ad214680$0763d380$@net> <4779975.cHAts0tdyJ@vostro.rjw.lan> <97183685.ubU62sp0PR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:38559 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbcCMHqL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Mar 2016 03:46:11 -0400
In-Reply-To: <97183685.ubU62sp0PR@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Rik van Riel' <riel@redhat.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2016.03.11 18:02 Rafael J. Wysocki wrote:
> On Saturday, March 12, 2016 02:45:42 AM Rafael J. Wysocki wrote:
>
> Gosh, I'm too tired.  Parens missing and it can be written simpler using <=.
>
> Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> drivers/cpuidle/governors/menu.c |    8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -327,11 +327,13 @@ static int menu_select(struct cpuidle_dr
> 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
> 		/*
> 		 * We want to default to C1 (hlt), not to busy polling
> -		 * unless the timer is happening really really soon.
> +		 * unless the timer is happening really really soon.  Still, if
> +		 * the exit latency of C1 is too high, we need to poll anyway.
> 		 */
> -		if (interactivity_req > 20 &&
> +		if (data->next_timer_us > 20 &&
> +		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= latency_req &&
> 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
> -			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
> +		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
> 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> 	} else {
> 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

Note 1: Above = rvr3 (because I already have a bunch of rjw kernels for other stuff).
Note 2: reference tests re-done, using Rafael's 3 patch set version 10
"cpufreq: Replace timers with utilization update callbacks".
Why? Because it was desirable to eliminate intel_pstate long durations
between calls that were due to the CPU being idle on jiffy boundaries,
but otherwise busy.
Well why was that desirable? So that trace could be acquired where
we could be reasonably confident that most very high CPU loads combined
with very long durations were due to long periods in idle state 0.

Aggregate times in each idle state for the 2000 second test:
State	k45rc7-rjw10 (mins)	k45rc7-rjw10-reverted (mins)	k45rc7-rjw10-rcr3 (mins)
0.00	18.07				0.92					18.38
1.00	12.35				19.51					13.16
2.00	3.96				4.28					2.91
3.00	1.55				1.53					1.00
4.00	138.96			141.99				115.41
			
total	174.90			168.24				150.87

Energy:
Kernel 4.5-rc7-rjw10: 61983 Joules
Kernel 4.5-rc7-rjw10-reverted: 48409 Joules
Kernel 4.5-rc7-rjw10-rvr3: 62938 Joules 

Isn't the issue here just that it can be just so very expensive, in terms
of energy, when the decision is made to poll instead of HLT or deeper?
It doesn't have to happen all that often, where the CPU is basically abandoned
in that state, because it can be there for up to 200,000 times longer
than was expected (4 seconds instead of <20 usecs), per occurrence.

An intel_pstate trace was obtained for the above "k45rc7-rjw10-rvr3" (Kernel
4.5-rc7 with Rafael's 3 patch set version 10 and the above suggested patch).
In 2000 seconds there were about 3164 long durations at high CPU load (in this
context meaning the CPU was actually idle, but was in idle state 0) accounting
for 17.15 minutes out of the above listed 18.38 minutes. For example:

CPU 6: mperf: 6672329686; aperf: 6921452881; load: 99.83% duration: 1.96 seconds.
CPU 5: mperf: 7591407713; aperf: 5651758618; load: 99.87% duration: 2.23 seconds.

An intel_pstate trace was obtained for the above "k45rc7-rjw10-reverted" (Kernel
4.5-rc7 with Rafael's 3 patch set version 10 and commits
9c4b2867ed7c8c8784dd417ffd16e705e81eb145 and
a9ceb78bc75ca47972096372ff3d48648b16317a reverted).
In 2000 seconds there were about 237 long durations at high CPU load (in this
context meaning the CPU was actually idle, but was in idle state 0)
totaling 3.42 minutes, or more than can be accounted for above.
However, if I compensate for actual load (which is consistently less in the 
237 samples (meaning it wasn't actually always in state 0 during that time)
and take out some of the watchdog limit hits at the end, because
the trace was longer than the actual idle states collection time, it goes
to 0.35 minutes.

... Doug
 

