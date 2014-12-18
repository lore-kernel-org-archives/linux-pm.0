From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/13] cpufreq: stats: return -EEXIST when stats are already allocated
Date: Thu, 18 Dec 2014 17:30:19 +0530
Message-ID: <ecc1c6409b288aba48dc6969818c43e2f02bb2d9.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64623 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:09 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so1285815pde.40
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:09 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

__cpufreq_stats_create_table() is called from:
- policy create notifier: stats will always be NULL here
- cpufreq_stats_init() calls it for all CPUs as cpufreq-stats can be initialized
  after cpufreq driver. Because CPUs share clock lines, 'stats' will be NULL
  here for the first cpu only and will return back for others.

While we return for other CPUs, we don't return the right error value. We must
return -EEXIST, as that is the case here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 81be4d637ab4..403671b1a5ee 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -192,8 +192,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (unlikely(!table))
 		return 0;
 
+	/* stats already initialized */
 	if (per_cpu(cpufreq_stats_table, cpu))
-		return -EBUSY;
+		return -EEXIST;
+
 	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
 	if ((stat) == NULL)
 		return -ENOMEM;
-- 
2.2.0

