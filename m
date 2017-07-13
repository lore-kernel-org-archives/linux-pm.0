From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V2 2/6] cpufreq: schedutil: Set dynamic_switching to true
Date: Thu, 13 Jul 2017 11:10:53 +0530
Message-ID: <2b68422c8b9ecd1561cc283bb2f8fa68517f07e7.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33125 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdGMFlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 01:41:36 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so23993013pfk.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 22:41:35 -0700 (PDT)
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
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
index 076a2e31951c..ab9d7a1b43dc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -650,6 +650,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 static struct cpufreq_governor schedutil_gov = {
 	.name = "schedutil",
 	.owner = THIS_MODULE,
+	.dynamic_switching = true,
 	.init = sugov_init,
 	.exit = sugov_exit,
 	.start = sugov_start,
-- 
2.13.0.71.gd7076ec9c9cb
