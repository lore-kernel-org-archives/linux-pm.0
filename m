From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH v4 2/2] cpufreq: ondemand: use all CPUs in update_sampling_rate
Date: Fri, 23 Nov 2012 10:31:57 +0100
Message-ID: <1353663117-10074-2-git-send-email-fabio.baltieri@linaro.org>
References: <1353663117-10074-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64968 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab2KWJck (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Nov 2012 04:32:40 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so1423350wib.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Nov 2012 01:32:39 -0800 (PST)
In-Reply-To: <1353663117-10074-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rickard Andersson <rickard.andersson@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>

Modify update_sampling_rate() to check, and eventually immediately
schedule, all CPU's do_dbs_timer delayed work.

This is required in case of software coordinated CPUs, as we now have a
separate delayed work for each CPU.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 849788b..14339f6 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -286,7 +286,7 @@ static void update_sampling_rate(unsigned int new_rate)
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			continue;
-		dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
+		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
 		mutex_lock(&dbs_info->timer_mutex);
@@ -306,7 +306,7 @@ static void update_sampling_rate(unsigned int new_rate)
 			cancel_delayed_work_sync(&dbs_info->work);
 			mutex_lock(&dbs_info->timer_mutex);
 
-			schedule_delayed_work_on(dbs_info->cpu, &dbs_info->work,
+			schedule_delayed_work_on(cpu, &dbs_info->work,
 						 usecs_to_jiffies(new_rate));
 
 		}
-- 
1.7.12.1

