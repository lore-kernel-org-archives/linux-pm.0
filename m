From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][Fix] cpuidle: Run tick_broadcast_exit() with disabled interrupts
Date: Fri, 01 May 2015 00:10:35 +0200
Message-ID: <1934706.ixTLMcGVHV@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2872649.RClMYKns0i@vostro.rjw.lan> <alpine.LFD.2.11.1504301602180.1582@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1504301602180.1582@knanqh.ubzr>
Sender: linux-acpi-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 30, 2015 04:12:46 PM Nicolas Pitre wrote:
> On Wed, 29 Apr 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 335f49196fd6 (sched/idle: Use explicit broadcast oneshot
> > control function) replaced clockevents_notify() invocations in
> > cpuidle_idle_call() with direct calls to tick_broadcast_enter()
> > and tick_broadcast_exit(), but it overlooked the fact that
> > interrupts were already enabled before calling the latter which
> > led to functional breakage on systems using idle states with the
> > CPUIDLE_FLAG_TIMER_STOP flag set.
> > 
> > Fix that by moving the invocations of tick_broadcast_enter()
> > and tick_broadcast_exit() down into cpuidle_enter_state() where
> > interrupts are still disabled when tick_broadcast_exit() is
> > called.  Also ensure that interrupts will be disabled before
> > running tick_broadcast_exit() even if they have been enabled by
> > the idle state's ->enter callback.  Trigger a WARN_ON_ONCE() in
> > that case, as we generally don't want that to happen for states
> > with CPUIDLE_FLAG_TIMER_STOP set.
> 
> Incidentally I was debugging this issue as well when I saw this thread.
> 
> And it turns out that I did report this issue 2 months ago:
> http://article.gmane.org/gmane.linux.kernel/1892049
> What happened?

The patch series had been picked up by someone else (me), reordered and rebased
in the meantime and your report was missed.  Sorry about that.

> > Fixes: 335f49196fd6 (sched/idle: Use explicit broadcast oneshot control function)
> > Reported-and-tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reported-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Tested-by: Nicolas Pitre <nico@linaro.org>

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
