From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 02:32:04 +0100
Message-ID: <3851575.bLxYIFy0zG@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <97183685.ubU62sp0PR@vostro.rjw.lan> <001001d17cfc$67721e70$36565b50$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44352 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751706AbcCNBaG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2016 21:30:06 -0400
In-Reply-To: <001001d17cfc$67721e70$36565b50$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On Saturday, March 12, 2016 11:46:03 PM Doug Smythies wrote:
> On 2016.03.11 18:02 Rafael J. Wysocki wrote:
> > On Saturday, March 12, 2016 02:45:42 AM Rafael J. Wysocki wrote:
> >
> > Gosh, I'm too tired.  Parens missing and it can be written simpler using <=.
> >
> > Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > drivers/cpuidle/governors/menu.c |    8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -327,11 +327,13 @@ static int menu_select(struct cpuidle_dr
> > 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
> > 		/*
> > 		 * We want to default to C1 (hlt), not to busy polling
> > -		 * unless the timer is happening really really soon.
> > +		 * unless the timer is happening really really soon.  Still, if
> > +		 * the exit latency of C1 is too high, we need to poll anyway.
> > 		 */
> > -		if (interactivity_req > 20 &&
> > +		if (data->next_timer_us > 20 &&
> > +		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= latency_req &&
> > 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
> > -			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
> > +		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
> > 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> > 	} else {
> > 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> 
> Note 1: Above = rvr3 (because I already have a bunch of rjw kernels for other stuff).
> Note 2: reference tests re-done, using Rafael's 3 patch set version 10
> "cpufreq: Replace timers with utilization update callbacks".
> Why? Because it was desirable to eliminate intel_pstate long durations
> between calls that were due to the CPU being idle on jiffy boundaries,
> but otherwise busy.
> Well why was that desirable? So that trace could be acquired where
> we could be reasonably confident that most very high CPU loads combined
> with very long durations were due to long periods in idle state 0.
> 
> Aggregate times in each idle state for the 2000 second test:
> State	k45rc7-rjw10 (mins)	k45rc7-rjw10-reverted (mins)	k45rc7-rjw10-rcr3 (mins)
> 0.00	18.07				0.92					18.38
> 1.00	12.35				19.51					13.16
> 2.00	3.96				4.28					2.91
> 3.00	1.55				1.53					1.00
> 4.00	138.96			141.99				115.41
> 			
> total	174.90			168.24				150.87
> 
> Energy:
> Kernel 4.5-rc7-rjw10: 61983 Joules
> Kernel 4.5-rc7-rjw10-reverted: 48409 Joules
> Kernel 4.5-rc7-rjw10-rvr3: 62938 Joules 

OK, thanks for the report.

This seems to mean that our latency_req is just off for short latencies (I guess
it simply is 0, because the performance multiplier is likely to be greater than
predicted_us for small values of that).

The patch below should restore the original behavior for you.  Can you please
test it?

---
 drivers/cpuidle/governors/menu.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -327,11 +327,13 @@ static int menu_select(struct cpuidle_dr
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
 		/*
 		 * We want to default to C1 (hlt), not to busy polling
-		 * unless the timer is happening really really soon.
+		 * unless the timer is happening really really soon.  Still, if
+		 * the exit latency of C1 is too high, we need to poll anyway.
 		 */
-		if (interactivity_req > 20 &&
+		if (data->next_timer_us > 20 &&
+		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= 2 &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
-			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
+		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 	} else {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

