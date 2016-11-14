From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: conservative: Rename get_freq_target() to get_freq_step()
Date: Mon, 14 Nov 2016 12:30:43 +0530
Message-ID: <4f72891a684f0a8510e8b9560e2d7922b133d591.1479106815.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34206 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbcKNHBA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 02:01:00 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so15998393pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2016 23:00:59 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, stratosk@semaphore.gr

What's returned from this function is the delta by which the frequency
must be increased or decreased and not the final frequency that should
be selected.

Name it properly to match its purpose. Also update the variables used to
store that value.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index fa5ece3915a1..0681fcff5aae 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -37,16 +37,16 @@ struct cs_dbs_tuners {
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
 #define MAX_SAMPLING_DOWN_FACTOR		(10)
 
-static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
-					   struct cpufreq_policy *policy)
+static inline unsigned int get_freq_step(struct cs_dbs_tuners *cs_tuners,
+					 struct cpufreq_policy *policy)
 {
-	unsigned int freq_target = (cs_tuners->freq_step * policy->max) / 100;
+	unsigned int freq_step = (cs_tuners->freq_step * policy->max) / 100;
 
 	/* max freq cannot be less than 100. But who knows... */
-	if (unlikely(freq_target == 0))
-		freq_target = DEF_FREQUENCY_STEP;
+	if (unlikely(freq_step == 0))
+		freq_step = DEF_FREQUENCY_STEP;
 
-	return freq_target;
+	return freq_step;
 }
 
 /*
@@ -90,7 +90,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		if (requested_freq == policy->max)
 			goto out;
 
-		requested_freq += get_freq_target(cs_tuners, policy);
+		requested_freq += get_freq_step(cs_tuners, policy);
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;
 
@@ -106,16 +106,16 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 
 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
-		unsigned int freq_target;
+		unsigned int freq_step;
 		/*
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
 		if (requested_freq == policy->min)
 			goto out;
 
-		freq_target = get_freq_target(cs_tuners, policy);
-		if (requested_freq > freq_target)
-			requested_freq -= freq_target;
+		freq_step = get_freq_step(cs_tuners, policy);
+		if (requested_freq > freq_step)
+			requested_freq -= freq_step;
 		else
 			requested_freq = policy->min;
 
-- 
2.7.1.410.g6faf27b

