From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/26] cpu_cooling: fix doc comment over struct cpufreq_cooling_device
Date: Fri, 28 Nov 2014 15:14:00 +0530
Message-ID: <db8b1c15f4c2ecf70c39ef7aac6da95e97d9957b.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48776 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaK1Jo7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:59 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so6561398pad.29
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:59 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

cooling_cpufreq_lock isn't used to protect this structure and so the comment
over it is outdated. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7c2ba2e..3ef9050 100644
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

