From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Fri, 31 Mar 2017 11:22:23 +0100
Message-ID: <20170331102223.GS19929@e106622-lin>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932618AbdCaKW1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Mar 2017 06:22:27 -0400
Content-Disposition: inline
In-Reply-To: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>

Hi Rafael,

On 30/03/17 23:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The schedutil governor reduces frequencies too fast in some
> situations which cases undesirable performance drops to
> appear.
> 
> To address that issue, make schedutil reduce the frequency slower by
> setting it to the average of the value chosen during the previous
> iteration of governor computations and the new one coming from its
> frequency selection formula.
> 

I'm curious to test this out on Pixel phones once back in office, but
I've already got some considerations about this patch. Please find them
inline below.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
> Reported-by: John <john.ettedgui@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This addresses a practical issue, but one in the "responsiveness" or
> "interactivity" category which is quite hard to represent quantitatively.
> 
> As reported by John in BZ194963, schedutil does not ramp up P-states quickly
> enough which causes audio issues to appear in his gaming setup.  At least it
> evidently is worse than ondemand in this respect and the patch below helps.
> 

Might also be a PELT problem?

> The patch essentially repeats the trick added some time ago to the load-based
> P-state selection algorithm in intel_pstate, which allowed us to make it viable
> for performance-oriented users, and which is to reduce frequencies at a slower
> pace.
> 
> The reason why I chose the average is because it is computationally cheap
> and pretty much the max reasonable slowdown and the idea is that in case
> there's something about to run that we don't know about yet, it is better to
> stay at a higher level for a while more to avoid having to get up from the floor
> every time.
> 

Another approach we have been playing with on Android (to solve what
seem to me similar issues) is to have decoupled up and down frequency
changes thresholds. With this you can decide how much quick to react to
a sudden increase in utilization and how much "hysteresis" you want to
have before slowing down. Every platfrom can also be easily tuned as
needed (instead of having the same filter applied for every platform).

We seemed to actually recently come to the consideration that the up
threshold is probably not much needed (and it is in fact set to very
small values in practice). Once one is confident that the utilization
signal is not too jumpy, responding to a request for additional capacity
quickly seems the right thing to do (especially for RT/DL policies).

What's your opinion?

> But technically speaking it is a filter. :-)
> 
> So among other things I'm wondering if that leads to substantial increases in
> energy consumption anywhere.
> 

Having a tunable might help getting the tradeoff right for different
platforms, maybe?

As we discussed at the last LPC, having an energy model handy and use
that to decide how quickly to ramp up or slow down seems the desirable
long term solution, but we probably need something (as you are
proposing) until we get there.

Thanks,

- Juri
