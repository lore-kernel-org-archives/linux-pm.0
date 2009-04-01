From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v4 RFC PATCH 4/4] timers: logic to move non pinned
	timers
Date: Wed, 1 Apr 2009 17:16:41 +0530
Message-ID: <20090401114641.GF22478__16924.6694226333$1238586912$gmane$org@linux.vnet.ibm.com>
References: <20090401113128.GA22478@linux.vnet.ibm.com>
	<20090401113738.GE22478@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090401113738.GE22478@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: a.p.zijlstra@chello.nl, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, Arun Bharadwaj <arun@linux.vnet.ibm.com>, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-04-01 17:07:38]:

--------snip--------------
> Index: linux.trees.git/include/linux/hrtimer.h
> ===================================================================
> --- linux.trees.git.orig/include/linux/hrtimer.h
> +++ linux.trees.git/include/linux/hrtimer.h
> @@ -22,7 +22,6 @@
>  #include <linux/wait.h>
>  #include <linux/percpu.h>
> 
> -
>  struct hrtimer_clock_base;
>  struct hrtimer_cpu_base;
> 
> @@ -376,6 +375,24 @@ extern ktime_t hrtimer_get_remaining(con
>  extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
> 
>  extern ktime_t hrtimer_get_next_event(void);
> +extern ktime_t hrtimer_get_next_event_on(int cpu);
> +
> +#define TICK_PERIOD_IN_NS	NSEC_PER_SEC / HZ
> +/*
> + * Helper function to check before migrating a hrtimer if it expires
> + * before the next timer interrupt on the target cpu.
> + */
> +static inline int check_hrtimer_latency(struct hrtimer *timer, int cpu)
> +{
> +	unsigned long next_hrtimeout, next_jiffies;
> +	next_jiffies = get_next_timer_interrupt_on(jiffies, cpu);
> +	next_jiffies = next_jiffies * TICK_PERIOD_IN_NS;
> +	next_hrtimeout = hrtimer_get_expires_ns(timer);
> +
> +	if (next_hrtimeout > next_jiffies)
> +		return 1;
> +	return 0;
> +}
>

This function can be greatly simplified.
Here i am getting the next timer interrupt on target_cpu.
The target_cpu is the idle load balancer.
So we can check if the hrtimer expiry is before the next tick
on the ilb or not.
By doing this we can eliminate a lot of extra code, which would
otherwise be needed in the form of helper functions for
get_next_timer_interrupt_on().

After simplification the code would simply look like
static inline int check_hrtimer_latency(struct hrtimer *timer, int cpu)
{
        unsigned long next_hrtimeout, next_jiffies;
        next_jiffies = (jiffies + 1) * TICK_PERIOD_IN_NS;
        next_hrtimeout = hrtimer_get_expires_ns(timer);

        if(.....)
}

--arun

>  /*
>   * A timer is active, when it is enqueued into the rbtree or the callback
> Index: linux.trees.git/include/linux/timer.h
> ===================================================================
> --- linux.trees.git.orig/include/linux/timer.h
> +++ linux.trees.git/include/linux/timer.h
> @@ -184,7 +184,7 @@ extern unsigned long next_timer_interrup
>   * jiffie.
>   */
>  extern unsigned long get_next_timer_interrupt(unsigned long now);
> -
> +extern unsigned long get_next_timer_interrupt_on(unsigned long now, int cpu);
>  /*
>   * Timer-statistics info:
>   */
