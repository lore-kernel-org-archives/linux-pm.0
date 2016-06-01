From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] sched, cpuidle: Do not access cpuidle_devices when
 !CONFIG_CPU_IDLE
Date: Wed, 1 Jun 2016 22:48:37 +0100
Message-ID: <20160601214836.GA14666@mbp>
References: <1464803536-19929-1-git-send-email-catalin.marinas@arm.com>
 <4245615.v9qo6igreM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4245615.v9qo6igreM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 01, 2016 at 10:20:03PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 01, 2016 06:52:16 PM Catalin Marinas wrote:
> > The cpuidle_devices per-CPU variable is only defined when CPU_IDLE is
> > enabled. Commit c8cc7d4de7a4 ("sched/idle: Reorganize the idle loop")
> > removed the #ifdef CONFIG_CPU_IDLE around cpuidle_idle_call() with the
> > compiler optimising away __this_cpu_read(cpuidle_devices). However, with
> > CONFIG_UBSAN && !CONFIG_CPU_IDLE, this optimisation no longer happens
> > and the kernel fails to link since cpuidle_devices is not defined.
> > 
> > This patch introduces an accessor function for the current CPU cpuidle
> > device (returning NULL when !CONFIG_CPU_IDLE) and uses it in
> > cpuidle_idle_call().
> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> OK
> 
> Is this needed in -stable?

Not sure how common this config combination is (I was just testing
different options and came across it). Even though it's not a fix for
UBSAN, we could add it up to 4.5 since that's when UBSAN was merged:

Cc: <stable@vger.kernel.org> # 4.5+

-- 
Catalin
