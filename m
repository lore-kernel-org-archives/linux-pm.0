From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/10] cpufreq: cpu0: Update Module Author
Date: Thu, 28 Aug 2014 11:22:24 +0530
Message-ID: <ed9372a696b0fff5ba9d3cefd638ba026d140f33.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49323 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaH1Fw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:52:56 -0400
Received: by mail-pa0-f47.google.com with SMTP id hz1so1117900pad.20
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:52:56 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Two people are maintaining it now, Viresh and Shawn. Add Viresh's details in
MODULE_AUTHOR() and copyright section.

Suggested-by: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 0d2172b..4cfde63 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  *
+ * Copyright (C) 2014 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
  * The OPP code in function cpu0_set_target() is reused from
  * drivers/cpufreq/omap-cpufreq.c
  *
@@ -243,6 +246,7 @@ static struct platform_driver cpu0_cpufreq_platdrv = {
 };
 module_platform_driver(cpu0_cpufreq_platdrv);
 
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.0.3.693.g996b0fd

