From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
Date: Mon, 13 Oct 2014 16:02:02 +0200
Message-ID: <1413208930-26019-2-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

There may be more than one device in a PM domain which then will be
probed at different points in time.

Depending on timing and runtime PM support, in for the device related
driver/subsystem, a PM domain may be advised to power off after a
successful probe sequence.

A general requirement for a device within a PM domain, is that the
PM domain must stay powered during the probe sequence. To cope with
such requirement, let's add the dev_pm_domain_get|put() APIs.

These APIs are intended to be invoked from subsystem-level code and the
calls between get/put needs to be balanced.

dev_pm_domain_get(), tells the PM domain that it needs to increase a
usage count and to keep supplying power. dev_pm_domain_put(), does the
opposite.

For a PM domain to support this feature, it must implement the optional
->get|put() callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  4 ++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index b0f1388..b4f0c8c 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -134,3 +134,43 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 		dev->pm_domain->detach(dev, power_off);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
+
+/**
+ * dev_pm_domain_get - Increase usage count to keep a PM domain powered.
+ * @domain: The PM domain to operate on.
+ *
+ * This function will not by itself increase the usage count, that's up to each
+ * PM domain implementation to support. Typically it should be invoked from
+ * subsystem level code prior drivers starts probing.
+ *
+ * Do note, it's optional to implement the ->get() callback for a PM domain.
+ *
+ * Returns 0 on successfully increased usage count or negative error code.
+ */
+int dev_pm_domain_get(struct dev_pm_domain *domain)
+{
+	int ret = 0;
+
+	if (domain && domain->get)
+		ret = domain->get(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_get);
+
+/**
+ * dev_pm_domain_put - Decrease usage count to allow a PM domain to power off.
+ * @domain: The PM domain to operate on.
+ *
+ * This function will not by itself decrease the usage count, that's up to each
+ * PM domain implementation to support. Typically it should be invoked from
+ * subsystem level code after drivers has finished probing.
+ *
+ * Do note, it's optional to implement the ->put() callback for a PM domain.
+ */
+void dev_pm_domain_put(struct dev_pm_domain *domain)
+{
+	if (domain && domain->put)
+		domain->put(domain);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_put);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 383fd68..f71900d 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -620,6 +620,8 @@ extern int dev_pm_put_subsys_data(struct device *dev);
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 	void (*detach)(struct device *dev, bool power_off);
+	int (*get)(struct dev_pm_domain *domain);
+	void (*put)(struct dev_pm_domain *domain);
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 73e938b..8e2806f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -304,12 +304,16 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 #ifdef CONFIG_PM
 extern int dev_pm_domain_attach(struct device *dev, bool power_on);
 extern void dev_pm_domain_detach(struct device *dev, bool power_off);
+extern int dev_pm_domain_get(struct dev_pm_domain *domain);
+extern void dev_pm_domain_put(struct dev_pm_domain *domain);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	return -ENODEV;
 }
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+static inline int dev_pm_domain_get(struct dev_pm_domain *domain) { return 0; }
+static inline void dev_pm_domain_put(struct dev_pm_domain *domain) {}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
1.9.1
