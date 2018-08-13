From: leo.yan@linaro.org
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Date: Mon, 13 Aug 2018 17:58:01 +0800
Message-ID: <20180813095801.GB11775@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s>
 <20180810090327.GE11817@leoy-ThinkPad-X240s>
 <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com>
 <20180812160740.GC28966@leoy-ThinkPad-X240s>
 <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 13, 2018 at 10:01:20AM +0200, Rafael J. Wysocki wrote:
> On Sun, Aug 12, 2018 at 6:07 PM <leo.yan@linaro.org> wrote:
> >
> > On Sun, Aug 12, 2018 at 01:12:41PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:
> 
> [cut]
> 
> > >
> > > Assuming shot noise wakeups, if
> > > drv->states[drv->state_count-1].target_residency is less than
> > > TICK_USEC, the tick will be stopped for CPUs more often on average
> > > with the patch applied (simply because the idle duration range for
> > > which it will not be stopped is narrower then).
> >
> > Yes, good point, so in the new approach I try to change the code
> > to compare with next tick delta rather than TICK_USEC, it can keeps
> > running tick for the tick with long expire time (similiar with
> > comparing with TICK_USEC) but we also can stop tick if the tick is likely
> > to break idle residency.
> 
> We tried something similar and the results were not encouraging.
> Please see https://lore.kernel.org/lkml/079e16b6-2e04-2518-0553-66becab226a6@tu-dresden.de/

I reviewed the result, in the shared page, it said to use next tick
delta and results in the power data increasing, I think this can be
explained.

If we use prediction to compare with next tick delta rather than
TICK_USEC, Thomas gave the expectation is 'This works as a I expect in
the sense of stopping the tick more often and allowing deeper sleep
states in some cases.'; but we also need to expect the change will give
more chance for powernightmares to occurring, if the expect_interval
just falls into the range [delta_next_us..TICK_USEC) then idle
governor will stop tick after comparing with the next tick delta, but
at the meantime the idle governor is very likely to select one shallow
state for expect_interval is a small value.  So though the change
gives more chance for staying deeper state but it also give more
chance for staying in shallow state for longer time.

>From the testing report, I don't find it do statistics for idle state
duration time.  The email said 'No more sched tick, no more C1E
requests, but increased power.', so this is just for statistics for
idle state requests (entering/exiting times), but not for duration
statistics.  So this isn't clear for me how the difference for idle
duration.

Because the change gives more chance for powernightmares, so we need
use extra method to avoid it.  This is why I add one extra patch for
this [1], it checks for shallow state with long expire timer, for this
case we should not stop the tick.

Actually the powernightmares issue is not completely resolved so it
still impact the power data; after we really get rid of the impaction
of powernightmares, I think we may have chance to see the benefits of
comparing with next tick delta.

Based on these ideas, I worked out the patch set 'Improvement stopping
tick decision making in 'menu' idle governor' [2], the testing result
supports the idle duration improvement, which shared in the cover letter.

Please help review and let me know if it's doable or not.  Thanks for
the suggestion.

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2018/8/12/84
[2] https://lkml.org/lkml/2018/8/12/82
