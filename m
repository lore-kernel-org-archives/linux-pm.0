From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v17] Currently SPM driver always initializes before the cpuidle driver
Date: Mon, 23 Mar 2015 09:46:29 -0600
Message-ID: <1427125589-63560-1-git-send-email-lina.iyer@linaro.org>
References: <1426882877-33008-2-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426882877-33008-2-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Remove unnecessary complexity in supporting initialization of SPM driver
after cpuidle driver. The current kernel initializes SPM driver before
cpuidle driver.

Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/soc/qcom/spm.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index cda321c..84344e7 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -266,13 +266,9 @@ static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
 	per_cpu(qcom_idle_ops, cpu) = fns;
 
 	/*
-	 * Condition: cpuidle_driver_register() needs to happen before
-	 * cpuidle_register_device().
-	 * Check if the SPM probe has happened -
-	 * - If SPM probed successfully before arm_idle_init(), then defer
-	 *   the registration of cpuidle_device back to arm_idle_init()
-	 * - If the SPM probe happens in the future, then let the SPM probe
-	 *   register the cpuidle device, return -ENXIO.
+	 * SPM probe for the cpu should have happened by now, if the
+	 * SPM device does not exist, return -ENXIO to indicate that the
+	 * cpu does not support idle states.
 	 */
 check_spm:
 	return per_cpu(cpu_spm_drv, cpu) ? 0 : -ENXIO;
@@ -332,7 +328,6 @@ static int spm_dev_probe(struct platform_device *pdev)
 	const struct of_device_id *match_id;
 	void __iomem *addr;
 	int cpu;
-	int ret = 0;
 
 	drv = spm_get_drv(pdev, &cpu);
 	if (!drv)
@@ -373,22 +368,7 @@ static int spm_dev_probe(struct platform_device *pdev)
 
 	per_cpu(cpu_spm_drv, cpu) = drv;
 
-	/*
-	 * If the cpuidle ops have already been registered with cpuidle,
-	 * then we have been waiting on this SPM probe to register the
-	 * cpuidle device.
-	 */
-	if (per_cpu(qcom_idle_ops, cpu)) {
-		struct cpuidle_device *dev;
-
-		dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-		if (!dev)
-			return -ENOMEM;
-		dev->cpu = cpu;
-		ret = cpuidle_register_device(dev);
-	}
-
-	return ret;
+	return 0;
 }
 
 static struct platform_driver spm_driver = {
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
