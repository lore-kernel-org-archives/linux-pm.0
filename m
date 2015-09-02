From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: dt: Tolerance applies on both sides of target voltage
Date: Wed,  2 Sep 2015 14:36:50 +0530
Message-ID: <4166ff63e1992adefd757cd3774e841e137024f9.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Tolerance applies on both sides of the target voltage, i.e. both min and
max sides. But while checking if a voltage is supported by the regulator
or not, we haven't taken care of tolerance on the lower side. Fix that.

Cc: Lucas Stach <l.stach@pengutronix.de>
Fixes: 045ee45c4ff2 ("cpufreq: cpufreq-dt: disable unsupported OPPs")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b1131cf89757..3b64c203bf99 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -303,7 +303,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 			rcu_read_unlock();
 
 			tol_uV = opp_uV * priv->voltage_tolerance / 100;
-			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
+			if (regulator_is_supported_voltage(cpu_reg,
+							   opp_uV - tol_uV,
 							   opp_uV + tol_uV)) {
 				if (opp_uV < min_uV)
 					min_uV = opp_uV;
-- 
2.4.0
