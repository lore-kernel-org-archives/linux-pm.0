From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 13:53:40 +0100
Message-ID: <20171215125340.akzm5kwa4pnijavz@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
 <20171215121417.GB19821@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171215121417.GB19821@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 15, 2017 at 12:14:17PM +0000, Patrick Bellasi wrote:
> On 13-Dec 17:16, Peter Zijlstra wrote:

> > > +	/*
> > > +	 * Skip update of task's estimated utilization when its EWMA is already
> > > +	 * ~1% close to its last activation value.
> > > +	 */
> > > +	util_est = p->util_est.ewma;
> > > +	if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> > > +		return;
> > 
> > Isn't that computation almost as expensive as the stuff you're trying to
> > avoid?
> 
> Mmm... maybe slightly simpler. I'll profile it again but I remember
> I've added it because it was slightly better on backbench.
> 
> This code at the end it's just a "sub" and a "compare to constant" and
> it's likely to bail early for all "almost regular" tasks.
> 
> Are you worried about the branch overhead?

Its a subtract, a test for sign, a conditional branch on test, a negate,
a subtract constant and another conditinoal branch.

Branch overhead certainly matters too.

> > > +	p->util_est.last = util_last;
> > > +	ewma = p->util_est.ewma;
> > > +	if (likely(ewma != 0)) {
> > 
> > Why special case 0? Yes it helps with the initial ramp-on, but would not
> > an asymmetric IIR (with a consistent upward bias) be better?
> 
> Yes, maybe the fast ramp-up is not really necessary... I'll test it
> without on some real use-cases and see if we really get any noticiable
> benefit, otheriwse I'll remove it.
> 
> Thanks for pointing this out.
> 
> > > +		ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
> > > +		ewma >>= UTIL_EST_WEIGHT_SHIFT;
> > > +	} else {
> > > +		ewma = util_last;
> > > +	}
> > > +	p->util_est.ewma = ewma;

And this, without the 0 case, is shift, an add, a subtract and another
shift followed by a store.

Which is less branches and roughly similar arith ops, some of which can
be done in parallel.

I suspect what you saw on the profile is the cacheline hit of the store,
but I'm not sure.
