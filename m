From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/3] Freezer: Use wait queue instead of
	busy looping
Date: Wed, 1 Aug 2007 00:26:55 +0200
Message-ID: <200708010026.56427.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <20070731100254.GC3462@elf.ucw.cz>
	<200708010025.27018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708010025.27018.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

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
 kernel/power/process.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-31 21:58:32.0000=
00000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-31 23:00:43.000000000=
 +0200
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
@@ -43,6 +49,18 @@ static inline void frozen_process(void)
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
+ * Used to notify try_to_freeze_tasks() that the refrigerator has been e=
ntered
+ * by a task.
+ */
+static int refrigerator_called;
+
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
@@ -58,6 +76,10 @@ void refrigerator(void)
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
@@ -170,6 +192,7 @@ static int try_to_freeze_tasks(int freez
 	unsigned int todo;
=20
 	end_time =3D jiffies + TIMEOUT;
+	refrigerator_called =3D 0;
 	do {
 		todo =3D 0;
 		read_lock(&tasklist_lock);
@@ -189,7 +212,16 @@ static int try_to_freeze_tasks(int freez
 				todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
+
+		if (todo) {
+			unsigned long ret;
+
+			ret =3D wait_event_timeout(refrigerator_waitq,
+					refrigerator_called, WAIT_TIME);
+			if (ret)
+				refrigerator_called =3D 0;
+		}
+
 		if (time_after(jiffies, end_time))
 			break;
 	} while (todo);
