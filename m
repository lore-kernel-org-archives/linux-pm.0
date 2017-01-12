From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency consideration
Date: Thu, 12 Jan 2017 21:27:04 +0800
Message-ID: <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35097 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdALN12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 08:27:28 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so13565445pfa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 05:27:28 -0800 (PST)
In-Reply-To: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

Kernel or user may have special requirement on cpu response time, like
if a interrupt is pinned to a cpu, we don't want the cpu goes too deep
sleep. This patch can prevent this thing happen by consider per cpu
resume_latency setting in cpu sleep state selection in menu governor.

The pm_qos_resume_latency ask device to give reponse in this time. That's
similar with cpu cstates' entry_latency + exit_latency. But since
most of cpu cstate either has no entry_latency or add it into exit_latency
So, we just can restrict this time requirement as states exit_latency.

We can set a wanted latency value according to the value of
/sys/devices/system/cpu/cpuX/cpuidle/stateX/latency. to just a bit
less than related state's latency value. Then cpu can get to this state
or higher.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 07e36bb..8d6d25c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,6 +19,7 @@
 #include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/math64.h>
+#include <linux/cpu.h>
 
 /*
  * Please note when changing the tuning values:
@@ -280,17 +281,23 @@ static unsigned int get_typical_interval(struct menu_device *data)
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
+	struct device *device = get_cpu_device(dev->cpu);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
+	int resume_latency = dev_pm_qos_read_value(device);
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
+	/* resume_latency is 0 means no restriction */
+	if (resume_latency && resume_latency < latency_req)
+		latency_req = resume_latency;
+
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0))
 		return 0;
-- 
2.8.1.101.g72d917a

