From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 04/10] cpufreq: cpu0: print relevant error when we defer probe
Date: Thu, 28 Aug 2014 11:22:26 +0530
Message-ID: <c0c98a653568f0403fcb7f74b1c3c30db5119187.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47019 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933992AbaH1FxG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:06 -0400
Received: by mail-pa0-f54.google.com with SMTP id fb1so1123069pad.27
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:05 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently, we defer probe if regulator_get() returned -EPROBE_DEFER, i.e.
regulator isn't registered yet. We do a dev_err() in this case. Sending a
message to the log on probe defer just duplicates what the driver core is
already doing. Convert it to dev_dbg() instead.

We should defer in case of clk_get() as well.

Current code already does it, but it wasn't intentional probably. Its just that
we are returning the right error with wrong print message.

Fix print message to convey right error.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index d2dc921..eb07e3f 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -151,7 +151,16 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
-		pr_err("failed to get cpu0 clock: %d\n", ret);
+
+		/*
+		 * If cpu's clk node is present, but clock is not yet
+		 * registered, we should try defering probe.
+		 */
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "cpu0 clock not ready, retry\n");
+		else
+			dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
+
 		goto out_put_reg;
 	}
 
-- 
2.0.3.693.g996b0fd

