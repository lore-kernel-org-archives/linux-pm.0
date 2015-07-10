From: Cristian Ardelean <cristian97.ardelean@gmail.com>
Subject: [PATCH] cpufreq: integrator: fixed coding style issues
Date: Fri, 10 Jul 2015 14:42:15 -0400
Message-ID: <1436553735-17622-1-git-send-email-cristian97.ardelean@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Cristian Ardelean <cristian97.ardelean@gmail.com>
List-Id: linux-pm@vger.kernel.org

Fixed coding style issues found by checkpatch.pl tool. Changed
space indentation to tab, removed unneccesary braces, removed
space between MODULE macros and parentheses.

REMARKS: failed to 'make' this file with error message
'fatal error: asm/mach-types.h: No such file or directory'.

Signed-off-by: Cristian Ardelean <cristian97.ardelean@gmail.com>
---
 drivers/cpufreq/integrator-cpufreq.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index 129e266..2faa421 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -98,11 +98,10 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	/* get current setting */
 	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
 
-	if (machine_is_integrator()) {
+	if (machine_is_integrator())
 		vco.s = (cm_osc >> 8) & 7;
-	} else if (machine_is_cintegrator()) {
+	else if (machine_is_cintegrator())
 		vco.s = 1;
-	}
 	vco.v = cm_osc & 255;
 	vco.r = 22;
 	freqs.old = icst_hz(&cclk_params, vco) / 1000;
@@ -163,11 +162,10 @@ static unsigned int integrator_get(unsigned int cpu)
 	/* detect memory etc. */
 	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
 
-	if (machine_is_integrator()) {
+	if (machine_is_integrator())
 		vco.s = (cm_osc >> 8) & 7;
-	} else {
+	else
 		vco.s = 1;
-	}
 	vco.v = cm_osc & 255;
 	vco.r = 22;
 
@@ -203,7 +201,7 @@ static int __init integrator_cpufreq_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-        if (!res)
+	if (!res)
 		return -ENODEV;
 
 	cm_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
@@ -234,6 +232,6 @@ static struct platform_driver integrator_cpufreq_driver = {
 module_platform_driver_probe(integrator_cpufreq_driver,
 			     integrator_cpufreq_probe);
 
-MODULE_AUTHOR ("Russell M. King");
-MODULE_DESCRIPTION ("cpufreq driver for ARM Integrator CPUs");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Russell M. King");
+MODULE_DESCRIPTION("cpufreq driver for ARM Integrator CPUs");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
