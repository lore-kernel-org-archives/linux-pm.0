From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 15:07:51 +0100
Message-ID: <20171215140751.3ajilhsmj4zhzhzy@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213160537.uqa423dyt5wrpgll@hirez.programming.kicks-ass.net>
 <20171215140218.GC19821@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171215140218.GC19821@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 15, 2017 at 02:02:18PM +0000, Patrick Bellasi wrote:
> On 13-Dec 17:05, Peter Zijlstra wrote:
> > On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > > +	if (cfs_rq->nr_running > 0) {
> > > +		util_est  = cfs_rq->util_est_runnable;
> > > +		util_est -= task_util_est(p);
> > > +		if (util_est < 0)
> > > +			util_est = 0;
> > > +		cfs_rq->util_est_runnable = util_est;
> > > +	} else {
> > 
> > I'm thinking that's an explicit load-store to avoid intermediate values
> > landing in cfs_rq->util_esp_runnable, right?
> 
> Was mainly to have an unsigned util_est for the following "sub"...
> 
> 
> > That would need READ_ONCE() / WRITE_ONCE() I think, without that the
> > compiler is free to munge the lot together.
> 
> ... do we still need the {READ,WRITE}_ONCE() in this case?
> I guess adding them however does not hurts.

I think the compiler is free to munge it into something like:

	cfs_rq->util_est_runnable -= task_util_est();
	if (cfs_rq->util_est_runnable < 0)
		cfs_rq->util_est_runnable = 0

and its a fairly simple optimization at that, it just needs to observe
that util_est is an alias for cfs_rq->util_est_runnable.

Using the volatile load/store completely destroys that optimization
though, so yes, I'd say its definitely needed.
