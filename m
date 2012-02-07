From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] PM / QoS: unconditionally build the
	per-device constraints feature
Date: Tue,  7 Feb 2012 09:34:06 +0100
Message-ID: <1328603646-2714-3-git-send-email-j-pihet@ti.com>
References: <1328603646-2714-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1328603646-2714-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Mark Gross <markgross@thegnar.org>, Venkatesh Pallipadi <venki@google.com>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

The per-device PM QoS feature depends on CONFIG_PM which depends
on PM_SLEEP || PM_RUNTIME. This breaks CPU C-states with kernels
not having these CONFIGs.

This patch allows the feature in all cases.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Mark Gross <markgross@thegnar.org>
---
 drivers/base/power/Makefile |    3 ++-
 include/linux/pm_qos.h      |   39 ---------------------------------------
 2 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 2e58ebb..312eb65 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,4 +1,5 @@
-obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o
+obj-y			+= qos.o
+obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 105be69..37b017a 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -77,7 +77,6 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
 s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
-#ifdef CONFIG_PM
 s32 __dev_pm_qos_read_value(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
@@ -94,43 +93,5 @@ void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 int dev_pm_qos_add_ancestor_request(struct device *dev,
 				    struct dev_pm_qos_request *req, s32 value);
-#else
-static inline s32 __dev_pm_qos_read_value(struct device *dev)
-			{ return 0; }
-static inline s32 dev_pm_qos_read_value(struct device *dev)
-			{ return 0; }
-static inline int dev_pm_qos_add_request(struct device *dev,
-					 struct dev_pm_qos_request *req,
-					 s32 value)
-			{ return 0; }
-static inline int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
-					    s32 new_value)
-			{ return 0; }
-static inline int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
-			{ return 0; }
-static inline int dev_pm_qos_add_notifier(struct device *dev,
-					  struct notifier_block *notifier)
-			{ return 0; }
-static inline int dev_pm_qos_remove_notifier(struct device *dev,
-					     struct notifier_block *notifier)
-			{ return 0; }
-static inline int dev_pm_qos_add_global_notifier(
-					struct notifier_block *notifier)
-			{ return 0; }
-static inline int dev_pm_qos_remove_global_notifier(
-					struct notifier_block *notifier)
-			{ return 0; }
-static inline void dev_pm_qos_constraints_init(struct device *dev)
-{
-	dev->power.power_state = PMSG_ON;
-}
-static inline void dev_pm_qos_constraints_destroy(struct device *dev)
-{
-	dev->power.power_state = PMSG_INVALID;
-}
-static inline int dev_pm_qos_add_ancestor_request(struct device *dev,
-				    struct dev_pm_qos_request *req, s32 value)
-			{ return 0; }
-#endif
 
 #endif
-- 
1.7.5.4
