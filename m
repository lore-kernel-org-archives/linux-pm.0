From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v3 3/5] PM / sleep: Make async suspend/resume of devices use device links
Date: Fri, 16 Sep 2016 00:06:23 +0200
Message-ID: <1777098.MByJbLFcVr@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <5257325.y9rG1UM74b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50618 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755327AbcIOWCL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 18:02:11 -0400
In-Reply-To: <5257325.y9rG1UM74b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the device suspend/resume part of the core system
suspend/resume code use device links to ensure that supplier
and consumer devices will be suspended and resumed in the right
order in case of async suspend/resume.

The idea, roughly, is to use dpm_wait() to wait for all consumers
before a supplier device suspend and to wait for all suppliers
before a consumer device resume.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/base.h       |    2 +
 drivers/base/core.c       |    4 +-
 drivers/base/power/main.c |   85 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 83 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/base/base.h
===================================================================
--- linux-pm.orig/drivers/base/base.h
+++ linux-pm/drivers/base/base.h
@@ -163,3 +163,5 @@ extern void device_links_driver_gone(str
 extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
+extern int device_links_read_lock(void);
+extern void device_links_read_unlock(int idx);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -212,12 +212,12 @@ void device_link_del(struct device_link
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
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -244,6 +244,62 @@ static void dpm_wait_for_children(struct
        device_for_each_child(dev, &async, dpm_wait_fn);
 }
 
+static void dpm_wait_for_suppliers(struct device *dev, bool async)
+{
+	struct device_link *link;
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
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node)
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
+	struct device_link *link;
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
+	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node)
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
@@ -488,7 +544,7 @@ static int device_resume_noirq(struct de
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -618,7 +674,7 @@ static int device_resume_early(struct de
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "early power domain ";
@@ -750,7 +806,7 @@ static int device_resume(struct device *
 		goto Complete;
 	}
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
@@ -1038,7 +1094,7 @@ static int __device_suspend_noirq(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1185,7 +1241,7 @@ static int __device_suspend_late(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "late power domain ";
@@ -1342,6 +1398,22 @@ static int legacy_suspend(struct device
 	return error;
 }
 
+static void dpm_clear_suppliers_direct_complete(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links_to_suppliers, c_node) {
+		spin_lock_irq(&link->supplier->power.lock);
+		link->supplier->power.direct_complete = false;
+		spin_unlock_irq(&link->supplier->power.lock);
+	}
+
+	device_links_read_unlock(idx);
+}
+
 /**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
@@ -1358,7 +1430,7 @@ static int __device_suspend(struct devic
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
 		goto Complete;
@@ -1454,6 +1526,7 @@ static int __device_suspend(struct devic
 
 			spin_unlock_irq(&parent->power.lock);
 		}
+		dpm_clear_suppliers_direct_complete(dev);
 	}
 
 	device_unlock(dev);
