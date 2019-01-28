From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 3/7] cpufreq: scpi: Register an Energy Model
Date: Mon, 28 Jan 2019 16:55:18 +0000
Message-ID: <20190128165522.31749-4-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, mka@chromium.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from scpi-cpufreq, hence ensuring interested subsystems (the task
scheduler, for example) can make use of that information when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..05fc7448f5cb 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -23,6 +23,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -98,11 +99,12 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 
 static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret, nr_opp;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scpi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -135,6 +137,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
 	}
+	nr_opp = ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -170,6 +173,9 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = false;
+
+	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.20.1
