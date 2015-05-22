From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] cpufreq:cpufreq - Fix for two typos in two comments.
Date: Fri, 22 May 2015 22:48:22 +0530
Message-ID: <1432315102-3465-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36385 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946274AbbEVRSf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 13:18:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c..b4c7e0f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -178,7 +178,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	/*
-	 * The driver only supports the SMP configuartion where all processors
+	 * The driver only supports the SMP configuration where all processors
 	 * share the clock and voltage and clock.
 	 */
 	cpumask_setall(policy->cpus);
@@ -1891,7 +1891,7 @@ static int __target_index(struct cpufreq_policy *policy,
 		 * Failed after setting to intermediate freq? Driver should have
 		 * reverted back to initial frequency and so should we. Check
 		 * here for intermediate_freq instead of get_intermediate, in
-		 * case we have't switched to intermediate freq at all.
+		 * case we haven't switched to intermediate freq at all.
 		 */
 		if (unlikely(retval && intermediate_freq)) {
 			freqs.old = intermediate_freq;
-- 
1.7.9.5

