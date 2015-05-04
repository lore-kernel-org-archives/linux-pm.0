From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched / idle: Move the default idle call code to a
 separate function
Date: Mon, 4 May 2015 16:22:45 +0200
Message-ID: <20150504142245.GL23123@twins.programming.kicks-ass.net>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
 <1607938.mB5HZupMYV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34555 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEDOW5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:22:57 -0400
Content-Disposition: inline
In-Reply-To: <1607938.mB5HZupMYV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, May 04, 2015 at 03:56:24PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the code under the "use_default" label in cpuidle_idle_call()
> into a separate (new) function.
> 
> This just allows the subsequent changes to be more stratightforward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c |   42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -67,6 +67,17 @@ void __weak arch_cpu_idle(void)
>  	local_irq_enable();
>  }
>  
> +static void default_idle_call(void) {

Please put opening brace of function on a new line.

> +	/*
> +	 * We can't use the cpuidle framework, let's use the default idle
> +	 * routine.
> +	 */
> +	if (current_clr_polling_and_test())
> +		local_irq_enable();
> +	else
> +		arch_cpu_idle();
> +}
