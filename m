From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
Date: Fri, 13 Mar 2015 16:43:41 +0100
Message-ID: <1426261429-31883-2-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:33703 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849AbbCMPoI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:08 -0400
Received: by labmn12 with SMTP id mn12so23555576lab.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:06 -0700 (PDT)
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

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
index f32b802..99225af 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -128,3 +128,43 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
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
index e2f1be6..e62330b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -607,6 +607,8 @@ extern void dev_pm_put_subsys_data(struct device *dev);
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 	void (*detach)(struct device *dev, bool power_off);
+	int (*get)(struct dev_pm_domain *domain);
+	void (*put)(struct dev_pm_domain *domain);
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 080e778..c80d6ac 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -315,12 +315,16 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
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

