From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required RT CPU capacity
Date: Thu, 01 Sep 2016 00:50:53 +0200
Message-ID: <4540932.qeAxWElPNp@vostro.rjw.lan>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <alpine.DEB.2.20.1608311812040.5647@nanos> <20160831164009.GF10153@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56860 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754200AbcHaWpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 18:45:03 -0400
In-Reply-To: <20160831164009.GF10153@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wednesday, August 31, 2016 06:40:09 PM Peter Zijlstra wrote:
> On Wed, Aug 31, 2016 at 06:28:10PM +0200, Thomas Gleixner wrote:
> > > That is the way it's been with cpufreq and many systems (including all
> > > mobile devices) rely on that to not destroy power. RT + variable cpufreq
> > > is not deterministic.
> > > 
> > > Given we don't have good constraints on RT tasks I don't think we should
> > > try to strengthen the semantics there. Folks should either move to DL if
> > > they want determinism *and* not-sucky power, or continue disabling
> > > cpufreq if they are able to do so.
> > 
> > RT deterministic behaviour is all about meeting the deadlines. If your
> > deadline is relaxed enough that you can meet it even with the lowest cpu
> > frequency then it's perfectly fine to enable cpufreq. The same logic applies
> > to C-States.
> > 
> > There are a lot of RT systems out there which enable both. If cpufreq or
> > c-states cause a deadline violation because the constraints of the system are
> > tight, then people will disable it and we need a knob for both.
> > 
> > Realtime is not as fast as possible. It's as fast as specified.
> 
> Sure, problem is of course that RR/FIFO doesn't specify anything so the
> users are left to prod knobs.
> 
> Another problem is that we have many semi related knobs; we have the
> global RT runtime limit knob, but that doesn't affect cpufreq (maybe it
> should) and cpufreq has knobs to set f_min and f_max, which again are
> unaware of RT anything.
> 
> So before we go do anything, I'd like input on what is needed and how
> things should tie together to make most sense.

I totally agree.

We need to know where we want to get to before deciding on which way to go.

Thanks,
Rafael

