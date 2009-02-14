From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/9] PM: Fix suspend_console and resume_console
	to use only one semaphore
Date: Sat, 14 Feb 2009 02:07:24 +0100
Message-ID: <200902140207.25476.rjw__8076.79433278299$1234575623$gmane$org@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Arve Hj=F8nnev=E5g <arve@android.com>

This fixes a race where a thread acquires the console while the
console is suspended, and the console is resumed before this
thread releases it. In this case, the secondary console
semaphore would be left locked, and the primary semaphore would
be released twice. This in turn would cause the console switch
on suspend or resume to hang forever.

Note that suspend_console does not actually lock the console
for clients that use acquire_console_sem, it only locks it for
clients that use try_acquire_console_sem. If we change
suspend_console to fully lock the console, then the kernel
may deadlock on suspend. One client of try_acquire_console_sem
is acquire_console_semaphore_for_printk, which uses it to
prevent printk from using the console while it is suspended.

Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 kernel/printk.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6/kernel/printk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/printk.c
+++ linux-2.6/kernel/printk.c
@@ -73,7 +73,6 @@ EXPORT_SYMBOL(oops_in_progress);
  * driver system.
  */
 static DECLARE_MUTEX(console_sem);
-static DECLARE_MUTEX(secondary_console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);
 =

@@ -891,12 +890,14 @@ void suspend_console(void)
 	printk("Suspending console(s) (use no_console_suspend to debug)\n");
 	acquire_console_sem();
 	console_suspended =3D 1;
+	up(&console_sem);
 }
 =

 void resume_console(void)
 {
 	if (!console_suspend_enabled)
 		return;
+	down(&console_sem);
 	console_suspended =3D 0;
 	release_console_sem();
 }
@@ -912,11 +913,9 @@ void resume_console(void)
 void acquire_console_sem(void)
 {
 	BUG_ON(in_interrupt());
-	if (console_suspended) {
-		down(&secondary_console_sem);
-		return;
-	}
 	down(&console_sem);
+	if (console_suspended)
+		return;
 	console_locked =3D 1;
 	console_may_schedule =3D 1;
 }
@@ -926,6 +925,10 @@ int try_acquire_console_sem(void)
 {
 	if (down_trylock(&console_sem))
 		return -1;
+	if (console_suspended) {
+		up(&console_sem);
+		return -1;
+	}
 	console_locked =3D 1;
 	console_may_schedule =3D 0;
 	return 0;
@@ -979,7 +982,7 @@ void release_console_sem(void)
 	unsigned wake_klogd =3D 0;
 =

 	if (console_suspended) {
-		up(&secondary_console_sem);
+		up(&console_sem);
 		return;
 	}
 =
