From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Mar 2018 16:26:05 +0000
Message-ID: <20180321162605.GO4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321125925.GB15165@localhost.localdomain>
 <20180321135557.GB1373@queper01-VirtualBox>
 <20180321151513.GE15165@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321151513.GE15165@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Quentin Perret <quentin.perret@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 21, 2018 at 04:15:13PM +0100, Juri Lelli wrote:
> On 21/03/18 13:55, Quentin Perret wrote:
> > On Wednesday 21 Mar 2018 at 13:59:25 (+0100), Juri Lelli wrote:
> > > On 21/03/18 12:26, Patrick Bellasi wrote:
> > > > On 21-Mar 10:04, Juri Lelli wrote:
> 
> [...]
> 
> > > > > > +	/*
> > > > > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > > > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > > > > +	 */
> > > > > > +	util += util >> 2;
> > > > > 
> > > > > What about other governors (ondemand for example). Is this supposed to
> > > > > work only when schedutil is in use (if so we should probably make it
> > > > > conditional on that)?
> > > > 
> > > > Yes, I would say that EAS mostly makes sense when you have a "minimum"
> > > > control on OPPs... otherwise all the energy estimations are really
> > > > fuzzy.
> > > 
> > > Make sense to me. Shouldn't we then make all this conditional on using
> > > schedutil?
> > 
> > So, in theory, EAS could make sense even for other governors than
> > schedutil. Even with the performance governor it is probably more
> > energy efficient (although users using "performance" probably don't care
> > about energy, but that's just an example) to place small tasks onto little
> > CPUs up to a certain point given by the energy model. The ideal solution
> > would be to change the behaviour of find_cap_state() depending on the
> > governor being used, but I don't know if this extra complexity is worth
> > it really.
> > I'm happy to make all this conditional on schedutil as a first step and
> > we can see later if that makes sense to extend EAS to other use-cases.
> 
> I agree that EAS makes still sense even for !schedutil cases (your
> performance example being one of them, powersave maybe another one?).
> Making it work with ondemand is tricky, though.
> 
> So, not sure what's the best thing to do, but we should be at least aware
> of limitations.

I would suggest making as few assumptions about the OPP selection as
possible. Even when we do use schedutil, there could be number of
reasons why we don't actually get the OPP schedutil requests (thermal,
hardware-says-no,...).

In the previous energy model-driven scheduling postings, years back, I
went with the assumption that OPP would follow the utilization. So if we
put more tasks on a cpu, the OPP would increase to match. If cpufreq or
hardware decided to go faster, that is fine but it could lead to
suboptimal decisions.

We could call into schedutil somehow to make sure that we at least
request the same OPP as the energy model assumes if the overhead is
small and we can present schedutil with all the information it needs to
choose the OPP for the proposed task placement. I wonder if it is worth
it, or if we should just decide on a simple assumption on OPP selection
for energy estimation and stick it in a comment.

Morten
