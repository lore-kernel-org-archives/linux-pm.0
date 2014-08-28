From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 08/10] cpufreq: cpu0: Make allocate_resources() work for any CPU
Date: Thu, 28 Aug 2014 11:22:30 +0530
Message-ID: <2f01b7a9b7abbdd4539fa27dff84656523bddf19.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60703 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbaH1FxZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so1121794pad.21
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:25 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently allocate_resources() supports only CPU0 and it would need to allocate
resources for any CPU going forward.

Add another argument to it, i.e. cpu, and update code accordingly.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index de38952..a5f8c5f 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -106,7 +106,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
-static int allocate_resources(struct device **cdev,
+static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
 	struct device *cpu_dev;
@@ -115,24 +115,28 @@ static int allocate_resources(struct device **cdev,
 	int ret = 0;
 	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
 
-	cpu_dev = get_cpu_device(0);
+	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu0 device\n");
+		pr_err("failed to get cpu%d device\n", cpu);
 		return -ENODEV;
 	}
 
 	/* Try "cpu0" for older DTs */
-	reg = reg_cpu0;
+	if (!cpu)
+		reg = reg_cpu0;
+	else
+		reg = reg_cpu;
 
 try_again:
 	cpu_reg = regulator_get_optional(cpu_dev, reg);
 	if (IS_ERR(cpu_reg)) {
 		/*
-		 * If cpu0 regulator supply node is present, but regulator is
+		 * If cpu's regulator supply node is present, but regulator is
 		 * not yet registered, we should try defering probe.
 		 */
 		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
-			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
+			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
+				cpu);
 			return -EPROBE_DEFER;
 		}
 
@@ -142,8 +146,8 @@ static int allocate_resources(struct device **cdev,
 			goto try_again;
 		}
 
-		dev_warn(cpu_dev, "failed to get cpu0 regulator: %ld\n",
-			 PTR_ERR(cpu_reg));
+		dev_warn(cpu_dev, "failed to get cpu%d regulator: %ld\n",
+			 cpu, PTR_ERR(cpu_reg));
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
@@ -159,9 +163,10 @@ static int allocate_resources(struct device **cdev,
 		 * registered, we should try defering probe.
 		 */
 		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu0 clock not ready, retry\n");
+			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
 		else
-			dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
+			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", ret,
+				cpu);
 	} else {
 		*cdev = cpu_dev;
 		*creg = cpu_reg;
@@ -183,8 +188,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	unsigned int transition_latency;
 	int ret;
 
-	/* We only support cpu0 currently */
-	ret = allocate_resources(&cpu_dev, &cpu_reg, &cpu_clk);
+	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
 	if (ret) {
 		pr_err("%s: Failed to allocate resources\n: %d", __func__, ret);
 		return ret;
@@ -322,7 +326,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	 *
 	 * FIXME: Is checking this only for CPU0 sufficient ?
 	 */
-	ret = allocate_resources(&cpu_dev, &cpu_reg, &cpu_clk);
+	ret = allocate_resources(0, &cpu_dev, &cpu_reg, &cpu_clk);
 	if (ret)
 		return ret;
 
-- 
2.0.3.693.g996b0fd

