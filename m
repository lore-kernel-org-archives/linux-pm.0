From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 05/26] thermal: cpu_cooling: random comment fixups
Date: Thu,  4 Dec 2014 09:41:47 +0530
Message-ID: <697523fc464a35f88d4ccadc6f691efd7927553b.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60866 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbaLDENF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:05 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so1705405pde.15
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:05 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

s/give/given

Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f98a763..6f2d41e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -121,7 +121,7 @@ enum cpufreq_cooling_property {
 };
 
 /**
- * get_property - fetch a property of interest for a give cpu.
+ * get_property - fetch a property of interest for a given cpu.
  * @cpu: cpu for which the property is required
  * @input: query parameter
  * @output: query return
@@ -131,6 +131,7 @@ enum cpufreq_cooling_property {
  * 1. get maximum cpu cooling states
  * 2. translate frequency to cooling state
  * 3. translate cooling state to frequency
+ *
  * Note that the code may be not in good shape
  * but it is written in this way in order to:
  * a) reduce duplicate code as most of the code can be shared.
@@ -211,7 +212,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 }
 
 /**
- * cpufreq_cooling_get_level - for a give cpu, return the cooling level.
+ * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
  * @cpu: cpu for which the level is required
  * @freq: the frequency of interest
  *
-- 
2.0.3.693.g996b0fd

