From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness
 is scaled
Date: Fri, 19 Feb 2016 10:49:11 +0000
Message-ID: <20160219104911.GA4821@techsingularity.net>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
 <CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
 <001101d16a90$a7a26e10$f6e74a30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:55687 "EHLO
	outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712AbcBSKt1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 05:49:27 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
	by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 023A31C1541
	for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 10:49:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <001101d16a90$a7a26e10$f6e74a30$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Rafael Wysocki' <rjw@rjwysocki.net>, 'Ingo Molnar' <mingo@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Matt Fleming' <matt@codeblueprint.co.uk>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>, 'Linux-PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On Thu, Feb 18, 2016 at 01:09:26PM -0800, Doug Smythies wrote:
> On 2106.02.18 Rafael J. Wysocki wrote:
> On Thu, Feb 18, 2016 at 12:11 PM, Mel Gorman wrote:
> >>
> >> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >> ---
> >>  drivers/cpufreq/intel_pstate.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> >> index cd83d477e32d..54250084174a 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -999,7 +999,7 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
> >>         sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
> >>         duration_us = ktime_us_delta(cpu->sample.time,
> >>                                      cpu->last_sample_time);
> >> -       if (duration_us > sample_time * 3) {
> >> +       if (duration_us > sample_time * 12) {
> >>                 sample_ratio = div_fp(int_tofp(sample_time),
> >>                                       int_tofp(duration_us));
> >>                 core_busy = mul_fp(core_busy, sample_ratio);
> >> --
> 
> The immediately preceding comment needs to be changed also.

Yes, it does. Thanks.

> Note that with duration related scaling only coming in at such a high
> ratio it might be worth saving the divide and just setting it to 0.
> 

That sounds reasonable. I've queued up a test based on this as well as
tests with the linux-next branch from linux-pm to see what falls out.

> > I've been considering making a change like this, but I wasn't quite
> > sure how much greater the multiplier should be, so I've queued this
> > one up for 4.6.
> 
> > That said please note that we're planning to make one significant
> > change to intel_pstate in the 4.6 cycle that's very likely to affect
> > your results.
> 
> Rafael:
> 
> I started to test Mel's change added to your 3 patch set version 10.
> 
> I only have one data point so far, I selected the test I did from one of Mel's
> better results (although there is no reason to expect my computer to have
> best results for the same operating conditions):
> 

It's a reasonable expectation.

> Stock kernel 4.5-rc4 just for reference:
> Linux s15 4.5.0-040500rc4-generic #201602141731 SMP Sun Feb 14 22:33:37 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
> 
>         Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
>         Output is in Kbytes/sec
> 
>               KB  reclen   write rewrite
>           401408      32 1895293 3035291
> _________________________________________________________________
> 
> Kernel 4.5-rc4 + jrw 3 patch set version 10  (nominal 3X duration holdoff)
> Linux s15 4.5.0-rc4-rjwv10 #167 SMP Mon Feb 15 14:23:10 PST 2016 x86_64 x86_64 x86_64 GNU/Linux
> 
>         Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
>         Output is in Kbytes/sec
> 
>               KB  reclen   write rewrite
>           401408      32 2010558 3086354
>           401408      32 1945126 3127472
>           401408      32 1944807 3110387
>           401408      32 1948620 3110002
>                      AVE 1962278 3108554
> 
> Performance mode, for comparison:
> 
>               KB  reclen   write rewrite
>           401408      32 2870111 5023311
>           401408      32 2869642 5149213
>           401408      32 2792053 5100280
>           401408      32 2863887 5149229
> _________________________________________________________________
> 
> Kernel 4.5-rc4 + jrw 3 patch set version 10 + mg 12X duration hold-off
> Linux s15 4.5.0-rc4-rjwv10-12 #169 SMP Thu Feb 18 08:15:33 PST 2016 x86_64 x86_64 x86_64 GNU/Linux
> 
>         Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
>         Output is in Kbytes/sec
> 
>               KB  reclen   write rewrite
>           401408      32 1989670 3100580
>           401408      32 2062291 3112463
>           401408      32 2107637 3233567
>           401408      32 2111772 3340610
>                      AVE 2067843 3196805
>           Gain Verses 3X    5.4%    2.8%
> _________________________________________________________________
> 
> Mel: Did you observe any downside conditions?
> 

Not so far but my expectation is that any downside would be power consumption
related. At worst, I expect the patch to have little or not performance
impact in cases where there are a lot of cores, a lot of migration and the
CPU core is idle longer than the new hold-off period. For power-consumption,
I'm relying entirely on the output of turbostat to tell me if there are
problems which may or may not be sufficient.

-- 
Mel Gorman
SUSE Labs
