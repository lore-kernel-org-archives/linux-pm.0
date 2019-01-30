From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 2/5] cpufreq: dt: Register an Energy Model
Date: Wed, 30 Jan 2019 17:05:03 +0000
Message-ID: <20190130170506.20450-3-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from cpufreq-dt, hence ensuring interested subsystems (the task
scheduler, for example) can make use of that information when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/cpufreq-dt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..1d4ad6f67408 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -160,7 +160,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned int transition_latency;
 	bool fallback = false;
 	const char *name;
-	int ret;
+	int ret, nr_opp;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -231,8 +231,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 * But we need OPP table to function so if it is not there let's
 	 * give platform code chance to provide it for us.
 	 */
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
@@ -280,6 +280,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
 
+	dev_pm_opp_of_register_em(policy->cpus, nr_opp);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.20.1
