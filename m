From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v5 1/2] cpufreq / OPP: Allow boost frequency to be looked up from device tree
Date: Thu, 29 May 2014 20:08:38 +0530
Message-ID: <1401374319-4480-2-git-send-email-thomas.ab@samsung.com>
References: <1401374319-4480-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1401374319-4480-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode. This patch adds support for finding available
boost frequencies from device tree and marking them as usable in boost mode.

Cc: Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/cpufreq/cpufreq_opp.c |   45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index c0c6f4a..05fb115 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -19,6 +19,7 @@
 #include <linux/pm_opp.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 /**
  * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
@@ -51,6 +52,11 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	struct cpufreq_frequency_table *freq_table = NULL;
 	int i, max_opps, ret = 0;
 	unsigned long rate;
+#ifdef CONFIG_CPU_FREQ_BOOST_SW
+	struct cpufreq_frequency_table *ft;
+	int len, count;
+	u32 *boost_freqs = NULL;
+#endif
 
 	rcu_read_lock();
 
@@ -82,6 +88,45 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 
 	*table = &freq_table[0];
 
+#ifdef CONFIG_CPU_FREQ_BOOST_SW
+	if (!of_find_property(dev->of_node, "boost-frequencies", &len))
+		goto out;
+
+	if (!len || !IS_ALIGNED(len, sizeof(u32))) {
+		dev_err(dev, "%s: invalid boost frequency\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	boost_freqs = kmalloc(len, GFP_KERNEL);
+	if (!boost_freqs) {
+		dev_err(dev, "%s: no memory for boost freq table\n", __func__);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	count = len / sizeof(u32);
+	of_property_read_u32_array(dev->of_node, "boost-frequencies",
+			boost_freqs, count);
+
+	for (i = 0; i < count; i++) {
+		cpufreq_for_each_valid_entry(ft, *table) {
+			if (boost_freqs[i] == ft->frequency) {
+				ft->flags |= CPUFREQ_BOOST_FREQ;
+				pr_debug("%s: marked %d as boost frequency\n",
+					__func__, boost_freqs[i]);
+				break;
+			}
+		}
+
+		if (ft->frequency == CPUFREQ_TABLE_END)
+			dev_err(dev, "%s: invalid boost frequency %d\n",
+				__func__, boost_freqs[i]);
+	}
+
+	kfree(boost_freqs);
+#endif
+
 out:
 	rcu_read_unlock();
 	if (ret)
-- 
1.7.9.5
