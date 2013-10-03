From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 52/92] cpufreq: integrator: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:46 +0530
Message-ID: <93c52b3adb5bddd9e0476102d0e600078198d387.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51015 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3JCPFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:05:09 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so2592110pdi.19
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:05:09 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init(). And so we don't need to set policy->cur from driver anymore.

Over that it sets policy->min and max correctly. They were earlier set to
current frequency of CPU but they should be set to max and min freq of cpu.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/integrator-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index f7c99df..6391dd3 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -186,10 +186,9 @@ static int integrator_cpufreq_init(struct cpufreq_policy *policy)
 {
 
 	/* set default policy and cpuinfo */
-	policy->cpuinfo.max_freq = 160000;
-	policy->cpuinfo.min_freq = 12000;
+	policy->max = policy->cpuinfo.max_freq = 160000;
+	policy->min = policy->cpuinfo.min_freq = 12000;
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms, assumed */
-	policy->cur = policy->min = policy->max = integrator_get(policy->cpu);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

