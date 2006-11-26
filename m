From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Sun, 26 Nov 2006 20:48:24 +0100
Message-ID: <20061126194824.GD12535@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl> <200611261102.17091.rjw@sisk.pl>
	<200611261215.14326.rjw@sisk.pl> <200611261434.18427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611261434.18427.rjw@sisk.pl>
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

> Index: linux-2.6.19-rc6-mm1/kernel/power/process.c
> ===================================================================
> --- linux-2.6.19-rc6-mm1.orig/kernel/power/process.c	2006-11-25 21:26:52.000000000 +0100
> +++ linux-2.6.19-rc6-mm1/kernel/power/process.c	2006-11-26 14:17:11.000000000 +0100
> @@ -28,8 +28,7 @@ static inline int freezeable(struct task
>  	if ((p == current) || 
>  	    (p->flags & PF_NOFREEZE) ||
>  	    (p->exit_state == EXIT_ZOMBIE) ||
> -	    (p->exit_state == EXIT_DEAD) ||
> -	    (p->state == TASK_STOPPED))
> +	    (p->exit_state == EXIT_DEAD))
>  		return 0;
>  	return 1;
>  }
> @@ -61,10 +60,13 @@ static inline void freeze_process(struct
>  	unsigned long flags;
>  
>  	if (!freezing(p)) {
> -		freeze(p);
> -		spin_lock_irqsave(&p->sighand->siglock, flags);
> -		signal_wake_up(p, 0);
> -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +		rmb();

If frozen is atomic_t, do we need memory barrier?

> +		if (!frozen(p)) {
> +			freeze(p);
> +			spin_lock_irqsave(&p->sighand->siglock, flags);
> +			signal_wake_up(p, 0);
> +			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +		}
>  	}
>  }
>  
> @@ -90,11 +92,12 @@ static unsigned int try_to_freeze_tasks(
>  {
>  	struct task_struct *g, *p;
>  	unsigned long end_time;
> -	unsigned int todo;
> +	unsigned int todo, nr_stopped;
>  
>  	end_time = jiffies + TIMEOUT;
>  	do {
>  		todo = 0;
> +		nr_stopped = 0;
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			if (!freezeable(p))
> @@ -103,6 +106,10 @@ static unsigned int try_to_freeze_tasks(
>  			if (frozen(p))
>  				continue;
>  
> +			if (p->state == TASK_STOPPED) {
> +				nr_stopped++;
> +				continue;
> +			}
>  			if (p->state == TASK_TRACED &&
>  			    (frozen(p->parent) ||
>  			     p->parent->state == TASK_STOPPED)) {
> @@ -128,6 +135,21 @@ static unsigned int try_to_freeze_tasks(
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
>  		yield();			/* Yield is okay here */
> +		if (!todo) {
> +			/* Make sure that none of the stopped processes has
> +			 * received the continuation signal after we checked
> +			 * last time.
> +			 */

I do not like the counting idea; it should be simpler to just check if
all the processes are still stopped.

But I'm not sure if this is enough. What if signal is being delivered
on another CPU while freezing, still being delivered while this second
check runs, and then SIGCONT is delivered? 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
