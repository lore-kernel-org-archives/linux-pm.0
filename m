From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] PM / Suspend: Fix ordering of calls in
	suspend error paths
Date: Fri, 2 Jul 2010 00:00:23 +0200
Message-ID: <201007020000.23790.rjw__14144.7596405216$1278021786$gmane$org@sisk.pl>
References: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007012356.44690.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI suspend code calls suspend_nvs_free() at a wrong place,
which may lead to a memory leak if there's an error executing
acpi_pm_prepare(), because acpi_pm_finish() will not be called in
that case.  However, the root cause of this problem is the
apparently confusing ordering of calls in suspend error paths that
needs to be fixed.

In addition to that, fix a typo in a label name in suspend.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |   10 ++++++----
 kernel/power/suspend.c  |    9 ++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -61,14 +61,15 @@ typedef int __bitwise suspend_state_t;
  *	before device drivers' late suspend callbacks are executed.  It returns
  *	0 on success or a negative error code otherwise, in which case the
  *	system cannot enter the desired sleep state (@prepare_late(), @enter(),
- *	@wake(), and @finish() will not be called in that case).
+ *	and @wake() will not be called in that case).
  *
  * @prepare_late: Finish preparing the platform for entering the system sleep
  *	state indicated by @begin().
  *	@prepare_late is called before disabling nonboot CPUs and after
  *	device drivers' late suspend callbacks have been executed.  It returns
  *	0 on success or a negative error code otherwise, in which case the
- *	system cannot enter the desired sleep state (@enter() and @wake()).
+ *	system cannot enter the desired sleep state (@enter() will not be
+ *	executed).
  *
  * @enter: Enter the system sleep state indicated by @begin() or represented by
  *	the argument if @begin() is not implemented.
@@ -81,14 +82,15 @@ typedef int __bitwise suspend_state_t;
  *	resume callbacks are executed.
  *	This callback is optional, but should be implemented by the platforms
  *	that implement @prepare_late().  If implemented, it is always called
- *	after @enter(), even if @enter() fails.
+ *	after @prepare_late and @enter(), even if one of them fails.
  *
  * @finish: Finish wake-up of the platform.
  *	@finish is called right prior to calling device drivers' regular suspend
  *	callbacks.
  *	This callback is optional, but should be implemented by the platforms
  *	that implement @prepare().  If implemented, it is always called after
- *	@enter() and @wake(), if implemented, even if any of them fails.
+ *	@enter() and @wake(), even if any of them fails.  It is executed after
+ *	a failing @prepare.
  *
  * @end: Called by the PM core right after resuming devices, to indicate to
  *	the platform that the system has returned to the working state or
Index: linux-2.6/kernel/power/suspend.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend.c
+++ linux-2.6/kernel/power/suspend.c
@@ -145,19 +145,19 @@ static int suspend_enter(suspend_state_t
 	if (suspend_ops->prepare) {
 		error = suspend_ops->prepare();
 		if (error)
-			return error;
+			goto Platform_finish;
 	}
 
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
-		goto Platfrom_finish;
+		goto Platform_finish;
 	}
 
 	if (suspend_ops->prepare_late) {
 		error = suspend_ops->prepare_late();
 		if (error)
-			goto Power_up_devices;
+			goto Platform_wake;
 	}
 
 	if (suspend_test(TEST_PLATFORM))
@@ -189,10 +189,9 @@ static int suspend_enter(suspend_state_t
 	if (suspend_ops->wake)
 		suspend_ops->wake();
 
- Power_up_devices:
 	dpm_resume_noirq(PMSG_RESUME);
 
- Platfrom_finish:
+ Platform_finish:
 	if (suspend_ops->finish)
 		suspend_ops->finish();
 
