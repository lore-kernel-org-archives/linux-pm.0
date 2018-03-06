From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before stopping the tick
Date: Tue, 06 Mar 2018 09:18:04 +0100
Message-ID: <2173697.qZXBTo6fPi@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2048240.1dZKXsSxFh@aspire.rjw.lan> <1520292421.6857.22.camel@surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520292421.6857.22.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 6, 2018 12:27:01 AM CET Rik van Riel wrote:
> On Sun, 2018-03-04 at 23:28 +0100, Rafael J. Wysocki wrote:
> > 
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
> >  	} else {
> >  		unsigned int duration_us;
> >  
> > -		tick_nohz_idle_go_idle(true);
> > -		rcu_idle_enter();
> > -
> >  		/*
> >  		 * Ask the cpuidle framework to choose a convenient
> > idle state.
> >  		 */
> >  		next_state = cpuidle_select(drv, dev, &duration_us);
> > +
> > +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC /
> > HZ);
> > +		rcu_idle_enter();
> > +
> >  		entered_state = call_cpuidle(drv, dev, next_state);
> 
> When the expected idle period is short enough
> that the timer is not stopped, does it make
> sense to still call rcu_idle_enter?
> 
> Should rcu_idle_enter also be conditional on
> the expected idle period?

Well, that would be the next step. :-)
