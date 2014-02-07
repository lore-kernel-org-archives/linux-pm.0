From: Thomas Abraham <ta.omasab@gmail.com>
Subject: [PATCH v2 1/2] PM / OPP: Allow boost frequency to be looked up from device tree
Date: Fri,  7 Feb 2014 20:49:01 +0530
Message-ID: <1391786342-11812-2-git-send-email-thomas.ab@samsung.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
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
 drivers/base/power/opp.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index fa41874..b636826 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -628,7 +628,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table;
-	int i = 0;
+	int i = 0, j, len, ret;
+	u32 *boost_freqs = NULL;
 
 	/* Pretend as if I am an updater */
 	mutex_lock(&dev_opp_list_lock);
@@ -650,10 +651,35 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		return -ENOMEM;
 	}
 
+	if (of_find_property(dev->of_node, "boost-frequency", &len)) {
+		if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
+			dev_err(dev, "%s: invalid boost frequency\n", __func__);
+			ret = -EINVAL;
+			goto err_boost;
+		}
+
+		boost_freqs = kzalloc(len, GFP_KERNEL);
+		if (!boost_freqs) {
+			dev_warn(dev, "%s: no memory for boost freq table\n",
+					__func__);
+			ret = -ENOMEM;
+			goto err_boost;
+		}
+		of_property_read_u32_array(dev->of_node, "boost-frequency",
+			boost_freqs, len / sizeof(u32));
+	}
+
 	list_for_each_entry(opp, &dev_opp->opp_list, node) {
 		if (opp->available) {
 			freq_table[i].driver_data = i;
 			freq_table[i].frequency = opp->rate / 1000;
+			for (j = 0; j < len / sizeof(u32) && boost_freqs; j++) {
+				if (boost_freqs[j] == freq_table[i].frequency) {
+					freq_table[i].driver_data =
+							CPUFREQ_BOOST_FREQ;
+					break;
+				}
+			}
 			i++;
 		}
 	}
@@ -663,8 +689,14 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	freq_table[i].frequency = CPUFREQ_TABLE_END;
 
 	*table = &freq_table[0];
+	kfree(boost_freqs);
 
 	return 0;
+
+err_boost:
+	kfree(freq_table);
+	mutex_unlock(&dev_opp_list_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
 
-- 
1.7.10.4
