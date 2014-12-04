From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 21/26] thermal: cpu_cooling: get_property() doesn't need to support GET_MAXL anymore
Date: Thu,  4 Dec 2014 09:42:03 +0530
Message-ID: <76f4dd2d1e4b05119de5a99fcf1c1e685de1141d.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55969 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaLDEOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:14:07 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so17283298pad.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:14:07 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

We don't use get_property() to find max levels anymore as it is done at boot
now. So, don't support GET_MAXL in get_property().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d34cc5b..d2e6f84 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -116,7 +116,6 @@ static void release_idr(struct idr *idr, int id)
 enum cpufreq_cooling_property {
 	GET_LEVEL,
 	GET_FREQ,
-	GET_MAXL,
 };
 
 /**
@@ -124,12 +123,11 @@ enum cpufreq_cooling_property {
  * @cpu: cpu for which the property is required
  * @input: query parameter
  * @output: query return
- * @property: type of query (frequency, level, max level)
+ * @property: type of query (frequency, level)
  *
  * This is the common function to
- * 1. get maximum cpu cooling states
- * 2. translate frequency to cooling state
- * 3. translate cooling state to frequency
+ * 1. translate frequency to cooling state
+ * 2. translate cooling state to frequency
  *
  * Note that the code may be not in good shape
  * but it is written in this way in order to:
@@ -176,12 +174,6 @@ static int get_property(unsigned int cpu, unsigned long input,
 	/* max_level is an index, not a counter */
 	max_level--;
 
-	/* get max level */
-	if (property == GET_MAXL) {
-		*output = (unsigned int)max_level;
-		return 0;
-	}
-
 	if (property == GET_FREQ)
 		level = descend ? input : (max_level - input);
 
-- 
2.0.3.693.g996b0fd

