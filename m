From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 05/10] PM core: Optimize the use of device links for runtime
	PM
Date: Fri, 17 Jun 2016 08:26:55 +0200
Message-ID: <1466144820-6286-6-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1466144820-6286-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

If the device has no links to suppliers that should be used for
runtime PM (links with DEVICE_LINK_PM_RUNTIME set), there is no
reason to walk the list of suppliers for that device during
runtime suspend and resume.

Add a simple mechanism to detect that case and possibly avoid the
extra unnecessary overhead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/base/core.c          |  6 ++++++
 drivers/base/power/runtime.c | 23 ++++++++++++++++++++---
 include/linux/pm.h           |  1 +
 include/linux/pm_runtime.h   |  4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1fe7cf232e1e..215cd44de761 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -119,6 +119,9 @@ struct devlink *device_link_add(struct device *consumer,
 	get_device(consumer);
 	link->consumer = consumer;
 	INIT_LIST_HEAD(&link->c_node);
+	if (flags & DEVICE_LINK_PM_RUNTIME)
+		pm_runtime_new_link(consumer);
+
 	link->flags = flags;
 	link->status = (flags & DEVICE_LINK_PROBE_TIME) ?
 			DEVICE_LINK_CONSUMER_PROBE : DEVICE_LINK_DORMANT;
@@ -161,6 +164,9 @@ static void devlink_del(struct devlink *link)
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DEVICE_LINK_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
 	call_srcu(&device_links_srcu, &link->rcu_head, __devlink_free_srcu);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ba21c123b16e..0ea00d442e0f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -270,6 +270,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 {
 	struct devlink *link;
 	int retval, idx;
+	bool use_links = dev->power.links_count > 0;
 
 	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
@@ -283,7 +284,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 		 * routine returns, so it is safe to read the status outside of
 		 * the lock.
 		 */
-		if (dev->power.runtime_status == RPM_RESUMING) {
+		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
 			idx = device_links_read_lock();
 
 			list_for_each_entry_rcu(link, &dev->consumer_links, c_node)
@@ -314,8 +315,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
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
@@ -1525,6 +1527,21 @@ void pm_runtime_clean_up_links(struct device *dev)
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
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06eb353182ab..49c811378110 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -596,6 +596,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index c21a21c064e3..bef6203aaf14 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -56,6 +56,8 @@ extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 extern void pm_runtime_clean_up_links(struct device *dev);
+extern void pm_runtime_new_link(struct device *dev);
+extern void pm_runtime_drop_link(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
@@ -188,6 +190,8 @@ static inline unsigned long pm_runtime_autosuspend_expiration(
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
 static inline void pm_runtime_clean_up_links(struct device *dev) {}
+static inline void pm_runtime_new_link(struct device *dev) {}
+static inline void pm_runtime_drop_link(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
-- 
1.9.1
