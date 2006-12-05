From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Wed, 6 Dec 2006 00:08:50 +0100
Message-ID: <200612060008.51373.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061205223634.GA2642@elf.ucw.cz>
	<200612052345.28882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612052345.28882.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 5 December 2006 23:45, Rafael J. Wysocki wrote:
> On Tuesday, 5 December 2006 23:36, Pavel Machek wrote:
> > Hi!
> > 
> > > ... and it fails to freeze processes if there's a stopped task (to verify,
> > > run vi, press ^Z, and try to suspend).
> > 
> > Ok, here's better version. (Notice it only differs by one bit ;-).
> > 
> > Ok, something is still weird. Bash reports spurious...
> > 
> > [2]+  Stopped                 vi
> > 
> > ...after resume.
> 
> This is because of how signal_wake_up() works, I think..
> 
> > But I think it is right approach.

Okay, with the appended patch applied everything seems to work and I don't
see any undesirable side-effects.

Greetings,
Rafael


 kernel/power/process.c |    8 +++++---
 kernel/signal.c        |    4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-05 21:10:00.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-06 00:14:21.000000000 +0100
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
@@ -63,7 +62,10 @@ static inline void freeze_process(struct
 	if (!freezing(p)) {
 		freeze(p);
 		spin_lock_irqsave(&p->sighand->siglock, flags);
-		signal_wake_up(p, 0);
+		set_tsk_thread_flag(p, TIF_SIGPENDING);
+		if (!wake_up_state(p, TASK_INTERRUPTIBLE | TASK_STOPPED))
+			kick_process(p);
+
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
 }
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
