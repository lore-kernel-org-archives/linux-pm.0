From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: New suspicious RCU usage in 4.2.0-rc1 plus patch
Date: Wed, 8 Jul 2015 21:36:14 -0700
Message-ID: <20150709043614.GX3717@linux.vnet.ibm.com>
References: <2195797.u9FVj8R87o@vostro.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:44608 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbGIEgV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 00:36:21 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 8 Jul 2015 22:36:21 -0600
Content-Disposition: inline
In-Reply-To: <2195797.u9FVj8R87o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steven Rostedt <srostedt@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Jul 09, 2015 at 02:50:25AM +0200, Rafael J. Wysocki wrote:
> Hi Paul,
> 
> Something seems to have changed in RCU in 4.2-rc1, as it is now complaining
> about a tracepoint in tick_freeze() like this:
> 
> [   66.340508] ===============================
> [   66.340509] [ INFO: suspicious RCU usage. ]
> [   66.340512] 4.2.0-rc1+ #1691 Not tainted
> [   66.340513] -------------------------------
> [   66.340515] /scratch/rafael/work/linux-pm/include/trace/events/power.h:193 suspicious rcu_dereference_check() usage!
> [   66.340517] 
> other info that might help us debug this:
> 
> [   66.340519] 
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 1, debug_locks = 0
> [   66.340520] RCU used illegally from extended quiescent state!
> [   66.340522] 1 lock held by swapper/0/0:
> [   66.340538]  #0:  (tick_freeze_lock){......}, at: [<ffffffff810dcb39>] tick_freeze+0x19/0x230
> [   66.340539] 
> stack backtrace:
> [   66.340543] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc1+ #1691
> [   66.340544] Hardware name: TOSHIBA PORTEGE R500/Portable PC, BIOS Version 1.60 03/04/2008
> [   66.340550]  0000000000000001 ffffffff81c03e48 ffffffff817ab99d 0000000000000004
> [   66.340555]  ffffffff81c10500 ffffffff81c03e78 ffffffff810a2dd7 0000000000000003
> [   66.340560]  0000000000000000 ffffffff81a6b2c7 ffffffffa00b3090 ffffffff81c03ea8
> [   66.340561] Call Trace:
> [   66.340567]  [<ffffffff817ab99d>] dump_stack+0x4f/0x7b
> [   66.340573]  [<ffffffff810a2dd7>] lockdep_rcu_suspicious+0xe7/0x120
> [   66.340577]  [<ffffffff810dcca8>] tick_freeze+0x188/0x230
> [   66.340582]  [<ffffffff816357a0>] cpuidle_enter_freeze+0x30/0x80
> [   66.340586]  [<ffffffff8109a495>] cpu_startup_entry+0x455/0x490
> [   66.340591]  [<ffffffff8179e882>] rest_init+0x132/0x140
> [   66.340595]  [<ffffffff8179e750>] ? csum_partial_copy_generic+0x170/0x170
> [   66.340601]  [<ffffffff81d14049>] start_kernel+0x484/0x491
> [   66.340604]  [<ffffffff81d139aa>] ? set_init_arg+0x58/0x58
> [   66.340608]  [<ffffffff81d135ad>] x86_64_start_reservations+0x2a/0x2c
> [   66.340611]  [<ffffffff81d13696>] x86_64_start_kernel+0xe7/0xeb
> 
> It didn't complained about it before, AFAICS, but in any case the simplest
> way to deal with it seems to be to put tick_freeze() under RCU_NONIDLE()
> like in the patch below.

The above warning won't show up unless you have lockdep enabled, so
maybe that is what changed?  (Recent RCU changes could expose additional
uses of RCU from offline CPUs, but shouldn't be any change from idle
CPUs.  Famous last words!)

> I wonder what you think about it?

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Thanks,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpuidle / s2i: Prevent RCU from complaining about tick_freeze()
> 
> Put tick_freeze() under RCU_NONIDLE() to prevent RCU from complaining
> about suspicious RCU usage in idle by trace_suspend_resume() called
> from there.
> 
> While at it, fix a comment related to another usage of RCU_NONIDLE()
> in enter_freeze_proper().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -112,7 +112,12 @@ int cpuidle_find_deepest_state(struct cp
>  static void enter_freeze_proper(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev, int index)
>  {
> -	tick_freeze();
> +	/*
> +	 * trace_suspend_resume() called by tick_freeze() for the last CPU
> +	 * executing it contains RCU usage regarded as invalid in the idle
> +	 * context, so tell RCU about that.
> +	 */
> +	RCU_NONIDLE(tick_freeze());
>  	/*
>  	 * The state used here cannot be a "coupled" one, because the "coupled"
>  	 * cpuidle mechanism enables interrupts and doing that with timekeeping
> @@ -122,7 +127,7 @@ static void enter_freeze_proper(struct c
>  	WARN_ON(!irqs_disabled());
>  	/*
>  	 * timekeeping_resume() that will be called by tick_unfreeze() for the
> -	 * last CPU executing it calls functions containing RCU read-side
> +	 * first CPU executing it calls functions containing RCU read-side
>  	 * critical sections, so tell RCU about that.
>  	 */
>  	RCU_NONIDLE(tick_unfreeze());
> 

