From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Fri, 8 Dec 2006 23:07:05 +0100
Message-ID: <200612082307.07305.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061208112123.GA4957@ucw.cz>
	<200612081249.48218.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612081249.48218.rjw@sisk.pl>
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
To: suspend-devel@lists.sourceforge.net
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 8 December 2006 12:49, Rafael J. Wysocki wrote:
> On Friday, 8 December 2006 12:21, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > > ...after resume.
> > > > > > 
> > > > > > This is because of how signal_wake_up() works, I think..
> > > > > > 
> > > > > > > But I think it is right approach.
> > > > > 
> > > > > Okay, with the appended patch applied everything seems to work and I don't
> > > > > see any undesirable side-effects.
> > > > 
> > > > I promise to try it... tommorow. Looks very good to me.
> > > 
> > > Unfortunately there's one problem with it.
> > 
> > Well, IIRC it still had the 'bash reports vi stopped twice' problem.
> 
> It doesn't do that for me, but ...
> 
> > > To reproduce it I run "gdb /bin/cat", execute "run" in gdb and press ^Z twice
> > > to stop both processes.  Next I suspend and resume and run "fg" to get the gdb
> > > back.and press "Enter" to get the prompt.  Then, it turns out that the
> > > terminal echo doesn't work and "Enter" doesn't make it go to the next line.
> > > I can recover from this state by typing "fg+Enter" (with no echo) so that
> > > /bin/cat gets the continuation signal and it restores the terminal settings,
> > > apparently.
> > 
> > I wonder if we should start a test suite ;-).
> > 
> > > This means, however, that with this patch the behavior of a process (gdb)
> > > after the resume may be different to its normal behavior, which is wrong.
> > 
> > Yep.

Okay, I think I know what to do so that it works.  The above symptoms are not
present with the appended patch.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   12 ++++++------
 kernel/signal.c        |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-08 21:15:18.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-08 21:47:23.000000000 +0100
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
@@ -61,9 +60,12 @@ static inline void freeze_process(struct
 	unsigned long flags;
 
 	if (!freezing(p)) {
+		if (p->state == TASK_STOPPED)
+			force_sig_specific(SIGSTOP, p);
+
 		freeze(p);
 		spin_lock_irqsave(&p->sighand->siglock, flags);
-		signal_wake_up(p, 0);
+		signal_wake_up(p, p->state == TASK_STOPPED);
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
 }
@@ -103,9 +105,7 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
-			if (p->state == TASK_TRACED &&
-			    (frozen(p->parent) ||
-			     p->parent->state == TASK_STOPPED)) {
+			if (p->state == TASK_TRACED && frozen(p->parent)) {
 				cancel_freezing(p);
 				continue;
 			}
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-12-08 21:15:18.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-12-08 21:15:30.000000000 +0100
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
