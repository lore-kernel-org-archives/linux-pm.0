From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v4 4/5] cpufreq: arm_big_little: Register an Energy Model
Date: Mon,  4 Feb 2019 11:09:51 +0000
Message-ID: <20190204110952.16025-5-quentin.perret@arm.com>
References: <20190204110952.16025-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from the arm_big_little CPUFreq driver, hence ensuring interested
subsystems (the task scheduler, for example) can make use of that
information when available.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index cf62a1f64dd7..7fe52fcddcf1 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -487,6 +487,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 				arm_bL_ops->get_transition_latency(cpu_dev);
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
 
-- 
2.20.1
