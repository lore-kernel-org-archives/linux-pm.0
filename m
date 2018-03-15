From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFT][PATCH v4 1/7] time: tick-sched: Reorganize idle tick
 management code
Date: Thu, 15 Mar 2018 18:26:47 +0100
Message-ID: <20180315172643.GA14075@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <2019498.YXfJVQUTuX@aspire.rjw.lan>
 <20180314154934.GA3635@lerouge>
 <20180314172016.GO4064@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314172016.GO4064@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2018 at 06:20:16PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 04:49:39PM +0100, Frederic Weisbecker wrote:
> > On Mon, Mar 12, 2018 at 10:47:41AM +0100, Rafael J. Wysocki wrote:
> 
> > > @@ -136,6 +138,13 @@ static inline u64 get_cpu_idle_time_us(i
> > >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> > >  #endif /* !CONFIG_NO_HZ_COMMON */
> > >  
> > > +static inline void tick_nohz_idle_stop_tick_protected(void)
> > > +{
> > > +	local_irq_disable();
> > > +	tick_nohz_idle_stop_tick();
> > > +	local_irq_enable();
> > > +}
> > 
> > It seems that even if we have CONFIG_NO_HZ_COMMON=n,
> > tick_nohz_idle_stop_tick_protected() will have overhead, right?
> 
> IIRC the only callsite of the _protected thing that remains at the end
> is in the hotplug path. So who cares ;-)

Hey, I see you trying to sneak in overhead out of hatred against the hotplug
code ;-)
