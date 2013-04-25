From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 4/4] ARM:TMU:fix: Avoid lockup when first frequency table
 entry is CPUFREQ_ENTRY_INVALID
Date: Thu, 25 Apr 2013 14:30:45 +0200
Message-ID: <1366893045-31586-5-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31373 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab3DYMc4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 08:32:56 -0400
In-reply-to: <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

With the while loop, when i=0 and first entry in the frequency table is
CPUFREQ_ENTRY_INVALID, the code results in an endless loop (since i is not
incremented).

To fix this problem the for loop has been chosen. Incrementing i in the for
end block solves the problem.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes for v2:
- New in v2
---
 drivers/thermal/cpu_cooling.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 8dc44cb..df79f5e8 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -124,7 +124,7 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 	if (!table)
 		return ret;
 
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
+	for (; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
@@ -138,7 +138,6 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 		/*return if level matched and table in descending order*/
 		if (descend && i == level)
 			return table[i].frequency;
-		i++;
 	}
 	i--;
 
-- 
1.7.10.4

