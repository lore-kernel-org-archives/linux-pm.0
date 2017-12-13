From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] cpufreq: schedutil: Initialize sg_cpu->flags to 0
Date: Wed, 13 Dec 2017 15:23:20 +0530
Message-ID: <763feda6424ced8486b25a0c52979634e6104478.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33312 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbdLMJxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:53:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id g7so1047627pgs.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 01:53:31 -0800 (PST)
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

Initializing sg_cpu->flags to SCHED_CPUFREQ_RT has no obvious benefit.
The flags field wouldn't be used until the utilization update handler is
called for the first time, and once that is called we will overwrite
flags anyway.

Initialize it to 0.

Change-Id: I028dbb40c5c242cff52fe1b14aeaff37f29a2f8d
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2f52ec0f1539..e8ccfa30f01a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -655,7 +655,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
-		sg_cpu->flags = SCHED_CPUFREQ_RT;
+		sg_cpu->flags = 0;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
 	}
 
-- 
2.15.0.194.g9af6a3dea062
