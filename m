From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Thu, 19 Jan 2017 17:25:37 +0800
Message-ID: <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117093837.GA2085@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org


> That said, I have the feeling that is taking the wrong direction. Each time we
> are entering idle, we check the latencies. Entering idle can be done thousand
> of times per second. Wouldn't make sense to disable the states not fulfilling
> the constraints at the moment the latencies are changed ? As the idle states
> have increasing exit latencies, setting an idle state limit to disable all
> states after that limit may be more efficient than checking again and again in
> the idle path, no ?

You'r right. save some checking is good thing to do.


>From 9e1cc3e02b8d954e606dd5a0f6466a8d5b3efab7 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linaro.org>
Date: Wed, 26 Oct 2016 15:26:22 +0800
Subject: [PATCH 2/2] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration

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
Acked-by: Rik van Riel <riel@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 drivers/base/cpu.c               |  2 ++
 drivers/cpuidle/governors/menu.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c28e1a..2c3b359 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_qos.h>
 
 #include "base.h"
 
@@ -376,6 +377,7 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
+	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
 
 	return 0;
 }
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 07e36bb..cc7d873 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,6 +19,7 @@
 #include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/math64.h>
+#include <linux/cpu.h>
 
 /*
  * Please note when changing the tuning values:
@@ -280,11 +281,13 @@ static unsigned int get_typical_interval(struct menu_device *data)
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
+	struct device *device;
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
+	int resume_latency;
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -295,6 +298,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	if (unlikely(latency_req == 0))
 		return 0;
 
+	device = get_cpu_device(dev->cpu);
+
+	/* resume_latency is 0 means no restriction */
+	resume_latency = dev_pm_qos_read_value(device);
+	if (resume_latency)
+		latency_req = min(latency_req, resume_latency);
+
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
 
-- 
2.8.1.101.g72d917a

> 
> For example, a zero PM_QOS_CPU_DMA_LATENCY latency should prevent to enter the
> select's idle routine.

That's a good idea. I will give a draft change to review! :)
