From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC PATCH 2/2] PM / Domains: Atomic counters for domain usage count
Date: Tue,  6 Oct 2015 15:57:36 -0600
Message-ID: <1444168656-6576-3-git-send-email-lina.iyer@linaro.org>
References: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36273 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbbJFV5y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 17:57:54 -0400
Received: by pablk4 with SMTP id lk4so220830197pab.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 14:57:54 -0700 (PDT)
In-Reply-To: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: grygorii.strashko@ti.com, ulf.hansson@linaro.org, khilman@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de, geert+renesas@glider.be, lorenzo.pieralisi@arm.com, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Locking a domain to check if the domain can be powered on/off is an
expensive operations and could hold up multiple devices executing
runtime PM at the same time.

In the case where there is atleast one active device, the domain would
remain active. This can be easily checked by using an atomic counter to
record domain usage. This restricts locking only to the last suspending
or the first resuming device.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 16 ++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3af1a63..80f8ea9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -204,6 +204,7 @@ static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)
 
 	if (!WARN_ON(atomic_read(&genpd->sd_count) == 0))
 		ret = !!atomic_dec_and_test(&genpd->sd_count);
+	atomic_dec(&genpd->usage_count);
 
 	return ret;
 }
@@ -211,6 +212,7 @@ static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)
 static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 {
 	atomic_inc(&genpd->sd_count);
+	atomic_inc(&genpd->usage_count);
 	smp_mb__after_atomic();
 }
 
@@ -583,6 +585,9 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
+	if (!atomic_dec_and_test(&genpd->usage_count))
+		return 0;
+
 	/*
 	 * If power.irq_safe is set, this routine may be run with
 	 * IRQ disabled, so suspend only if the power domain is
@@ -620,6 +625,9 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
+	if (atomic_inc_return(&genpd->usage_count) > 1)
+		goto out;
+
 	/*
 	 * As we dont power off a non IRQ safe domain, which holds
 	 * an IRQ safe device, we dont need to restore power to it.
@@ -1400,9 +1408,11 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
-	else
+	else {
 		dev_pm_qos_add_notifier(dev, &gpd_data->nb);
-
+		atomic_inc(&genpd->usage_count);
+		printk("Add device %d\n", atomic_read(&genpd->usage_count));
+	}
 	return ret;
 }
 
@@ -1457,6 +1467,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	genpd_unlock(genpd);
 
+	atomic_dec(&genpd->usage_count);
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
@@ -1799,6 +1810,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
+	atomic_set(&genpd->usage_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 613f7a5..7e52923 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -55,6 +55,7 @@ struct generic_pm_domain {
 	struct work_struct power_off_work;
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
+	atomic_t usage_count;	/* Number of active users of domain "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
-- 
2.1.4

