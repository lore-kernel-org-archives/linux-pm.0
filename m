From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH 1/3] power: domain: add pm_genpd_uninit
Date: Thu, 19 Nov 2015 19:08:08 +0100
Message-ID: <1447956490-22930-2-git-send-email-alex.aring@gmail.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33765 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbbKSSIe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 13:08:34 -0500
In-Reply-To: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds function pm_genpd_uninit for undo a pm_genpd_init. This
is useful for multiple power domains while probing. If the probing fails
after one pm_genpd_init was called we need to undo all previous
registrations of generic pm domains inside the gpd_list list.

There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
registered power domains and not registered domains, the driver can use
this mechanism to have an array with registered and non-registered power
domains, where non-registered power domains are NULL.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/base/power/domain.c | 22 ++++++++++++++++++++++
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e03b1ad..24f54b8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1509,6 +1509,28 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+/**
+ * pm_genpd_uninit - Uninitialize a generic I/O PM domain object.
+ * @genpd: PM domain object to initialize.
+ */
+void pm_genpd_uninit(struct generic_pm_domain *genpd)
+{
+	if (IS_ERR_OR_NULL(genpd))
+		return;
+
+	/* check if domain is still in registered inside the pm subsystem */
+	WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
+		     !list_empty(&genpd->slave_links) ||
+		     !list_empty(&genpd->dev_list));
+
+	mutex_lock(&gpd_list_lock);
+	list_del(&genpd->gpd_list_node);
+	mutex_unlock(&gpd_list_lock);
+
+	mutex_destroy(&genpd->lock);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_uninit);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ba4ced3..df84a45 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -123,6 +123,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern void pm_genpd_uninit(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -161,6 +162,9 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
 }
+static inline void pm_genpd_uninit(struct generic_pm_domain *genpd)
+{
+}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
2.6.1

