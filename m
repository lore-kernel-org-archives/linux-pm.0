From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/8] cpufreq/schedutil: sum per-sched class utilization
Date: Wed, 16 Mar 2016 08:38:50 +0100
Message-ID: <20160316073850.GO6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-7-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212926.GG6344@twins.programming.kicks-ass.net>
 <20160315220951.30639.12872@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47671 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbcCPHiy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 03:38:54 -0400
Content-Disposition: inline
In-Reply-To: <20160315220951.30639.12872@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Tue, Mar 15, 2016 at 03:09:51PM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2016-03-15 14:29:26)
> > On Sun, Mar 13, 2016 at 10:22:10PM -0700, Michael Turquette wrote:
> > 
> > > +static unsigned long sugov_sum_total_util(struct sugov_cpu *sg_cpu)
> > > +{
> > > +     enum sched_class_util sc;
> > > +
> > > +     /* sum the utilization of all sched classes */
> > > +     sg_cpu->total_util = 0;
> > > +     for (sc = 0; sc < nr_util_types; sc++)
> > > +             sg_cpu->total_util += sg_cpu->util[sc];
> > > +
> > > +     return sg_cpu->total_util;
> > > +}
> > 
> > > @@ -153,7 +172,7 @@ static unsigned int sugov_next_freq(struct sugov_policy *sg_policy,
> > >               if ((s64)delta_ns > NSEC_PER_SEC / HZ)
> > >                       continue;
> > >  
> > > -             j_util = j_sg_cpu->util;
> > > +             j_util = j_sg_cpu->total_util;
> > >               j_max = j_sg_cpu->max;
> > >               if (j_util > j_max)
> > >                       return max_f;
> > 
> > So while not strictly wrong, I think we can do so much better.
> > 
> > Changelog doesn't mention anything useful, like that this is indeed very
> > rough and what we really should be doing etc..
> 
> What should we really be doing? Summing the scheduler class
> contributions seems correct to me.
> 
> Are you referring to the fact that dl and rt are passing bogus values
> into cpufreq_update_util()? If so I'm happy to add a note about that in
> the changelog.

Somewhere in the giant discussions I mentioned that we should be looking
at a CPPC like interface and pass {min,max} tuples to the cpufreq
selection thingy.

In that same discussion I also mentioned that we must compute min as the
hard dl reservation, but that for max we can actually use the avg dl +
avg rt + avg cfs.

That way there is far more room for selecting a sensible frequency.
