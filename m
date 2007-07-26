From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Thu, 26 Jul 2007 14:24:48 +0200
Message-ID: <200707261424.49503.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200707251603.02297.rjw@sisk.pl>
	<20070725142429.GA299@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070725142429.GA299@tv-sign.ru>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 July 2007 16:24, Oleg Nesterov wrote:
> On 07/25, Rafael J. Wysocki wrote:
> >
> > On Wednesday, 25 July 2007 15:29, Oleg Nesterov wrote:
> > > On 07/25, Rafael J. Wysocki wrote:
> > > >
> > > >  void refrigerator(void)
> > > >  {
> > > > @@ -50,6 +73,9 @@ void refrigerator(void)
> > > >  	   processes around? */
> > > >  	long save;
> > > >
> > > > +	refrigerator_called =3D 1;
> > > > +	wake_up(&refrigerator_waitq);
> > > > +
> > >=20
> > > This is a bit racy. Unless I missed something, the task should not =
set
> > > refrigerator_called =3D=3D 1 until it has PF_FROZEN.
> >=20
> > No, it's just to signal that the task has entered the refrigerator, n=
ot that
> > it has actually frozen.
>=20
> Yes, I see.
>=20
> > > Otherwise, try_to_freeze_tasks() can set refrigerator_called =3D=3D=
 0 after
> > > refrigerator() sets it =3D=3D 1, the the main loop notices this unf=
rozen task,
> > > and goes to sleep.
> >=20
> > refrigerator_called is only reset after try_to_freeze_tasks() has fou=
nd it
> > equal to one.  There is only a small window between checking it in
> > wait_event_timeout() and resetting it,
>=20
> Yes.
>=20
> > but then we go to send freeze requests
> > to the remaining tasks and we count 'todo' from the start, so that sh=
ouldn't
> > be a problem.
>=20
> ... and we find the task which is not frozen() yet, but which has alrea=
dy passed
> the "set condition and wakeup", increment todo, and wait for the event.=
 If it was
> the last task, we will sleep until timeout.
>=20
> I agree, this is not fatal and unlikely, but still it is a race. I thin=
k it is
> better to move this code down, after frozen_process().

OK, I see your point.  The updated patch is appended.

> (offtopic: strictly speaking, we don't even need the "refrigerator_call=
ed", we
>  only need the wait_queue_head_t. try_to_freeze_tasks() just adds the "=
current"
>  to wq at the very start of the main loop).

Hmm, yes, I think so.

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

Use the observation that try_to_freeze() need not loop while waiting for =
the
freezing tasks to enter the refrigerator and make it use a wait queue.

The idea is that after sending freeze requests to the tasks regarded as
freezable try_to_freeze() can go to sleep and wait until at least one tas=
k
enters the refrigerator. =A0The first task that does it wakes up try_to_f=
reeze()
and the procedure is repeated. =A0If the refrigerator is not entered by a=
ny tasks
before TIMEOUT expires, try_to_freeze() increases the counter of expired
timeouts and sends freeze requests to the remaining tasks. =A0If the numb=
er of
expired timeouts becomes greater than MAX_WAITS, the freezing of tasks fa=
ils
(the counter of expired timeouts is reset whenever a task enters the
refrigerator).

This way, try_to_freeze() doesn't occupy the CPU unnecessarily when some
freezing tasks are waiting for I/O to complete and we have more fine grai=
ned
control over the freezing procedure.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   71 +++++++++++++++++++++++++++++++++++++++++-=
-------
 1 file changed, 60 insertions(+), 11 deletions(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc1.orig/kernel/power/process.c
+++ linux-2.6.23-rc1/kernel/power/process.c
@@ -13,11 +13,22 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/time.h>
=20
 /*=20
- * Timeout for stopping processes
+ * Time to wait until one or more tasks enter the refrigerator after sen=
ding
+ * freeze requests to them.
  */
-#define TIMEOUT	(20 * HZ)
+#define TIMEOUT (HZ / 5)
+
+/*
+ * Each time after sending freeze requests to tasks the freezer will wai=
t until
+ * some of them enter the refrigerater, but no longer than TIMEOUT.  If =
TIMEOUT
+ * has been exceeded, the freezer increases the number of waits by one a=
nd
+ * repeats.  If the number of waits becomes greater than MAX_WAITS, the
+ * freezing fails.
+ */
+#define MAX_WAITS 5
=20
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
@@ -43,6 +54,18 @@ static inline void frozen_process(void)
 	clear_freeze_flag(current);
 }
=20
+/*
+ * Wait queue head used by try_to_freeze_tasks() to wait for tasks to en=
ter the
+ * refrigerator.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(refrigerator_waitq);
+
+/*
+ * Used to signal try_to_freeze_tasks() that the refrigerator has been e=
ntered
+ * by a task.
+ */
+static int refrigerator_called;
+
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
@@ -58,6 +81,10 @@ void refrigerator(void)
 		task_unlock(current);
 		return;
 	}
+
+	refrigerator_called =3D 1;
+	wake_up(&refrigerator_waitq);
+
 	save =3D current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
=20
@@ -166,10 +193,16 @@ static void cancel_freezing(struct task_
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned long end_time;
-	unsigned int todo;
+	unsigned int todo, waits;
+	unsigned long ret;
+	struct timeval start, end;
+	s64 elapsed_csecs64;
+	unsigned int elapsed_csecs;
+
+	do_gettimeofday(&start);
=20
-	end_time =3D jiffies + TIMEOUT;
+	refrigerator_called =3D 0;
+	waits =3D 0;
 	do {
 		todo =3D 0;
 		read_lock(&tasklist_lock);
@@ -189,11 +222,25 @@ static int try_to_freeze_tasks(int freez
 				todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
-		if (time_after(jiffies, end_time))
-			break;
+
+		if (todo) {
+			ret =3D wait_event_timeout(refrigerator_waitq,
+						refrigerator_called, TIMEOUT);
+			if (!ret) {
+				if (++waits > MAX_WAITS)
+					break;
+			} else {
+				refrigerator_called =3D 0;
+				waits =3D 0;
+			}
+		}
 	} while (todo);
=20
+	do_gettimeofday(&end);
+	elapsed_csecs64 =3D timeval_to_ns(&end) - timeval_to_ns(&start);
+	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
+	elapsed_csecs =3D elapsed_csecs64;
+
 	if (todo) {
 		/* This does not unfreeze processes that are already frozen
 		 * (we have slightly ugly calling convention in that respect,
@@ -201,10 +248,9 @@ static int try_to_freeze_tasks(int freez
 		 * but it cleans up leftover PF_FREEZE requests.
 		 */
 		printk("\n");
-		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
+		printk(KERN_ERR "Freezing of tasks failed after %d.%d seconds "
 				"(%d tasks refusing to freeze):\n",
-				freeze_user_space ? "user space " : "tasks ",
-				TIMEOUT / HZ, todo);
+				elapsed_csecs / 100, elapsed_csecs % 100, todo);
 		show_state();
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
@@ -215,6 +261,9 @@ static int try_to_freeze_tasks(int freez
 			task_unlock(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+	} else {
+		printk("(elapsed %d.%d seconds) ", elapsed_csecs / 100,
+			elapsed_csecs % 100);
 	}
=20
 	return todo ? -EBUSY : 0;
