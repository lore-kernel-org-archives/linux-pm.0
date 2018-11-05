From: Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor
 for tickless systems
Date: Mon, 05 Nov 2018 20:14:24 +0100
Message-ID: <1541445264.3441.6.camel@suse.cz>
References: <1899281.leNo2RexrE@aspire.rjw.lan>
         <1541010981.3423.2.camel@suse.cz> <4168371.zz0pVZtGOY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4168371.zz0pVZtGOY@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Doug Smythies <dsmythies@telus.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2018-11-04 at 11:06 +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 31, 2018 7:36:21 PM CET Giovanni Gherdovich wrote:
>
> [...]
> You can use the cpu_idle trace point to correlate the selected state index
> with the observed idle duration (that's what Doug did IIUC).

True, that works; although I ended up slapping a tracepoint right at the
beginning of the teo_update() and capturing the variables
cpu_data->last_state, dev->last_residency and dev->cpu.

I should have some plots to share soon. I really wanted to do in-kernel
histograms with systemtap as opposed to collecting data with ftrace and doing
post-processing, because I noticed that the latter approach generates lots of
events and wakeups from idle on the cpu that handles the ftrace data. It's
kind of a workload in itself and spoils the results.

> 
> Then, if the observed idle duration is between the target residency of the
> selected state and the target residency of the next one, the selected state
> is adequate and that's what we care about really.
> 
> If the observed idle duration is below the target residency of the selected
> state, the selected state is too deep and it if is above (or equal to) the
> target residency of the next state, it is too shallow.

Thanks for explaining this.

> 
> > After that it would be nice to somehow know where timers came from; i.e. if
> > I see that residences in a given state are consistently shorter than
> > they're supposed to be, it would be interesting to see who set the timer
> > that causes the wakeup. But... I'm not sure to know how to do that :) Do
> > you have a strategy to track down the origin of timers/interrupts? Is there
> > any script you're using to evaluate teo that you can share?
> 
> I need to think about that TBH.
> 
> The information that we can get readily should give use quite a good idea of
> what happens on average, though, so let's first do that and then try to dig
> deeper if need be.
> 
> I think that the difference between the v1 and v2 of the TEO governor comes
> mostly from the way in which they handle patterns of "early" wakeups.  The
> method used in v1 is very crude (and arguably invalid in general) and it
> will cause shallow states to be selected more often, while the v2 tries to
> be more "intelligent", but it may be overly conservative with that.
> 
> I'm working on a v3 that will try to address the above ATM, but I'd like to run
> it on my systems first (I'm going back home from a conference right now).
>

I've seen v3, I'll send you the test results ASAP.

Giovanni
