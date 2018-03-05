From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Date: Mon, 5 Mar 2018 12:45:42 +0100
Message-ID: <20180305114542.GP25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2048240.1dZKXsSxFh@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 04, 2018 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
>  	} else {
>  		unsigned int duration_us;
>  
> -		tick_nohz_idle_go_idle(true);
> -		rcu_idle_enter();
> -
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
>  		 */
>  		next_state = cpuidle_select(drv, dev, &duration_us);
> +
> +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC / HZ);
> +		rcu_idle_enter();
> +
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
>  		 * Give the governor an opportunity to reflect on the outcome

So I think this is entirely wrong, I would much rather see something
like:

	tick_nohz_idle_go_idle(next_state->nohz);

Where the selected state itself has the nohz property or not.

We can always insert an extra state at whatever the right boundary point
is for nohz if it doesn't line up with an existing point.
