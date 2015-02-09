From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v4 2/3] PM / Domains: Save restore slave pm runtime devices
Date: Mon, 09 Feb 2015 16:32:05 +0530
Message-ID: <1423479726-23140-3-git-send-email-amit.daniel@samsung.com>
References: <1423479726-23140-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29074 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbbBIK7f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 05:59:35 -0500
In-reply-to: <1423479726-23140-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, khilman@linaro.org, rjw@rjwysocki.net, len.brown@intel.com, ulf.hansson@linaro.org, tomasz.figa@gmail.com, kgene.kim@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, pankaj.dubey@samsung.com, m.szyprowski@samsung.com, geert+renesas@glider.be, Amit Daniel Kachhap <amit.daniel@samsung.com>

Based on the runtime request of the active device, the callbacks of
the passive pm runtime devices will be invoked.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/base/power/domain.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c5280f2..160e74a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -49,6 +49,7 @@
 
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
+static void __pm_genpd_restore_devices(struct generic_pm_domain *genpd);
 
 static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 {
@@ -176,6 +177,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
 		genpd->name, "on", elapsed_ns);
 
+	__pm_genpd_restore_devices(genpd);
+
 	return ret;
 }
 
@@ -397,6 +400,9 @@ static int __pm_genpd_save_device(struct pm_domain_data *pdd,
 	struct device *dev = pdd->dev;
 	int ret = 0;
 
+	if (dev->power.slave == true)
+		gpd_data->need_restore = 0;
+
 	if (gpd_data->need_restore > 0)
 		return 0;
 
@@ -453,6 +459,28 @@ static void __pm_genpd_restore_device(struct pm_domain_data *pdd,
 }
 
 /**
+ * __pm_genpd_restore_devices- Restore the pre-suspend state of all device
+ *				according to the restore flag.
+ * @genpd: PM domain the device belongs to.
+ */
+static void __pm_genpd_restore_devices(struct generic_pm_domain *genpd)
+{
+	struct pm_domain_data *pdd;
+	struct generic_pm_domain_data *gpd_data;
+	struct device *dev;
+
+	/* Force restore the devices according to the restore flag */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		dev = pdd->dev;
+		gpd_data = to_gpd_data(pdd);
+		if (dev->power.slave == true) {
+			gpd_data->need_restore = 1;
+			__pm_genpd_restore_device(pdd, genpd);
+		}
+	}
+}
+
+/**
  * genpd_abort_poweroff - Check if a PM domain power off should be aborted.
  * @genpd: PM domain to check.
  *
-- 
2.2.0

