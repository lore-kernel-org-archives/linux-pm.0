From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Make ACPI wakeup from S5 work again if
	CONFIG_PM_SLEEP is unset
Date: Wed, 23 Feb 2011 22:58:44 +0100
Message-ID: <201102232258.44784.rjw__25178.190394263$1298499314$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Justin Maggard <jmaggard10@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 074037e (PM / Wakeup: Introduce wakeup source objects and
event statistics (v3)) caused ACPI wakeup to only work if
CONFIG_PM_SLEEP is set, but it also worked for CONFIG_PM_SLEEP unset
before.  This can be fixed by making device_set_wakeup_enable(),
device_init_wakeup() and device_may_wakeup() work in the same way
as before commit 074037e when CONFIG_PM_SLEEP is unset.

Reported-and-tested-by: Justin Maggard <jmaggard10@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pm.h        |    2 ++
 include/linux/pm_wakeup.h |   23 +++++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -431,6 +431,8 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+#else
+	unsigned int		should_wakeup:1;
 #endif
 #ifdef CONFIG_PM_RUNTIME
 	struct timer_list	suspend_timer;
Index: linux-2.6/include/linux/pm_wakeup.h
===================================================================
--- linux-2.6.orig/include/linux/pm_wakeup.h
+++ linux-2.6/include/linux/pm_wakeup.h
@@ -103,11 +103,6 @@ static inline bool device_can_wakeup(str
 	return dev->power.can_wakeup;
 }
 
-static inline bool device_may_wakeup(struct device *dev)
-{
-	return false;
-}
-
 static inline struct wakeup_source *wakeup_source_create(const char *name)
 {
 	return NULL;
@@ -128,24 +123,32 @@ static inline void wakeup_source_unregis
 
 static inline int device_wakeup_enable(struct device *dev)
 {
-	return -EINVAL;
+	dev->power.should_wakeup = true;
+	return 0;
 }
 
 static inline int device_wakeup_disable(struct device *dev)
 {
+	dev->power.should_wakeup = false;
+	return 0;
+}
+
+static inline int device_set_wakeup_enable(struct device *dev, bool enable)
+{
+	dev->power.should_wakeup = enable;
 	return 0;
 }
 
 static inline int device_init_wakeup(struct device *dev, bool val)
 {
 	device_set_wakeup_capable(dev, val);
-	return val ? -EINVAL : 0;
+	device_set_wakeup_enable(dev, val);
+	return 0;
 }
 
-
-static inline int device_set_wakeup_enable(struct device *dev, bool enable)
+static inline bool device_may_wakeup(struct device *dev)
 {
-	return -EINVAL;
+	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
