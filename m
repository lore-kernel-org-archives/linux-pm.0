From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Fri, 17 Feb 2017 01:31:48 +0900
Message-ID: <20170216163148.GA22354@tigerII.localdomain>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170215180158.GO21809@atomide.com>
 <20170216013109.GA772@jagdpanzerIV.localdomain>
 <20170216040335.GR21809@atomide.com>
 <20170216042500.GC772@jagdpanzerIV.localdomain>
 <20170216151009.GS21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170216151009.GS21809@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Russell King <rmk@armlinux.org.uk>
List-Id: linux-pm@vger.kernel.org

On (02/16/17 07:10), Tony Lindgren wrote:
[..]
> > > > [..]
> > > > > Below is another issue I noticed caused by commit f975237b7682 that
> > > > > I noticed during booting.
> > > > 
> > > > do you mean that with f975237b7682 you _always_ see that illegal RCU
> > > > usage warning?
> > > 
> > > Yeah on every boot on devices using cpuidle_coupled.
> > 
> > does this mean that with the printk-safe patches reverted
> > (so, basically, the same conditions module 4 printk patches)
> > you don't see illegal RCU usage reports? at the moment I can't
> > see any connection between f975237b7682 and RCU usage from idle CPU.
> 
> Yes reverting those four patches I listed earlier also makes it go
> away.

aha... so, the previous RCU warning was simply suppressed by lockdep_off()
that we used to have in printk().


RCU dereference check

#define __rcu_dereference_check(p, c, space) \
({ \
	/* Dependency order vs. p above. */ \
	typeof(*p) *________p1 = (typeof(*p) *__force)lockless_dereference(p); \
	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
	rcu_dereference_sparse(p, space); \
	((typeof(*p) __force __kernel *)(________p1)); \
})


where RCU_LOCKDEP_WARN() that prints "suspicious rcu_dereference_check() usage"
is


#define RCU_LOCKDEP_WARN(c, s)						\
	do {								\
		static bool __section(.data.unlikely) __warned;		\
		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
			__warned = true;				\
			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
		}							\
	} while (0)



where debug_lockdep_rcu_enabled()

int notrace debug_lockdep_rcu_enabled(void)
{
	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
	       current->lockdep_recursion == 0;
}

depends on lockdep state. and we just used to have
'current->lockdep_recursion != 0' here, because of lockdep_off()
in printk() around console_unlock(), which increments ->lockdep_recursion.

now we have lockdep enabled and the ->lockdep_recursion == 0.


so the RCU warning is valid and I need to Cc stable on that _rcuidle
patch, the tracepoint is pretty old. it's from 3.4

	-ss
