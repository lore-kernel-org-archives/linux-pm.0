From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/7] sched, preempt: Fixup missed PREEMPT_NEED_RESCHED
 folding
Date: Thu, 21 Nov 2013 09:25:28 +0100
Message-ID: <20131121082528.GV10022@twins.programming.kicks-ass.net>
References: <20131120160450.072555619@infradead.org>
 <20131120162736.446984500@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40373 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3KUIZf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 03:25:35 -0500
Content-Disposition: inline
In-Reply-To: <20131120162736.446984500@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Nov 20, 2013 at 05:04:52PM +0100, Peter Zijlstra wrote:
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -105,14 +105,14 @@ static void cpu_idle_loop(void)
>  				__current_set_polling();
>  			}
>  			arch_cpu_idle_exit();
> -			/*
> -			 * We need to test and propagate the TIF_NEED_RESCHED
> -			 * bit here because we might not have send the
> -			 * reschedule IPI to idle tasks.
> -			 */
> -			if (tif_need_resched())
> -				set_preempt_need_resched();
>  		}


		/*
		 * Ensure our read doesn't slip before the read that
		 * terminates the loop above; in that situation we might
		 * actually fail to observe the TIF_NEED_RESCHED we
		 * _know_ must be set here.
		 */

		smp_rmb(); /* pairs with resched_task() */

> +
> +		/*
> +		 * We need to test and propagate the TIF_NEED_RESCHED bit here
> +		 * because we might not have send the reschedule IPI to idle
> +		 * tasks.
> +		 */
> +		preempt_fold_need_resched();
>  		tick_nohz_idle_exit();
>  		schedule_preempt_disabled();
>  	}
