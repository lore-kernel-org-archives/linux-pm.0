From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v3 5/5] PM / runtime: Optimize the use of device links
Date: Fri, 16 Sep 2016 00:07:51 +0200
Message-ID: <1822638.LMjdEO2HUu@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <5257325.y9rG1UM74b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64606 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754254AbcIOWCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 18:02:10 -0400
In-Reply-To: <5257325.y9rG1UM74b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the device has no links to suppliers that should be used for
runtime PM (links with DEVICE_LINK_PM_RUNTIME set), there is no
reason to walk the list of suppliers for that device during
runtime suspend and resume.

Add a simple mechanism to detect that case and possibly avoid the
extra unnecessary overhead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |   20 +++++++++++++-------
 drivers/base/power/runtime.c |   23 ++++++++++++++++++++---
 include/linux/pm.h           |    1 +
 include/linux/pm_runtime.h   |    4 ++++
 4 files changed, 38 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -150,14 +150,17 @@ struct device_link *device_link_add(stru
 	if (!link)
 		goto out;
 
-	if ((flags & DEVICE_LINK_PM_RUNTIME) && (flags & DEVICE_LINK_RPM_ACTIVE)) {
-		if (pm_runtime_get_sync(supplier) < 0) {
-			pm_runtime_put_noidle(supplier);
-			kfree(link);
-			link = NULL;
-			goto out;
+	if (flags & DEVICE_LINK_PM_RUNTIME) {
+		if (flags & DEVICE_LINK_RPM_ACTIVE) {
+			if (pm_runtime_get_sync(supplier) < 0) {
+				pm_runtime_put_noidle(supplier);
+				kfree(link);
+				link = NULL;
+				goto out;
+			}
+			link->rpm_active = true;
 		}
-		link->rpm_active = true;
+		pm_runtime_new_link(consumer);
 	}
 	get_device(supplier);
 	link->supplier = supplier;
@@ -207,6 +210,9 @@ static void __device_link_del(struct dev
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DEVICE_LINK_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
 	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -305,6 +305,7 @@ static int __rpm_callback(int (*cb)(stru
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
 	int retval, idx;
+	bool use_links = dev->power.links_count > 0;
 
 	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
@@ -318,7 +319,7 @@ static int __rpm_callback(int (*cb)(stru
 		 * routine returns, so it is safe to read the status outside of
 		 * the lock.
 		 */
-		if (dev->power.runtime_status == RPM_RESUMING) {
+		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
 			idx = device_links_read_lock();
 
 			retval = rpm_get_suppliers(dev);
@@ -341,8 +342,9 @@ static int __rpm_callback(int (*cb)(stru
 		 *
 		 * Do that if resume fails too.
 		 */
-		if ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
-		    || (dev->power.runtime_status == RPM_RESUMING && retval)) {
+		if (use_links
+		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
+		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
 			idx = device_links_read_lock();
 
  fail:
@@ -1557,6 +1559,21 @@ void pm_runtime_clean_up_links(struct de
 	device_links_read_unlock(idx);
 }
 
+void pm_runtime_new_link(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.links_count++;
+	spin_unlock_irq(&dev->power.lock);
+}
+
+void pm_runtime_drop_link(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	WARN_ON(dev->power.links_count == 0);
+	dev->power.links_count--;
+	spin_unlock_irq(&dev->power.lock);
+}
+
 /**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -596,6 +596,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -56,6 +56,8 @@ extern void pm_runtime_update_max_time_s
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 extern void pm_runtime_clean_up_links(struct device *dev);
+extern void pm_runtime_new_link(struct device *dev);
+extern void pm_runtime_drop_link(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -188,6 +190,8 @@ static inline unsigned long pm_runtime_a
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
 static inline void pm_runtime_clean_up_links(struct device *dev) {}
+static inline void pm_runtime_new_link(struct device *dev) {}
+static inline void pm_runtime_drop_link(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 

