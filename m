From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 1/6] cpufreq: make scaling_boost_freqs sysfs attr available
 when boost is enabled
Date: Thu, 06 Aug 2015 15:41:49 +0200
Message-ID: <1438868514-8814-2-git-send-email-b.zolnierkie@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Add cpufreq_boost_enabled_generic_attr table and use it in
cpufreq-dt driver instead of cpufreq_generic_attr one when
boost support is enabled.  As a result scaling_boost_freqs
sysfs attribute is available when cpufreq-dt driver is
used and boost support is enabled.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 3 +++
 drivers/cpufreq/freq_table.c | 7 +++++++
 include/linux/cpufreq.h      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b9259ab..7b091c0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -182,6 +182,8 @@ try_again:
 	return ret;
 }
 
+static struct cpufreq_driver dt_cpufreq_driver;
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -336,6 +338,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = cpufreq_enable_boost_support();
 		if (ret)
 			goto out_free_cpufreq_table;
+		dt_cpufreq_driver.attr = cpufreq_boost_enabled_generic_attr;
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index a8f1daf..5a00a09 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -300,6 +300,13 @@ struct freq_attr *cpufreq_generic_attr[] = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
 
+struct freq_attr *cpufreq_boost_enabled_generic_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	&cpufreq_freq_attr_scaling_boost_freqs,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(cpufreq_boost_enabled_generic_attr);
+
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f0186..25937ff 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -610,6 +610,7 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr *cpufreq_generic_attr[];
+extern struct freq_attr *cpufreq_boost_enabled_generic_attr[];
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
 
-- 
1.9.1
