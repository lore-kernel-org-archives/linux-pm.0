From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Thu, 27 Sep 2018 11:23:00 +0100
Message-ID: <20180927102258.gxhte2k4li2uktm5@queper01-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
 <20180914093240.GB24082@hirez.programming.kicks-ass.net>
 <20180914131919.GO1413@e110439-lin>
 <20180914133654.GL24124@hirez.programming.kicks-ass.net>
 <20180914135712.GQ1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180914135712.GQ1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday 14 Sep 2018 at 14:57:12 (+0100), Patrick Bellasi wrote:
> On 14-Sep 15:36, Peter Zijlstra wrote:
> > On Fri, Sep 14, 2018 at 02:19:19PM +0100, Patrick Bellasi wrote:
> > > On 14-Sep 11:32, Peter Zijlstra wrote:
> > 
> > > > Should that not be:
> > > > 
> > > > 	util = clamp_util(rq, cpu_util_cfs(rq));
> > > > 
> > > > Because if !util might we not still want to enforce the min clamp?
> > > 
> > > If !util CFS tasks should have been gone since a long time
> > > (proportional to their estimated utilization) and thus it probably
> > > makes sense to not affect further energy efficiency for tasks of other
> > > classes.
> > 
> > I don't remember what we do for util for new tasks; but weren't we
> > talking about setting that to 0 recently? IIRC the problem was that if
> > we start at 1 with util we'll always run new tasks on big cores, or
> > something along those lines.

I guess you're referring to that discussion ?

https://lore.kernel.org/lkml/CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com/

If yes, then the outcome was that we'll see later what we do with new
tasks :-)

Setting the util of new tasks to 0 surely can help power, but that can
also harm performance pretty badly, I think. You'd be stuck at min freq
for a while w/ sugov in case of a fork bomb for example.

> Mmm.. could have been in a recent discussion with Quentin, but I
> think I've missed it. I know we have something similar on Android for
> similar reasons.

I don't think PELT is different in Android (we still set the initial
util of new tasks as half of the spare cap of the CPU), but there are
other tweaks that influence the first task placement, though. And WALT
sets the util of new tasks to 0 IIRC (but I'm not sure it's relevant
since its signal ramps up a lot faster than PELT's).

Thanks,
Quentin
