From: Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH RFC 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Wed, 24 May 2017 12:01:51 +0200
Message-ID: <20170524120151.72847b6e@luca>
References: <20170523085351.18586-1-juri.lelli@arm.com>
        <20170523202321.3bygt6ydyiy5xief@hirez.programming.kicks-ass.net>
        <20170524092505.ipsdp2r4btsxxhn3@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170524092505.ipsdp2r4btsxxhn3@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, 24 May 2017 10:25:05 +0100
Juri Lelli <juri.lelli@arm.com> wrote:

> Hi,
> 
> On 23/05/17 22:23, Peter Zijlstra wrote:
> > On Tue, May 23, 2017 at 09:53:43AM +0100, Juri Lelli wrote:
> >   
> > > A point that is still very much up for discussion (more that the
> > > others :) is how we implement frequency/cpu scaling.
> > > SCHED_FLAG_RECLAIM tasks only need grub_reclaim(), as the
> > > function already scales their reservation runtime considering
> > > other reservations and maximum bandwidth a CPU has to offer.
> > > However, for normal !RECLAIM tasks multiple things can be
> > > implemented which seem to make sense:
> > > 
> > >  - don't scale at all: normal tasks will only get a % of CPU
> > > _time_ as granted by AC
> > >  - go to max as soon as a normal task in enqueued: this because
> > > dimensioning of parameters is usually done at max OPP/biggest CPU
> > > and normal task assume that this is always the condition when
> > > they run
> > >  - scale runtime acconding to current frequency and max CPU
> > > capacity: this is what this set is currently implementing
> > > 
> > > Opinions?  
> > 
> > 
> > So I'm terribly confused...
> > 
> > By using the active bandwidth to select frequency we effectively
> > reduce idle time (to 0 if we had infinite granular frequency steps
> > and no margins).
> > 
> > So !RECLAIM works as expected. They get the time they reserved,
> > since that was taken into account by active bandwidth.
> >   
> 
> This was my impression as well, but Luca (and please Luca correct me
> if I misunderstood your point) argued (in an off-line discussion
> ahead of this posting) that !reclaim tasks might not be interested in
> reclaiming *at all*.

Well, I also admitted that I am almost completely ignorant about many
people's requirements...

What I know is that there are some people using SCHED_DEADLINE to make
sure that a task can make progress (executing with a "high priority")
without consuming more than a specified fraction of CPU time... So,
they for example schedule a CPU-hungry task with runtime=10ms and
period=100ms to make sure that the task can execute every 100ms (giving
the impression of a "fluid progress") without stealing more than 10% of
CPU time to other tasks.

In this case, if the CPU frequency change the goal is still to
"reserve" 10% of CPU time (not more, even if the CPU is slower) to the
task. So, no runtime rescaling (or reclaiming) is required in this case.


My proposal was that if a task is not interested in a fixed
runtime / fraction of CPU time but wants to adapt the runtime when the
CPU frequency scales, then it can select the RECLAIMING flag.

But of course there might be different requirements or other use-cases.



			Luca

> Since scaling frequency down is another way of
> effectively reclaiming unused bandwidth (the other being sharing
> unused bandwidth among reservations while keeping frequency at
> max), !reclaim tasks could not be interested in frequency scaling (my
> first point above) or require frequency to be always at max (second
> point above).
> 
> Does this help claryfing a bit? :)
> 
> This said however, I'd personally be inclined to go with option 3
> above, which is what this set is currently implementing.
> 
> > And RECLAIM works, since that only promises to (re)distribute idle
> > time, and if there is none that is an easy task.
> >   
> 
> Right.
> 
> Thanks,
> 
> - Juri
