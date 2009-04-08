From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [RFC][PATCH] Add late pm notifiers for hibernate
Date: Wed, 08 Apr 2009 17:37:57 +0200
Message-ID: <1239205077.4241.15.camel__19359.818849671$1239205349$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: schwidefsky@de.ibm.com, ubraun@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Michael Holzheu <holzheu at linux.vnet.ibm.com>

This patch is a suggestion to solve the issue reported by Ursula Braun:
https://lists.linux-foundation.org/pipermail/linux-pm/2009-March/020443.html

On s390 we have device drivers that don't belong to a Linux bus. Therefore
we can't use the PM device callbacks (dev_pm_ops). The only way to get
informed that we hibernate or resume is the pm_notifier_call_chain.
Unfortunately some of our drivers need a frozen userspace to do their
hibernate actions and the current notifiers are called before userspace is
frozen. Another point is that we want our console driver to suspend as late
as possible so that we can see all the hibernate progress messages on the
console.

This patch introduces the following new events for the pm_notifier:
* PM_HIBERNATION_PREPARE_FROZEN: Going to hibernate. Processes are frozen.
* PM_POST_HIBERNATION_FROZEN:    Hibernation finished. Processes are frozen.
* PM_RESTORE_PREPARE_FROZEN:     Going to restore a saved image. Processes are
                                 frozen.
* PM_POST_RESTORE_FROZEN:        Restore failed. Processes are frozen.

Signed-off-by: Michael Holzheu <holzheu at linux.vnet.ibm.com>
---
 include/linux/notifier.h |    8 ++++++++
 kernel/power/disk.c      |   34 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

Index: git-linux-2.6-defconfig/include/linux/notifier.h
===================================================================
--- git-linux-2.6-defconfig.orig/include/linux/notifier.h
+++ git-linux-2.6-defconfig/include/linux/notifier.h
@@ -245,6 +245,14 @@ static inline int notifier_to_errno(int 
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
+#define PM_HIBERNATION_PREPARE_FROZEN	0x0007 /* Going to hibernate. Processes
+						* are frozen. */
+#define PM_POST_HIBERNATION_FROZEN	0x0008 /* Hibernation finished.
+						* Processes are frozen. */
+#define PM_RESTORE_PREPARE_FROZEN	0x0009 /* Going to restore a saved
+						* image. Processes are frozen.*/
+#define PM_POST_RESTORE_FROZEN		0x0010 /* Restore failed. Processes are
+						* frozen. */
 
 /* Console keyboard events.
  * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
Index: git-linux-2.6-defconfig/kernel/power/disk.c
===================================================================
--- git-linux-2.6-defconfig.orig/kernel/power/disk.c
+++ git-linux-2.6-defconfig/kernel/power/disk.c
@@ -309,15 +309,21 @@ int hibernation_snapshot(int platform_mo
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
-	if (error)
-		goto Recover_platform;
-
-	if (hibernation_test(TEST_DEVICES))
-		goto Recover_platform;
+	if (error) {
+		platform_recover(platform_mode);
+		goto Resume_devices;
+	}
+	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE_FROZEN);
+	if (error || hibernation_test(TEST_DEVICES)) {
+		pm_notifier_call_chain(PM_POST_HIBERNATION_FROZEN);
+		platform_recover(platform_mode);
+		goto Resume_devices;
+	}
 
 	error = create_image(platform_mode);
 	/* Control returns here after successful restore */
 
+	pm_notifier_call_chain(PM_POST_HIBERNATION_FROZEN);
  Resume_devices:
 	device_resume(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
@@ -325,10 +331,6 @@ int hibernation_snapshot(int platform_mo
  Close:
 	platform_end(platform_mode);
 	return error;
-
- Recover_platform:
-	platform_recover(platform_mode);
-	goto Resume_devices;
 }
 
 /**
@@ -424,10 +426,16 @@ int hibernation_restore(int platform_mod
 	pm_prepare_console();
 	suspend_console();
 	error = device_suspend(PMSG_QUIESCE);
-	if (!error) {
-		error = resume_target_kernel(platform_mode);
-		device_resume(PMSG_RECOVER);
-	}
+	if (error)
+		goto Resume_console;
+	error = pm_notifier_call_chain(PM_RESTORE_PREPARE_FROZEN);
+	if (error)
+		goto Notifier_call_chain;
+	error = resume_target_kernel(platform_mode);
+	device_resume(PMSG_RECOVER);
+ Notifier_call_chain:
+	pm_notifier_call_chain(PM_POST_RESTORE_FROZEN);
+ Resume_console:
 	resume_console();
 	pm_restore_console();
 	return error;
