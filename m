From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/17] cpufreq: limit the scope of l_p_j variables
Date: Fri,  2 Jan 2015 12:34:34 +0530
Message-ID: <46d55a2d516c384fee4e0c8e6e60f0add60aa4f8.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63903 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:44 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so23380584pdj.28
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:44 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

These variables are just used within adjust_jiffies() and so must be local to
it. Also there is no need of a dummy routine for CONFIG_SMP case as we can take
care of all that with help of macros in the same routine. It doesn't look that
ugly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 788016cded33..74169ad47546 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -249,12 +249,12 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
  * systems as each CPU might be scaled differently. So, use the arch
  * per-CPU loops_per_jiffy value wherever possible.
  */
-#ifndef CONFIG_SMP
-static unsigned long l_p_j_ref;
-static unsigned int l_p_j_ref_freq;
-
 static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 {
+#ifndef CONFIG_SMP
+	static unsigned long l_p_j_ref;
+	static unsigned int l_p_j_ref_freq;
+
 	if (ci->flags & CPUFREQ_CONST_LOOPS)
 		return;
 
@@ -270,13 +270,8 @@ static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 		pr_debug("scaling loops_per_jiffy to %lu for frequency %u kHz\n",
 			 loops_per_jiffy, ci->new);
 	}
-}
-#else
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
-{
-	return;
-}
 #endif
+}
 
 static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs, unsigned int state)
-- 
2.2.0

