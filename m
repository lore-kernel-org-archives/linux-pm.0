From: leo.yan@linaro.org
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Date: Fri, 10 Aug 2018 14:19:17 +0800
Message-ID: <20180810061917.GB11817@leoy-ThinkPad-X240s>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2161372.IsD4PDzmmY@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the tick has been stopped already, but the governor has not asked to
> stop it (which it can do sometimes), the idle loop should invoke
> tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> of this case properly.

IMHO, I don't think this patch is on the right way; from the idle loop
side, it needs to provide sane fundamental supports, for example, it
can stop or restart the tick per idle governor's request.  On the
other hand, the idle governors can decide their own policy for how to
use the tick in idle loop.  This patch seems mixes two things and
finally it's possible to couple the implementation between idle loop
and 'menu' governor for sched tick usage.

I still think my patch to restart the tick is valid :)

Thanks,
Leo Yan

> Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick)
> +		if (stop_tick || tick_nohz_tick_stopped())
>  			tick_nohz_idle_stop_tick();
>  		else
>  			tick_nohz_idle_retain_tick();
> 
