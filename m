From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/4] swsusp: Fix hibernation code ordering
	(updated)
Date: Sat, 19 May 2007 10:36:57 +0200
Message-ID: <200705191036.58177.rjw__46663.266598671$1179563599$gmane$org@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl> <200705180026.20647.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705180026.20647.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Change the code ordering so that hibernation_ops->prepare() is called after
device_suspend().  This is needed so that we don't violate the ACPI
specification, which states that the _PTS and _GTS system-control methods,
executed from acpi_sleep_prepare(), ought to be called after devices have been
put in low power states.

The "Finish" label in hibernation_restore() is moved, because device_suspend()
resumes devices if the suspending of them fails and the restore code ordering
should reflect the hibernation code ordering.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc1/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc1.orig/kernel/power/disk.c	2007-05-18 23:49:33.000000000 +0200
+++ linux-2.6.22-rc1/kernel/power/disk.c	2007-05-18 23:56:47.000000000 +0200
@@ -133,15 +133,15 @@ int hibernation_snapshot(int platform_mo
 	/* Free memory before shutting down devices. */
 	error = swsusp_shrink_memory();
 	if (error)
-		goto Finish;
-
-	error = platform_prepare(platform_mode);
-	if (error)
-		goto Finish;
+		return error;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
+		goto Resume_console;
+
+	error = platform_prepare(platform_mode);
+	if (error)
 		goto Resume_devices;
 
 	error = disable_nonboot_cpus();
@@ -159,8 +159,8 @@ int hibernation_snapshot(int platform_mo
  Resume_devices:
 	platform_finish(platform_mode);
 	device_resume();
+ Resume_console:
 	resume_console();
- Finish:
 	return error;
 }
 
@@ -191,8 +191,8 @@ int hibernation_restore(int platform_mod
 		enable_nonboot_cpus();
 	}
 	platform_restore_cleanup(platform_mode);
- Finish:
 	device_resume();
+ Finish:
 	resume_console();
 	pm_restore_console();
 	return error;
