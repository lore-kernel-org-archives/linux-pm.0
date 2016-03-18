From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Fri, 18 Mar 2016 23:38:48 +0100
Message-ID: <2872717.8glRvO6UyU@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com> <5840060.D0yKLcstnf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63436 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752642AbcCRWgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 18:36:44 -0400
In-Reply-To: <5840060.D0yKLcstnf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Friday, March 18, 2016 10:56:38 PM Rafael J. Wysocki wrote:
> On Friday, March 18, 2016 10:48:45 PM Rafael J. Wysocki wrote:
> > On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com> wrote:
> > > On Fri, 18 Mar 2016 11:32:28 -0700
> > > "Doug Smythies" <dsmythies@telus.net> wrote:
> > >
> > >> Energy:
> > >> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > >>
> > >> Trace data (very crude summary):
> > >> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
> > >> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)
> > >
> > > This is a bit of a big hammer, but since the polling loop already uses
> > > full CPU power anyway, this could be harmless, and solve your problem.
> > 
> > Yes, it would be good to test this.
> > 
> > No, I don't like it.
> > 
> > If we are to break out of the polling loop after a specific time, we
> > shouldn't be using polling at all in the first place.
> > 
> > So I very much prefer to compare data->next_timer_us with the target
> > residency of C1 instead of doing this.
> 
> IOW, something like the below (on top of the $subject patch).
> 
> ---
>  drivers/cpuidle/governors/menu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -321,7 +321,7 @@ static int menu_select(struct cpuidle_dr
>  		 * unless the timer is happening really really soon, or
>  		 * C1's exit latency exceeds the user configured limit.
>  		 */
> -		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
> +		if (data->next_timer_us > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
>  		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency &&
>  		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>  		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
> 

Actually, that may be made somewhat less aggressive:

---
 drivers/cpuidle/governors/menu.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -315,13 +315,18 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = min(expected_interval, data->next_timer_us);
 
 	if (CPUIDLE_DRIVER_STATE_START > 0) {
+		unsigned int next_timer_limit_us = drv->states[CPUIDLE_DRIVER_STATE_START].target_residency;
+
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
 		/*
 		 * We want to default to C1 (hlt), not to busy polling
 		 * unless the timer is happening really really soon, or
 		 * C1's exit latency exceeds the user configured limit.
 		 */
-		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
+		if (next_timer_limit_us < 20)
+			next_timer_limit_us = 20;
+
+		if (data->next_timer_us > next_timer_limit_us &&
 		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)

except that next_timer_limit_us only needs to be computed once for the given
driver, because it won't change.

