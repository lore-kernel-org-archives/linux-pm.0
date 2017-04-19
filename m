From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 09:24:11 +0200
Message-ID: <20170419072411.uxd7spyzgs5oszah@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759291AbdDSHYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:24:16 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> @@ -1689,11 +1708,16 @@ static void run_timer_base(int index, bo
>   */
>  static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>  {
> +	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);

Does this want to be inside the IS_ENABLED() block below? It seems to me
this could generate an unused variable warning for !NO_HZ_COMMON
compiler.

> +
>  	run_timer_base(BASE_LOCAL, false);
>  
>  	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
>  		run_timer_base(BASE_GLOBAL, false);
>  		run_timer_base(BASE_DEF, true);
> +
> +		if (base->nohz_active)
> +			tmigr_handle_remote();
>  	}
>  }
