From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
Date: Thu, 16 May 2019 14:22:50 +0100
Message-ID: <20190516132250.hedtianse7rnk3wq@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
 <20190516124200.opxczohjelhvrzmo@e110439-lin>
 <20190516130148.uhq55ptut47usnae@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516130148.uhq55ptut47usnae@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: douglas.raillard@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 16-May 14:01, Quentin Perret wrote:
> On Thursday 16 May 2019 at 13:42:00 (+0100), Patrick Bellasi wrote:
> > > +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
> > > +	unsigned long min_freq, unsigned long cost_margin)
> > > +{
> > > +	unsigned long max_cost = 0;
> > > +	struct em_cap_state *cs;
> > > +	int i;
> > > +
> > > +	if (!pd)
> > > +		return min_freq;
> > > +
> > > +	/* Compute the maximum allowed cost */
> > > +	for (i = 0; i < pd->nr_cap_states; i++) {
> > > +		cs = &pd->table[i];
> > > +		if (cs->frequency >= min_freq) {
> > > +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
> >                                                                          ^^^^
> > ... end here we should probably better use SCHED_CAPACITY_SCALE
> > instead of hard-coding in values, isn't it?
> 
> I'm not sure to agree. This isn't part of the scheduler per se, and the
> cost thing isn't in units of capacity, but in units of power, so I don't
> think SCHED_CAPACITY_SCALE is correct here.

Right, I get the units do not match and it would not be elegant to use
it here...

> But I agree these hard coded values (that one, and the 512 in one of the
> following patches) could use some motivation :-)

... ultimately SCHED_CAPACITY_SCALE is just SCHED_FIXEDPOINT_SCALE,
which is adimensional. Perhaps we should use that or yet another alias
for the same.

> Thanks,
> Quentin

-- 
#include <best/regards.h>

Patrick Bellasi
