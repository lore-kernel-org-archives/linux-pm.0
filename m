From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Sun, 13 Mar 2016 23:39:06 -0700
Message-ID: <001901d17dbc$3788f060$a69ad120$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <97183685.ubU62sp0PR@vostro.rjw.lan> <001001d17cfc$67721e70$36565b50$@net> <3851575.bLxYIFy0zG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta10.telus.net ([209.171.16.83]:56421 "EHLO cmta10.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcCNGjM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Mar 2016 02:39:12 -0400
In-Reply-To: <3851575.bLxYIFy0zG@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2106.03.13 18:32 Rafael J. Wysocki write:
> On Saturday, March 12, 2016 11:46:03 PM Doug Smythies wrote:

>> Note 1: Above = rvr3 (because I already have a bunch of rjw kernels for other stuff).
>> Note 2: reference tests re-done, using Rafael's 3 patch set version 10
>> "cpufreq: Replace timers with utilization update callbacks".
>> Why? Because it was desirable to eliminate intel_pstate long durations
>> between calls that were due to the CPU being idle on jiffy boundaries,
>> but otherwise busy.
>> Well why was that desirable? So that trace could be acquired where
>> we could be reasonably confident that most very high CPU loads combined
>> with very long durations were due to long periods in idle state 0.
>> 
>> Aggregate times in each idle state for the 2000 second test:
>> State	k45rc7-rjw10 (mins)	k45rc7-rjw10-reverted (mins)	k45rc7-rjw10-rvr3 (mins)
>> 0.00	18.07				0.92					18.38
>> 1.00	12.35				19.51					13.16
>> 2.00	3.96				4.28					2.91
>> 3.00	1.55				1.53					1.00
>> 4.00	138.96			141.99				115.41
>> 			
>> total	174.90			168.24				150.87
>> 
>> Energy:
>> Kernel 4.5-rc7-rjw10: 61983 Joules
>> Kernel 4.5-rc7-rjw10-reverted: 48409 Joules
>> Kernel 4.5-rc7-rjw10-rvr3: 62938 Joules 
>
> OK, thanks for the report.
>
> This seems to mean that our latency_req is just off for short latencies (I guess
> it simply is 0, because the performance multiplier is likely to be greater than
> predicted_us for small values of that).
>
> The patch below should restore the original behavior for you.  Can you please
> test it?

Yes, it seems O.K. (reference rvr4 = below patch).

State	k45rc7-rjw10-rvr4 (mins)
0.00	1.79
1.00	21.82
2.00	4.26
3.00	1.64
4.00	148.77
			
total	178.29

Energy: 55743 Joules.
Note: there were other systems changes today, and energy has variations anyhow.
For example another run of k45rc7-rjw10-rcr3 was 55040 Joules, but still 0.13
minutes in idle state 0.

Note: I broke something today and, due to some missing shared library,
trace does not work, so no trace was acquired.

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
>  		/*
> 		 * We want to default to C1 (hlt), not to busy polling
> -		 * unless the timer is happening really really soon.
> +		 * unless the timer is happening really really soon.  Still, if
> +		 * the exit latency of C1 is too high, we need to poll anyway.
> 		 */
> -		if (interactivity_req > 20 &&
> +		if (data->next_timer_us > 20 &&
> +		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= 2 &&
> 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
> -			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
> +		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
>  			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> 	} else {
>  		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;


