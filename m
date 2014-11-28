From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 20/26] cpu_cooling: get_property() doesn't need to support GET_MAXL anymore
Date: Fri, 28 Nov 2014 15:14:14 +0530
Message-ID: <a0e1a6616db4b8be4eaf11e270d81d5e65fe17c5.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49290 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaK1Jpx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:53 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so6433901pdb.29
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:53 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

We don't use get_property() to find max levels anymore as it is done at boot
now. So, don't support GET_MAXL in get_property().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 05712d5..ddb97aa 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -81,7 +81,6 @@ static struct cpufreq_cooling_device *notify_device;
 enum cpufreq_cooling_property {
 	GET_LEVEL,
 	GET_FREQ,
-	GET_MAXL,
 };
 
 /**
@@ -89,12 +88,11 @@ enum cpufreq_cooling_property {
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
@@ -141,12 +139,6 @@ static int get_property(unsigned int cpu, unsigned long input,
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

