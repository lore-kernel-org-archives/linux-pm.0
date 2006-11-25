From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 5/5] PM: Change code ordering in
	main.c
Date: Sat, 25 Nov 2006 22:49:05 +0100
Message-ID: <200611252249.06306.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611252210.58203.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Change the ordering of code in kernel/power/main.c so that device_suspend()
is called before disable_nonboot_cpus() and pm_ops->finish() is called after
enable_nonboot_cpus() and before device_resume().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: linux-2.6.19-rc6-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/power/main.c
+++ linux-2.6.19-rc6-mm1/kernel/power/main.c
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
