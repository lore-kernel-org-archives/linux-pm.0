From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH][RFC] PM / Domains: Add on-off notifiers
Date: Fri, 15 Mar 2013 13:39:03 +0100
Message-ID: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:42422 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754208Ab3COMjP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 08:39:15 -0400
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B8A4152
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 12:39:09 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEF244CBE
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 12:39:08 +0000 (GMT)
Received: from exdcvycastm004.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm004", Issuer "exdcvycastm004" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 0FE7C24C080
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 13:39:02 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rickard.andersson@stericsson.com

Some drivers needs to restore their context directly
when a power domain is activated. For example a driver
handling system bus settings must be able to restore
context before the bus is being used for the first time.
Other examples could be clock settings hardware blocks and
special debugging hardware blocks which should be restored
as early as possible in order to be able to debug direcly
from waking up. Typically these notifers are needed in
systems with CPU coupled power domains. The notifiers
are intended to be trigged by cpuidle driver or the
suspend ops hooks.

The drivers that needs to use these notifiers are
some special cases. Most drivers should not use this
method and instead control their context via the
pm_runtime interface.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/base/power/domain.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 22 ++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a6b05a..16fbc52 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1955,6 +1955,69 @@ int pm_genpd_name_detach_cpuidle(const char *name)
 	return pm_genpd_detach_cpuidle(pm_genpd_lookup_name(name));
 }
 
+/**
+ * pm_genpd_register_on_off_notifier - Register to early power on /
+ * late power off notifications.
+ * Only use this function if absolutly needed. It is only intended to be
+ * used for power domains that are coupled with the CPU, that is, power
+ * domains being controlled from cpuidle and the platform suspend ops hooks.
+ * Also only devices that needs their context to be restored directly when
+ * leaving a sleep state should use this method. Most devices should be
+ * fine handling their context and power domains via pm_runtime.
+ * @dev: Device to register.
+ * @nb: Notifier block to be registered.
+ */
+int pm_genpd_register_on_off_notifier(struct device *dev,
+				      struct notifier_block *nb)
+{
+	struct generic_pm_domain *genpd;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	genpd = dev_to_genpd(dev);
+
+	return atomic_notifier_chain_register(&genpd->on_off_notifier, nb);
+}
+
+/**
+ * pm_genpd_unregister_on_off_notifier - Unregister to early power on /
+ * late power off notification.
+ * @dev: Device to unregister.
+ * @nb: Notifier block to be unregistered.
+ */
+int pm_genpd_unregister_on_off_notifier(struct device *dev,
+					struct notifier_block *nb)
+{
+	struct generic_pm_domain *genpd;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	genpd = dev_to_genpd(dev);
+
+	return atomic_notifier_chain_unregister(&genpd->on_off_notifier, nb);
+}
+
+/**
+ * pm_genpd_notify_power_on_off - Notify that the CPU coupled power
+ * domain is going to be powered off or has been powered on.
+ * Intended users of this function are cpuidle drivers and the platform
+ * suspend operations implementation.
+ * @genpd: pm domain that will change state.
+ * @nb: true = has been powered on, false = will power off.
+ */
+int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
+				 bool power_on_off)
+{
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	atomic_notifier_call_chain((&genpd->on_off_notifier),
+				   power_on_off, NULL);
+
+	return 0;
+}
+
+
 /* Default device callbacks for generic PM domains. */
 
 /**
@@ -2136,6 +2199,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
+	ATOMIC_INIT_NOTIFIER_HEAD(&genpd->on_off_notifier);
 	genpd->poweroff_task = NULL;
 	genpd->resume_count = 0;
 	genpd->device_count = 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7c1d252..a0a9cf7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -82,6 +82,7 @@ struct generic_pm_domain {
 	bool cached_power_down_ok;
 	struct device_node *of_node; /* Node in device tree */
 	struct gpd_cpu_data *cpu_data;
+	struct atomic_notifier_head on_off_notifier;
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
@@ -159,6 +160,12 @@ extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
 extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
+extern int pm_genpd_register_on_off_notifier(struct device *dev,
+					     struct notifier_block *nb);
+int pm_genpd_unregister_on_off_notifier(struct device *dev,
+					struct notifier_block *nb);
+int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
+				  bool power_on_off);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
 
@@ -243,6 +250,21 @@ static inline int pm_genpd_name_detach_cpuidle(const char *name)
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_register_on_off_notifier(struct device *dev,
+					     struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+int pm_genpd_unregister_on_off_notifier(struct device *dev,
+					struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
+				  bool power_on_off)
+{
+	return -ENOSYS;
+}
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
-- 
1.8.0

