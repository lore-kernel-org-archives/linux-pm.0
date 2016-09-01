From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Thu, 1 Sep 2016 09:12:30 +0200
Message-ID: <20160901071230.GI10153@twins.programming.kicks-ass.net>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-3-git-send-email-smuckle@linaro.org>
 <20160831143907.GX10121@twins.programming.kicks-ass.net>
 <20160831150846.GN5599@graphite.smuckle.net>
 <alpine.DEB.2.20.1608311812040.5647@nanos>
 <20160831164009.GF10153@twins.programming.kicks-ass.net>
 <20160831170002.GK9337@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831170002.GK9337@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 31, 2016 at 06:00:02PM +0100, Juri Lelli wrote:
> On 31/08/16 18:40, Peter Zijlstra wrote:
> > Another problem is that we have many semi related knobs; we have the
> > global RT runtime limit knob, but that doesn't affect cpufreq (maybe it
> > should)
> 
> Maybe we could create this sort of link when using the cgroup RT
> throttling interface as well? It should still then fit well once we
> replace the underlying mechanism with DL reservations. And, AFAIK, the
> interface is used by Android folks already.

Tricky, but possible I suppose.

Since minimal cpufreq is 'global', the cgroup reservation only matters
if there are no tasks in any of its parent groups. Computing the
effective rt min then again becomes somewhat tricky, since we'd have to
iterate the cgroup tree.
