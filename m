From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 07/10] cpufreq: cpu0: try regulators with name "cpu-supply"
Date: Thu, 28 Aug 2014 11:22:29 +0530
Message-ID: <65c2c6931b4787091b865252a784f026476d4586.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59100 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216AbaH1FxU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:20 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so1110562pad.40
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:20 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently, we expect regulator name to be "cpu0", but as we are going to support
multiple cpu-blocks (all CPUs in a block share clock/voltage) later, we need to
pass some generic string instead of that.

For backwards compatibility try for "cpu0" first and if it fails, then try for
"cpu".

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 03e352b..de38952 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -113,6 +113,7 @@ static int allocate_resources(struct device **cdev,
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	int ret = 0;
+	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
@@ -120,7 +121,11 @@ static int allocate_resources(struct device **cdev,
 		return -ENODEV;
 	}
 
-	cpu_reg = regulator_get_optional(cpu_dev, "cpu0");
+	/* Try "cpu0" for older DTs */
+	reg = reg_cpu0;
+
+try_again:
+	cpu_reg = regulator_get_optional(cpu_dev, reg);
 	if (IS_ERR(cpu_reg)) {
 		/*
 		 * If cpu0 regulator supply node is present, but regulator is
@@ -130,6 +135,13 @@ static int allocate_resources(struct device **cdev,
 			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
 			return -EPROBE_DEFER;
 		}
+
+		/* Try with "cpu-supply" */
+		if (reg == reg_cpu0) {
+			reg = reg_cpu;
+			goto try_again;
+		}
+
 		dev_warn(cpu_dev, "failed to get cpu0 regulator: %ld\n",
 			 PTR_ERR(cpu_reg));
 	}
-- 
2.0.3.693.g996b0fd

