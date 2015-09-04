From: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] thermal: mediatek: Add cpu power cooling model
Date: Fri, 4 Sep 2015 17:01:48 +0800
Message-ID: <1441357309-61669-2-git-send-email-dawei.chien@mediatek.com>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1441357309-61669-1-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Use Intelligent Power Allocation (IPA) technical to add
static/dynamic power model for binding CPU thermal zone.
The power allocator governor allocates power budget to control
CPU temperature.

Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
This patch is base on
https://patchwork.kernel.org/patch/7034601/
---
 drivers/cpufreq/mt8173-cpufreq.c |   97 +++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 49caed2..9233ec5 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -28,7 +28,8 @@
 #define MAX_VOLT_SHIFT		(200000)
 #define MAX_VOLT_LIMIT		(1150000)
 #define VOLT_TOL		(10000)
-
+#define CAPACITANCE_CA53	(263)
+#define CAPACITANCE_CA57	(530)
 /*
  * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
  * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
@@ -51,6 +52,72 @@ struct mtk_cpu_dvfs_info {
 	bool need_voltage_tracking;
 };
 
+struct mtk_cpu_static_power {
+	unsigned long voltage;
+	unsigned int power;
+};
+
+/* measured by WA program. */
+static const struct mtk_cpu_static_power mtk_ca53_static_power[] = {
+	{859000, 43},
+	{908000, 52},
+	{983000, 86},
+	{1009000, 123},
+	{1028000, 138},
+	{1083000, 172},
+	{1109000, 180},
+	{1125000, 192},
+};
+
+/* measured by WA program. */
+static const struct mtk_cpu_static_power mtk_ca57_static_power[] = {
+	{828000, 72},
+	{867000, 90},
+	{927000, 156},
+	{968000, 181},
+	{1007000, 298},
+	{1049000, 435},
+	{1089000, 533},
+	{1125000, 533},
+};
+
+unsigned int mtk_cpufreq_lookup_power(const struct mtk_cpu_static_power *table,
+		unsigned int count, unsigned long voltage)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (voltage <= table[i].voltage)
+			return table[i].power;
+	}
+
+	return table[count - 1].power;
+}
+
+int mtk_cpufreq_get_static(cpumask_t *cpumask, int interval,
+		unsigned long voltage, u32 *power)
+{
+	int nr_cpus = cpumask_weight(cpumask);
+
+	*power = 0;
+
+	if (nr_cpus) {
+
+		if (cpumask_test_cpu(0, cpumask))
+			*power += mtk_cpufreq_lookup_power(
+				mtk_ca53_static_power,
+				ARRAY_SIZE(mtk_ca53_static_power),
+				voltage);
+
+		if (cpumask_test_cpu(2, cpumask))
+			*power += mtk_cpufreq_lookup_power(
+				mtk_ca57_static_power,
+				ARRAY_SIZE(mtk_ca57_static_power),
+				voltage);
+	}
+	return 0;
+}
+
 static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 					int new_vproc)
 {
@@ -272,15 +339,21 @@ static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 		return;
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		info->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
-
-		if (IS_ERR(info->cdev)) {
-			dev_err(info->cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(info->cdev));
-
-			info->cdev = NULL;
+		u32 capacitance = cpumask_test_cpu(0, policy->related_cpus) ?
+			CAPACITANCE_CA53 : CAPACITANCE_CA57;
+
+		if (!info->cdev) {
+			info->cdev = of_cpufreq_power_cooling_register(np,
+				policy->related_cpus,
+				capacitance,
+				mtk_cpufreq_get_static);
+
+			if (IS_ERR(info->cdev)) {
+				dev_err(info->cpu_dev,
+					"running cpufreq without cooling device: %ld\n",
+					PTR_ERR(info->cdev));
+					info->cdev = NULL;
+			}
 		}
 	}
 
@@ -460,7 +533,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	cpufreq_cooling_unregister(info->cdev);
+	if (info->cdev)
+		cpufreq_cooling_unregister(info->cdev);
+
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 	mtk_cpu_dvfs_info_release(info);
 	kfree(info);
-- 
1.7.9.5
