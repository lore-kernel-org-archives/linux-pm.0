From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/6] driver core: Fix handling of runtime PM flags in device_link_add()
Date: Thu, 24 Jan 2019 12:21:22 +0100
Message-ID: <1665211.FOmLsISsVf@aspire.rjw.lan>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit ead18c23c263 ("driver core: Introduce device links
reference counting"), if if there is a link between the given supplier
and the given consumer already, device_link_add() will refcount it
and return it unconditionally without updating its flags.  It is
possible, however, that the second (or any subsequent) caller of
device_link_add() for the same consumer-supplier pair will pass
DL_FLAG_PM_RUNTIME, possibly along with DL_FLAG_RPM_ACTIVE, in flags
to it and the existing link may not behave as expected then.

First, if DL_FLAG_PM_RUNTIME is not set in the existing link's flags
at all, it needs to be set like during the original initialization of
the link.  In that case DL_FLAG_RPM_ACTIVE should take effect like
during the original initialization of the link too.

Second, however, if DL_FLAG_PM_RUNTIME is set in the existing link's
flags, attempting to cause DL_FLAG_RPM_ACTIVE to take its normal
effect is generally unsafe and it is better to return NULL from
device_link_add() in that case (to indicate to the caller that the
expected behavior of the new device link could not be guaranteed).

Modify device_link_add() to behave as per the above.

[Note that the change in behavior regarding DL_FLAG_RPM_ACTIVE should
 not affect the existing users of that flag.]

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   56 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -165,6 +165,23 @@ void device_pm_move_to_tail(struct devic
 	device_links_read_unlock(idx);
 }
 
+static void device_link_rpm_prepare(struct device *consumer,
+				    struct device *supplier,
+				    struct device_link *link, u32 flags)
+{
+	if (flags & DL_FLAG_RPM_ACTIVE)
+		link->rpm_active = true;
+
+	pm_runtime_new_link(consumer);
+	/*
+	 * If the link is being added by the consumer driver at probe time,
+	 * balance the decrementation of the supplier's runtime PM usage counter
+	 * after consumer probe in driver_probe_device().
+	 */
+	if (consumer->links.status == DL_DEV_PROBING)
+		pm_runtime_get_noresume(supplier);
+}
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -177,7 +194,9 @@ void device_pm_move_to_tail(struct devic
  * DL_FLAG_RPM_ACTIVE flag is set in addition to it, the supplier devices will
  * be forced into the active metastate and reference-counted upon the creation
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
- * ignored.
+ * ignored.  However, passing both DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE in
+ * @flags will cause NULL to be returned if an existing link between @consumer
+ * and @supplier with the DL_FLAG_PM_RUNTIME flag set is found.
  *
  * If the DL_FLAG_AUTOREMOVE_CONSUMER flag is set, the reference to the link
  * acquired by this function will be dropped automatically when the consumer
@@ -202,7 +221,6 @@ struct device_link *device_link_add(stru
 				    struct device *supplier, u32 flags)
 {
 	struct device_link *link;
-	bool rpm_put_supplier = false;
 
 	if (!consumer || !supplier ||
 	    (flags & DL_FLAG_STATELESS &&
@@ -214,7 +232,6 @@ struct device_link *device_link_add(stru
 			pm_runtime_put_noidle(supplier);
 			return NULL;
 		}
-		rpm_put_supplier = true;
 	}
 
 	device_links_write_lock();
@@ -250,6 +267,20 @@ struct device_link *device_link_add(stru
 		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
 			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
 
+		if (flags & DL_FLAG_PM_RUNTIME) {
+			if (link->flags & DL_FLAG_PM_RUNTIME) {
+				if (WARN_ON(flags & DL_FLAG_RPM_ACTIVE)) {
+					link = NULL;
+					goto out;
+				}
+			} else {
+				link->flags |= DL_FLAG_PM_RUNTIME;
+
+				device_link_rpm_prepare(consumer, supplier,
+							link, flags);
+			}
+		}
+
 		kref_get(&link->kref);
 		goto out;
 	}
@@ -258,20 +289,9 @@ struct device_link *device_link_add(stru
 	if (!link)
 		goto out;
 
-	if (flags & DL_FLAG_PM_RUNTIME) {
-		if (flags & DL_FLAG_RPM_ACTIVE) {
-			link->rpm_active = true;
-			rpm_put_supplier = false;
-		}
-		pm_runtime_new_link(consumer);
-		/*
-		 * If the link is being added by the consumer driver at probe
-		 * time, balance the decrementation of the supplier's runtime PM
-		 * usage counter after consumer probe in driver_probe_device().
-		 */
-		if (consumer->links.status == DL_DEV_PROBING)
-			pm_runtime_get_noresume(supplier);
-	}
+	if (flags & DL_FLAG_PM_RUNTIME)
+		device_link_rpm_prepare(consumer, supplier, link, flags);
+
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
@@ -334,7 +354,7 @@ struct device_link *device_link_add(stru
 	device_pm_unlock();
 	device_links_write_unlock();
 
-	if (rpm_put_supplier)
+	if ((flags & DL_FLAG_PM_RUNTIME && flags & DL_FLAG_RPM_ACTIVE) && !link)
 		pm_runtime_put(supplier);
 
 	return link;
