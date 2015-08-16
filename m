From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 40/46] sched/cpufreq_sched: compute freq_new based
 on capacity_orig_of()
Date: Sun, 16 Aug 2015 22:24:01 +0200
Message-ID: <20150816202401.GJ10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com>
 <20150815124638.GG10304@worktop.programming.kicks-ass.net>
 <20150816040333.31346.22542@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55471 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbHPWBq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2015 18:01:46 -0400
Content-Disposition: inline
In-Reply-To: <20150816040333.31346.22542@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, Aug 15, 2015 at 09:03:33PM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2015-08-15 05:46:38)
> > On Tue, Jul 07, 2015 at 07:24:23PM +0100, Morten Rasmussen wrote:
> > > diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> > > index 2968f3a..7071528 100644
> > > --- a/kernel/sched/cpufreq_sched.c
> > > +++ b/kernel/sched/cpufreq_sched.c
> > > @@ -184,7 +184,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
> > >               goto out;
> > >  
> > >       /* Convert the new maximum capacity request into a cpu frequency */
> > > -     freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> > > +     freq_new = (capacity * policy->max) / capacity_orig_of(cpu);
> > >  
> > >       /* No change in frequency? Bail and return current capacity. */
> > >       if (freq_new == policy->cur)
> > 
> > Can't we avoid exporting that lot by simply passing in the right values
> > to begin with?
> 
> By "right value" do you mean, "pass the frequency from cfs"?

Nah, just maybe: (capacity << SCHED_CAPACITY_SHIFT) / capacity_orig_of()
such that you don't have to export that knowledge to this thing.
