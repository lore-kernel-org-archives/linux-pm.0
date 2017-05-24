From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH RFC 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Wed, 24 May 2017 10:50:53 +0100
Message-ID: <20170524095053.sp6hy4erpyktcmoi@e106622-lin>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523202321.3bygt6ydyiy5xief@hirez.programming.kicks-ass.net>
 <20170524092505.ipsdp2r4btsxxhn3@e106622-lin>
 <20170524094111.irvopsw3aszghry6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935851AbdEXJvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 May 2017 05:51:00 -0400
Content-Disposition: inline
In-Reply-To: <20170524094111.irvopsw3aszghry6@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com

On 24/05/17 11:41, Peter Zijlstra wrote:
> On Wed, May 24, 2017 at 10:25:05AM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > On 23/05/17 22:23, Peter Zijlstra wrote:
> > > On Tue, May 23, 2017 at 09:53:43AM +0100, Juri Lelli wrote:
> > > 
> > > > A point that is still very much up for discussion (more that the others :) is
> > > > how we implement frequency/cpu scaling. SCHED_FLAG_RECLAIM tasks only need
> > > > grub_reclaim(), as the function already scales their reservation runtime
> > > > considering other reservations and maximum bandwidth a CPU has to offer.
> > > > However, for normal !RECLAIM tasks multiple things can be implemented which
> > > > seem to make sense:
> > > > 
> > > >  - don't scale at all: normal tasks will only get a % of CPU _time_ as granted
> > > >    by AC
> > > >  - go to max as soon as a normal task in enqueued: this because dimensioning of
> > > >    parameters is usually done at max OPP/biggest CPU and normal task assume
> > > >    that this is always the condition when they run
> > > >  - scale runtime acconding to current frequency and max CPU capacity: this is
> > > >    what this set is currently implementing
> > > > 
> > > > Opinions?
> > > 
> > > 
> > > So I'm terribly confused...
> > > 
> > > By using the active bandwidth to select frequency we effectively
> > > reduce idle time (to 0 if we had infinite granular frequency steps and
> > > no margins).
> > > 
> > > So !RECLAIM works as expected. They get the time they reserved, since
> > > that was taken into account by active bandwidth.
> > > 
> > 
> > This was my impression as well, but Luca (and please Luca correct me if
> > I misunderstood your point) argued (in an off-line discussion ahead of
> > this posting) that !reclaim tasks might not be interested in reclaiming
> > *at all*. Since scaling frequency down is another way of effectively
> > reclaiming unused bandwidth (the other being sharing unused bandwidth
> > among reservations while keeping frequency at max), !reclaim tasks could
> > not be interested in frequency scaling (my first point above) or require
> > frequency to be always at max (second point above).
> > 
> > Does this help claryfing a bit? :)
> 
> No ;-) As you said, confusion++.
> 
> A !RECLAIM task doesn't care (cannot care, should not care etc..) about
> any bandwidth not allocated to itself. Therefore it should/must/etc..
> not have any opinion on what we do with 'spare' bandwidth.
> 

Agreed. However, problem seems to be that

 - in my opinion (current implementation) this translated into scaling
   runtime considering current freq and cpu-max-capacity; and this is
   required when frequency scaling is enabled and we still want to meet
   a task's guaranteed bandwidth
 
 - Luca seemed instead to be inclined to say that, if we scale runtime
   for !reclaim tasks, such tasks are basically allowed to run for more
   time (when frequency is lower than max) by using some of the
   bandwidth not allocated to themselves
