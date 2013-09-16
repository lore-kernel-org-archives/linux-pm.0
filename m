From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 42/44] cpufreq: exynos: call cpufreq_frequency_table_put_attr()
Date: Mon, 16 Sep 2013 18:56:44 +0530
Message-ID: <41f49dc7f5f994eccb8eb6e3a1e381fef12605dd.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33116 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab3IPNbB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:31:01 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so5361565pab.11
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:31:00 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Acked-By: Amit Daniel Kachhap <amit.daniel@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index cf52759..ea3e3b2 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -339,12 +339,19 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= exynos_verify_speed,
 	.target		= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
+	.exit		= exynos_cpufreq_cpu_exit,
 	.name		= CPUFREQ_NAME,
 };
 
-- 
1.7.12.rc2.18.g61b472e

