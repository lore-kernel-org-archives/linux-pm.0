From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Fri, 2 Sep 2016 14:17:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609021410340.5647@nanos>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <1472236848-17038-3-git-send-email-smuckle@linaro.org> <20160831143907.GX10121@twins.programming.kicks-ass.net> <20160831150846.GN5599@graphite.smuckle.net> <alpine.DEB.2.20.1608311812040.5647@nanos>
 <20160831164009.GF10153@twins.programming.kicks-ass.net> <20160831170002.GK9337@e106622-lin> <20160901214851.GP5599@graphite.smuckle.net> <20160902093549.GU9337@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160902093549.GU9337@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2 Sep 2016, Juri Lelli wrote:
> On 01/09/16 14:48, Steve Muckle wrote:
> > On Wed, Aug 31, 2016 at 06:00:02PM +0100, Juri Lelli wrote:
> > > > Another problem is that we have many semi related knobs; we have the
> > > > global RT runtime limit knob, but that doesn't affect cpufreq (maybe it
> > > > should)
> > > 
> > > Maybe we could create this sort of link when using the cgroup RT
> > > throttling interface as well? It should still then fit well once we
> > > replace the underlying mechanism with DL reservations. And, AFAIK, the
> > > interface is used by Android folks already.
> > 
> > I'm not sure how the upper bounds can be used to infer CPU frequency...
> > On my Nexus 6p (an Android device), the global RT runtime limit
> > seems to be set at 950ms/1sec, the root cgroup is set to 800ms/1sec, and
> > bg_non_interactive is set at 700ms/1sec.
> > 
> 
> Right, unfortunately. Still too coarse grained (as Thomas is also saying
> in his last reply, if I read it correctly).

Yes, you do. It's a big hammer and really unsuitable for this kind of
mechanism.

> Doesn't pay off the added complexity I'm afraid.

Certainly not. And the only choice we have is heuristics. Heuristic is an
euphemism for saying that it cannot work.

Thanks,

	tglx
