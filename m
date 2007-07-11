From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 6/7] Freezer: Be more verbose
Date: Thu, 12 Jul 2007 00:16:00 +0200
Message-ID: <200707120016.01454.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120006.50095.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Increase the freezer's verbosity a bit, so that it's easier to read problem
reports related to it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/process.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c	2007-07-11 20:51:48.000000000 +0200
+++ linux-2.6.22-rc6-mm1/kernel/power/process.c	2007-07-11 20:52:07.000000000 +0200
@@ -225,20 +225,23 @@ static int try_to_freeze_tasks(int freez
  */
 int freeze_processes(void)
 {
-	int error;
+	int error = 0;
 
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
