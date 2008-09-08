From: shaohua.li@intel.com
Subject: [RFC 2/5] devcore adds generic wakeup event handler
Date: Mon, 08 Sep 2008 17:19:28 +0800
Message-ID: <20080908092305.333496279__34446.6859977276$1220866572$gmane$org@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=devcore-introduce-default-pme-action.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

The default action to handle wakeup event. Currently just prints something,
maybe we should call .resume(). The routine will be called in task context.

---
 drivers/base/power/main.c |    6 ++++++
 include/linux/pm.h        |    2 ++
 2 files changed, 8 insertions(+)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c	2008-09-08 13:55:56.000000000 +0800
+++ linux/drivers/base/power/main.c	2008-09-08 14:22:12.000000000 +0800
@@ -785,3 +785,9 @@ void __suspend_report_result(const char 
 	}
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
+
+void device_receive_wakeup_event(struct device *dev)
+{
+	printk("Device %s invokes wakeup event\n", dev->bus_id);
+}
+EXPORT_SYMBOL(device_receive_wakeup_event);
Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2008-09-08 13:56:51.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-08 14:22:12.000000000 +0800
@@ -436,6 +436,8 @@ static inline int device_suspend(pm_mess
 
 #endif /* !CONFIG_PM_SLEEP */
 
+void device_receive_wakeup_event(struct device *dev);
+
 /*
  * Global Power Management flags
  * Used to keep APM and ACPI from both being active

-- 
