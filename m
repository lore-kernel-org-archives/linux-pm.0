From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v3 2/3] cpufreq-dt: Supply power coefficient when registering cooling devices
Date: Mon,  9 Nov 2015 17:29:22 +0000
Message-ID: <1447090163-13700-3-git-send-email-punit.agrawal@arm.com>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: viresh.kumar@linaro.org, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com
List-Id: linux-pm@vger.kernel.org

Support registering cooling devices with dynamic power coefficient
where provided by the device tree. This allows OF registered cooling
devices driver to be used with the power_allocator thermal governor.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7c0d70e..4434e45 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -407,8 +407,13 @@ static void cpufreq_ready(struct cpufreq_policy *policy)
 	 * thermal DT code takes care of matching them.
 	 */
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		priv->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		u32 power_coefficient = 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &power_coefficient);
+
+		priv->cdev = of_cpufreq_power_cooling_register(np,
+				policy->related_cpus, power_coefficient, NULL);
 		if (IS_ERR(priv->cdev)) {
 			dev_err(priv->cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
-- 
2.5.3
