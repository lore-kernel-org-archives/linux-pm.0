From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] Hibernation: Prepare to enter the low power
	state
Date: Sat, 19 May 2007 12:27:46 +0200
Message-ID: <200705191227.47325.rjw__49095.008444465$1179570251$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

During hibernation we call hibernation_ops->prepare() before creating the image,
but then we cancel the power transition by calling hibernation_ops->finish()
before saving it.  Thus prior to calling hibernation_ops->enter() we should let
the platform firmware know that we're going to enter the low power state after
all.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

Index: linux-2.6.22-rc2/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc2.orig/kernel/power/disk.c	2007-05-19 11:25:56.000000000 +0200
+++ linux-2.6.22-rc2/kernel/power/disk.c	2007-05-19 12:09:19.000000000 +0200
@@ -205,12 +205,24 @@ int hibernation_restore(int platform_mod
 
 int hibernation_platform_enter(void)
 {
+	int error;
+
 	if (hibernation_ops) {
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		return hibernation_ops->enter();
+		/*
+		 * We have cancelled the power transition by running
+		 * hibernation_ops->finish() before saving the image, so we
+		 * should let the firmware know that we're going to enter the
+		 * sleep state after all
+		 */
+		error = hibernation_ops->prepare();
+		if (!error) {
+			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+			error = hibernation_ops->enter();
+		}
 	} else {
-		return -ENOSYS;
+		error = -ENOSYS;
 	}
+	return error;
 }
 
 /**
