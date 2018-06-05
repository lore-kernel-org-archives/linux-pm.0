From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Date: Tue, 5 Jun 2018 12:43:44 -0700
Message-ID: <20180605194344.GB239272@joelaf.mtv.corp.google.com>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <20180604174618.GA222053@joelaf.mtv.corp.google.com>
 <20180605152156.GD32302@e110439-lin>
 <20180605193317.GA239272@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605193317.GA239272@joelaf.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 05, 2018 at 12:33:17PM -0700, Joel Fernandes wrote:
> On Tue, Jun 05, 2018 at 04:21:56PM +0100, Patrick Bellasi wrote:
[..]
> > To be more precise, at each ___update_load_avg we should really update
> > running_avg by:
> > 
> >    u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
> >    sa->running_avg = sa->running_sum / divider;
> > 
> > but, this would imply tracking an additional signal in sched_avg and
> > doing an additional division at ___update_load_avg() time.
> > 
> > Morten suggested that, if we accept the rounding errors due to
> > considering
> > 
> >       divider ~= LOAD_AVG_MAX
> > 
> > thus discarding the (sa->period_contrib - 1024) correction, then we
> > can completely skip the tracking of running_avg (thus saving space in
> > sched_avg) and approximate it at dequeue time as per the code line,
> > just to compute the new util_est sample to accumulate.
> > 
> > Does that make sense now?
> 
> The patch always made sense to me.. I was just pointing out the extra
> division this patch adds. I agree since its done on dequeue-only, then its
> probably Ok to do..
> 

One thing to note about this error is I remember not compensating for it
would make the utilization reduce... which is kind of weird. But yeah if we
can find a way compensate for the error and also keep the overhead low,
that's super.. I know this is probably low in priority considering the other
concerns Vincent brought up which are being discussed in the other thread,..
but just saying. :)

 - Joel
