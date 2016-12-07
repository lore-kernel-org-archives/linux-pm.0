From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/12] PM / OPP: Simplify dev_pm_opp_get_max_volt_latency()
Date: Wed,  7 Dec 2016 16:07:49 +0530
Message-ID: <a5187f39f00bb5904d8b6e86f6afe12545e6852a.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_get_max_volt_latency() calls _find_opp_table() two times
effectively.

Merge _get_regulator_count() into dev_pm_opp_get_max_volt_latency() to
avoid that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6a1374fafe75..21be3377c135 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -170,22 +170,6 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 
-static int _get_regulator_count(struct device *dev)
-{
-	struct opp_table *opp_table;
-	int count;
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return 0;
-
-	count = opp_table->regulator_count;
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return count;
-}
-
 /**
  * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanoseconds
  * @dev: device for which we do this operation
@@ -204,24 +188,24 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 		unsigned long max;
 	} *uV;
 
-	count = _get_regulator_count(dev);
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	count = opp_table->regulator_count;
 
 	/* Regulator may not be required for the device */
 	if (!count)
-		return 0;
+		goto put_opp_table;
 
 	regulators = kmalloc_array(count, sizeof(*regulators), GFP_KERNEL);
 	if (!regulators)
-		return 0;
+		goto put_opp_table;
 
 	uV = kmalloc_array(count, sizeof(*uV), GFP_KERNEL);
 	if (!uV)
 		goto free_regulators;
 
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		goto free_uV;
-
 	memcpy(regulators, opp_table->regulators, count * sizeof(*regulators));
 
 	mutex_lock(&opp_table->lock);
@@ -242,7 +226,6 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	}
 
 	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
 
 	/*
 	 * The caller needs to ensure that opp_table (and hence the regulator)
@@ -254,10 +237,11 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 			latency_ns += ret * 1000;
 	}
 
-free_uV:
 	kfree(uV);
 free_regulators:
 	kfree(regulators);
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return latency_ns;
 }
-- 
2.7.1.410.g6faf27b
