From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 2/3] cpufreq-dt: Supply power coefficient when registering cooling devices
Date: Mon, 16 Nov 2015 19:30:24 +0000
Message-ID: <1447702225-13323-3-git-send-email-punit.agrawal@arm.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447702225-13323-1-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, javi.merino-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Support registering cooling devices with dynamic power coefficient
where provided by the device tree. This allows OF registered cooling
devices driver to be used with the power_allocator thermal governor.

Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 90d6408..1ceece9 100644
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
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
