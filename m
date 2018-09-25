From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Tue, 25 Sep 2018 17:49:56 +0200
Message-ID: <20180925154956.GA30146@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924151400.GT1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:

> > So why bother changing it around?
> 
> For two main reasons:
> 
> 1) to expose userspace a more generic interface:
>    a "performance percentage" is more generic then a "capacity value"
>    while keep translating and using a 1024 based value in kernel space

The unit doesn't make it more or less generic. It's the exact same thing
in the end.

> 2) to reduce the configuration space:
>    it quite likely doesn't make sense to use, in the same system, 100
>    difference clamp values... it makes even more sense to use 1024
>    different clamp values, does it ?

I'd tend to agree with you that 1024 is probably too big a
configureation space, OTOH I also don't want to end up with a "640KB is
enough for everybody" situation.

And 100 really isn't that much better either way around.

> > The thing I worry about is how do we determine the value to put in in
> > the first place.
> 
> I agree that's the main problem, but I also think that's outside of
> the kernel-space mechanism.
> 
> Is not all that quite similar to DEADLINE tasks configuration?

Well, with DL there are well defined rules for what to put in and what
to then expect.

For this thing, not so much I feel.

> Given a DL task solving a certain issue, you can certainly define its
> deadline (or period) on a completely platform independent way, by just
> looking at the problem space. But when it comes to the run-time, we
> always have to profile the task in a platform specific way.
> 
> In the DL case from user-space we figure out a bandwidth requirement.

Most likely, although you can compute in a number of cases. But yes, it
is always platform specific.

> In the clamping case, it's still the user-space that needs to figure
> our an optimal clamp value, while considering your performance and
> energy efficiency goals. This can be based on an automated profiling
> process which comes up with "optimal" clamp values.
> 
> In the DL case, we are perfectly fine to have a running time
> parameter, although we don't give any precise and deterministic
> formula to quantify it. It's up to user-space to figure out the
> required running time for a given app and platform.
> It's also not unrealistic the case you need to close a control loop
> with user-space to keep updating this requirement.
> 
> Why the same cannot hold for clamp values ?

The big difference is that if I request (and am granted) a runtime quota
of a given amount, then that is what I'm guaranteed to get.

Irrespective of the amount being sufficient for the work in question --
which is where the platform dependency comes in.

But what am I getting when I set a specific clamp value? What does it
mean to set the value to 80%

So far the only real meaning is when combined with the EAS OPP data, we
get a direct translation to OPPs. Irrespective of how the utilization is
measured and the capacity:OPP mapping established, once that's set, we
can map a clamp value to an OPP and get meaning.

But without that, it doesn't mean anything much at all. And that is my
complaint. It seems to get presented as: 'random knob that might do
something'. The range it takes as input doesn't change a thing.

> > How are expecting people to determine what to put into the interface?
> > Knee points, little capacity, those things make 'obvious' sense.
> 
> IMHO, they make "obvious" sense from a kernel-space perspective
> exactly because they are implementation details and platform specific
> concepts.
> 
> At the same time, I struggle to provide a definition of knee point and
> I struggle to find a use-case where I can certainly say that a task
> should be clamped exactly to the little capacity for example.
> 
> I'm more of the idea that the right clamp value is something a bit
> fuzzy and possibly subject to change over time depending on the
> specific application phase (e.g. cpu-vs-memory bounded) and/or
> optimization goals (e.g. performance vs energy efficiency).
> 
> Here we are thus at defining and agree about a "generic and abstract"
> interface which allows user-space to feed input to kernel-space.
> To this purpose, I think platform specific details and/or internal
> implementation details are not "a bonus".

But unlike DL, which has well specified behaviour, and when I know my
platform I can compute a usable value. This doesn't seem to gain meaning
when I know the platform.

Or does it? If you say yes, then we need to be able to correlate to the
platform data that gives it meaning; which would be the OPP states. And
those come with capacity numbers.

> > > > But changing the clamp metric to something different than these values
> > > > is going to be pain.
> > > 
> > > Maybe I don't completely get what you mean here... are you saying that
> > > not using exact capacity values to defined clamps is difficult ?
> > > If that's the case why? Can you elaborate with an example ?
> > 
> > I meant changing the unit around, 1/1024 is what we use throughout and
> > is what EAS is also exposing IIRC, so why make things complicated again
> > and use 1/100 (which is a shit fraction for computers).
> 
> Internally, in kernel space, we use 1024 units. It's just the
> user-space interface that speaks percentages but, as soon as a
> percentage value is used to configure a clamp, it's translated into a
> [0..1024] range value.
> 
> Is this not an acceptable compromise? We have a generic user-space
> interface and an effective/consistent kernel-space implementation.

I really don't see how changing the unit changes anything. Either you
want to relate to OPPs and those are exposed in 1/1024 unit capacity
through the EAS files, or you don't and then the knob has no meaning.

And how the heck are we supposed to assign a value for something that
has no meaning.

Again, with DL we ask for time, once I know the platform I can convert
my work into instructions and time and all makes sense.

With this, you seem reluctant to allow us to close that loop. Why is
that? Why not directly relate to the EAS OPPs, because that is directly
what they end up mapping to.

When I know the platform, I can convert my work into instructions and
obtain time, I can convert my clamp into an OPP and time*OPP gives an
energy consumption.

Why muddle things up and make it complicated?
