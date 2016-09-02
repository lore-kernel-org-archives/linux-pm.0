From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Fri, 2 Sep 2016 10:35:49 +0100
Message-ID: <20160902093549.GU9337@e106622-lin>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-3-git-send-email-smuckle@linaro.org>
 <20160831143907.GX10121@twins.programming.kicks-ass.net>
 <20160831150846.GN5599@graphite.smuckle.net>
 <alpine.DEB.2.20.1608311812040.5647@nanos>
 <20160831164009.GF10153@twins.programming.kicks-ass.net>
 <20160831170002.GK9337@e106622-lin>
 <20160901214851.GP5599@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbcIBJfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Sep 2016 05:35:41 -0400
Content-Disposition: inline
In-Reply-To: <20160901214851.GP5599@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On 01/09/16 14:48, Steve Muckle wrote:
> On Wed, Aug 31, 2016 at 06:00:02PM +0100, Juri Lelli wrote:
> > > Another problem is that we have many semi related knobs; we have the
> > > global RT runtime limit knob, but that doesn't affect cpufreq (maybe it
> > > should)
> > 
> > Maybe we could create this sort of link when using the cgroup RT
> > throttling interface as well? It should still then fit well once we
> > replace the underlying mechanism with DL reservations. And, AFAIK, the
> > interface is used by Android folks already.
> 
> I'm not sure how the upper bounds can be used to infer CPU frequency...
> On my Nexus 6p (an Android device), the global RT runtime limit
> seems to be set at 950ms/1sec, the root cgroup is set to 800ms/1sec, and
> bg_non_interactive is set at 700ms/1sec.
> 

Right, unfortunately. Still too coarse grained (as Thomas is also saying
in his last reply, if I read it correctly). Doesn't pay off the added
complexity I'm afraid.
