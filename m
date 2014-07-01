From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/14] cpufreq: cpu0: defer probe if clock isn't registered yet
Date: Tue,  1 Jul 2014 22:02:35 +0530
Message-ID: <eb6df0f1f2c82db0d516b9b63820cfe0c0c97d5c.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently, we defer probe if regulator_get() returned -EPROBE_DEFER, i.e.
regulator isn't registered yet.

The same is true for clock as well, so lets defer in that case as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 4273a5f..b5b8e1c 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -150,8 +150,17 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
-		ret = PTR_ERR(cpu_clk);
-		pr_err("failed to get cpu0 clock: %d\n", ret);
+		/*
+		 * If cpu's clk node is present, but clock is not yet
+		 * registered, we should try defering probe.
+		 */
+		if (PTR_ERR(cpu_clk) == -EPROBE_DEFER) {
+			dev_err(cpu_dev, "cpu0 clock not ready, retry\n");
+			ret = -EPROBE_DEFER;
+		} else {
+			ret = PTR_ERR(cpu_clk);
+			dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
+		}
 		goto out_put_reg;
 	}
 
-- 
2.0.0.rc2
