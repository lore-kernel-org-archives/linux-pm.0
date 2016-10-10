From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v5 3/5] PM / sleep: Make async suspend/resume of devices use device links
Date: Mon, 10 Oct 2016 14:54:32 +0200
Message-ID: <2538022.qMGl8lB1tE@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13957403.ZrB4mMbICz@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

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

v4 -> v5:

- Rebase, change the symbol names in accordance with patch [2/5] etc.

- Use READ_ONCE() to annotate "unprotected" accesses to link status data.

---
 drivers/base/power/main.c |   85 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -246,6 +246,62 @@ static void dpm_wait_for_children(struct
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
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
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
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
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
@@ -490,7 +546,7 @@ static int device_resume_noirq(struct de
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -620,7 +676,7 @@ static int device_resume_early(struct de
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
 		info = "early power domain ";
@@ -752,7 +808,7 @@ static int device_resume(struct device *
 		goto Complete;
 	}
 
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_superior(dev, async);
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
@@ -1040,7 +1096,7 @@ static int __device_suspend_noirq(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1187,7 +1243,7 @@ static int __device_suspend_late(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (dev->pm_domain) {
 		info = "late power domain ";
@@ -1344,6 +1400,22 @@ static int legacy_suspend(struct device
 	return error;
 }
 
+static void dpm_clear_suppliers_direct_complete(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
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
@@ -1360,7 +1432,7 @@ static int __device_suspend(struct devic
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
 		goto Complete;
@@ -1456,6 +1528,7 @@ static int __device_suspend(struct devic
 
 			spin_unlock_irq(&parent->power.lock);
 		}
+		dpm_clear_suppliers_direct_complete(dev);
 	}
 
 	device_unlock(dev);
