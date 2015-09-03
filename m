From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 2/3] cpufreq-dt: add suspend frequency support
Date: Thu, 03 Sep 2015 20:11:31 +0200
Message-ID: <1441303892-32004-3-git-send-email-b.zolnierkie@samsung.com>
References: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).  Also implement
custom suspend method (needed to not error out on platforms
which don't require suspend frequency).

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cd..ba4ca85 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -196,6 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct dev_pm_opp *suspend_opp;
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool need_update = false;
@@ -329,6 +330,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 
 	policy->clk = cpu_clk;
+
+	suspend_opp = dev_pm_opp_get_suspend_opp(cpu_dev);
+	if (suspend_opp)
+		policy->suspend_freq = dev_pm_opp_get_freq(suspend_opp) / 1000;
+
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
@@ -409,6 +415,31 @@ static void cpufreq_ready(struct cpufreq_policy *policy)
 	of_node_put(np);
 }
 
+#ifdef CONFIG_PM
+static int cpufreq_dt_suspend(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	if (!policy->suspend_freq) {
+		pr_debug("%s: suspend_freq not defined\n", __func__);
+		return 0;
+	}
+
+	pr_debug("%s: Setting suspend-freq: %u\n", __func__,
+			policy->suspend_freq);
+
+	ret = __cpufreq_driver_target(policy, policy->suspend_freq,
+			CPUFREQ_RELATION_H);
+	if (ret)
+		pr_err("%s: unable to set suspend-freq: %u. err: %d\n",
+				__func__, policy->suspend_freq, ret);
+
+	return ret;
+}
+#else
+#define cpufreq_dt_suspend NULL
+#endif
+
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
@@ -419,6 +450,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
+	.suspend = cpufreq_dt_suspend,
 };
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
-- 
1.9.1
