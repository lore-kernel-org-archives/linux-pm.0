From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpuidle: Handle tick_broadcast_enter() failure gracefully
Date: Thu, 07 May 2015 22:50:14 +0200
Message-ID: <1562115.g1s3BW0dJA@vostro.rjw.lan>
References: <20150507174355.25321.85885.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55555 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751158AbbEGUZK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 16:25:10 -0400
In-Reply-To: <20150507174355.25321.85885.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org

On Thursday, May 07, 2015 11:17:21 PM Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only are we not
> aware what the arch cpuidle code does, but we also do not account for
> the idle state residency time and usage of such a CPU.
> 
> This scenario can be handled better by simply asking the cpuidle
> governor to choose an idle state where in ticks do not stop. To
> accommodate this change move the setting of runqueue idle state from the
> core to the cpuidle driver, else the rq->idle_state will be set wrong.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes from V1: https://lkml.org/lkml/2015/5/7/24
> Rebased on the latest linux-pm/bleeding-edge
> 
>  drivers/cpuidle/cpuidle.c          |   21 +++++++++++++++++----
>  drivers/cpuidle/governors/ladder.c |   13 ++++++++++---
>  drivers/cpuidle/governors/menu.c   |    6 +++++-
>  include/linux/cpuidle.h            |    6 +++---
>  include/linux/sched.h              |   16 ++++++++++++++++
>  kernel/sched/core.c                |   17 +++++++++++++++++
>  kernel/sched/fair.c                |    2 +-
>  kernel/sched/idle.c                |    8 +-------
>  kernel/sched/sched.h               |   24 ------------------------
>  9 files changed, 70 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8c24f95..b7e86f4 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/suspend.h>
>  #include <linux/tick.h>
> +#include <linux/sched.h>
>  #include <trace/events/power.h>
>  
>  #include "cpuidle.h"
> @@ -168,10 +169,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>  	 */
>  	if (broadcast && tick_broadcast_enter()) {
> -		default_idle_call();
> -		return -EBUSY;
> +		index = cpuidle_select(drv, dev, !broadcast);

No, you can't do that.

This code path may be used by suspend-to-idle and that should not call
cpuidle_select().

What's needed here seems to be a fallback mechanism like "choose the
deepest state shallower than X and such that it won't stop the tick".
You don't really need to run a full governor for that.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
