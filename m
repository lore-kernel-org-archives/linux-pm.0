From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 07/11] cpufreq: Optimize cpufreq_frequency_table_verify()
Date: Wed,  2 Oct 2013 14:13:15 +0530
Message-ID: <e94c6a64e8c3e5df0ca803e1464330678a00dc3b.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34228 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab3JBIo1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 04:44:27 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so581064pde.23
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 01:44:27 -0700 (PDT)
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_frequency_table_verify() is a bit rewritten here to make it more logical
and optimal.
- merge multiple lines for variable declarations together.
- quit early if any frequency between min/max is found.
- don't call cpufreq_verify_within_limits() in case any valid freq is found as
  it is of no use.
- count renamed as found and made a boolean.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 11f6fa9..10f3cfb 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -54,9 +54,8 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table)
 {
-	unsigned int next_larger = ~0;
-	unsigned int i;
-	unsigned int count = 0;
+	unsigned int next_larger = ~0, freq, i = 0;
+	bool found = false;
 
 	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
 					policy->min, policy->max, policy->cpu);
@@ -64,21 +63,23 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     policy->cpuinfo.max_freq);
 
-	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
+	for (; freq = table[i].frequency, freq != CPUFREQ_TABLE_END; i++) {
 		if (freq == CPUFREQ_ENTRY_INVALID)
 			continue;
-		if ((freq >= policy->min) && (freq <= policy->max))
-			count++;
-		else if ((next_larger > freq) && (freq > policy->max))
+		if ((freq >= policy->min) && (freq <= policy->max)) {
+			found = true;
+			break;
+		}
+
+		if ((next_larger > freq) && (freq > policy->max))
 			next_larger = freq;
 	}
 
-	if (!count)
+	if (!found) {
 		policy->max = next_larger;
-
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     policy->cpuinfo.max_freq);
+		cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				policy->cpuinfo.max_freq);
+	}
 
 	pr_debug("verification lead to (%u - %u kHz) for cpu %u\n",
 				policy->min, policy->max, policy->cpu);
-- 
1.7.12.rc2.18.g61b472e

