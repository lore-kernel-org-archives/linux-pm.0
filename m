From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 13:38:59 +0100
Message-ID: <20151215123859.GC6357@twins.programming.kicks-ass.net>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214165128.GU6357@twins.programming.kicks-ass.net>
 <20151214223113.5732201a@luca-1225C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151214223113.5732201a@luca-1225C>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 14, 2015 at 10:31:13PM +0100, Luca Abeni wrote:

> > There 'might' be smart pants ways around this, where you run part of
> > the execution at lower speed and switch to a higher speed to 'catch'
> > up if you exceed some boundary, such that, on average, you run at the
> > same speed the WCET mandates, but I'm not sure that's worth it.
> > Juri/Luca might know.

> Some previous works (see for example
> https://www.researchgate.net/profile/Giuseppe_Lipari/publication/220800940_Using_resource_reservation_techniques_for_power-aware_scheduling/links/09e41513639b2703fc000000.pdf
> ) investigated the usage of the "active utilisation" for switching the
> CPU frequency. This "active utilisation tracking" mechanism is the same
> I mentioned in the previous email, and implemented here:
> https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b .

I have stuck the various PDFs and commits you've linked into my todo
list ;-) Thanks!

> I suspect the "inactive timer" I used to decrease the utilisation at
> the so called 0-lag time might be problematic, but I did not find any
> way to implement (or approximate) the active utilisation tracking
> without this timer... Anyway, if there is interest I am willing to
> adapt/rework/modify my patches as needed.

So I remember something else from the BFQ code, which also had to track
entries for the 0-lag stuff, and I just had a quick peek at that code
again. And what they appear to do is keep inactive entries with a lag
deficit in a separate tree (the idle tree).

And every time they update the vtime, they also push fwd the idle tree
and expire entries on that.

Or that is what I can make of it in a quick few minutes staring at that
code -- look for bfq_forget_idle().
