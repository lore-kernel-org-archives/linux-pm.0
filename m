From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 2/6] sched: idle: Do not stop the tick
 upfront in the idle loop
Date: Thu, 8 Mar 2018 00:39:12 +0100
Message-ID: <20180307233911.GB9367@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
 <3346281.BDGJiv2ZOp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3346281.BDGJiv2ZOp@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 06, 2018 at 10:02:15AM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -220,13 +220,17 @@ static void do_idle(void)
>  	 */
>  
>  	__current_set_polling();
> -	tick_nohz_idle_enter();
> +	tick_nohz_idle_prepare();

Since we leave tick_nohz_idle_exit() unchanged, can we keep tick_nohz_idle_prepare()
under the name tick_nohz_idle_enter() so that we stay symetric? And then make xen call
the two functions:

    tick_nohz_idle_enter();
    tick_nohz_idle_go_idle();

Also can we rename tick_nohz_idle_go_idle() to tick_nohz_idle_stop_tick() ?
This will be more self-explanatory.

Thanks.
