From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 2/8] cpufreq: imx6q: add return value check for voltage scale
Date: Thu, 22 Nov 2018 14:57:09 -0500
Message-ID: <20181122195716.13961-2-sashal@kernel.org>
References: <20181122195716.13961-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122195716.13961-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Anson Huang <anson.huang@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit 6ef28a04d1ccf718eee069b72132ce4aa1e52ab9 ]

Add return value check for voltage scale when ARM clock
rate change fail.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa8145419..fa86946d12aa 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -130,8 +130,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	/* Ensure the arm clock divider is what we expect */
 	ret = clk_set_rate(arm_clk, new_freq * 1000);
 	if (ret) {
+		int ret1;
+
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		ret1 = regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		if (ret1)
+			dev_warn(cpu_dev,
+				 "failed to restore vddarm voltage: %d\n", ret1);
 		return ret;
 	}
 
-- 
2.17.1
