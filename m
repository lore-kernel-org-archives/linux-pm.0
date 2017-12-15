From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 15:22:25 +0000
Message-ID: <20171215152225.GD19821@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213160537.uqa423dyt5wrpgll@hirez.programming.kicks-ass.net>
 <20171215140218.GC19821@e110439-lin>
 <20171215140751.3ajilhsmj4zhzhzy@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756692AbdLOPWa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 10:22:30 -0500
Content-Disposition: inline
In-Reply-To: <20171215140751.3ajilhsmj4zhzhzy@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 15-Dec 15:07, Peter Zijlstra wrote:
> On Fri, Dec 15, 2017 at 02:02:18PM +0000, Patrick Bellasi wrote:
> > On 13-Dec 17:05, Peter Zijlstra wrote:
> > > On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > > > +	if (cfs_rq->nr_running > 0) {
> > > > +		util_est  = cfs_rq->util_est_runnable;
> > > > +		util_est -= task_util_est(p);
> > > > +		if (util_est < 0)
> > > > +			util_est = 0;
> > > > +		cfs_rq->util_est_runnable = util_est;
> > > > +	} else {
> > > 
> > > I'm thinking that's an explicit load-store to avoid intermediate values
> > > landing in cfs_rq->util_esp_runnable, right?
> > 
> > Was mainly to have an unsigned util_est for the following "sub"...
> > 
> > 
> > > That would need READ_ONCE() / WRITE_ONCE() I think, without that the
> > > compiler is free to munge the lot together.
> > 
> > ... do we still need the {READ,WRITE}_ONCE() in this case?
> > I guess adding them however does not hurts.
> 

This is just to better understand....

> I think the compiler is free to munge it into something like:
> 
> 	cfs_rq->util_est_runnable -= task_util_est();
> 	if (cfs_rq->util_est_runnable < 0)
> 		cfs_rq->util_est_runnable = 0
> 

I'm still confused, we have:

            long util_est
   unsigned long cfs_rq->util_est_runnable

The optimization above can potentially generate an overflow, isn't it?

> and its a fairly simple optimization at that, it just needs to observe
> that util_est is an alias for cfs_rq->util_est_runnable.

Since the first is signed and the last unsigned, can the compiler still
considered them an alias?

At least on ARM I would expect a load of an unsigned value, some
computations on "signed registers", and finally a store of an unsigned
value. This is what I get:


        if (cfs_rq->nr_running > 0) {
    51e4:       91020000        add     x0, x0, #0x80
    51e8:       b9401802        ldr     w2, [x0,#24]
    51ec:       340004a2        cbz     w2, 5280 <dequeue_task_fair+0xb20>
	// skip branch for nr_running == 0

        return max(p->util_est.ewma, p->util_est.last);
    51f0:       f9403ba2        ldr     x2, [x29,#112]
    51f4:       f9418044        ldr     x4, [x2,#768]
    51f8:       f9418443        ldr     x3, [x2,#776]
	// x3 := p->util_est.ewma
	// x4 := p->util_est.last

                util_est -= task_util_est(p);
    51fc:       f9405002        ldr     x2, [x0,#160]
	// x2 := cfs_rq->util_est_runnable

        return max(p->util_est.ewma, p->util_est.last);
    5200:       eb04007f        cmp     x3, x4
    5204:       9a842063        csel    x3, x3, x4, cs
	// x3 := task_util_est(p) := max(p->util_est.ewma, p->util_est.last)

                cfs_rq->util_est_runnable = util_est;
    5208:       eb030042        subs    x2, x2, x3
	// x2 := util_est -= task_util_est(p);

    520c:       9a9f5042        csel    x2, x2, xzr, pl
	// x2 := max(0, util_est)

    5210:       f9005002        str     x2, [x0,#160]
	// store back into cfs_rq->util_est_runnable


And by adding {READ,WRITE}_ONCE I still get the same code.

While, compiling for x86, I get two different versions, here is
the one without {READ,WRITE}_ONCE:

       if (cfs_rq->nr_running > 0) {
    3e3e:       8b 90 98 00 00 00       mov    0x98(%rax),%edx
    3e44:       85 d2                   test   %edx,%edx
    3e46:       0f 84 e0 00 00 00       je     3f2c <dequeue_task_fair+0xf9c>
                util_est  = cfs_rq->util_est_runnable;
                util_est -= task_util_est(p);
    3e4c:       48 8b 74 24 28          mov    0x28(%rsp),%rsi
    3e51:       48 8b 96 80 02 00 00    mov    0x280(%rsi),%rdx
    3e58:       48 39 96 88 02 00 00    cmp    %rdx,0x288(%rsi)
    3e5f:       48 0f 43 96 88 02 00    cmovae 0x288(%rsi),%rdx
    3e66:       00 
                if (util_est < 0)
                        util_est = 0;
                cfs_rq->util_est_runnable = util_est;
    3e67:       48 8b b0 20 01 00 00    mov    0x120(%rax),%rsi
    3e6e:       48 29 d6                sub    %rdx,%rsi
    3e71:       48 89 f2                mov    %rsi,%rdx
    3e74:       be 00 00 00 00          mov    $0x0,%esi
    3e79:       48 0f 48 d6             cmovs  %rsi,%rdx
    3e7d:       48 89 90 20 01 00 00    mov    %rdx,0x120(%rax)

but I'm not confident on "parsing it"...


> Using the volatile load/store completely destroys that optimization
> though, so yes, I'd say its definitely needed.

Ok, since it's definitively not harmful, I'll add it.

-- 
#include <best/regards.h>

Patrick Bellasi
