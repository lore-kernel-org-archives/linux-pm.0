From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: export the PM runtime workqueue
Date: Mon, 30 Nov 2009 11:31:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911301130300.4478-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1306) exports the PM runtime workqueue for use by
loadable modules.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/kernel/power/main.c
===================================================================
--- usb-2.6.orig/kernel/power/main.c
+++ usb-2.6/kernel/power/main.c
@@ -220,6 +220,7 @@ static struct attribute_group attr_group
 
 #ifdef CONFIG_PM_RUNTIME
 struct workqueue_struct *pm_wq;
+EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
