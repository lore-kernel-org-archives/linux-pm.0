From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 22:51:24 +0200
Message-ID: <200705032251.25054.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
	<200705031333.37471.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031333.37471.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 22:33, David Brownell wrote:
> On Thursday 03 May 2007, Alan Stern wrote:
> 
> > In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
> > same as a normal non-hibernate poweroff? 
> 
> No.  One of the differences between ACPI S4 (hibernate)
> and S5 (poweroff) states is for example how wakeup behaves.
> Look for example at /proc/acpi/wakeup and see how many
> devices are listed as "can wake from S5" vs from S4 ...
> most systems support some S4 events, not so for S5.
> 
> Another is that S4 can consume more power.
> 
> (Although I believe I noticed a regression there in recent
> kernels ... previously I was able to trigger wakeup from
> hibernation using the RTC, but not with 2.6.21 patches.)

May I ask you to test a patch (appended)?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

In the platform mode of hibernation swsusp calls (indirectly) the function
acpi_pm_finish() in the nonerror resume-during-hibernation code paths, which
is wrong, because this function effectively aborts the power transition and
disables the wake-up capability of devices.  Fix it.

Remove references to the platform functions from the snapshot restore code path
in kernel/power/user.c , since they should not be there.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 kernel/power/disk.c |    1 -
 kernel/power/user.c |   15 +++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c	2007-05-03 12:24:05.000000000 +0200
+++ linux-2.6.21/kernel/power/disk.c	2007-05-03 14:42:26.000000000 +0200
@@ -195,7 +195,6 @@ int hibernate(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
 		pr_debug("PM: writing image.\n");
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-03 12:22:57.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-03 14:40:49.000000000 +0200
@@ -169,7 +169,7 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
+	if (platform_suspend && (!in_suspend || error))
 		platform_finish();
 
 	device_resume();
@@ -179,17 +179,12 @@ static inline int snapshot_suspend(int p
 	return error;
 }
 
-static inline int snapshot_restore(int platform_suspend)
+static inline int snapshot_restore(void)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
@@ -201,12 +196,8 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
 	device_resume();
 	resume_console();
- Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore(data->platform_suspend);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:
