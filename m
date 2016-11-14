From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] cpuidle: allow setting deepest idle
Date: Mon, 14 Nov 2016 15:58:01 +0100
Message-ID: <20161114145801.GF3142@twins.programming.kicks-ass.net>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1478718312-12847-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbcKNO6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 09:58:01 -0500
Content-Disposition: inline
In-Reply-To: <1478718312-12847-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>

On Wed, Nov 09, 2016 at 11:05:11AM -0800, Jacob Pan wrote:
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -173,6 +173,9 @@ static void cpuidle_idle_call(void)
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev);
>  		call_cpuidle(drv, dev, next_state);
> +	} else if (dev->use_deepest_state) {
> +			next_state = cpuidle_find_deepest_state(drv, dev);
> +			call_cpuidle(drv, dev, next_state);

looks like excessive indenting..

>  	} else {
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
> -- 
> 1.9.1
> 
