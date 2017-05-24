From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Wed, 24 May 2017 13:29:26 +0200
Message-ID: <20170524112926.b76lxxab7hzh4ay5@hirez.programming.kicks-ass.net>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523202321.3bygt6ydyiy5xief@hirez.programming.kicks-ass.net>
 <20170524092505.ipsdp2r4btsxxhn3@e106622-lin>
 <20170524120151.72847b6e@luca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170524120151.72847b6e@luca>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, May 24, 2017 at 12:01:51PM +0200, Luca Abeni wrote:
> > > So I'm terribly confused...
> > > 
> > > By using the active bandwidth to select frequency we effectively
> > > reduce idle time (to 0 if we had infinite granular frequency steps
> > > and no margins).
> > > 
> > > So !RECLAIM works as expected. They get the time they reserved,
> > > since that was taken into account by active bandwidth.


> Well, I also admitted that I am almost completely ignorant about many
> people's requirements...
> 
> What I know is that there are some people using SCHED_DEADLINE to make
> sure that a task can make progress (executing with a "high priority")
> without consuming more than a specified fraction of CPU time... So,
> they for example schedule a CPU-hungry task with runtime=10ms and
> period=100ms to make sure that the task can execute every 100ms (giving
> the impression of a "fluid progress") without stealing more than 10% of
> CPU time to other tasks.
> 
> In this case, if the CPU frequency change the goal is still to
> "reserve" 10% of CPU time (not more, even if the CPU is slower) to the
> task. So, no runtime rescaling (or reclaiming) is required in this case.
> 
> 
> My proposal was that if a task is not interested in a fixed
> runtime / fraction of CPU time but wants to adapt the runtime when the
> CPU frequency scales, then it can select the RECLAIMING flag.

I think these people are doing it wrong :-)

Firstly, the runtime budget is a WCET. This very much means it is
subject to CPU frequency; after all, when the CPU runs slower, that same
amount of work takes longer. So being subject to cpufreq is the natural
state and should not require a special marker.

Secondly, if you want a steady progress of 10%, I don't see the problem
with giving them more at slower frequency, they get the 'same' amount of
'work' done without bothering other people.
