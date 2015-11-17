From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 19/27] drivers: cpu-pd: Invoke CPU PM runtime on hotplug
Date: Tue, 17 Nov 2015 15:37:43 -0700
Message-ID: <1447799871-56374-20-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36841 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbbKQWi5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:57 -0500
Received: by pacdm15 with SMTP id dm15so22085012pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:56 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

When a CPU is hotplugged off invoke CPU runtime suspend to notify
runtime PM of the CPU being powered down and opportunistically power
down the domain as well. Do that independent of the architecture using
hotplug notifiers.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu-pd.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
index a00abc1..e331ae6 100644
--- a/drivers/base/power/cpu-pd.c
+++ b/drivers/base/power/cpu-pd.c
@@ -237,6 +237,30 @@ static int of_pm_domain_attach_cpus(struct device_node *dn,
 	return 0;
 }
 
+static int cpu_hotplug(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	/* Execute CPU runtime PM on that CPU */
+	switch (action) {
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		pm_runtime_put_sync_suspend(dev);
+		pm_runtime_disable(dev);
+		break;
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		pm_runtime_enable(dev);
+		pm_runtime_get_sync(dev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 int of_register_cpu_pm_domain(struct device_node *dn,
 		struct cpu_pm_domain *pd)
 {
@@ -277,10 +301,13 @@ int of_register_cpu_pm_domain(struct device_node *dn,
 
 	/* Attach the CPUs to the CPU PM domain */
 	ret = of_pm_domain_attach_cpus(dn, pd);
-	if (ret)
+	if (ret) {
 		of_genpd_del_provider(dn);
+		return ret;
+	}
 
-	return ret;
+	hotcpu_notifier(cpu_hotplug, 0)
+	return 0;
 }
 
 /**
-- 
2.1.4

