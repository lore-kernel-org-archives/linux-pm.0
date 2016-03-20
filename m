From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: menu: Fall back to polling if next timer event is near
Date: Sat, 19 Mar 2016 23:54:39 -0700
Message-ID: <000c01d18275$60543190$20fc94b0$@net>
References: <11672478.oHFBPvKbda@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta8.telus.net ([209.171.16.81]:49863 "EHLO cmta8.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbcCTGyl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Mar 2016 02:54:41 -0400
In-Reply-To: <11672478.oHFBPvKbda@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Rik van Riel' <riel@redhat.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>

On 2016.03.19 17:34 Rafael J. Wysocki wrote:

> Commit a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable
> polling) changed the behavior of the fallback state selection part
> of menu_select() so it looks at interactivity_req instead of
> data->next_timer_us when it makes its decision.  That effectively
> caused polling to be used more often as fallback idle which led to
> significant increases of energy consumption in some cases.
>
> Commit e132b9b3bc7f (cpuidle: menu: use high confidence factors
> only when considering polling) changed that logic again to be more
> predictable, but that didn't help with the increased energy
> consumption problem.
>
> For this reason, go back to making decisions on which state to fall
> back to based on data->next_timer_us which is the time we know for
> sure something will happen rather than a prediction (which may be
> inaccurate and turns out to be so often enough to be problematic).
> However, take the target residency of the first proper idle state
> (C1) into account, so that state is not used as the fallback one
> if its target residency is greater than data->next_timer_us.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Doug, can you please see if this patch helps to address the problem
> you're seeing?
> 

Yes, it appears to work great.

>
> Commit e132b9b3bc7f is in linux-next only ATM, but it is a rebased
> version of https://patchwork.kernel.org/patch/8602101/.

So, I applied it to my existing kernel 4.5-rc7 work, i.e. the not
rebased version.

My reference = rvr7:
Kernel 4.5-rc7 +
Rafael's 3 patch set version 10 "cpufreq: Replace timers with utilization update callbacks" +
Rik's patch (rvr5) "cpuidle: menu: use high confidence factors only when considering polling" +
Rafael's patch from herein.

My reference: k45rc7-rjw10-rvr7

Aggregate Idle States in minutes for 2000 second test (some old data re-stated for reference):

State	k45rc7-rjw10	k45rc7-rjw10-reverted	k45rc7-rjw10-rvr7
0.00	18.07			0.92				0.41
1.00	12.35			19.51				21.17
2.00	3.96			4.28				4.40
3.00	1.55			1.53				1.66
4.00	138.96		141.99			150.77
			
total	174.90		168.24			178.41

Energy:
>>>> Kernel 4.5-rc7-rjw10: 61983 Joules
>>>> Kernel 4.5-rc7-rjw10-reverted: 48409 Joules (test 2 was 55040 Joules)
k45rc7-rjw10-rvr7: 54748 Joules

The trace data has a record low number of long durations at 71.

... Doug


