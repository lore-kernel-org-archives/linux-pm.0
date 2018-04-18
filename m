From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Date: Wed, 18 Apr 2018 08:18:16 +0800
Message-ID: <20180418001815.GE18509@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <20180417142440.GB18509@leoy-ThinkPad-X240s>
 <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 17, 2018 at 07:39:21PM +0200, Dietmar Eggemann wrote:
> On 04/17/2018 04:25 PM, Leo Yan wrote:
> 
> >>@@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  		update_cfs_group(se);
> >>  	}
> >>-	if (!se)
> >>+	if (!se) {
> >>  		add_nr_running(rq, 1);
> >>+		update_overutilized_status(rq);
> >>+	}
> >
> >Maybe this isn't a good question, why only update overutilized flag
> >for enqueue flow but not for dequeue flow?
> 
> [...]
> 
> >>@@ -9955,6 +10009,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >>  	if (static_branch_unlikely(&sched_numa_balancing))
> >>  		task_tick_numa(rq, curr);
> >>+
> >>+	update_overutilized_status(rq);
> >
> >Can sched tick clear overutilized flag if under tipping point?
> 
> No, only the load balancer for this particular sched domain level is able to
> clear the flag. We want to use the existing iteration over all cpus of the
> sched domain span to reset the flag.

Yes and sorry introduce noise.  The overutilized flag is shared with
all CPUs in the sched domain, so one CPU can set overutilized flag
for itself, but the CPU cannot clear the flag due this flag might be
set by other CPUs in the same sched domain.

Thanks,
Leo Yan
