From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 3/5] PM core: Make async suspend/resume of devices use device links
Date: Thu, 14 Jan 2016 02:55:25 +0100
Message-ID: <2464004.VfRsJaNrp3@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <2576341.476ZsjkPgF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41889 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753266AbcANB4p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 20:56:45 -0500
In-Reply-To: <2576341.476ZsjkPgF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

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
 drivers/base/power/main.c |   68 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 66 insertions(+), 8 deletions(-)

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
@@ -163,12 +163,12 @@ void device_link_del(struct devlink *lin
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
@@ -1357,7 +1413,7 @@ static int __device_suspend(struct devic
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	dpm_wait_for_children(dev, async);
+	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
 		goto Complete;

