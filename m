From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/16] cpufreq: stats: remove unused cpufreq_stats_attribute
Date: Tue,  6 Jan 2015 21:09:02 +0530
Message-ID: <152320dedd4d46691353088322b1d4a3b19a868b.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53154 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPjj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:39 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so31368047pad.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:39 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

It was never used, but is there since the first commit. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index d2299ca2fc2c..14f8d858a63d 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -33,11 +33,6 @@ struct cpufreq_stats {
 
 static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
 
-struct cpufreq_stats_attribute {
-	struct attribute attr;
-	ssize_t(*show) (struct cpufreq_stats *, char *);
-};
-
 static int cpufreq_stats_update(unsigned int cpu)
 {
 	struct cpufreq_stats *stat;
-- 
2.2.0

