From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Wed, 31 Aug 2016 18:28:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1608311812040.5647@nanos>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <1472236848-17038-3-git-send-email-smuckle@linaro.org> <20160831143907.GX10121@twins.programming.kicks-ass.net> <20160831150846.GN5599@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935772AbcHaQc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 12:32:29 -0400
In-Reply-To: <20160831150846.GN5599@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wed, 31 Aug 2016, Steve Muckle wrote:
> On Wed, Aug 31, 2016 at 04:39:07PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 26, 2016 at 11:40:48AM -0700, Steve Muckle wrote:
> > > A policy of going to fmax on any RT activity will be detrimental
> > > for power on many platforms. Often RT accounts for only a small amount
> > > of CPU activity so sending the CPU frequency to fmax is overkill. Worse
> > > still, some platforms may not be able to even complete the CPU frequency
> > > change before the RT activity has already completed.
> > > 
> > > Cpufreq governors have not treated RT activity this way in the past so
> > > it is not part of the expected semantics of the RT scheduling class. The
> > > DL class offers guarantees about task completion and could be used for
> > > this purpose.
> > 
> > Not entirely true. People have simply disabled cpufreq because of this.
> >
> > Yes, RR/FIFO are a pain, but they should still be deterministic, and
> > variable cpufreq destroys that.
> 
> That is the way it's been with cpufreq and many systems (including all
> mobile devices) rely on that to not destroy power. RT + variable cpufreq
> is not deterministic.
> 
> Given we don't have good constraints on RT tasks I don't think we should
> try to strengthen the semantics there. Folks should either move to DL if
> they want determinism *and* not-sucky power, or continue disabling
> cpufreq if they are able to do so.

RT deterministic behaviour is all about meeting the deadlines. If your
deadline is relaxed enough that you can meet it even with the lowest cpu
frequency then it's perfectly fine to enable cpufreq. The same logic applies
to C-States.

There are a lot of RT systems out there which enable both. If cpufreq or
c-states cause a deadline violation because the constraints of the system are
tight, then people will disable it and we need a knob for both.

Realtime is not as fast as possible. It's as fast as specified.
 
Thanks,

	tglx
