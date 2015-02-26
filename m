From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] drivers: cpuidle: remove stale irq disabling call in
 cpuidle_enter_freeze()
Date: Thu, 26 Feb 2015 09:48:16 +0000
Message-ID: <20150226094816.GA25057@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <54EDD883.30608@linaro.org>
 <20150225143917.GC20214@red-moon>
 <1789709.hzh3CkisvM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40461 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbbBZJry (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Feb 2015 04:47:54 -0500
Content-Disposition: inline
In-Reply-To: <1789709.hzh3CkisvM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, Feb 25, 2015 at 11:36:10PM +0000, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 02:39:17 PM Lorenzo Pieralisi wrote:
> > On Wed, Feb 25, 2015 at 02:13:23PM +0000, Daniel Lezcano wrote:
> > > On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> > > > On return from cpuidle_enter_freeze() irqs are re-enabled by the function
> > > > caller (ie cpuidle_idle_call) in the idle loop. This patch removes a stale
> > > > local_irq_disable() call and its stale comment in cpuidle_enter_freeze(),
> > > > since they disagree and do not serve a useful purpose.
> > > >
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > ---
> > > >   drivers/cpuidle/cpuidle.c | 3 ---
> > > >   1 file changed, 3 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > > index 4d53458..f47edc6c 100644
> > > > --- a/drivers/cpuidle/cpuidle.c
> > > > +++ b/drivers/cpuidle/cpuidle.c
> > > > @@ -144,9 +144,6 @@ void cpuidle_enter_freeze(void)
> > > >   		cpuidle_enter(drv, dev, index);
> > > >   	else
> > > >   		arch_cpu_idle();
> > > > -
> > > > -	/* Interrupts are enabled again here. */
> > > > -	local_irq_disable();
> > > >   }
> > > 
> > > Hmm, I think Rafael added this prevent lockdep to raise a warning.
> > 
> > Ok, so the comment is there to say "at this point of execution IRQs
> > are enabled", it does not refer to local_irq_disable() call effects,
> > that's misleading and not necessarily nice, at least it should
> > be explained.
> > 
> > > Otherwise, cpuidle_enter or arch_cpu_idle enables the irq again and then 
> > > when exiting the cpu_idle_call, we enable them again, so leading to a 
> > > lockdep WARN in trace_hardirqs_on_caller.
> > 
> > Would not it be better to enable irqs in cpuidle_enter_freeze() on
> > returning from enter_freeze_proper() and remove the local_irq_enable()
> > call in the cpuidle_idle_call() before jumping to exit_idle ?
> > 
> > > That said, if we have to do this, it may reveal something is wrong in 
> > > the code.
> > 
> > I just spotted code through inspection, I have to say at the moment it
> > is not very clear what it is meant to achieve, so I put together this
> > patch.
> 
> So there are two code paths in cpuidle_idle_call(), the enter_freeze_proper()
> one which does *not* re-enable interrupts and the one you modified which does
> that.  The local_irq_disable() is to keep things consistent.
> 
> I'm not entirely against of re-arranging things here, but a patch like the
> (untested) one below might be more appropriate.
> 
> Rafael (who would appreciate it if people asked questions instead of sending
> patches on a hunch).

I understand that, I wanted to just send [patch 2], this patch was more
a way to get a clarification than anything else, asking would have been more
appropriate, sorry.

Anyway, I did not like disabling IRQs to just re-enable them on function
return, in particular the comment below seemed to apply to the following
line, which is a bit misleading.

/* Interrupts are enabled again here. */
local_irq_disable();

> 
> 
> ---
>  drivers/cpuidle/cpuidle.c |    2 +-
>  kernel/sched/idle.c       |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -132,6 +132,7 @@ void cpuidle_enter_freeze(void)
>  	index = cpuidle_find_deepest_state(drv, dev, true);
>  	if (index >= 0) {
>  		enter_freeze_proper(drv, dev, index);
> +		local_irq_enable();
>  		return;
>  	}
>  
> @@ -146,7 +147,6 @@ void cpuidle_enter_freeze(void)
>  		arch_cpu_idle();
>  
>  	/* Interrupts are enabled again here. */
> -	local_irq_disable();
>  }
>  
>  /**
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -116,7 +116,6 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (idle_should_freeze()) {
>  		cpuidle_enter_freeze();
> -		local_irq_enable();
>  		goto exit_idle;
>  	}
>  

It looks fine, I will test it. I would add a comment to
cpuidle_enter_freeze() to document it must return with IRQs
enabled.

Thanks,
Lorenzo
