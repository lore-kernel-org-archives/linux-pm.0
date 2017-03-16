From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC v3 5/5] sched/{core,cpufreq_schedutil}: add capacity
 clamping for RT/DL tasks
Date: Thu, 16 Mar 2017 17:17:12 +0000
Message-ID: <20170316171712.GR31499@e106622-lin>
References: <20170315114052.GB18557@e110439-lin>
 <CAJWu+opgLoa3EGdhQKXSi+dkQjXtc62tKmTL0krXxpqJp+PjPQ@mail.gmail.com>
 <20170315144449.GH31499@e106622-lin>
 <CAJWu+orSQbyDxN4O6wk8SYj-t5FyUZA4aO0GQqm8Fgujwr9+Lw@mail.gmail.com>
 <20170315162414.GI31499@e106622-lin>
 <CAJWu+ooCmyx7PNXhzrDsUQM=eU1zxo8F3gyp2ihpabpREk5vfg@mail.gmail.com>
 <20170316111644.GP31499@e106622-lin>
 <20170316122726.GA10171@e110439-lin>
 <20170316124420.GQ31499@e106622-lin>
 <CAJWu+oqPDnxTHkMFFhN3q1prWYhXALZXCyA7FiD+aBo7S+8i2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbdCPRRA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Mar 2017 13:17:00 -0400
Content-Disposition: inline
In-Reply-To: <CAJWu+oqPDnxTHkMFFhN3q1prWYhXALZXCyA7FiD+aBo7S+8i2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Andres Oportus <andresoportus@google.com>

On 16/03/17 09:58, Joel Fernandes wrote:
> On Thu, Mar 16, 2017 at 5:44 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> > On 16/03/17 12:27, Patrick Bellasi wrote:
> >> On 16-Mar 11:16, Juri Lelli wrote:
> >> > On 15/03/17 16:40, Joel Fernandes wrote:
> >> > > On Wed, Mar 15, 2017 at 9:24 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> >> > > [..]
> >> > > >
> >> > > >> > However, trying to quickly summarize how that would work (for who is
> >> > > >> > already somewhat familiar with reclaiming bits):
> >> > > >> >
> >> > > >> >  - a task utilization contribution is accounted for (at rq level) as
> >> > > >> >    soon as it wakes up for the first time in a new period
> >> > > >> >  - its contribution is then removed after the 0lag time (or when the
> >> > > >> >    task gets throttled)
> >> > > >> >  - frequency transitions are triggered accordingly
> >> > > >> >
> >> > > >> > So, I don't see why triggering a go down request after the 0lag time
> >> > > >> > expired and quickly reacting to tasks waking up would have create
> >> > > >> > problems in your case?
> >> > > >>
> >> > > >> In my experience, the 'reacting to tasks' bit doesn't work very well.
> >> > > >
> >> > > > Humm.. but in this case we won't be 'reacting', we will be
> >> > > > 'anticipating' tasks' needs, right?
> >> > >
> >> > > Are you saying we will start ramping frequency before the next
> >> > > activation so that we're ready for it?
> >> > >
> >> >
> >> > I'm saying that there is no need to ramp, simply select the frequency
> >> > that is needed for a task (or a set of them).
> >> >
> >> > > If not, it sounds like it will only make the frequency request on the
> >> > > next activation when the Active bandwidth increases due to the task
> >> > > waking up. By then task has already started to run, right?
> >> > >
> >> >
> >> > When the task is enqueued back we select the frequency considering its
> >> > bandwidth request (and the bandwidth/utilization of the others). So,
> >> > when it actually starts running it will already have enough capacity to
> >> > finish in time.
> >>
> >> Here we are factoring out the time required to actually switch to the
> >> required OPP. I think Joel was referring to this time.
> >>
> 
> Yes, that's what I meant.
> 
> >
> > Right. But, this is an HW limitation. It seems a problem that every
> > scheduler driven decision will have to take into account. So, doesn't
> > make more sense to let the driver (or the governor shim layer) introduce
> > some sort of hysteresis to frequency changes if needed?
> 
> The problem IMO which Hysterisis in the governor will not help is what
> if you had a DL task that is not waking up for several periods and
> then wakes up, then for that wake up, we would still be subject to the
> HW limitation of time taken to switch to needed OPP. Right?
> 

True, but in this case the problem is that you cannot really predict the
future anyway. So, if your HW is so slow to react that it always causes
latency problems then I guess you'll be forced to statically raise your
min_freq value to cope with that HW limitation, indipendently from
scheduling policies/heuristics?

OTOH, hysteresis, when properly tuned, should cover the 'normal' cases.

> >> That time cannot really be eliminated but from having faster OOP
> >> swiching HW support. Still, jumping strating to the "optimal" OPP
> >> instead of rumping up is a big improvement.
> 
> Yes I think so.
> 
> Thanks,
> Joel
