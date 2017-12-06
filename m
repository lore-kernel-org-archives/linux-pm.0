From: Vikas Bansal <vikas.bansal@samsung.com>
Subject: In kernel power management domain_pm created for async schedules
Date: Wed, 06 Dec 2017 05:38:31 +0000
Message-ID: <20171206053831epcms5p58903d153d261ffd797e43b6983cda1ce@epcms5p5>
References: <CGME20171206053831epcms5p58903d153d261ffd797e43b6983cda1ce@epcms5p5>
Reply-To: vikas.bansal@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

If there is a driver in system which starts creating async schedules just after resume (Same as our case, in which we faced issue). Then async_synchronize_full API in PM cores starts waiting for completion of async schedules created by that driver (Even though those are in a domain). Because of this kernel resume time is increased (We faces the same issue) and whole system is delayed. 
This problem can be solved by creating is domain for async schedules in PM core (As we solved in our case). Below patch is for solving this problem.


>From b8ea152eed6eef3b53275e7dd240a4d2124e9d4d Mon Sep 17 00:00:00 2001
From: Anuj Gupta <anuj01.gupta@samsung.com>
Date: Tue, 5 Dec 2017 21:34:49 -0800
Subject: [PATCH] Added domain_pm to PM core


Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
---
 drivers/base/power/main.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index db2f044..2d19dfb 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -39,6 +39,7 @@
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
+ASYNC_DOMAIN(domain_pm);
 
 /*
  * The entries in the dpm_list list are in a depth first order, simply
@@ -615,7 +616,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_noirq, dev);
+			async_schedule_domain(async_resume_noirq, dev, &domain_pm);
 		}
 	}
 
@@ -641,7 +642,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "noirq");
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
@@ -755,7 +756,7 @@ void dpm_resume_early(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_early, dev);
+			async_schedule_domain(async_resume_early, dev, &domain_pm);
 		}
 	}
 
@@ -780,7 +781,7 @@ void dpm_resume_early(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
@@ -919,7 +920,7 @@ void dpm_resume(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume, dev);
+			async_schedule_domain(async_resume, dev, &domain_pm);
 		}
 	}
 
@@ -946,7 +947,7 @@ void dpm_resume(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
@@ -1156,7 +1157,7 @@ static int device_suspend_noirq(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_noirq, dev);
+		async_schedule_domain(async_suspend_noirq, dev, &domain_pm);
 		return 0;
 	}
 	return __device_suspend_noirq(dev, pm_transition, false);
@@ -1202,7 +1203,7 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 
@@ -1316,7 +1317,7 @@ static int device_suspend_late(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_late, dev);
+		async_schedule_domain(async_suspend_late, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1361,7 +1362,7 @@ int dpm_suspend_late(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 	if (error) {
@@ -1576,7 +1577,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_domain(async_suspend, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1622,7 +1623,7 @@ int dpm_suspend(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 	if (error) {
-- 
1.7.9.5
