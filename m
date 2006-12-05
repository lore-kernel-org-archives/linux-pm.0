From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] [PATCH -mm 1/2]: PM: Fix handling of
	stopped tasks
Date: Tue, 5 Dec 2006 22:42:26 +0100
Message-ID: <200612052242.26915.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612052203.43977.rjw@sisk.pl>
	<200612052226.10540.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200612052226.10540.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 5 December 2006 22:26, Rafael J. Wysocki wrote:
> On Tuesday, 5 December 2006 22:03, Rafael J. Wysocki wrote:
> > Okay, I have replaced my [1/2] with the patch below ...
> > =

> > On Tuesday, 5 December 2006 11:34, Pavel Machek wrote:
<--snip-->
> =

> Well, now the task that was stopped before the suspend doesn't go to the
> refrigerator when it's received the continuation signal after the resume.
> Good, but is it sufficient?

Well, almost.

Namely, if you suspend with a stopped vi and you look at the dmesg output
after the resume, there will be something like this:

Restarting tasks ... <4> Strange, vi not stopped

which means that thaw_tasks() is confused by the lurking stopped task.  We =
can
fix that by checking if the task in question is not stopped before printing
the message in thaw_tasks() and we get this:

 kernel/power/process.c |   21 ++++++++++++++++++---
 kernel/signal.c        |    4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-05 21:10:00.00=
0000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-05 22:44:45.0000000=
00 +0100
@@ -28,8 +28,7 @@ static inline int freezeable(struct task
 	if ((p =3D=3D current) || =

 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state =3D=3D EXIT_ZOMBIE) ||
-	    (p->exit_state =3D=3D EXIT_DEAD) ||
-	    (p->state =3D=3D TASK_STOPPED))
+	    (p->exit_state =3D=3D EXIT_DEAD))
 		return 0;
 	return 1;
 }
@@ -103,6 +102,9 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 =

+			if (p->state =3D=3D TASK_STOPPED && freezing(p))
+				continue;
+
 			if (p->state =3D=3D TASK_TRACED &&
 			    (frozen(p->parent) ||
 			     p->parent->state =3D=3D TASK_STOPPED)) {
@@ -185,6 +187,18 @@ int freeze_processes(void)
 	return 0;
 }
 =

+static inline void release_stopped_tasks(void)
+{
+	struct task_struct *g, *p;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->state =3D=3D TASK_STOPPED && freezing(p))
+			cancel_freezing(p);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
 static void thaw_tasks(int thaw_user_space)
 {
 	struct task_struct *g, *p;
@@ -197,7 +211,7 @@ static void thaw_tasks(int thaw_user_spa
 		if (is_user_space(p) =3D=3D !thaw_user_space)
 			continue;
 =

-		if (!thaw_process(p))
+		if (!thaw_process(p) && p->state !=3D TASK_STOPPED)
 			printk(KERN_WARNING " Strange, %s not stopped\n",
 				p->comm );
 	} while_each_thread(g, p);
@@ -207,6 +221,7 @@ static void thaw_tasks(int thaw_user_spa
 void thaw_processes(void)
 {
 	printk("Restarting tasks ... ");
+	release_stopped_tasks();
 	thaw_tasks(FREEZER_KERNEL_THREADS);
 	thaw_tasks(FREEZER_USER_SPACE);
 	schedule();
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-12-05 21:10:00.000000000=
 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-12-05 21:11:31.000000000 +0100
@@ -1829,7 +1829,9 @@ finish_stop(int stop_count)
 		read_unlock(&tasklist_lock);
 	}
 =

-	schedule();
+	do {
+		schedule();
+	} while (try_to_freeze());
 	/*
 	 * Now we don't run again until continued.
 	 */

But now it looks almost like my [1/2], doesn't it? ;-)

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
