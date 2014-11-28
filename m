From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/26] cpu_cooling: Add comment to clarify relation between cooling state and frequency
Date: Fri, 28 Nov 2014 15:14:01 +0530
Message-ID: <8a8a35afbdbc0e4408f494324e2d78195af0fdf7.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44073 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbaK1JpD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:03 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so6579848pab.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:03 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

This wasn't explained well anywhere and should be clearly specified. Lets add a
top level comment for this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 3ef9050..def0f21 100644
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

