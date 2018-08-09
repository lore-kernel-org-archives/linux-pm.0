From: leo.yan@linaro.org
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Date: Fri, 10 Aug 2018 01:04:50 +0800
Message-ID: <20180809170449.GE14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <2704016.RYJlhC2yyo@aspire.rjw.lan>
 <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
 <20180809162957.GD14362@leoy-ThinkPad-X240s>
 <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 06:43:55PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 6:29 PM,  <leo.yan@linaro.org> wrote:
> > On Thu, Aug 09, 2018 at 05:42:30PM +0200, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> >> >> This issue can be easily reproduce with the case on Arm Hikey board: use
> >> >> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
> >> >> function it start a hrtimer with 4ms, so the 4ms timer delta value can
> >> >> let 'menu' governor to choose deepest state in the next entering idle
> >> >> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
> >> >> 10 times, so this can utilize the typical pattern in 'menu' governor to
> >> >> have prediction for 1ms duration, finally idle governor is easily to
> >> >> select a shallow state, on Hikey board it usually is to select CPU off
> >> >> state.  From then on, CPU7 stays in this shallow state for long time
> >> >> until there have other interrupts on it.
> >> >
> >> > And which means that the above-mentioned code misses this case.
> >>
> >> And I don't really understand how this happens. :-/
> >>
> >> If menu sees that the tick has been stopped, it sets
> >> data->predicted_us to the minimum of TICK_USEC and
> >> ktime_to_us(delta_next) and the latency requirements comes from PM QoS
> >> (no interactivity boost).  Thus the only case when it will say "do not
> >> stop the tick" is when delta_next is below the tick period length, but
> >> that's OK, because it means that there is a timer pending that much
> >> time away, so it doesn't make sense to select a deeper idle state
> >> then.
> >>
> >> If there is a short-interval timer pending every time we go idle, it
> >> doesn't matter that the tick is stopped really, because the other
> >> timer will wake the CPU up anyway.
> >>
> >> Have I missed anything?
> >
> > Yeah, you miss one case is if there haven't anymore timer event, for this
> > case the ktime_to_us(delta_next) is a quite large value and
> > data->predicted_us will be to set TICK_USEC; if HZ=1000 then TICK_USEC is
> > 1000us, on Hikey board if data->predicted_us is 1000us then it's easily
> > to set shallow state (C1) rather than C2.  Unfortunately, this is the
> > last time the CPU can predict idle state before it will stay in idle
> > for long period.
> 
> Fair enough, but in that case the governor will want the tick to be
> stopped, because expected_interval is TICK_USEC then, so I'm not sure
> how the patch helps?

Correct, I might introduce confusion at here and I mentioned in
another email I have one prerequisite patch [1]: "cpuidle: menu: Correct
the criteria for stopping tick", if without this dependency patch, the idle
governor will always stop the tick even it selects one shallow state.

Sorry when I sent patchs with [1], I didn't send to linux-pm mailing list,
do you want me to send these patches to linux-pm?

[...]

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2018/8/7/407
