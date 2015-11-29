From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 3/4] cpufreq: mt8173: check return value of regulator_get_voltage() call
Date: Sun, 29 Nov 2015 16:31:37 +0800
Message-ID: <1448785898-17838-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35749 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbK2Ibv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 03:31:51 -0500
Received: by pacej9 with SMTP id ej9so152808467pac.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 00:31:51 -0800 (PST)
In-Reply-To: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Sometimes regulator_get_voltage() call returns negative values for
reasons(e.g. underlying I2C bus timeout). Add check for the return
values and fail out early.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 750cda7..9d0fe37 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -59,6 +59,10 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
 
 	old_vproc = regulator_get_voltage(proc_reg);
+	if (old_vproc < 0) {
+		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
+		return old_vproc;
+	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
 	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
 
@@ -71,7 +75,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		 */
 		do {
 			old_vsram = regulator_get_voltage(sram_reg);
+			if (old_vsram < 0) {
+				pr_err("%s: invalid Vsram value: %d\n",
+				       __func__, old_vsram);
+				return old_vsram;
+			}
 			old_vproc = regulator_get_voltage(proc_reg);
+			if (old_vproc < 0) {
+				pr_err("%s: invalid Vproc value: %d\n",
+				       __func__, old_vproc);
+				return old_vproc;
+			}
 
 			vsram = min(new_vsram, old_vproc + MAX_VOLT_SHIFT);
 
@@ -116,7 +130,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		 */
 		do {
 			old_vproc = regulator_get_voltage(proc_reg);
+			if (old_vproc < 0) {
+				pr_err("%s: invalid Vproc value: %d\n",
+				       __func__, old_vproc);
+				return old_vproc;
+			}
 			old_vsram = regulator_get_voltage(sram_reg);
+			if (old_vsram < 0) {
+				pr_err("%s: invalid Vsram value: %d\n",
+				       __func__, old_vsram);
+				return old_vsram;
+			}
 
 			vproc = max(new_vproc, old_vsram - MAX_VOLT_SHIFT);
 			ret = regulator_set_voltage(proc_reg, vproc,
@@ -184,6 +208,10 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	old_freq_hz = clk_get_rate(cpu_clk);
 	old_vproc = regulator_get_voltage(info->proc_reg);
+	if (old_vproc < 0) {
+		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
+		return old_vproc;
+	}
 
 	freq_hz = freq_table[index].frequency * 1000;
 
-- 
1.9.1

