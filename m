From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Tegra: drop wrapper around tegra_update_cpu_speed()
Date: Thu, 15 May 2014 11:21:19 +0530
Message-ID: <a38df05b91198f393b1c4b78f39110c6bece3627.1400133049.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33836 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaEOFv1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 01:51:27 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so9176955wib.4
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 22:51:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Tegra has implemented an unnecessary wrapper over tegra_update_cpu_speed(), i.e.
tegra_target(), which wasn't doing anything apart of calling
tegra_update_cpu_speed(). Get rid of that and use tegra_target() directly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index 63f0059..6e774c6 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -82,9 +82,9 @@ out:
 	return ret;
 }
 
-static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
-		unsigned long rate)
+static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
+	unsigned long rate = freq_table[index].frequency;
 	int ret = 0;
 
 	/*
@@ -106,11 +106,6 @@ static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
-{
-	return tegra_update_cpu_speed(policy, freq_table[index].frequency);
-}
-
 static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret;
-- 
2.0.0.rc2

