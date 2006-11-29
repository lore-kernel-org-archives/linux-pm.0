From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Thu, 30 Nov 2006 00:55:23 +0100
Message-ID: <20061129235523.GA1952@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl>
	<20061126194824.GD12535@elf.ucw.cz>
	<200611270009.56736.rjw@sisk.pl> <200611290040.37965.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611290040.37965.rjw@sisk.pl>
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

> > > I do not like the counting idea; it should be simpler to just check if
> > > all the processes are still stopped.
> > 
> > I thought about that but didn't invent anything reasonable enough.
> > 
> > > But I'm not sure if this is enough. What if signal is being delivered
> > > on another CPU while freezing, still being delivered while this second
> > > check runs, and then SIGCONT is delivered? 
> > 
> > Hm, is this possible in practice?  I mean, if todo is 0 and nr_stopped doesn't
> > change, then there are no processes that can send the SIGCONT (unless someone
> > creates a kernel thread with PF_NOFREEZE that will do just that).
> > 
> > Anyway, for now I've no idea how to fix this properly.  Will think about it
> > tomorrow.
> 
> As far as this particular problem is concerned, I think there are two possible
> solutions.
> 
> One of them would be do disable the delivery of continuation signals before
> we start freezing processes, but I don't know how to do this exactly so that
> it's not racy.  Also it would be quite intrusive.
> 
> The other one may be something along with the lines of the appended patch.

There has to be a better solution. Stopped tasks are suspended
somewhere in kernel, right? One try_to_freeze() and problem should be
solved, in regular way, and without tricks...?

								Pavel

> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/process.c |   22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
> ===================================================================
> --- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-11-28 22:49:30.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-11-29 00:10:05.000000000 +0100
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
> @@ -103,9 +102,13 @@ static unsigned int try_to_freeze_tasks(
>  			if (frozen(p))
>  				continue;
>  
> +			if (p->state == TASK_STOPPED && freezing(p))
> +				continue;
> +
>  			if (p->state == TASK_TRACED &&
>  			    (frozen(p->parent) ||
> -			     p->parent->state == TASK_STOPPED)) {
> +			     (p->parent->state == TASK_STOPPED &&
> +			      freezing(p->parent)))) {
>  				cancel_freezing(p);
>  				continue;
>  			}
> @@ -185,6 +188,18 @@ int freeze_processes(void)
>  	return 0;
>  }
>  
> +static void release_stopped_tasks(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	read_lock(&tasklist_lock);
> +	do_each_thread(g, p) {
> +		if (p->state == TASK_STOPPED)
> +			cancel_freezing(p);
> +	} while_each_thread(g, p);
> +	read_unlock(&tasklist_lock);
> +}
> +
>  static void thaw_tasks(int thaw_user_space)
>  {
>  	struct task_struct *g, *p;
> @@ -207,6 +222,7 @@ static void thaw_tasks(int thaw_user_spa
>  void thaw_processes(void)
>  {
>  	printk("Restarting tasks ... ");
> +	release_stopped_tasks();
>  	thaw_tasks(FREEZER_KERNEL_THREADS);
>  	thaw_tasks(FREEZER_USER_SPACE);
>  	schedule();
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Suspend-devel mailing list
> Suspend-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/suspend-devel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
