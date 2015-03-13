From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 04/10] pm: domains: sync runtime PM status with PM domains
 after probe
Date: Fri, 13 Mar 2015 16:23:35 +0000
Message-ID: <E1YWSN5-0006G5-Ld@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312183020.GU8656-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

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

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/amba/bus.c          |  4 +++-
 drivers/base/platform.c     |  2 ++
 drivers/base/power/common.c | 15 +++++++++++++++
 drivers/base/power/domain.c | 12 ++++++++++++
 drivers/i2c/i2c-core.c      |  2 ++
 drivers/spi/spi.c           |  2 ++
 include/linux/pm.h          |  1 +
 include/linux/pm_domain.h   |  4 ++++
 8 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 52ddd9fbb55e..8d4097f982d1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -205,8 +205,10 @@ static int amba_probe(struct device *dev)
 		pm_runtime_enable(dev);
 
 		ret = pcdrv->probe(pcdev, id);
-		if (ret == 0)
+		if (ret == 0) {
+			dev_pm_domain_sync(dev);
 			break;
+		}
 
 		pm_runtime_disable(dev);
 		pm_runtime_set_suspended(dev);
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
index 69fa87aa3b52..2b552a2d3544 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2169,6 +2169,17 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 }
 
+static void genpd_dev_pm_sync(struct device *dev)
+{
+	struct generic_pm_domain *pd;
+
+	pd = pm_genpd_lookup_dev(dev);
+	if (!pd)
+		return;
+
+	genpd_queue_power_off_work(pd);
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -2235,6 +2246,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
+	dev->pm_domain->sync = genpd_dev_pm_sync;
 	pm_genpd_poweron(pd);
 
 	return 0;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e9eae57a2b50..a6d628542907 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -659,6 +659,8 @@ static int i2c_device_probe(struct device *dev)
 					client));
 		if (status)
 			dev_pm_domain_detach(&client->dev, true);
+		else
+			dev_pm_domain_sync(&client->dev);
 	}
 
 	return status;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 66a70e9bc743..9f697cb51097 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -270,6 +270,8 @@ static int spi_drv_probe(struct device *dev)
 		ret = sdrv->probe(to_spi_device(dev));
 		if (ret)
 			dev_pm_domain_detach(dev, true);
+		else
+			dev_pm_domain_sync(dev);
 	}
 
 	return ret;
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
