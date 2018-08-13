From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Date: Mon, 13 Aug 2018 10:11:20 +0200
Message-ID: <CAJZ5v0i27XksAGUsq8CQRpE_AbNhYwu0roGdfy5DHBrPqtsPtw@mail.gmail.com>
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan> <20180812145515.GB28966@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180812145515.GB28966@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 12, 2018 at 4:55 PM <leo.yan@linaro.org> wrote:
>
> On Fri, Aug 10, 2018 at 01:15:58PM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >

[cut]

>
> I tried this patch at my side, firstly just clarify this patch is okay
> for me, but there have other underlying issues I observed the CPU
> staying shallow idle state with tick stopped, so just note at here.

Thanks for testing!

> From my understanding, the rational for this patch is we
> only use the timer event as the reliable wake up source; if there have
> one short timer event then we can select shallow state, otherwise we
> also can select deepest idle state for long expired timer.
>
> This means the idle governor needs to know the reliable info for the
> timer event, so far I observe there at least have two issues for timer
> event delta value cannot be trusted.
>
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

Yes, it can potentially happen, but I'm not worried about it.  If it
happens, that will only be occasionally and without measurable effect
on total energy usage of the system.

> Another issue is caused by spurious interrupts; if we review the
> function tick_nohz_get_sleep_length(), it uses 'ts->idle_entrytime' to
> calculate tick or timer delta, so every time when exit from interrupt
> and before enter idle governor, it needs to update
> 'ts->idle_entrytime'; but for spurious interrupts, it will not call
> irq_enter() and irq_exit() pairs, so it doesn't invoke below flows:
>
>   irq_exit()
>     `->tick_irq_exit()
>          `->tick_nohz_irq_exit()
>               `->tick_nohz_start_idle()
>
> As result, after spurious interrupts handling, the idle loop doesn't
> update for ts->idle_entrytime so the governor might read back a stale
> value.  I don't really locate this issue, but I can see the CPU is
> waken up without any interrupt handling and then directly go to
> sleep again, the menu governor selects one shallow state so the cpu
> stay in shallow state for long time.

This sounds buggy, but again, spurious interrupts are not expected to
occur too often and if they do, they are a serious enough issue by
themselves.
