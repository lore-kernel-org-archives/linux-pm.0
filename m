From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 7/9] cpufreq: schedutil: Set dynamic_switching to true
Date: Wed, 19 Jul 2017 15:42:47 +0530
Message-ID: <4bc6051ec75b42cf91810d71cc8581f4ddcf93f2.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36487 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbdGSKNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 06:13:32 -0400
Received: by mail-pf0-f173.google.com with SMTP id o88so18903342pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 03:13:32 -0700 (PDT)
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

Set dynamic_switching to 'true' to disallow use of schedutil governor
for platforms with transition_latency set to CPUFREQ_ETERNAL, as they
may not want to do automatic dynamic frequency switching.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 89c4dd9777bb..45fcf21ad685 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -646,6 +646,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 static struct cpufreq_governor schedutil_gov = {
 	.name = "schedutil",
 	.owner = THIS_MODULE,
+	.dynamic_switching = true,
 	.init = sugov_init,
 	.exit = sugov_exit,
 	.start = sugov_start,
-- 
2.13.0.71.gd7076ec9c9cb
