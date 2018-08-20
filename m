From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Date: Mon, 20 Aug 2018 11:14:30 +0200
Message-ID: <20180820091430.GV2494@hirez.programming.kicks-ass.net>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
 <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
> So I have given more consideration to this and my conclusion is that
> restarting the tick between cpuidle_select() and call_cpuidle() is a
> bad idea.

Ack, we should only restart the tick once we leave the idle loop.

> First off, if need_resched() is "false", the primary reason for
> running the tick on the given CPU is not there, so it only might be
> useful as a "backup" timer to wake up the CPU from an inadequate idle
> state.

this..

<snip>

> The second
> reason is when the governor predicts a wakeup which is not by a timer
> in this time frame and it is quite arguable what the governor should
> do then.  IMO it at least is not unreasonable to throw the prediction
> away and still go for the closest timer event in that case (which is
> the current approach).

Yes, I think I can agree with that, predictions at that scale are just
not that useful. The primary point of the governor is to stay shallow
when we can, but once we're deep and have disabled the tick and lost
caches, there's really no point anymore. Waking up is going to hurt.

> There's more, though.  Restarting the tick between cpuidle_select()
> and call_cpuidle() might introduce quite a bit of latency into that
> point and that would mess up with the idle state selection (e.g.
> selecting a very shallow idle state might not make a lot of sense if
> that latency was high enough, because the expected wakeup might very
> well take place when the tick was being restarted), so it should
> rather be avoided IMO.

Absolutely, mucking with the tick just because of a hunch is the wrong
thing.

So,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

for this one.
