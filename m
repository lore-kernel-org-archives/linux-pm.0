From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Sat, 12 Mar 2016 03:02:11 +0100
Message-ID: <97183685.ubU62sp0PR@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <003b01d17bf8$ad214680$0763d380$@net> <4779975.cHAts0tdyJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65088 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751873AbcCLCAP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 21:00:15 -0500
In-Reply-To: <4779975.cHAts0tdyJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Rik van Riel' <riel@redhat.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On Saturday, March 12, 2016 02:45:42 AM Rafael J. Wysocki wrote:
> On Friday, March 11, 2016 04:46:53 PM Doug Smythies wrote:
> > On 2106.03.11 15:55 Rafael J. Wysocki wrote:
> > > On Fri, Mar 11, 2016 at 9:30 PM, Rik van Riel <riel@redhat.com> wrote:
> > >> On Fri, 11 Mar 2016 10:22:30 -0800 Doug Smythies wrote:
> > >>> On 2016.03.11 06:03 Rik van Riel wrote:
> > >>
> > >>>> The patch below should fix that.
> > >>>>
> > >>>> It didn't for Arto, due to the other issues on his system, but
> > >>>> it might resolve the issue for Doug, where cstate/pstate is
> > >>>> otherwise working fine.
> > >>>>
> > >>>> Doug, does the patch below solve your issue?
> > >>>
> > >>> No.
> > >>
> > >> OK, lets try doing this check a little more aggressively, since there
> > >> almost certainly are good reasons why the main selection loop in
> > >> menu_select() so aggressively tries to stay with shallower C states.
> > >>
> > >> With the patch below, we compare the (not corrected for load) expected
> > >> sleep time against the target residency of the C1 (hlt) state on the CPU.
> > >>
> > >> This might resolve the issue, while still doing the right thing on CPUs
> > >> that have really high C1 latencies (eg. Atom).
> > >>
> > >> Does this resolve the issue for you?
> > 
> > No, but it seems better.
> > 
> > Old data restated with new data added below:
> > Aggregate times in each idle state for the 2000 second test:
> > 
> > State	k45rc7 (mins)	reverted (mins)	rvr(mins)	rvr2(mins)
> > 0.00	20.18			2.64			19.11		14.09
> > 1.00	13.03			21.81			13.56		12.05
> 
> The difference is still significant, though.
> 
> > 2.00	3.43			3.95			3.70		3.93
> > 3.00	1.45			1.55			1.53		1.52
> > 4.00	134.91		143.55		138.53	142.80
> > 				
> > total	172.99		173.51		176.42	174.37 
> > 
> > Energy (old restated, plus new added):
> > 
> > Kernel 4.5-rc7 Reverted: 56178 Joules
> > Kernel 4.5-rc7: 63269 Joules (revert saves 12.6% energy)
> > Kernel 4.5-rc7 + rvr patch: 62914 Joules
> > Kernel 4.5-rc7 + rvr patch version 2: 60416 Joules
> > 
> > > If we do this, we probably should check the exit latency
> > > (against latency_req) too.
> > 
> > I already had the above data before I noticed Rafael's e-mail.
> 
> So having considered that for a while more I think that the original Rik's
> commit tried to address a real problem, but in a way that wasn't really
> adequate.
> 
> The original problem appears to be that on some systems the exit latency
> of C1 (not the target residency, mind you) is too high and that causes
> performance issues if we aggressively choose C1 instead of polling on
> them.  So to address that directy, why don't we simply check the
> exit latency against latency_req?
> 
> Something like the patch below, maybe?
> 
> ---
>  drivers/cpuidle/governors/menu.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -329,7 +329,8 @@ static int menu_select(struct cpuidle_dr
>  		 * We want to default to C1 (hlt), not to busy polling
>  		 * unless the timer is happening really really soon.
>  		 */
> -		if (interactivity_req > 20 &&
> +		if (data->next_timer_us > 20 &&
> +		    !drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency > latency_req &&

Gosh, I'm too tired.  Parens missing and it can be written simpler using <=.

Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
+		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= latency_req &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
-			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
+		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 	} else {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

