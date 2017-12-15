From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 15:41:40 +0000
Message-ID: <20171215154140.GE19821@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
 <20171215121417.GB19821@e110439-lin>
 <20171215125340.akzm5kwa4pnijavz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932168AbdLOPlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 10:41:45 -0500
Content-Disposition: inline
In-Reply-To: <20171215125340.akzm5kwa4pnijavz@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 15-Dec 13:53, Peter Zijlstra wrote:
> On Fri, Dec 15, 2017 at 12:14:17PM +0000, Patrick Bellasi wrote:
> > On 13-Dec 17:16, Peter Zijlstra wrote:
> 
> > > > +	/*
> > > > +	 * Skip update of task's estimated utilization when its EWMA is already
> > > > +	 * ~1% close to its last activation value.
> > > > +	 */
> > > > +	util_est = p->util_est.ewma;
> > > > +	if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> > > > +		return;
> > > 
> > > Isn't that computation almost as expensive as the stuff you're trying to
> > > avoid?
> > 
> > Mmm... maybe slightly simpler. I'll profile it again but I remember
> > I've added it because it was slightly better on backbench.
> > 
> > This code at the end it's just a "sub" and a "compare to constant" and
> > it's likely to bail early for all "almost regular" tasks.
> > 
> > Are you worried about the branch overhead?
> 
> Its a subtract, a test for sign, a conditional branch on test, a negate,
> a subtract constant and another conditinoal branch.

Close enough, the actual code is:

        util_est = p->util_est.ewma;
    5218:       f9403ba3        ldr     x3, [x29,#112]
    521c:       f9418462        ldr     x2, [x3,#776]
        if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
    5220:       eb010040        subs    x0, x2, x1
    5224:       da805400        cneg    x0, x0, mi
    5228:       f100281f        cmp     x0, #0xa
    522c:       54fff9cd        b.le    5164 <dequeue_task_fair+0xa04>

> 
> Branch overhead certainly matters too.
> 
> > > > +	p->util_est.last = util_last;
> > > > +	ewma = p->util_est.ewma;
> > > > +	if (likely(ewma != 0)) {
> > > 
> > > Why special case 0? Yes it helps with the initial ramp-on, but would not
> > > an asymmetric IIR (with a consistent upward bias) be better?
> > 
> > Yes, maybe the fast ramp-up is not really necessary... I'll test it
> > without on some real use-cases and see if we really get any noticiable
> > benefit, otheriwse I'll remove it.
> > 
> > Thanks for pointing this out.
> > 
> > > > +		ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
> > > > +		ewma >>= UTIL_EST_WEIGHT_SHIFT;
> > > > +	} else {
> > > > +		ewma = util_last;
> > > > +	}
> > > > +	p->util_est.ewma = ewma;
> 
> And this, without the 0 case, is shift, an add, a subtract and another
> shift followed by a store.

Actual code:

       p->util_est.last = util_last;
    5230:       f9018061        str     x1, [x3,#768]
        if (likely(ewma != 0)) {
    5234:       b40000a2        cbz     x2, 5248 <dequeue_task_fair+0xae8>
                ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
    5238:       d37ef440        lsl     x0, x2, #2
    523c:       cb020002        sub     x2, x0, x2
    5240:       8b010041        add     x1, x2, x1
                ewma >>= UTIL_EST_WEIGHT_SHIFT;
    5244:       d342fc21        lsr     x1, x1, #2
        p->util_est.ewma = ewma;
    5248:       f9403ba0        ldr     x0, [x29,#112]
    524c:       f9018401        str     x1, [x0,#776]
    5250:       17ffffc5        b       5164 <dequeue_task_fair+0xa04>

> 
> Which is less branches and roughly similar arith ops, some of which can
> be done in parallel.
> 
> I suspect what you saw on the profile is the cacheline hit of the store,
> but I'm not sure.

Yes likely, looking at the two chunks above and considering the
removal of the 0 case, it's probably worth to remove the first check.

I'll give it a try again to measure hackbench overheads with the cache
alignment fixed.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
