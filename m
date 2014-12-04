From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 06/26] thermal: cpu_cooling: fix doc comment over struct cpufreq_cooling_device
Date: Thu,  4 Dec 2014 09:41:48 +0530
Message-ID: <65fe28eb30ff75ec96c29f85c0822eecf23879bf.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41009 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbaLDENJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:09 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so17169838pab.21
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:09 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

cooling_cpufreq_lock isn't used to protect this structure and so the comment
over it is outdated. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6f2d41e..cc10641 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -40,9 +40,8 @@
  *	frequency.
  * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
  *
- * This structure is required for keeping information of each
- * cpufreq_cooling_device registered. In order to prevent corruption of this a
- * mutex lock cooling_cpufreq_lock is used.
+ * This structure is required for keeping information of each registered
+ * cpufreq_cooling_device.
  */
 struct cpufreq_cooling_device {
 	int id;
-- 
2.0.3.693.g996b0fd

