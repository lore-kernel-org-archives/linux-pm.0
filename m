From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 38/44] cpufreq: tegra: fix implementation of ->exit()
Date: Mon, 16 Sep 2013 18:56:40 +0530
Message-ID: <4106fd9c9d0f7b4a770a868bb29d686a1dfb485e.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53891 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab3IPNah (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:30:37 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so4097522pdj.20
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:30:37 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

->exit() of drivers should call cpufreq_frequency_table_put_attr() if they have
called cpufreq_frequency_table_get_attr() earlier in init() and they aren't
required to validate their cpufreq table in exit by calling
cpufreq_frequency_table_cpuinfo(). Tegra's driver wasn't calling
cpufreq_frequency_table_put_attr() and was calling
cpufreq_frequency_table_cpuinfo() in exit.

Fix both these issues in it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index d45c1d8..e014077 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -232,7 +232,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
-	cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	clk_disable_unprepare(emc_clk);
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

