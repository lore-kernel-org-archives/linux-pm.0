From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 1/4] PM: Change code ordering in main.c
Date: Sun, 17 Dec 2006 19:02:32 +0100
Message-ID: <200612171902.32819.rjw@sisk.pl>
References: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612171858.16380.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: pm list <linux-pm@lists.osdl.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Change the ordering of code in kernel/power/main.c so that device_suspend()
is called before disable_nonboot_cpus() and pm_ops->finish() is called after
enable_nonboot_cpus() and before device_resume(), as indicated by recent
discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: linux-2.6.20-rc1/kernel/power/main.c
===================================================================
--- linux-2.6.20-rc1.orig/kernel/power/main.c	2006-12-14 22:35:52.000000000 +0100
+++ linux-2.6.20-rc1/kernel/power/main.c	2006-12-14 23:19:32.000000000 +0100
@@ -43,6 +43,11 @@ void pm_set_ops(struct pm_ops * ops)
 	mutex_unlock(&pm_mutex);
 }
 
+static inline void pm_finish(suspend_state_t state)
+{
+	if (pm_ops->finish)
+		pm_ops->finish(state);
+}
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.
@@ -63,10 +68,6 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
-	error = disable_nonboot_cpus();
-	if (error)
-		goto Enable_cpu;
-
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
@@ -88,18 +89,22 @@ static int suspend_prepare(suspend_state
 	}
 
 	suspend_console();
-	if ((error = device_suspend(PMSG_SUSPEND))) {
+	error = device_suspend(PMSG_SUSPEND);
+	if (error) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
-		goto Finish;
+		goto Resume_devices;
 	}
-	return 0;
- Finish:
-	if (pm_ops->finish)
-		pm_ops->finish(state);
+	error = disable_nonboot_cpus();
+	if (!error)
+		return 0;
+
+	enable_nonboot_cpus();
+ Resume_devices:
+	pm_finish(state);
+	device_resume();
+	resume_console();
  Thaw:
 	thaw_processes();
- Enable_cpu:
-	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
 }
@@ -134,12 +139,11 @@ int suspend_enter(suspend_state_t state)
 
 static void suspend_finish(suspend_state_t state)
 {
+	enable_nonboot_cpus();
+	pm_finish(state);
 	device_resume();
 	resume_console();
 	thaw_processes();
-	enable_nonboot_cpus();
-	if (pm_ops && pm_ops->finish)
-		pm_ops->finish(state);
 	pm_restore_console();
 }
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
