From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Date: Mon, 20 Aug 2018 12:15:41 +0200
Message-ID: <20180820101541.GW2494@hirez.programming.kicks-ass.net>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <20180812145515.GB28966@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180812145515.GB28966@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: leo.yan@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 12, 2018 at 10:55:15PM +0800, leo.yan@linaro.org wrote:
> The first one issue is caused by timer cancel, I wrote one case for
> CPU_0 starting a hrtimer with pinned mode with short expire time and
> when the CPU_0 goes to sleep this short timeout timer can let idle
> governor selects a shallow state; at the meantime another CPU_1 will
> be used to try to cancel the timer, my purpose is to cheat CPU_0 so can
> see the CPU_0 staying in shallow state for long time;  it has low
> percentage to cancel the timer successfully, but I do see seldomly the
> timer can be canceled successfully so CPU_0 will stay in idle for long
> time (I cannot explain why the timer cannot be canceled successfully
> for every time, this might be another issue?).  This case is tricky,
> but it's possible happen in drivers with timer cancel.

So this is really difficuly to make hapen I think; you first need the
CPU to go deep idle, such that it disabled the tick. Then you have to
start the hrtimer there (using an IPI I suppose) which will then force
the governor to pick a shallow idle state, and then you have to cancel
the timer before it gets triggered.

And then, if the CPU stays perfectly idle, it will be stuck in that
shallow state... forever more.

_However_ IIRC when we (remotely) cancel an hrtimer, we do not in fact
reprogram the timer hardware. So the timer _will_ trigger.
hrtimer_interrupt() will observe nothing to do and reprogram the
hardware for the next timer (if there is one).

This should be enough to cycle through the idle loop and re-select an
idle state and avoid this whole problem.

If that is not happening, then something is busted and we need to figure
out what.
