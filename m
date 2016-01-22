From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 5/5] cpufreq: mt8173: Add notifier to handle OPP voltage adjustment
Date: Fri, 22 Jan 2016 16:40:29 +0800
Message-ID: <1453452029-20843-6-git-send-email-pi-cheng.chen@linaro.org>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33616 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbcAVIlH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 03:41:07 -0500
Received: by mail-pf0-f172.google.com with SMTP id e65so38753950pfe.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2016 00:41:07 -0800 (PST)
In-Reply-To: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Kevin Hilman <khilman@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>

Add a notifier to receive OPP voltage adjustment event which is
triggered by voltage change of OPP entries done by Mediatek SVS
(Smart Voltage Scaling) engine.

CC: Stephen Boyd <sboyd@codeaurora.org>

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
This patch is modify from the patch which adds[1] a notifier in
cpufreq-dt to handle OPP voltage adjust event. This patch relies on the
on the runtime voltage adjustment mechanism of OPP introduced in the
same patchset.

[1] https://lkml.org/lkml/2015/9/18/833
---
 drivers/cpufreq/mt8173-cpufreq.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 1ede917..248f6e8 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -48,8 +48,11 @@ struct mtk_cpu_dvfs_info {
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
 	struct thermal_cooling_device *cdev;
+	struct mutex lock;
+	struct notifier_block opp_nb;
 	struct list_head list_head;
 	int intermediate_voltage;
+	unsigned long opp_freq;
 	bool need_voltage_tracking;
 };
 
@@ -211,6 +214,33 @@ static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
 					     vproc + VOLT_TOL);
 }
 
+static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct dev_pm_opp *opp = data;
+	struct mtk_cpu_dvfs_info *info = container_of(nb,
+						      struct mtk_cpu_dvfs_info,
+						      opp_nb);
+	unsigned long freq, volt;
+	int ret = 0;
+
+	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
+		freq = dev_pm_opp_get_freq(opp);
+
+		if (info->opp_freq == freq) {
+			volt = dev_pm_opp_get_voltage(opp);
+			mutex_lock(&info->lock);
+			ret = mtk_cpufreq_set_voltage(info, volt);
+			mutex_unlock(&info->lock);
+			if (ret)
+				dev_err(info->cpu_dev,
+					"failed to scale voltage: %d\n", ret);
+		}
+	}
+
+	return notifier_from_errno(ret);
+}
+
 static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 				  unsigned int index)
 {
@@ -245,6 +275,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	vproc = dev_pm_opp_get_voltage(opp);
 	rcu_read_unlock();
 
+	mutex_lock(&info->lock);
+
 	/*
 	 * If the new voltage or the intermediate voltage is higher than the
 	 * current voltage, scale up voltage first.
@@ -256,6 +288,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 			pr_err("cpu%d: failed to scale up voltage!\n",
 			       policy->cpu);
 			mtk_cpufreq_set_voltage(info, old_vproc);
+			mutex_unlock(&info->lock);
 			return ret;
 		}
 	}
@@ -267,6 +300,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 		       policy->cpu);
 		mtk_cpufreq_set_voltage(info, old_vproc);
 		WARN_ON(1);
+		mutex_unlock(&info->lock);
 		return ret;
 	}
 
@@ -277,6 +311,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 		       policy->cpu);
 		clk_set_parent(cpu_clk, armpll);
 		mtk_cpufreq_set_voltage(info, old_vproc);
+		mutex_unlock(&info->lock);
 		return ret;
 	}
 
@@ -287,6 +322,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 		       policy->cpu);
 		mtk_cpufreq_set_voltage(info, inter_vproc);
 		WARN_ON(1);
+		mutex_unlock(&info->lock);
 		return ret;
 	}
 
@@ -302,10 +338,14 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 			clk_set_parent(cpu_clk, info->inter_clk);
 			clk_set_rate(armpll, old_freq_hz);
 			clk_set_parent(cpu_clk, armpll);
+			mutex_unlock(&info->lock);
 			return ret;
 		}
 	}
 
+	info->opp_freq = freq_hz;
+	mutex_unlock(&info->lock);
+
 	return 0;
 }
 
@@ -343,6 +383,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	struct dev_pm_opp *opp;
 	unsigned long rate;
 	int ret;
+	struct srcu_notifier_head *opp_srcu_head;
 
 	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
@@ -417,11 +458,25 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
 	rcu_read_unlock();
 
+	opp_srcu_head = dev_pm_opp_get_notifier(cpu_dev);
+	if (IS_ERR(opp_srcu_head)) {
+		ret = PTR_ERR(opp_srcu_head);
+		goto out_free_opp_table;
+	}
+
+	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
+	ret = srcu_notifier_chain_register(opp_srcu_head, &info->opp_nb);
+	if (ret)
+		goto out_free_opp_table;
+
 	info->cpu_dev = cpu_dev;
 	info->proc_reg = proc_reg;
 	info->sram_reg = IS_ERR(sram_reg) ? NULL : sram_reg;
 	info->cpu_clk = cpu_clk;
 	info->inter_clk = inter_clk;
+	info->opp_freq = clk_get_rate(cpu_clk);
+
+	mutex_init(&info->lock);
 
 	/*
 	 * If SRAM regulator is present, software "voltage tracking" is needed
-- 
1.9.1

