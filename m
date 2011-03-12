From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/8] timekeeping: Use syscore_ops instead of
	sysdev class and sysdev
Date: Sat, 12 Mar 2011 22:17:33 +0100
Message-ID: <201103122217.34004.rjw__12715.8249299557$1299965024$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122212.40828.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The timekeeping subsystem uses a sysdev class and a sysdev for
executing timekeeping_suspend() after interrupts have been turned off
on the boot CPU (during system suspend) and for executing
timekeeping_resume() before turning on interrupts on the boot CPU
(during system resume).  However, since both of these functions
ignore their arguments, the entire mechanism may be replaced with a
struct syscore_ops object which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/time/timekeeping.c |   27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

Index: linux-2.6/kernel/time/timekeeping.c
===================================================================
--- linux-2.6.orig/kernel/time/timekeeping.c
+++ linux-2.6/kernel/time/timekeeping.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
@@ -561,13 +561,12 @@ static struct timespec timekeeping_suspe
 
 /**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
- * @dev:	unused
  *
  * This is for the generic clocksource timekeeping.
  * xtime/wall_to_monotonic/jiffies/etc are
  * still managed by arch specific suspend/resume code.
  */
-static int timekeeping_resume(struct sys_device *dev)
+static void timekeeping_resume(void)
 {
 	unsigned long flags;
 	struct timespec ts;
@@ -596,11 +595,9 @@ static int timekeeping_resume(struct sys
 
 	/* Resume hrtimers */
 	hres_timers_resume();
-
-	return 0;
 }
 
-static int timekeeping_suspend(struct sys_device *dev, pm_message_t state)
+static int timekeeping_suspend(void)
 {
 	unsigned long flags;
 
@@ -618,26 +615,18 @@ static int timekeeping_suspend(struct sy
 }
 
 /* sysfs resume/suspend bits for timekeeping */
-static struct sysdev_class timekeeping_sysclass = {
-	.name		= "timekeeping",
+static struct syscore_ops timekeeping_syscore_ops = {
 	.resume		= timekeeping_resume,
 	.suspend	= timekeeping_suspend,
 };
 
-static struct sys_device device_timer = {
-	.id		= 0,
-	.cls		= &timekeeping_sysclass,
-};
-
-static int __init timekeeping_init_device(void)
+static int __init timekeeping_init_ops(void)
 {
-	int error = sysdev_class_register(&timekeeping_sysclass);
-	if (!error)
-		error = sysdev_register(&device_timer);
-	return error;
+	register_syscore_ops(&timekeeping_syscore_ops);
+	return 0;
 }
 
-device_initcall(timekeeping_init_device);
+device_initcall(timekeeping_init_ops);
 
 /*
  * If the error is already larger, we look ahead even further
