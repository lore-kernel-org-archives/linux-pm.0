From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 2/6] sched: idle: Do not stop the tick upfront in the idle loop
Date: Thu, 08 Mar 2018 10:05:52 +0100
Message-ID: <2273590.04PyvAHADg@aspire.rjw.lan>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <3346281.BDGJiv2ZOp@aspire.rjw.lan> <20180307233911.GB9367@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307233911.GB9367@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 8, 2018 12:39:12 AM CET Frederic Weisbecker wrote:
> On Tue, Mar 06, 2018 at 10:02:15AM +0100, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -220,13 +220,17 @@ static void do_idle(void)
> >  	 */
> >  
> >  	__current_set_polling();
> > -	tick_nohz_idle_enter();
> > +	tick_nohz_idle_prepare();
> 
> Since we leave tick_nohz_idle_exit() unchanged, can we keep tick_nohz_idle_prepare()
> under the name tick_nohz_idle_enter() so that we stay symetric? And then make xen call
> the two functions:
> 
>     tick_nohz_idle_enter();
>     tick_nohz_idle_go_idle();

No problem with that.

> Also can we rename tick_nohz_idle_go_idle() to tick_nohz_idle_stop_tick() ?
> This will be more self-explanatory.

But it doesn't always stop the tick which is why I chose the other name.
