From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 3/3] Freezer: Replace the timeout
Date: Wed, 1 Aug 2007 00:29:42 +0200
Message-ID: <200708010029.43652.rjw@sisk.pl>
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

Instead of using the global timeout, we can use a more fine grained metho=
d of
checking if the freezing of tasks should fail.  Namely, we can measure th=
e time
in which no tasks have entered the refrigerator by counting the number of=
 calls
to wait_event_timeout() in try_to_freeze_tasks() that have returned 0 (in=
 a
row).

After sending freeze requests to the tasks regarded as freezable
try_to_freeze_tasks() goes to sleep and waits until at least one task ent=
ers the
refrigerator. =A0If the refrigerator is not entered by any tasks before W=
AIT_TIME
expires, try_to_freeze_tasks() increases the counter of expired timeouts =
and
sends freeze requests to the remaining tasks.  If the number of expired t=
imeouts
becomes greater than MAX_WAITS, the freezing of tasks fails (the counter =
of
expired timeouts is reset whenever a task enters the refrigerator).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-31 23:01:10.0000=
00000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-31 23:12:34.000000000=
 +0200
@@ -14,17 +14,21 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
=20
-/*=20
- * Timeout for stopping processes
- */
-#define TIMEOUT	(20 * HZ)
-
 /*
  * Time to wait until one or more tasks enter the refrigerator after sen=
ding
  * freeze requests to them.
  */
 #define WAIT_TIME (HZ / 5)
=20
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
+
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
=20
@@ -188,16 +192,15 @@ static void cancel_freezing(struct task_
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned long end_time;
-	unsigned int todo;
+	unsigned int todo, waits;
 	struct timeval start, end;
 	s64 elapsed_csecs64;
 	unsigned int elapsed_csecs;
=20
 	do_gettimeofday(&start);
=20
-	end_time =3D jiffies + TIMEOUT;
 	refrigerator_called =3D 0;
+	waits =3D 0;
 	do {
 		todo =3D 0;
 		read_lock(&tasklist_lock);
@@ -223,12 +226,14 @@ static int try_to_freeze_tasks(int freez
=20
 			ret =3D wait_event_timeout(refrigerator_waitq,
 					refrigerator_called, WAIT_TIME);
-			if (ret)
+			if (ret) {
 				refrigerator_called =3D 0;
+				waits =3D 0;
+			} else {
+				if (++waits > MAX_WAITS)
+					break;
+			}
 		}
-
-		if (time_after(jiffies, end_time))
-			break;
 	} while (todo);
=20
 	do_gettimeofday(&end);
