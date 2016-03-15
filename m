From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] sched/fair: add margin to utilization update
Date: Tue, 15 Mar 2016 22:43:54 +0100
Message-ID: <20160315214354.GL6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
 <20160315211614.GC6344@twins.programming.kicks-ass.net>
 <20160315212848.30639.38747@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39205 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbcCOVoV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:44:21 -0400
Content-Disposition: inline
In-Reply-To: <20160315212848.30639.38747@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Tue, Mar 15, 2016 at 02:28:48PM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2016-03-15 14:16:14)
> > On Sun, Mar 13, 2016 at 10:22:06PM -0700, Michael Turquette wrote:
> > > @@ -2840,6 +2853,8 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
> > >  
> > >       if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
> > >               unsigned long max = rq->cpu_capacity_orig;
> > > +             unsigned long cap = cfs_rq->avg.util_avg *
> > > +                     cfs_capacity_margin / max;
> > >  
> > >               /*
> > >                * There are a few boundary cases this might miss but it should
> > > @@ -2852,8 +2867,7 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
> > >                * thread is a different class (!fair), nor will the utilization
> > >                * number include things like RT tasks.
> > >                */
> > > -             cpufreq_update_util(rq_clock(rq),
> > > -                                 min(cfs_rq->avg.util_avg, max), max);
> > > +             cpufreq_update_util(rq_clock(rq), min(cap, max), max);
> > >       }
> > >  }
> > 
> > I really don't see why that is here, and not inside whatever uses
> > cpufreq_update_util().
> 
> Because I want schedutil to be dumb and not implement any policy of it's
> own. The idea is for the scheduler to select frequency after all.
> 
> I want to avoid a weird hybrid solution where we try to be smart about
> selecting the right capacity/frequency in fair.c (e.g. Steve and Juri's
> patches to fair.c from the sched-freq-v7 series), but then have an
> additional layer of "smarts" massaging those values further in the
> cpufreq governor.

So the problem here is that you add an unconditional division, even if
cpufreq_update_util() then decides to not do anything with it.

Please, these are scheduler paths, do not add (fancy) instructions if
you don't absolutely have to.
