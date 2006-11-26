From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Sun, 26 Nov 2006 20:45:39 +0100
Message-ID: <20061126194539.GC12535@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl>
	<20061126074740.GB12479@elf.ucw.cz>
	<200611261102.17091.rjw@sisk.pl> <200611261215.14326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611261215.14326.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Okay, I'll use atomic_t.
> 
> Patch with atomic_t follows.
> 
> The atomic_set(..., 0) are used to avoid the (theoretical) situation in which
> freezing might be decreased twice in a row and I've decided to explicitly
> initialize freezing in fork.c for clarity.

Looks okay to me, but I'm not sure if Andrew/someone will not have a
problem with task_struct getting bigger. Can you push this one early
and separately?

								Pavel

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/freezer.h |   10 +++++-----
>  include/linux/sched.h   |    4 +++-
>  kernel/fork.c           |    4 ++++
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6.19-rc6-mm1/include/linux/freezer.h
> ===================================================================
> --- linux-2.6.19-rc6-mm1.orig/include/linux/freezer.h	2006-11-26 11:31:39.000000000 +0100
> +++ linux-2.6.19-rc6-mm1/include/linux/freezer.h	2006-11-26 11:52:29.000000000 +0100
> @@ -14,16 +14,15 @@ static inline int frozen(struct task_str
>   */
>  static inline int freezing(struct task_struct *p)
>  {
> -	return p->flags & PF_FREEZE;
> +	return !!atomic_read(&p->freezing);
>  }
>  
>  /*
>   * Request that a process be frozen
> - * FIXME: SMP problem. We may not modify other process' flags!
>   */
>  static inline void freeze(struct task_struct *p)
>  {
> -	p->flags |= PF_FREEZE;
> +	atomic_inc(&p->freezing);
>  }
>  
>  /*
> @@ -31,7 +30,7 @@ static inline void freeze(struct task_st
>   */
>  static inline void do_not_freeze(struct task_struct *p)
>  {
> -	p->flags &= ~PF_FREEZE;
> +	atomic_set(&p->freezing, 0);
>  }
>  
>  /*
> @@ -52,7 +51,8 @@ static inline int thaw_process(struct ta
>   */
>  static inline void frozen_process(struct task_struct *p)
>  {
> -	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
> +	p->flags |= PF_FROZEN;
> +	atomic_set(&p->freezing, 0);
>  }
>  
>  extern void refrigerator(void);
> Index: linux-2.6.19-rc6-mm1/include/linux/sched.h
> ===================================================================
> --- linux-2.6.19-rc6-mm1.orig/include/linux/sched.h	2006-11-26 11:31:39.000000000 +0100
> +++ linux-2.6.19-rc6-mm1/include/linux/sched.h	2006-11-26 11:33:29.000000000 +0100
> @@ -1065,6 +1065,9 @@ struct task_struct {
>  #ifdef	CONFIG_TASK_DELAY_ACCT
>  	struct task_delay_info *delays;
>  #endif
> +#ifdef CONFIG_PM
> +	atomic_t freezing;	/* if set, we should be freezing for suspend */
> +#endif
>  #ifdef CONFIG_FAULT_INJECTION
>  	int make_it_fail;
>  #endif
> @@ -1161,7 +1164,6 @@ static inline void put_task_struct(struc
>  #define PF_MEMALLOC	0x00000800	/* Allocating memory */
>  #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
>  #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
> -#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
>  #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
>  #define PF_FROZEN	0x00010000	/* frozen for system suspend */
>  #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
> Index: linux-2.6.19-rc6-mm1/kernel/fork.c
> ===================================================================
> --- linux-2.6.19-rc6-mm1.orig/kernel/fork.c	2006-11-25 21:26:52.000000000 +0100
> +++ linux-2.6.19-rc6-mm1/kernel/fork.c	2006-11-26 11:45:00.000000000 +0100
> @@ -1097,6 +1097,10 @@ static struct task_struct *copy_process(
>  	p->blocked_on = NULL; /* not blocked yet */
>  #endif
>  
> +#ifdef CONFIG_PM
> +	atomic_set(&p->freezing, 0);
> +#endif
> +
>  	p->tgid = p->pid;
>  	if (clone_flags & CLONE_THREAD)
>  		p->tgid = current->tgid;
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
