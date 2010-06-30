From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] cpuidle: avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu) v4
Date: Wed, 30 Jun 2010 12:58:53 -0700
Message-ID: <20100630125853.245e6b99.akpm__33161.9394514293$1277927989$gmane$org@linux-foundation.org>
References: <20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
	<20100617062950.GA3979@swordfish>
	<1277476773.32034.639.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277476773.32034.639.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Thomas@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jun 2010 16:39:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, 2010-06-17 at 09:29 +0300, Sergey Senozhatsky wrote:
> > Fix
> >    
> >  BUG: using smp_processor_id() in preemptible [00000000] code: s2disk/3392
> 
> > The initial fix was to use get_cpu/put_cpu in nr_iowait_cpu.  However,
> > Arjan stated that "the bug is that it needs to be nr_iowait_cpu(int cpu)".
> > 
> > This patch introduces nr_iowait_cpu(int cpu) and changes to its callers.
> > 
> > Arjan also pointed out that we can't use get_cpu/put_cpu in update_ts_time_stats
> > since we "pick the current cpu, rather than the one denoted by ts" in that case.
> > To match given *ts and cpu denoted by *ts we use new field in the struct tick_sched: int cpu.
> 
> 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index b232ccc..db14691 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -51,6 +51,7 @@ struct tick_sched {
> >  	unsigned long			check_clocks;
> >  	enum tick_nohz_mode		nohz_mode;
> >  	ktime_t				idle_tick;
> > +	int				cpu;
> >  	int				inidle;
> >  	int				tick_stopped;
> >  	unsigned long			idle_jiffies;
> 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 1d7b9bc..1907037 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -38,6 +38,9 @@ static ktime_t last_jiffies_update;
> >  
> >  struct tick_sched *tick_get_tick_sched(int cpu)
> >  {
> > +	/*FIXME: Arjan van de Ven:
> > +	 can we do this bit once, when the ts structure gets initialized?*/
> > +	per_cpu(tick_cpu_sched, cpu).cpu = cpu;
> >  	return &per_cpu(tick_cpu_sched, cpu);
> >  }
> 
> > @@ -161,7 +164,7 @@ update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_time)
> >  	if (ts->idle_active) {
> >  		delta = ktime_sub(now, ts->idle_entrytime);
> >  		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
> > -		if (nr_iowait_cpu() > 0)
> > +		if (nr_iowait_cpu(ts->cpu) > 0)
> >  			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
> >  		ts->idle_entrytime = now;
> >  	}
> 
> 
> This all seems extremely silly, why not something like:

Does it work?

c'mon guys, it's taking us weeks and weeks to fix one simple bug.  It's
a regression!  We should be in panic mode.
