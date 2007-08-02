From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 2/3] Freezer: Use wait queue instead of busy
	looping (updated)
Date: Thu, 2 Aug 2007 19:38:36 +0200
Message-ID: <200708021938.37547.rjw__43658.0523536124$1186075825$gmane$org@sisk.pl>
References: <200708012328.23939.rjw@sisk.pl>
	<20070801164831.ed40546d.akpm@linux-foundation.org>
	<200708021315.18851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708021315.18851.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Thursday, 2 August 2007 13:15, Rafael J. Wysocki wrote:
> On Thursday, 2 August 2007 01:48, Andrew Morton wrote:
> > On Wed, 1 Aug 2007 23:32:48 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >=20
> > > +/*
> > > + * Used to notify try_to_freeze_tasks() that the refrigerator has =
been entered
> > > + * by a task.
> > > + */
> > > +static int refrigerator_called;
> >=20
> > this is rather icky.
>=20
> Well, the alternative would be to open code something like wait_event_t=
imeout.

Still, having considered this for a while, I think it may be a good idea =
to
actually try this.

<modifies the patch, tests>

OK, here it goes (I hope I didn't messed up anything).  Please replace th=
e
previous version with this patch if you prefer it. :-)

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

Use the observation that try_to_freeze_tasks() need not loop while waitin=
g for
the freezing tasks to enter the refrigerator and make it use a wait queue.

The idea is that after sending freeze requests to the tasks regarded as
freezable try_to_freeze_tasks() can go to sleep and wait until at least o=
ne task
enters the refrigerator. =A0The first task that does it wakes up
try_to_freeze_tasks() and the procedure is repeated. =A0If the refrigerat=
or is not
entered by any tasks before TIMEOUT expires, the freezing of tasks fails.

This way, try_to_freeze_tasks() doesn't occupy the CPU unnecessarily when=
 some
freezing tasks are waiting for I/O to complete.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc1-mm2/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc1-mm2.orig/kernel/power/process.c
+++ linux-2.6.23-rc1-mm2/kernel/power/process.c
@@ -19,6 +19,12 @@
  */
 #define TIMEOUT	(20 * HZ)
=20
+/*
+ * Time to wait until one or more tasks enter the refrigerator after sen=
ding
+ * freeze requests to them.
+ */
+#define WAIT_TIME (HZ / 5)
+
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
=20
@@ -43,6 +49,12 @@ static inline void frozen_process(void)
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
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
@@ -58,6 +70,9 @@ void refrigerator(void)
 		task_unlock(current);
 		return;
 	}
+
+	wake_up(&refrigerator_waitq);
+
 	save =3D current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
=20
@@ -171,6 +186,10 @@ static int try_to_freeze_tasks(int freez
=20
 	end_time =3D jiffies + TIMEOUT;
 	do {
+		DEFINE_WAIT(wait);
+
+		add_wait_queue(&refrigerator_waitq, &wait);
+
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
@@ -189,7 +208,12 @@ static int try_to_freeze_tasks(int freez
 				todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (todo && !list_empty_careful(&wait.task_list))
+			schedule_timeout(WAIT_TIME);
+		finish_wait(&refrigerator_waitq, &wait);
+
 		if (time_after(jiffies, end_time))
 			break;
 	} while (todo);
