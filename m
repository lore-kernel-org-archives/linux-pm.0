From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 5/5] cpufreq: dt: Add support for interconnect bandwidth scaling
Date: Tue, 23 Apr 2019 16:28:23 +0300
Message-ID: <20190423132823.7915-6-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bde28878725b..8a20f4d0243e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -98,6 +99,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -124,6 +126,19 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
+	cpu_path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(cpu_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
+
+		return ret;
+	}
+
+	icc_put(cpu_path);
+
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
@@ -203,10 +218,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	opp_table = dev_pm_opp_set_paths(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(cpu_dev, "Failed to set interconnect path for cpu%d: %d\n",
+			policy->cpu, ret);
+		goto out_put_regulator;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_put_regulator;
+		goto out_put_path;
 	}
 
 	priv->reg_name = name;
@@ -288,6 +311,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	kfree(priv);
+out_put_path:
+	dev_pm_opp_put_paths(opp_table);
 out_put_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
