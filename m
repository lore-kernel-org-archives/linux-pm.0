From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 11:34:29 +0100
Message-ID: <20061205103429.GB5306@elf.ucw.cz>
References: <200612032318.29030.rjw@sisk.pl> <200612032350.23067.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612032350.23067.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
> considered by the freezer as unfreezeable.  However, there may be a race
> between the freezer and the delivery of the continuation signal to the task
> resulting in the task running after we have finished freezing other tasks.
> This, in turn, may lead to undesirable effects up to and including a
> corruption of data.
> 
> To prevent this from happening we first need to make the freezer consider
> stopped tasks as freezeable.  For this purpose we need to make freezeable()
> stop returning 0 for these tasks.  We must remember, however, that the
> stopped tasks need not receive the continuation signal before thaw_processes()
> is called, so as soon as PF_FREEZE is set for them try_to_freeze_tasks()
> should stop counting them as the ones to wait for.  Additionally, if there's a
> traced task (ie. a task in the TASK_TRACED state) the parent of which has
> PF_FREEZE set and is stopped, try_to_freeze_tasks() should not wait for it.
> Moreover, if there are some stopped tasks that haven't received the continuation
> signal before thaw_processes() is called, we must clear PF_FREEZE for them so
> that they don't go to the refrigerator when it's no longer desirable.

Actually, what do you think about this patch? It removes special
handling of TASK_TRACED, and should do the trick, too...
								Pavel

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 7bcc976..d56e494 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -26,8 +26,7 @@ static inline int freezeable(struct task
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
-	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
-	    (p->state == TASK_STOPPED))
+	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)))
 		return 0;
 	return 1;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 9a61944..e305ad1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1702,7 +1702,9 @@ finish_stop(int stop_count)
 		read_unlock(&tasklist_lock);
 	}
 
-	schedule();
+	do {
+		schedule();
+	} while (try_to_freeze());
 	/*
 	 * Now we don't run again until continued.
 	 */


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
