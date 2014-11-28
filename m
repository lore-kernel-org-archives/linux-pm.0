From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/26] cpu_cooling: random comment fixups
Date: Fri, 28 Nov 2014 15:13:59 +0530
Message-ID: <79da69f109b055b435f3703e23abf3a6415a40d9.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37865 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaK1Jo4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:56 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so6493959pac.22
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:55 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

s/give/given

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1ab0018..7c2ba2e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -122,7 +122,7 @@ enum cpufreq_cooling_property {
 };
 
 /**
- * get_property - fetch a property of interest for a give cpu.
+ * get_property - fetch a property of interest for a given cpu.
  * @cpu: cpu for which the property is required
  * @input: query parameter
  * @output: query return
@@ -132,6 +132,7 @@ enum cpufreq_cooling_property {
  * 1. get maximum cpu cooling states
  * 2. translate frequency to cooling state
  * 3. translate cooling state to frequency
+ *
  * Note that the code may be not in good shape
  * but it is written in this way in order to:
  * a) reduce duplicate code as most of the code can be shared.
@@ -212,7 +213,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 }
 
 /**
- * cpufreq_cooling_get_level - for a give cpu, return the cooling level.
+ * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
  * @cpu: cpu for which the level is required
  * @freq: the frequency of interest
  *
-- 
2.0.3.693.g996b0fd

