From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] sched: fair: Don't update CPU frequency too frequently
Date: Wed, 7 Jun 2017 17:36:55 +0530
Message-ID: <20170607120655.GB11126@vireshk-i7>
References: <b3a96d619a4cad34f4243a173a42915c41059669.1496316723.git.viresh.kumar@linaro.org>
 <20170601122224.c324h4t7y3i4wr6e@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170601122224.c324h4t7y3i4wr6e@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Juri Lelli <Juri.Lelli@arm.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

+ Patrick,

On 01-06-17, 14:22, Peter Zijlstra wrote:
> On Thu, Jun 01, 2017 at 05:04:27PM +0530, Viresh Kumar wrote:
> > This patch relocates the call to utilization hook from
> > update_cfs_rq_load_avg() to task_tick_fair().
> 
> That's not right. Consider hardware where 'setting' the DVFS is a
> 'cheap' MSR write, doing that once every 10ms (HZ=100) is absurd.

Yeah, that may be too much for such a platforms. Actually we (/me & Vincent)
were worried about the current location of the utilization update hooks and
believed that they are getting called way too often. But yeah, this patch
optimized it way too much.

One of the goals of this patch was to avoid doing small OPP updates from
update_load_avg() which can potentially block significant utilization changes
(and hence big OPP changes) while a task is attached or detached, etc.

> We spoke about this problem in Pisa, the proposed solution was having
> each driver provide a cost metric and the generic code doing a max
> filter over the window constructed from that cost metric.

So we want to compensate for the lost opportunities (due to rate_limit_us
window) by changing the OPP based on what has happened in the previous
rate_limit_us window. I am not sure how will that help.

Case 1: A periodic RT task runs for a small time in the rate_limit_us window and
        the timing is such that we (almost) never go to the max OPP because of
        rate_limit_us window.

        Wouldn't a better solution towards such a case is what Patrick [1]
        proposed earlier (i.e. ignore rate_limit_us for RT/DL tasks), as we will
        run at high OPP when we really needed it the most.


Case 2: A high utilization periodic CFS task runs for short duration and keeps
        on migrating to other CPUs. We miss the opportunity to update the OPP
        based on this tasks utilization because of rate_limit_us window and by
        the time we update the OPP again, this task is already migrated and so
        the utilization is low again.

        If the task has already migrated, why should we increase the OPP on
        assumption that this task will come back on this CPU? There are enough
        chances that the selected (higher) OPP will not be utilized by the
        current load on the CPU.

        Also if this CFS tasks runs once every 2 (or more) ticks on the same
        CPU, then we are back to the same problem again.

        1         2         3         4
        |---------|---------|---------|---------|

           T                   T

        1,2,3,4 are representing the events on which we try to update the OPP
        and are placed rate_limit_us distance apart. And the task T happens to
        run between 1-2 and 3-4. We will not change the frequency until the
        event 2 in this case as rate_limit_us window isn't over yet. We go to
        higher OPP on 2 (which is really wasted for the current loads) because T
        happened in the last window. On 3 we come back to the OPP proportional
        to the current load. And the next time T runs again, we are still stuck
        on the low OPP. So instead of fixing it, we made it worse by wasting
        power unnecessarily.

Is there any case I am missing that you are concerned about ?

-- 
viresh

[1] https://marc.info/?l=linux-kernel&m=148846976032099&w=2
