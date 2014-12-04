From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 07/26] thermal: cpu_cooling: Add comment to clarify relation between cooling state and frequency
Date: Thu,  4 Dec 2014 09:41:49 +0530
Message-ID: <9bbfd5e1683a89aa5016704a09e13796a89b6407.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35105 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaLDENN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:13 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so16763598pde.19
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:13 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

This wasn't explained well anywhere and should be clearly specified. Lets add a
top level comment for this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index cc10641..a5a9317 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -28,6 +28,20 @@
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
 
+/*
+ * Cooling state <-> CPUFreq frequency
+ *
+ * Cooling states are translated to frequencies throughout this driver and this
+ * is the relation between them.
+ *
+ * Highest cooling state corresponds to lowest possible frequency.
+ *
+ * i.e.
+ *	level 0 --> 1st Max Freq
+ *	level 1 --> 2nd Max Freq
+ *	...
+ */
+
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
-- 
2.0.3.693.g996b0fd

