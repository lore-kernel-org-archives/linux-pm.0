From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH v2 2/3] xen: use freeze/restore/thaw PM events
	for suspend/resume/chkpt
Date: Tue, 22 Feb 2011 23:03:54 -0800
Message-ID: <1298444634-10865-1-git-send-email-rshriram__18291.5147197948$1298444704$gmane$org@cs.ubc.ca>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

Use PM_FREEZE, PM_THAW and PM_RESTORE power events for
suspend/resume/checkpoint functionality, instead of PM_SUSPEND
and PM_RESUME. Use of these pm events fixes the Xen Guest hangup
when taking checkpoints. When a suspend event is cancelled
(while taking checkpoints once/continuously), we use PM_THAW
instead of PM_RESUME. PM_RESTORE is used when suspend is not
cancelled. See Documentation/power/devices.txt and linux/pm.h
for more info about freeze, thaw and restore. The sequence of
pm events in a suspend-resume scenario is shown below.

        dpm_suspend_start(PMSG_FREEZE);

                dpm_suspend_noirq(PMSG_FREEZE);

                       sysdev_suspend(PMSG_FREEZE);
                       cancelled = suspend_hypercall()
                       sysdev_resume();

               dpm_resume_noirq(cancelled ? PMSG_THAW : PMSG_RESTORE);

       dpm_resume_end(cancelled ? PMSG_THAW : PMSG_RESTORE);

Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
---
 drivers/xen/manage.c                       |   16 ++++++++--------
 drivers/xen/xenbus/xenbus_probe_frontend.c |    8 +++++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index c255ed4..c24d0e7 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -61,7 +61,7 @@ static void xen_post_suspend(int cancelled)
 	xen_mm_unpin_all();
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_XEN_SAVE_RESTORE
 static int xen_suspend(void *data)
 {
 	struct suspend_info *si = data;
@@ -69,7 +69,7 @@ static int xen_suspend(void *data)
 
 	BUG_ON(!irqs_disabled());
 
-	err = sysdev_suspend(PMSG_SUSPEND);
+	err = sysdev_suspend(PMSG_FREEZE);
 	if (err) {
 		printk(KERN_ERR "xen_suspend: sysdev_suspend failed: %d\n",
 			err);
@@ -118,7 +118,7 @@ static void do_suspend(void)
 	}
 #endif
 
-	err = dpm_suspend_start(PMSG_SUSPEND);
+	err = dpm_suspend_start(PMSG_FREEZE);
 	if (err) {
 		printk(KERN_ERR "xen suspend: dpm_suspend_start %d\n", err);
 		goto out_thaw;
@@ -127,7 +127,7 @@ static void do_suspend(void)
 	printk(KERN_DEBUG "suspending xenstore...\n");
 	xs_suspend();
 
-	err = dpm_suspend_noirq(PMSG_SUSPEND);
+	err = dpm_suspend_noirq(PMSG_FREEZE);
 	if (err) {
 		printk(KERN_ERR "dpm_suspend_noirq failed: %d\n", err);
 		goto out_resume;
@@ -147,7 +147,7 @@ static void do_suspend(void)
 
 	err = stop_machine(xen_suspend, &si, cpumask_of(0));
 
-	dpm_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 	if (err) {
 		printk(KERN_ERR "failed to start xen_suspend: %d\n", err);
@@ -161,7 +161,7 @@ out_resume:
 	} else
 		xs_suspend_cancel();
 
-	dpm_resume_end(PMSG_RESUME);
+	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 	/* Make sure timer events get retriggered on all CPUs */
 	clock_was_set();
@@ -173,7 +173,7 @@ out:
 #endif
 	shutting_down = SHUTDOWN_INVALID;
 }
-#endif	/* CONFIG_PM_SLEEP */
+#endif	/* CONFIG_XEN_SAVE_RESTORE */
 
 struct shutdown_handler {
 	const char *command;
@@ -202,7 +202,7 @@ static void shutdown_handler(struct xenbus_watch *watch,
 		{ "poweroff",	do_poweroff },
 		{ "halt",	do_poweroff },
 		{ "reboot",	do_reboot   },
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_XEN_SAVE_RESTORE
 		{ "suspend",	do_suspend  },
 #endif
 		{NULL, NULL},
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index ea83999..b6a2690 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -86,9 +86,11 @@ static struct device_attribute xenbus_frontend_dev_attrs[] = {
 };
 
 static const struct dev_pm_ops xenbus_pm_ops = {
-	.suspend = xenbus_dev_suspend,
-	.resume  = xenbus_dev_resume,
-	.thaw  = xenbus_dev_cancel,
+	.suspend	= xenbus_dev_suspend,
+	.resume		= xenbus_dev_resume,
+	.freeze		= xenbus_dev_suspend,
+	.thaw		= xenbus_dev_cancel,
+	.restore	= xenbus_dev_resume,
 };
 
 static struct xen_bus_type xenbus_frontend = {
-- 
1.7.0.4
