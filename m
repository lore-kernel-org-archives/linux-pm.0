From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 03/10] PM / OPP: Don't use OPP structure outside of rcu protected section
Date: Thu, 24 Nov 2016 17:06:12 +0530
Message-ID: <7817d2d3ccc77680c6e40101e80d201794398693.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The OPP structure must not be used out of the rcu protected section.
Cache the values to be used in separate variables instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/opp/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..056527a3fb4e 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -584,6 +584,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	unsigned long freq, old_freq;
 	unsigned long u_volt, u_volt_min, u_volt_max;
+	unsigned long old_u_volt, old_u_volt_min, old_u_volt_max;
 	int ret;
 
 	if (unlikely(!target_freq)) {
@@ -633,6 +634,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return ret;
 	}
 
+	if (IS_ERR(old_opp)) {
+		old_u_volt = 0;
+	} else {
+		old_u_volt = old_opp->u_volt;
+		old_u_volt_min = old_opp->u_volt_min;
+		old_u_volt_max = old_opp->u_volt_max;
+	}
+
 	u_volt = opp->u_volt;
 	u_volt_min = opp->u_volt_min;
 	u_volt_max = opp->u_volt_max;
@@ -677,9 +686,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			__func__, old_freq);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (!IS_ERR(old_opp))
-		_set_opp_voltage(dev, reg, old_opp->u_volt,
-				 old_opp->u_volt_min, old_opp->u_volt_max);
+	if (old_u_volt) {
+		_set_opp_voltage(dev, reg, old_u_volt, old_u_volt_min,
+				 old_u_volt_max);
+	}
 
 	return ret;
 }
-- 
2.7.1.410.g6faf27b
