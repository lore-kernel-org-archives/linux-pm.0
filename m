From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH 1/5] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Wed, 16 Oct 2013 14:52:39 +0100
Message-ID: <1381931563-16785-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54921 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934581Ab3JPNxJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 09:53:09 -0400
In-Reply-To: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently clk_get_sys is used with cpu-cluster.<n> as the device id
which is incorrect. It should be connection/consumer ID instead.

It is possible to specify input clock in the cpu device node along
with the optional clock-name. clk_get_sys can't handle that.

This patch replaces clk_get_sys with clk_get to extend support for
clocks specified in the device tree cpu node.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 3549f07..501a091 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -127,7 +127,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
 	}
 
 	name[12] = cluster + '0';
-	clk[cluster] = clk_get_sys(name, NULL);
+	clk[cluster] = clk_get(cpu_dev, name);
 	if (!IS_ERR(clk[cluster])) {
 		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
 				__func__, clk[cluster], freq_table[cluster],
-- 
1.8.1.2

