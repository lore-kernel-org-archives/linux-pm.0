From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] cpufreq: arm_big_little: make cpufreq_arm_bL_ops structures const
Date: Thu, 19 Oct 2017 12:59:15 +0200
Message-ID: <1508410755-13666-3-git-send-email-bhumirks@gmail.com>
References: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:48788 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdJSK73 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 06:59:29 -0400
In-Reply-To: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: julia.lawall@lip6.fr, viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const as they are only getting passed to the functions
bL_cpufreq_{register/unregister} having the arguments as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/cpufreq/arm_big_little_dt.c    | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 39b3f51..b944f29 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -61,7 +61,7 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 	return transition_latency;
 }
 
-static struct cpufreq_arm_bL_ops dt_bL_ops = {
+static const struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dev_pm_opp_of_cpumask_add_table,
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 8de2364..05d2990 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -53,7 +53,7 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
 	return ret;
 }
 
-static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
+static const struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
 	.name	= "scpi",
 	.get_transition_latency = scpi_get_transition_latency,
 	.init_opp_table = scpi_init_opp_table,
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 87e5bdc..5323728 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -42,7 +42,7 @@ static int ve_spc_get_transition_latency(struct device *cpu_dev)
 	return 1000000; /* 1 ms */
 }
 
-static struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
+static const struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
 	.name	= "vexpress-spc",
 	.get_transition_latency = ve_spc_get_transition_latency,
 	.init_opp_table = ve_spc_init_opp_table,
-- 
1.9.1
