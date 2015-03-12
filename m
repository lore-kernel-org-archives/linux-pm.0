From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains after
 probe
Date: Thu, 12 Mar 2015 18:31:05 +0000
Message-ID: <E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40995 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbCLSbW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 14:31:22 -0400
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

Synchronise the PM domain status with runtime PM's status after a
platform device has been probed.  This augments the solution in commit
2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
completes").

The above commit added a call to power up the PM domain when a device
attaches to the domain in order to match the behaviour required by
drivers that make no use of runtime PM.  The assumption is that the
device driver will cause a runtime PM transition, which will synchronise
the PM domain state with the runtime PM state.

However, by default, runtime PM will assume that the device is initially
suspended, and some drivers may make use of this should they not need to
touch the hardware during probe.

In order to allow such drivers, trigger the PM domain code to check
whether the PM domain can be suspended after the probe function, undoing
the effect of the power-on prior to the probe.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/platform.c     |  2 ++
 drivers/base/power/common.c | 15 +++++++++++++++
 drivers/base/power/domain.c | 23 +++++++++++++++++++++++
 include/linux/pm.h          |  1 +
 include/linux/pm_domain.h   |  4 ++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9421fed40905..552d1affc060 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -512,6 +512,8 @@ static int platform_drv_probe(struct device *_dev)
 		ret = drv->probe(dev);
 		if (ret)
 			dev_pm_domain_detach(_dev, true);
+		else
+			dev_pm_domain_sync(_dev);
 	}
 
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index b0f138806bbc..8c739a14d3c7 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -134,3 +134,18 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 		dev->pm_domain->detach(dev, power_off);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
+
+/**
+ * dev_pm_domain_sync - synchronise the PM domain state with its devices
+ * @dev: device corresponding with domain
+ *
+ * Synchronise the PM domain state with the recently probed device, which
+ * may be in a variety of PM states.  This ensures that a device which
+ * enables runtime PM in suspended state, and never transitions to active
+ * in its probe handler is properly suspended after the probe.
+ */
+void dev_pm_domain_sync(struct device *dev)
+{
+	if (dev->pm_domain && dev->pm_domain->sync)
+		dev->pm_domain->sync(dev);
+}
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 11a1023fa64a..13ae3355dff7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2157,6 +2157,28 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 }
 
+static void genpd_dev_pm_sync(struct device *dev)
+{
+	struct generic_pm_domain *pd = NULL, *gpd;
+
+	if (!dev->pm_domain)
+		return;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (&gpd->domain == dev->pm_domain) {
+			pd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	if (!pd)
+		return;
+
+	genpd_queue_power_off_work(pd);
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -2223,6 +2245,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
+	dev->pm_domain->sync = genpd_dev_pm_sync;
 	pm_genpd_poweron(pd);
 
 	return 0;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8b5976364619..676ca4055239 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -607,6 +607,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 	void (*detach)(struct device *dev, bool power_off);
+	void (*sync)(struct device *dev);
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a9edab2c787a..8d58b30e23ac 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -319,12 +319,16 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 #ifdef CONFIG_PM
 extern int dev_pm_domain_attach(struct device *dev, bool power_on);
 extern void dev_pm_domain_detach(struct device *dev, bool power_off);
+void dev_pm_domain_sync(struct device *dev);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	return -ENODEV;
 }
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+static inline void dev_pm_domain_sync(struct device *dev)
+{
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
1.8.3.1

