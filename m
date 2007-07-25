From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/2] Freezer: Be more verbose
Date: Wed, 25 Jul 2007 14:03:14 +0200
Message-ID: <200707251403.15078.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707251401.48340.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Increase the freezer's verbosity a bit, so that it's easier to read problem
reports related to it.

This is necessary for the next patch.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>
---
 kernel/power/process.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
===================================================================
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-24 00:13:46.000000000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-24 00:13:58.000000000 +0200
@@ -227,18 +227,21 @@ int freeze_processes(void)
 {
 	int error;
 
-	printk("Stopping tasks ... ");
+	printk("Freezing user space processes ... ");
 	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
 	if (error)
-		return error;
+		goto Exit;
+	printk("done.\n");
 
+	printk("Freezing remaining freezable tasks ... ");
 	error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
 	if (error)
-		return error;
-
-	printk("done.\n");
+		goto Exit;
+	printk("done.");
+ Exit:
 	BUG_ON(in_atomic());
-	return 0;
+	printk("\n");
+	return error;
 }
 
 static void thaw_tasks(int thaw_user_space)
