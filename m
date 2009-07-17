From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
	of frozen	tasks really
Date: Fri, 17 Jul 2009 08:51:17 -0700
Message-ID: <20090717155116.GB5878__35177.0959132866$1247845975$gmane$org@count0.beaverton.ibm.com>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090717122103.225652146@linutronix.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Nathan Lynch <ntl@pobox.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 17, 2009 at 12:25:01PM -0000, Thomas Gleixner wrote:
> commit e3c8ca8336 (sched: do not count frozen tasks toward load) broke
> the nr_uninterruptible accounting on freeze/thaw. On freeze the task
> is excluded from accounting with a check for (task->flags &
> PF_FROZEN), but that flag is cleared before the task is thawed. So
> while we prevent that the freezing task with state
> TASK_UNINTERRUPTIBLE is accounted to nr_uninterruptible we decrement
> nr_uninterruptible on thaw.
> 
> Use a separate flag which is handled by the freezing task itself. Set
> it before calling the scheduler with TASK_UNINTERRUPTIBLE state and
> clear it after we return from frozen state.

I'm sorry, it's not clear to me based on the description what problem is
being fixed. As far as I can see PF_FROZEN is almost exactly the same as
PF_FREEZING. When a task is being frozen TIF_FREEZE is set. Then the task
enters the refrigerator, sets PF_FROZEN, and schedule()s until PF_FROZEN
is no longer set. The original code with extra comments:

static inline void frozen_process(void)
{
        if (!unlikely(current->flags & PF_NOFREEZE)) {
                current->flags |= PF_FROZEN;
                wmb();
        }
        clear_freeze_flag(current);
}

/* Refrigerator is place where frozen processes are stored :-). */
void refrigerator(void)
{
        /* Hmm, should we be allowed to suspend when there are realtime
           processes around? */
        long save;

        task_lock(current);
        if (freezing(current)) {
		/* prevent accounting of that task to load */
                frozen_process();  /* <-- sets PF_FROZEN */
                task_unlock(current);
        } else {
                task_unlock(current);
                return;
        }
        save = current->state;
        pr_debug("%s entered refrigerator\n", current->comm);

        spin_lock_irq(&current->sighand->siglock);
        recalc_sigpending(); /* We sent fake signal, clean it up */
        spin_unlock_irq(&current->sighand->siglock);

	/* you set PF_FREEZING here */
        for (;;) {
                set_current_state(TASK_UNINTERRUPTIBLE);
                if (!frozen(current))  /* <-- checks PF_FROZEN */
                        break;
                schedule();
        }
	/* you clear PF_FREEZING here */
        pr_debug("%s left refrigerator\n", current->comm);
        __set_current_state(save);
}

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nathan Lynch <ntl@pobox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nigel Cunningham <nigel@tuxonice.net>
> Cc: <stable@kernel.org>
> Cc: containers@lists.linux-foundation.org
> Cc: linux-pm@lists.linux-foundation.org
> Cc: Matt Helsley <matthltc@us.ibm.com>
> 
> ---
>  include/linux/sched.h |    3 ++-
>  kernel/freezer.c      |    7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/sched.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched.h
> +++ linux-2.6/include/linux/sched.h
> @@ -209,7 +209,7 @@ extern unsigned long long time_sync_thre
>  			((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
>  #define task_contributes_to_load(task)	\
>  				((task->state & TASK_UNINTERRUPTIBLE) != 0 && \
> -				 (task->flags & PF_FROZEN) == 0)
> +				 (task->flags & PF_FREEZING) == 0)
> 
>  #define __set_task_state(tsk, state_value)		\
>  	do { (tsk)->state = (state_value); } while (0)
> @@ -1680,6 +1680,7 @@ extern cputime_t task_gtime(struct task_
>  #define PF_MEMALLOC	0x00000800	/* Allocating memory */
>  #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
>  #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
> +#define PF_FREEZING	0x00004000	/* freeze in progress. do not account to load */
>  #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
>  #define PF_FROZEN	0x00010000	/* frozen for system suspend */
>  #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
> Index: linux-2.6/kernel/freezer.c
> ===================================================================
> --- linux-2.6.orig/kernel/freezer.c
> +++ linux-2.6/kernel/freezer.c
> @@ -44,12 +44,19 @@ void refrigerator(void)
>  	recalc_sigpending(); /* We sent fake signal, clean it up */
>  	spin_unlock_irq(&current->sighand->siglock);
> 
> +	/* prevent accounting of that task to load */
> +	current->flags |= PF_FREEZING;
> +
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		if (!frozen(current))
>  			break;
>  		schedule();
>  	}
> +
> +	/* Remove the accounting blocker */
> +	current->flags &= ~PF_FREEZING;
> +

Hence PF_FREEZING covers slightly less time than PF_FROZEN but
otherwise does not change the way nr_uninterruptible is incremented or
decremented (in (de)activate_task()).

So it's not clear to me how adding PF_FREEZING fixes anything. Am I
missing something?

Cheers,
	-Matt Helsley
