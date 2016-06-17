From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 03/10] PM core: Make async suspend/resume of devices use
	device links
Date: Fri, 17 Jun 2016 08:26:53 +0200
Message-ID: <1466144820-6286-4-git-send-email-m.szyprowski@samsung.com>
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

Make the device suspend/resume part of the core system
suspend/resume code use device links to ensure that supplier
and consumer devices will be suspended and resumed in the right
order in case of async suspend/resume.

The idea, roughly, is to use dpm_wait() to wait for all consumers
before a supplier device suspend and to wait for all suppliers
before a consumer device resume.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/base/base.h       |  2 ++
 drivers/base/core.c       |  4 +--
 drivers/base/power/main.c | 68 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index cccb1d211541..123b986eb061 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -163,3 +163,5 @@ extern void device_links_driver_gone(struct device *dev);
 extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
+extern int device_links_read_lock(void);
+extern void device_links_read_unlock(int idx);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 416341df3268..51a479ed68b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -163,12 +163,12 @@ void device_link_del(struct devlink *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
-static int device_links_read_lock(void)
+int device_links_read_lock(void)
 {
 	return srcu_read_lock(&device_links_srcu);
 }
 
-static void device_links_read_unlock(int idx)
+void device_links_read_unlock(int idx)
 {
 	return srcu_read_unlock(&device_links_srcu, idx);
 }
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e44944f4be77..9470ccd87f11 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -244,6 +244,62 @@ static void dpm_wait_for_children(struct device *dev, bool async)
        device_for_each_child(dev, &async, dpm_wait_fn);
 }
 
+static void dpm_wait_for_suppliers(struct device *dev, bool async)
+{
+	struct devlink *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	/*
+	 * If the supplier goes away right after we've checked the link to it,
+	 * we'll wait for its completion to change the state, but that's fine,
+	 * because the only things that will block as a result are the SRCU
+	 * callbacks freeing the link objects for the links in the list we're
+	 * walking.
+	 */
+	list_for_each_entry_rcu(link, &dev->consumer_links, c_node)
+		if (link->status != DEVICE_LINK_DORMANT)
+			dpm_wait(link->supplier, async);
+
+	device_links_read_unlock(idx);
+}
+
+static void dpm_wait_for_superior(struct device *dev, bool async)
+{
+	dpm_wait(dev->parent, async);
+	dpm_wait_for_suppliers(dev, async);
+}
+
+static void dpm_wait_for_consumers(struct device *dev, bool async)
+{
+	struct devlink *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	/*
+	 * The status of a device link can only be changed from "dormant" by a
+	 * probe, but that cannot happen during system suspend/resume.  In
+	 * theory it can change to "dormant" at that time, but then it is
+	 * reasonable to wait for the target device anyway (eg. if it goes
+	 * away, it's better to wait for it to go away completely and then
+	 * continue instead of trying to continue in parallel with its
+	 * unregistration).
+	 */
+	list_for_each_entry_rcu(link, &dev->supplier_links, s_node)
+		if (link->status != DEVICE_LINK_DORMANT)
+			dpm_wait(link->consumer, async);
+
+	device_links_read_unlock(idx);
+}
+
+static void dpm_wait_for_subordinate(struct device *dev, bool async)
+{
+	dpm_wait_for_children(dev, async);
+	dpm_wait_for_consumers(dev, async);
+}
+
 /**
  * pm_op - Return the PM operation appropriate for given PM event.
  * @ops: PM operations to choose from.
@@ -488,7 +544,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -618,7 +674,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "early power domain ";
@@ -750,7 +806,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 		goto Complete;
 	}
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
@@ -1038,7 +1094,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1185,7 +1241,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "late power domain ";
@@ -1358,7 +1414,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
 		goto Complete;
-- 
1.9.1
