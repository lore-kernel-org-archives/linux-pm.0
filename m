From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/4] cpufreq: governor: Process remote callback for shared policies
Date: Thu, 29 Jun 2017 10:56:31 +0530
Message-ID: <e41df6731e29c46f69955b0432befd6db9242f0b.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36582 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdF2F2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:28:00 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so42283863pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2017 22:28:00 -0700 (PDT)
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

This patch updates the legacy governors (ondemand/conservative) to
process cpufreq utilization update hooks to be called for remote CPUs
(i.e. For updates to the runqueue of other non-local CPUs).

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 47e24b5384b3..0b49fc8bb91d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -275,6 +275,10 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (!cpumask_test_cpu(smp_processor_id(), policy_dbs->policy->cpus))
+		return;
+
 	/*
 	 * The work may not be allowed to be queued up right now.
 	 * Possible reasons:
-- 
2.13.0.71.gd7076ec9c9cb
