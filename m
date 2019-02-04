From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v4 3/5] cpufreq: scpi: Register an Energy Model
Date: Mon,  4 Feb 2019 11:09:50 +0000
Message-ID: <20190204110952.16025-4-quentin.perret@arm.com>
References: <20190204110952.16025-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from scpi-cpufreq, hence ensuring interested subsystems (the task
scheduler, for example) can make use of that information when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..b279f94d82f7 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -170,6 +170,9 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = false;
+
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.20.1
