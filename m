From: Xiaoguang Chen <chenxg@marvell.com>
Subject: [PATCH] cpufreq: conservative: fix requested_freq reduction issue
Date: Thu, 7 Nov 2013 10:28:50 +0800
Message-ID: <1383791330-8289-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:20841 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508Ab3KGC3P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2013 21:29:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chenxg@marvell.com, chenxg.marvell@gmail.com

When decreasing frequency, requested_freq may be less than
freq_target, So requested_freq minus freq_target may be negative,
But reqested_freq's unit is unsigned int, then the negative result
will be one larger interger which may be even higher than
requested_freq.

This patch is to fix such issue. when result becomes negative,
set requested_freq as the min value of policy.

Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index f62d822..218460f 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -80,13 +80,18 @@ static void cs_check_cpu(int cpu, unsigned int load)
 
 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
+		unsigned int freq_target;
 		/*
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
 		if (policy->cur == policy->min)
 			return;
 
-		dbs_info->requested_freq -= get_freq_target(cs_tuners, policy);
+		freq_target = get_freq_target(cs_tuners, policy);
+		if (dbs_info->requested_freq > freq_target)
+			dbs_info->requested_freq -= freq_target;
+		else
+			dbs_info->requested_freq = policy->min;
 
 		__cpufreq_driver_target(policy, dbs_info->requested_freq,
 				CPUFREQ_RELATION_L);
-- 
1.8.0

