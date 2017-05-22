From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Mon, 22 May 2017 10:40:14 +0530
Message-ID: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34163 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEVFKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 01:10:25 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so70538521pfj.1
        for <linux-pm@vger.kernel.org>; Sun, 21 May 2017 22:10:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

The rate_limit_us for the schedutil governor is getting set to 500 ms by
default for the ARM64 hikey board. And its way too much, even for the
default value. Lets set the default transition_delay_ns to something
more realistic (10 ms), while the userspace always have a chance to set
something it wants.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c943787d761e..70eac3fd89ac 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -275,6 +275,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
+	/* Set the default transition delay to 10ms */
+	policy->transition_delay_us = 10 * USEC_PER_MSEC;
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.7.4
