From: <gregkh@suse.de>
Subject: patch pm-export-device_pm_schedule_removal.patch added
	to gregkh-2.6 tree
Date: Mon, 28 Jan 2008 09:59:20 -0800
Message-ID: <12015431603673@kroah.org>
References: <200801250130.26591.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801250130.26591.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, akpm@linux-foundation.org, greg@kroah.com, gregkh@suse.de, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, mb@bu3sch.de
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PM: Export device_pm_schedule_removal

to my gregkh-2.6 tree.  Its filename is

     pm-export-device_pm_schedule_removal.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rjw@sisk.pl  Mon Jan 28 08:57:01 2008
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 25 Jan 2008 01:30:25 +0100
Subject: PM: Export device_pm_schedule_removal
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, bcm43xx-dev@lists.berlios.de, Alessandro Rubini <rubini@ipvvis.unipv.it>, Richard Purdie <rpurdie@rpsys.net>, Greg KH <greg@kroah.com>
Message-ID: <200801250130.26591.rjw@sisk.pl>
Content-Disposition: inline


From: Rafael J. Wysocki <rjw@sisk.pl>

Move the declaration of device_pm_schedule_removal() to device.h
and make it exported, as it will be used directly by some drivers
for unregistering device objects during suspend/resume cycles in a
safe way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/power/main.c  |    1 +
 drivers/base/power/power.h |    1 -
 include/linux/device.h     |    6 ++++++
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -129,6 +129,7 @@ void device_pm_schedule_removal(struct d
 	list_move_tail(&dev->power.entry, &dpm_destroy);
 	mutex_unlock(&dpm_list_mtx);
 }
+EXPORT_SYMBOL_GPL(device_pm_schedule_removal);
 
 /**
  *	pm_sleep_lock - mutual exclusion for registration and suspend
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -13,7 +13,6 @@ static inline struct device *to_device(s
 
 extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
-extern void device_pm_schedule_removal(struct device *);
 extern int pm_sleep_lock(void);
 extern void pm_sleep_unlock(void);
 
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -534,11 +534,17 @@ extern struct device *device_create(stru
 extern void device_destroy(struct class *cls, dev_t devt);
 #ifdef CONFIG_PM_SLEEP
 extern void destroy_suspended_device(struct class *cls, dev_t devt);
+extern void device_pm_schedule_removal(struct device *);
 #else /* !CONFIG_PM_SLEEP */
 static inline void destroy_suspended_device(struct class *cls, dev_t devt)
 {
 	device_destroy(cls, devt);
 }
+
+static inline void device_pm_schedule_removal(struct device *dev)
+{
+	device_unregister(dev);
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 /*


Patches currently in gregkh-2.6 which might be from rjw@sisk.pl are

driver/pm-export-device_pm_schedule_removal.patch
