From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 22:03:43 +0100
Message-ID: <200612052203.43977.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612032350.23067.rjw@sisk.pl>
	<20061205103429.GB5306@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205103429.GB5306@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Okay, I have replaced my [1/2] with the patch below ...

On Tuesday, 5 December 2006 11:34, Pavel Machek wrote:
> Hi!
> 
> > Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
> > considered by the freezer as unfreezeable.  However, there may be a race
> > between the freezer and the delivery of the continuation signal to the task
> > resulting in the task running after we have finished freezing other tasks.
> > This, in turn, may lead to undesirable effects up to and including a
> > corruption of data.
> > 
> > To prevent this from happening we first need to make the freezer consider
> > stopped tasks as freezeable.  For this purpose we need to make freezeable()
> > stop returning 0 for these tasks.  We must remember, however, that the
> > stopped tasks need not receive the continuation signal before thaw_processes()
> > is called, so as soon as PF_FREEZE is set for them try_to_freeze_tasks()
> > should stop counting them as the ones to wait for.  Additionally, if there's a
> > traced task (ie. a task in the TASK_TRACED state) the parent of which has
> > PF_FREEZE set and is stopped, try_to_freeze_tasks() should not wait for it.
> > Moreover, if there are some stopped tasks that haven't received the continuation
> > signal before thaw_processes() is called, we must clear PF_FREEZE for them so
> > that they don't go to the refrigerator when it's no longer desirable.
> 
> Actually, what do you think about this patch? It removes special
> handling of TASK_TRACED, and should do the trick, too...
> 								Pavel
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 7bcc976..d56e494 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -26,8 +26,7 @@ static inline int freezeable(struct task
>  	    (p->flags & PF_NOFREEZE) ||
>  	    (p->exit_state == EXIT_ZOMBIE) ||
>  	    (p->exit_state == EXIT_DEAD) ||
> -	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
> -	    (p->state == TASK_STOPPED))
> +	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)))

... with the exception that I haven't added the last line, since there's some
code in try_to_freeze_tasks() that does the same and better ...

>  		return 0;
>  	return 1;
>  }
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9a61944..e305ad1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1702,7 +1702,9 @@ finish_stop(int stop_count)
>  		read_unlock(&tasklist_lock);
>  	}
>  
> -	schedule();
> +	do {
> +		schedule();
> +	} while (try_to_freeze());
>  	/*
>  	 * Now we don't run again until continued.
>  	 */
> 
> 

... and it fails to freeze processes if there's a stopped task (to verify,
run vi, press ^Z, and try to suspend).

It happens because we shouldn't count the stopped task as freezeable any
more after we've set PF_FREEZE for it and we can fix that by adding

	if (p->state == TASK_STOPPED && freezing(p))
		continue;

to the main loop in try_to_freeze_tasks().  Then we obtain the appended patch.

<tests again>

Now the stopped task doesn't prevent us from freezing processes.  So far so
good.  [To be continued.]

Greetings,
Rafael


Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-05 21:10:00.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-05 21:56:57.000000000 +0100
@@ -28,8 +28,7 @@ static inline int freezeable(struct task
 	if ((p == current) || 
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
-	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED))
+	    (p->exit_state == EXIT_DEAD))
 		return 0;
 	return 1;
 }
@@ -103,6 +102,9 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
+			if (p->state == TASK_STOPPED && freezing(p))
+				continue;
+
 			if (p->state == TASK_TRACED &&
 			    (frozen(p->parent) ||
 			     p->parent->state == TASK_STOPPED)) {
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-12-05 21:10:00.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-12-05 21:11:31.000000000 +0100
@@ -1829,7 +1829,9 @@ finish_stop(int stop_count)
 		read_unlock(&tasklist_lock);
 	}
 
-	schedule();
+	do {
+		schedule();
+	} while (try_to_freeze());
 	/*
 	 * Now we don't run again until continued.
 	 */

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
