From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 1/7] time: tick-sched: Reorganize idle tick
 management code
Date: Mon, 5 Mar 2018 11:44:46 +0100
Message-ID: <20180305104446.GN25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <46071692.o1R0bjyNQV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46071692.o1R0bjyNQV@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 04, 2018 at 11:24:00PM +0100, Rafael J. Wysocki wrote:
> +/**
> + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> + *
> + * Called when we start the idle loop.
> + */
> +void tick_nohz_idle_prepare(void)
> +{
> +	__tick_nohz_idle_prepare();
> +
> +	local_irq_enable();
> +}

I really dislike the asymmetry in IRQ state you introduced here.
__tick_nohz_idle_prepare() disables IRQs. Must we do that?
